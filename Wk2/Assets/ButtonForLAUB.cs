using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;


[CustomEditor(typeof(LookAtUnityBezier))]

    public class ButtonsForLAUB : Editor
    {

        public override void OnInspectorGUI()
        {
        LookAtUnityBezier myLAUB = (LookAtUnityBezier)target; //casting class into object
        DrawDefaultInspector();
            if (GUILayout.Button("Make new curve"))
            {
            BezierExample newBE = myLAUB.myModel.gameObject.AddComponent<BezierExample>();
            if (myLAUB.curveList.Count > 0)
            {
                BezierExample lastBE = myLAUB.curveList[myLAUB.curveList.Count - 1];
                newBE.startPoint = lastBE.endPoint;
                newBE.endPoint = lastBE.endPoint;
                newBE.startTangent = lastBE.endPoint;
                newBE.endTangent = lastBE.endPoint;
            }
            
            myLAUB.curveList.Add(newBE);
            }
        }
    }


