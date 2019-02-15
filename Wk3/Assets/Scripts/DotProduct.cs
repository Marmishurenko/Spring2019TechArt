using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DotProduct : MonoBehaviour
{
    public Vector3 v1Start;
    public Vector3 v1End;
    public Vector3 v2Start;
    public Vector3 v2End;

    private Vector3 _v1;
    private Vector3 _v2;
    public float outputDotP1 { get; private set; }
    public float outputDotP2 { get; private set; }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Debug.DrawLine(v1Start, v1End);
        Debug.DrawLine(v2Start, v2End);

        _v1 = v1End - v1Start;
        _v2 = v2End - v2Start;

        _v1 = Vector3.Normalize(_v1); //zero is perp, plus one when vecs are parallel, minus when they are 
        _v2 = Vector3.Normalize(_v2);// way of thinking of directionality

        outputDotP1 = Vector3.Dot(v1End - v1Start, v2End - v2Start);
        outputDotP2 = Vector3.Dot(v2End - v2Start, v1End - v1Start);
    }
}
