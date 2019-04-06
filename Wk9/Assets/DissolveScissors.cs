using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DissolveScissors : MonoBehaviour
{
    public float dissTime;
    private float finDissAmount = 0.785f;
    private float initDissAmount = 0f;
    // Start is called before the first frame update


    // Update is called once per frame
    void Update()
    {
        StartCoroutine(StartDissolve());
    }

    IEnumerator StartDissolve()
    {
        for (float i = 0; i < 1; i += Time.deltaTime / dissTime)
        {
            gameObject.GetComponent<Renderer>().material.SetFloat("_DissolveAmount", Mathf.Lerp(initDissAmount, finDissAmount, i));
            yield return null;
        }
    }
}
