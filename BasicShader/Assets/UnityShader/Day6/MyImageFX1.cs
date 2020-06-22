using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyImageFX1 : MonoBehaviour {


    public Shader fxShader;
    public float grayScaleAmount = 1.0f;
    private Material fxMaterial;

    Material material
    {
        get
        {
            if(fxMaterial == null)
            {
                fxMaterial = new Material(fxShader);
                fxShader.hideFlags = HideFlags.HideAndDontSave;
            }

            return fxMaterial;
        }
    }



	// Use this for initialization
	void Start () {

        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
        
        
		
	}

    void OnRenderImage(RenderTexture sourceTexture,RenderTexture desTexture)
    {
        if(fxShader != null)
        {
            material.SetFloat("_LuminosityAmount", grayScaleAmount);
            Graphics.Blit(sourceTexture, desTexture, material);
        }
        else
        {
            Graphics.Blit(sourceTexture, desTexture);
        }

    }

	
	// Update is called once per frame
	void Update () {
        grayScaleAmount = Mathf.Clamp(grayScaleAmount,0.0f, 1.0f);
	}

    void onDisable()
    {
        if (fxMaterial)
        {
            DestroyImmediate(fxMaterial);
        }
    }
}
