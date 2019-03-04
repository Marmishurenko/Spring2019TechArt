
// code approach to implementation based on  Holisitic 3D Youtube Channel lecture: https://www.youtube.com/watch?v=dycHQFEz8VI

using System.Collections;
using System.Collections.Generic;
using UnityEngine;



class Chunk
{
    public GameObject oneChunk;
    public float creationTime;
    public Chunk (GameObject c, float ct)
    {
        oneChunk = c;
        creationTime = ct;
    }

}

public class TerrainThreadmillMaker : MonoBehaviour
{

    #region variables
    public GameObject chunkPrefab;
    public Camera camera;
    int chunkSize = 10;
    int radiusAroundX = 10;//how many tiles around the camera
    int radiusAroundY = 10;

    Vector3 startPos; // genrate only on movement

    Hashtable chunksHashTable = new Hashtable();

    #endregion
    // Start is called before the first frame update

    void Start()
    {
        gameObject.transform.position = Vector3.zero;
        startPos = Vector3.zero;

        float updateTime = Time.realtimeSinceStartup;
        for (int x = -radiusAroundX; x < radiusAroundX;x++)
        {
            for (int z = -radiusAroundY; z<radiusAroundY; z++)
            {
                Vector3 pos = new Vector3((x * chunkSize + startPos.x), 0, (z * chunkSize + startPos.z));
                GameObject c = (GameObject)Instantiate(chunkPrefab, pos, Quaternion.identity);

                string chunkName = "Chunk_" + ((int)(pos.x)).ToString() + "_" + ((int)(pos.z)).ToString();
                c.name = chunkName;
                Chunk chunk = new Chunk(c, updateTime);
                chunksHashTable.Add(chunkName, chunk);
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        //how far the player has moved since last terr update
        int xMove = (int)(camera.transform.position.x - startPos.x);
        int zMove = (int)(camera.transform.position.z - startPos.z);

        if (Mathf.Abs(xMove)>= chunkSize || Mathf.Abs(zMove)>= chunkSize)
        {
            float updateTime = Time.realtimeSinceStartup;

            //rounding int position to nearest tilesize
            int camX = (int)(Mathf.Floor(camera.transform.position.x / chunkSize) * chunkSize);
            int camZ = (int)(Mathf.Floor(camera.transform.position.z / chunkSize) * chunkSize);

            for (int x = -radiusAroundX; x < radiusAroundX; x++)
            {
                for (int z = -radiusAroundY; z < radiusAroundY; z++)
                {

                    Vector3 pos = new Vector3((x * chunkSize + camX), 0, (z * chunkSize + camZ));
                    string chunkName = "Chunk_" + ((int)(pos.x)).ToString() + "_" + ((int)(pos.z)).ToString();

                    if (!chunksHashTable.ContainsKey(chunkName))
                    {
                        GameObject c = (GameObject)Instantiate(chunkPrefab, pos, Quaternion.identity);
                        c.name = chunkName;
                        Chunk tile = new Chunk(c, updateTime);
                        chunksHashTable.Add(chunkName, tile);
                    }
                    else
                    {
                        (chunksHashTable[chunkName] as Chunk).creationTime = updateTime;
                    }
                }
            }

            // destroy all irrelevant tiles and put fresh tiles to the new hashtable
            Hashtable newChunkHashTable = new Hashtable();
            foreach (Chunk chks in chunksHashTable.Values)
            {
                if (chks.creationTime != updateTime)
                {
                    Destroy(chks.oneChunk);
                }
                else
                {
                    newChunkHashTable.Add(chks.oneChunk.name, chks);
                }
            }

            //copy new HT content to the main HT
            chunksHashTable = newChunkHashTable; // reindexed HT
            startPos = camera.transform.position;
            
        }
    }
}
