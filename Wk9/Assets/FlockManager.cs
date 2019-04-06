using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlockManager : MonoBehaviour
{
    public GameObject prefab;
    [Range(1,500) ] public int numberOfSpawns;
    List<GameObject> allAgents = new List<GameObject>();
    Collider[] collinRad = new Collider[1];

    // Start is called before the first frame update
    void Start()
    {

        float rCubed = 3 * numberOfSpawns / (4 * Mathf.PI * .005f); //2 per unit volume
        float r = Mathf.Pow(rCubed, .33f); // formula for cube

        for (int i = 0; i < numberOfSpawns; i++)
        {
            allAgents.Add(Instantiate(prefab, Random.insideUnitSphere * r , Quaternion.identity,transform));
        }
    }
    
    // Update is called once per frame
    void Update()
    {
        foreach (GameObject g in allAgents)
        {
         AgentBehavior a= g.GetComponent<AgentBehavior>();
           
            Physics.OverlapSphereNonAlloc(g.transform.position, 1f, collinRad); // currently getting a ref to itself so might be weird

            a.PassListOfContext(collinRad);
        }
    }
}
