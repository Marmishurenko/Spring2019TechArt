 using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChunkExample : MonoBehaviour
{
    #region variables
    private MeshFilter meshFilter;
    private MeshRenderer meshRenderer;

    private Mesh myMesh;

    private Vector3[] verts;
    private int[] tris;
    private Vector2[] uVs;
    private Vector3[] normals;

    public int sizeSquare;
    private int totalVertInd;
    private int totalTrisInd;
    private int seed = 4;
    public float noiseHeight = 4;

    #endregion

    #region gameLoop
    private void Awake()
    {
        meshFilter = gameObject.AddComponent<MeshFilter>();
        meshRenderer = gameObject.AddComponent<MeshRenderer>();
        myMesh = new Mesh();
    }

    private void Start()
    {
        _Init();
        _CalcMesh();
        _ApplyNoise();
        _ApplyMesh();
    }

    private void Update()
    {
        UpdateMesh();
        
    }
#endregion

    private void _Init()
    {
        totalVertInd = (sizeSquare + 1) * (sizeSquare + 1);
        totalTrisInd = (sizeSquare) * (sizeSquare) * 2 * 3;
        verts = new Vector3[totalVertInd];
        tris = new int[totalTrisInd];
        uVs = new Vector2[totalVertInd];
        normals = new Vector3[totalVertInd];
    }

    private void _CalcMesh()
    {
        int _triInd = 0;
        for (int i = 0; i < sizeSquare; i++)
        {
            for (int j = 0; j < sizeSquare; j++)
            {
                int bottomLeft = j + (i * (sizeSquare + 1)); // true as long as j < sizesquare - 1
                int bottomRight = j + (i * (sizeSquare + 1)) + 1; // true as long as j < sizesquare -1
                int topLeft = j + ((i + 1) * (sizeSquare + 1));
                int topRight = j + ((i + 1) * (sizeSquare + 1)) + 1;

                tris[_triInd] = bottomLeft;
                _triInd++;
                tris[_triInd] = topLeft;
                _triInd++;
                tris[_triInd] = bottomRight;
                _triInd++;
                tris[_triInd] = topLeft;
                _triInd++;
                tris[_triInd] = topRight;
                _triInd++;
                tris[_triInd] = bottomRight;
                _triInd++;
            }
        }
    }

    private void _ApplyMesh()
    {
        myMesh.vertices = verts;
        myMesh.triangles = tris;
        MakeSeamlessNormals();

        myMesh.normals = normals;

        meshFilter.mesh = myMesh;
       

        meshRenderer.material = Resources.Load<Material>("TerrainMat");
    }

    private void _ApplyNoise()
    {
        for (int z = 0; z <= sizeSquare; z++)
        {
            for (int x = 0; x <= sizeSquare; x++)
            {
                verts[(z * (sizeSquare + 1)) + x] =
                    new Vector3(x,
                    5 * Perlin.Noise(
                        ((float)x + this.transform.position.x+seed) / noiseHeight,
                        ((float)z + this.transform.position.z)+seed-2 / noiseHeight),
                    z);


            }
        }
    }

    void MakeSeamlessNormals() // partial implementation of Chuang Xie, https://github.com/thankcreate/TAS-2019-S-CX/blob/master/Week5/Assets/Scenes/Assignment/PerlinMeshWriter.cs#L74
    {
        float normalizedUnit = 1;
        float maxLength = sizeSquare * normalizedUnit;
        int verticesCount = (sizeSquare + 1) * (sizeSquare + 1);

        for (int z = 0; z <= sizeSquare; z++)
        {
            for (int x = 0; x <= sizeSquare; x++)
            {
                int i = z * (sizeSquare + 1) + x;
                var zRelative = (float)z * normalizedUnit;
                var xRelative = (float)x * normalizedUnit;
                var zCoordinate = zRelative + transform.position.z;
                var xCoordinate = xRelative + transform.position.x;

                float y0 = GetY(zCoordinate, xCoordinate);
                verts[i] = new Vector3(xRelative, y0, zRelative);

                // used the cross product of partial derivatives to compute the normal
                var step = 0.02f;

                var y1 = GetY(zCoordinate + step, xCoordinate);
                var diffZ = new Vector3(0, y1 - y0, step);

                var y2 = GetY(zCoordinate, xCoordinate + step);
                var diffX = new Vector3(step, y2 - y0, 0);

                normals[i] = Vector3.Cross(diffX, diffZ).normalized;

            }
        }

    }

    float GetY(float z, float x)
    {
        float normalizedUnit = 1;
        var maxLength = sizeSquare * normalizedUnit;
        return Perlin.Noise(z / maxLength, x / maxLength) * 5;
    }

    private void UpdateMesh()
    {

        myMesh.vertices = verts;
        myMesh.triangles = tris;
        MakeSeamlessNormals();
        myMesh.normals = normals;

    }
}



