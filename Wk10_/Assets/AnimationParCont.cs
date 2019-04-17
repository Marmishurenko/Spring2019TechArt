using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationParCont : MonoBehaviour
{
    private float walk_Blend_X;
    private float walk_Blend_Y;
    private float time;
    private float idletime;
    private Animator _myAnim;

    [Header("Tuning values")]
    [Range(0.001f, 10.0f)]public float walkCycleTime;
    [Range(0.001f, 10.0f)] public float walkRunBlendTotal;// 2* 1/(walkCycletime)
    [Range(0.001f, 10.0f)] public float walkRunMag;

    // Start is called before the first frame update
    void Start()
    {
        _myAnim = GetComponent<Animator>();
    }

    // Update is called once per frame
    //Soh - opposite /hypotjenuse
    //Cah - adjacent over h
    //Toa - opp over adj 
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            _myAnim.SetBool("idle_false_move_true",true);
        }else _myAnim.SetBool("idle_false_move_true", false);

        idletime = Time.deltaTime * 6;
        _myAnim.SetFloat("idle_val", (Mathf.Sin(idletime) + 1) / 2);

        walkCycleTime = 1-(.5f + walkRunBlendTotal);
        walkRunMag = 0.25f + (.75f * walkRunBlendTotal );
        time +=(Mathf.PI * 2* Time.deltaTime)/ walkCycleTime;// normalized time / walk cycle
        walk_Blend_X = Mathf.Sin(time) * walkRunMag; 
        walk_Blend_Y = Mathf.Cos(time) * walkRunMag;

        _myAnim.SetFloat("WalkTreeValX", walk_Blend_X);
        _myAnim.SetFloat("WalkTreeValY", walk_Blend_Y);

    }
}
