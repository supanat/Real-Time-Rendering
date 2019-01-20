// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CGM499/My_Lambert" {

    Properties {
        _Color ("Color",Color) = (1.0,1.0,1.0,1.0)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
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


			sampler2D _MainTex;

            //base input struct
            struct vertexInput{

                float4 vertex:POSITION0;
                float3 normal:NORMAL;

            };
            struct vertexOutput{
                float4 pos : SV_POSITION0;
                float3 normal : TEXCOORD;
            };

            //VERTEX SHADER FUNCTION
            vertexOutput vert(vertexInput v){
                vertexOutput output;
              
			  	output.normal = mul(float4(v.normal,1.0),unity_WorldToObject).xyz;
                output.pos  = UnityObjectToClipPos(v.vertex);

                return output;
            }

            //FRAGMENT SHADER FUNCTION
            float4 frag(vertexOutput input):COLOR
            {
                float4 outColor;

				float3 lightDirection;
                float3 atten = 1.0;

                lightDirection = normalize(_WorldSpaceLightPos0.xyz);

                //float3 diffuse = max(0.0 , dot(normalDirection,lightDirection));
                //float3 diffuse = atten * _LightColor0.xyz *  max(0.0 , dot(normalDirection,lightDirection));

                float3 diffuse = atten * _LightColor0.xyz * _Color.rgb * max(0.0 , dot(input.normal,lightDirection));
				//float3 finalLight = diffuse * UNITY_LIGHTMODEL_AMBIENT.xyz;


				outColor = float4(diffuse,1.0);
				return outColor;
                //return float4(0.0,1.0,1.0,1.0);
                //return input.color;
            }


            ENDCG
        }
    }

}