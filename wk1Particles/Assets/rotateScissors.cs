using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotateScissors : MonoBehaviour {


    public float speed = 3f;
    public ParticleSystem sparkPS;
    public bool moduleEnabled;


    // Use this for initialization
    void Start () {
        var emission = sparkPS.emission;
        

    }
	
	// Update is called once per frame
	void Update () {
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            transform.Rotate(Vector3.down * Time.deltaTime*speed, Space.World);
        } else if (Input.GetKey(KeyCode.RightArrow))
        {
            transform.Rotate(Vector3.up * Time.deltaTime * speed, Space.World);
        }
        

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("spark"))
        {
            print(other.name);
            sparkPS.Emit(46);
        }
    }
}
