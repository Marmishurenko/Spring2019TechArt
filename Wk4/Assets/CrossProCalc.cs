using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class CrossProCalc : MonoBehaviour
{
    public Vector3 vectorA;
    public Vector3 vectorB;
    public Vector3 outputVectorAcrossB;
    public Vector3 outputVectorBcrossA;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        outputVectorAcrossB = Vector3.Cross(vectorA, vectorB);
        outputVectorBcrossA = Vector3.Cross(vectorB, vectorA);
    }
}
