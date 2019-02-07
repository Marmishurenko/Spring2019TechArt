using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

//[ExecuteInEditMode] // use sparingly

public class LookAtUnityBezier : MonoBehaviour {

    public GameObject marker;
    public BezierExample bezEx;
    public List<BezierExample> curveList = new List<BezierExample>();
    public Transform myModel;

    public void Start()
    {
        PutPointsOnCurve();
    }

    private void PutPointsOnCurve()
    {
        //Run though 100 points and place a marker at those points on the bezier curve
        //for loop through 100 points  btw 0 and 1 
        //pass that fraction to a curve calculator to find the resultant v3
        //Place a marker at that v3

        for (int i = 0; i <= 100; i++)
        {
            float t = (float)i / 100;
            Vector3 pointOnCurve = CalculateBezier(bezEx, t);
            Instantiate(marker, pointOnCurve, Quaternion.identity, null);
        }
    }

    // Use this for initialization
    void Update () {
       
        
	}

    Vector3 CalculateBezier(BezierExample curvData, float t)
    {
        Vector3 a= curvData.startPoint;
        Vector3 b= curvData.startTangent;
        Vector3 c= curvData.endPoint;
        Vector3 d= curvData.endTangent;

        Vector3 ab = Vector3.Lerp(a, b, t);
        Vector3 bc = Vector3.Lerp(b, c, t);
        Vector3 cd = Vector3.Lerp(c, d, t);
        
        Vector3 abc = Vector3.Lerp(ab, bc, t);
        Vector3 bcd = Vector3.Lerp(bc,cd, t);

        Vector3 final = Vector3.Lerp(abc, bcd, t);

        return final;
    }




}
