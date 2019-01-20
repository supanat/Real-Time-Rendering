// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CGM499/Lambert_Ambient" {

    Properties {
        _Color ("Color",Color) = (1.0,1.0,1.0,1.0)
    }

    SubShader {
        Pass {
            Tags {"LihgtMode" = "ForwardBase"}
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

                float3 normalDirection = normalize(mul(float4(v.normal,1.0),unity_WorldToObject).xyz);
                float3 lightDirection;
                float3 atten = 1.0;

                lightDirection = normalize(_WorldSpaceLightPos0.xyz);

                //float3 diffuse = max(0.0 , dot(normalDirection,lightDirection));
                //float3 diffuse = atten * _LightColor0.xyz *  max(0.0 , dot(normalDirection,lightDirection));

                float3 diffuse = atten * _LightColor0.xyz * _Color.rgb * max(0.0 , dot(normalDirection,lightDirection));
				//float3 finalLight = diffuse * UNITY_LIGHTMODEL_AMBIENT.xyz;
				float3 finalLight = diffuse;

                output.color = float4(finalLight,1.0);
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