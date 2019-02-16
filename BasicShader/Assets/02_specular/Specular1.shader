// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CGM499/Specular" {

    Properties {
        _Color ("Color",Color) = (1.0,1.0,1.0,1.0)
        _SpecColor ("Color",Color) = (1.0,1.0,1.0,1.0)
        _Shininess ("Shininess",Float) = 10
    }

    SubShader {
        Pass {
            Tags {"LihgtMode" = "ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //user defined variable
            uniform float3 _Color;
            uniform float3 _SpecColor;
            uniform float3 _Shininess;

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
                //float3 viewDirection = normalize(float3(float4(_WorldSpaceLightPos0.xyz,1.0)-UnityObjectToClipPos(v.vertex)));
                float3 viewDirection = normalize(float4(_WorldSpaceCameraPos.xyz,1.0)-UnityObjectToClipPos(v.vertex));
                viewDirection = normalize(viewDirection);
                float3 lightDirection;
                float3 atten = 1.0;

                //Light Direction
                lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 diffuse = atten * _LightColor0.xyz * _Color.rgb * max(0.0 , dot(normalDirection,lightDirection));
                
                //without shininess
                //float3 specular = max(0,dot(reflect(-lightDirection,normalDirection),viewDirection));

                //with shininess
                float3 specular = (max(0,dot(reflect(-lightDirection,normalDirection),viewDirection)));

                float3 specularReflection = atten * _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);


                float3 outColor = diffuse + specularReflection + UNITY_LIGHTMODEL_AMBIENT;

                //output.color = float4(diffuse,1.0);
                //output.color = float4(specular,1.0);
                output.color = float4(outColor,1.0);


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