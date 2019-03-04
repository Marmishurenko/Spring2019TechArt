using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeTreadmill : MonoBehaviour
{
    public GameObject cube;

    public GameObject target;

    private List<GameObject> _cubes;

    private Vector3 _intPos;
    private Vector3 _currentIntPos;
    private Vector3 _oldIntPos;

    void Start()
    {
        _cubes = new List<GameObject>();

        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < 2; j++)
            {
                _cubes.Add(Instantiate(cube, new Vector3(j, 0, i), Quaternion.identity));
            }
        }
    }

    void Update()
    {
        _intPos = new Vector3(Mathf.Floor(target.transform.position.x), 0, Mathf.Floor(target.transform.position.z));

        if (_intPos != _oldIntPos)
        {
            if (_intPos.x > _oldIntPos.x)
            {
                foreach (GameObject g in _cubes)
                {
                    g.transform.position += Vector3.right;
                }
            }
            if (_intPos.x < _oldIntPos.x)
            {
                foreach (GameObject g in _cubes)
                {
                    g.transform.position -= Vector3.right;
                }
            }
            if (_intPos.z > _oldIntPos.z)
            {
                foreach (GameObject g in _cubes)
                {
                    g.transform.position += Vector3.forward;
                }
            }
            if (_intPos.z < _oldIntPos.z)
            {
                foreach (GameObject g in _cubes)
                {
                    g.transform.position -= Vector3.forward;
                }
            }

            _oldIntPos = _intPos;
        }
    }
}