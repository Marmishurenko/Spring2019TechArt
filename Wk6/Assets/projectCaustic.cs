using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class projectCaustic : MonoBehaviour
{
    int FPS = 30;
    private Projector proj;
    public Texture[] causticTex;
    //public string TextureName;
    // Start is called before the first frame update
    void Start()
    {
        proj = GetComponent<Projector>();
    }

    // Update is called once per frame
    void Update()
    {
        int causticIndex = (int)(Time.time * FPS) % causticTex.Length;
        proj.material.SetTexture("_TextureSample0", causticTex[causticIndex]);
    }
}


