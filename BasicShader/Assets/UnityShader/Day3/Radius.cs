using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Radius : MonoBehaviour {

    public float radius = 0.5f;
    public Color color = Color.green;
    public Material material;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

        material.SetVector("_Center", transform.position);
        material.SetFloat("_Radius", radius);
        material.SetColor("_CircleColor", color);
		
	}
}
