using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainGenerator : MonoBehaviour
   
{
    int heightScale = 5;
    float detailScale = 5.0f;
    // Start is called before the first frame update
    void Start()
    {
        Mesh mesh = gameObject.GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;
        for (int v = 0; v< vertices.Length; v++)
        {
            vertices[v].y = Perlin.Noise((vertices[v].x + gameObject.transform.position.x) / detailScale, 
                                              (vertices[v].z + gameObject.transform.position.z) / detailScale) * heightScale; // offset for noise
        }

        mesh.vertices = vertices;
        mesh.RecalculateBounds();
       // mesh.RecalculateNormals();
        //gameObject.AddComponent<MeshCollider>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
