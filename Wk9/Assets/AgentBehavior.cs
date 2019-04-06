using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AgentBehavior : MonoBehaviour
{
    public Vector3 moveDirection;
    public float moveVelocityMagnitude;
    private Transform myModelTransform;
    [Range(0.0f, 1.0f)] public float clumpStrentgh;
    [Range(0.0f, 1.0f)] public float avoidStrentgh;
    [Range(0.0f, 1.0f)] public float alignStrentgh;
    [Range(0.0f, 1.0f)] public float originStrentgh;

    // Start is called before the first frame update
    void Start()
    {
       
        myModelTransform = gameObject.transform.GetChild(0);
    }
    
    public void PassListOfContext(Collider[] context)
    {
        //use contect
        CalcMyDir(context);
        MoveInMyAssignedDir(moveDirection, moveVelocityMagnitude);
    }

    void CalcMyDir(Collider[] context)
    {
        moveDirection = Vector3.Lerp(moveDirection, Vector3.Normalize(ClumpDir(context) * 
            clumpStrentgh + Align(context) * alignStrentgh + Avoidance(context) *
            avoidStrentgh + MoveTowardsOrigin() * originStrentgh* 
            Vector3.Magnitude(transform.position)/500f), 0.05f);
       
    }

    Vector3 ClumpDir(Collider[] context)
    {
        Vector3 midpoint = Vector3.zero;
        foreach (Collider c in context)
        {
            midpoint += c.transform.position;
        }
        midpoint /= context.Length;
        Vector3 dirIwantToGo = midpoint - transform.position;
        Vector3 normalizedDirIwantToGo = Vector3.Normalize(dirIwantToGo);
       // moveDirection = normalizedDirIwantToGo;
        return normalizedDirIwantToGo;
    }

    Vector3 Align (Collider[] context)
    {
        Vector3 headings = Vector3.zero;
        foreach (Collider c in context)
        {
            headings += c.transform.GetChild(0).forward;
        }

        headings /= context.Length;
        return Vector3.Normalize(headings);
    }

    Vector3 Avoidance(Collider[] context)
    {
        List<Collider> contextWithoutMe = new List<Collider>();
        foreach (Collider c in context)
        {
            if (c.gameObject != gameObject)
            {
                contextWithoutMe.Add(c);
            }
        }

        
        foreach (Collider c in context)
        {
            if (c != null && c.gameObject != gameObject)
                contextWithoutMe.Add(c);
        }
        Vector3 midpoint = Vector3.zero;
        foreach (Collider c in context)
        {
            midpoint += c.transform.position;
        }
        midpoint /= context.Length;
        Vector3 dirIwantToGo = midpoint - transform.position;
        Vector3 normalizedDirIwantToGo = Vector3.Normalize(dirIwantToGo);

        return (Quaternion.Euler(20, 20, 20) * -normalizedDirIwantToGo);
    }

    Vector3 MoveTowardsOrigin()
    {
    return Vector3.zero - transform.position;

    }

    void MoveInMyAssignedDir(Vector3 dir, float mag)
    {
        transform.position += dir * mag * Time.deltaTime;
        myModelTransform.rotation = Quaternion.LookRotation(dir);
    }
}
