// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CGM499/Start" {

    Properties {
        _Color ("Color",Color) = (1.0,1.0,1.0,1.0)
    }

    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //user defined variable
            uniform float3 _Color;

            //unity defined variable
            uniform float4 _LightColor0;

            //base input struct
            struct vertexInput{

                float4 vertex:POSITION0;
                float3 normal:NORMAL;

            };
            struct vertexOutput{
                float4 pos : SV_POSITION0;
                float4 color : COLOR;
            };

            //VERTEX SHADER FUNCTION
            vertexOutput vert(vertexInput v){
                vertexOutput output;

                output.color = float4(v.normal,1.0);
                output.pos  = UnityObjectToClipPos(v.vertex);

                return output;
            }

            //FRAGMENT SHADER FUNCTION
            float4 frag(vertexOutput input):COLOR
            {
                

                //return float4(0.0,1.0,1.0,1.0);
                return input.color;
            }


            ENDCG
        }
    }

}