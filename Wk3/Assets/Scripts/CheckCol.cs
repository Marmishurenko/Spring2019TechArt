﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckCol : MonoBehaviour
{
    public static bool isHitTrap = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))


        {
            isHitTrap = true;
           // print(isHitTrap);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            isHitTrap = false;
        }
    }
}
