Shader "CGM/CustomVertex" {
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf Lambert vertex:vert
      struct Input {
          float2 uv_MainTex;
      };

      sampler2D _MainTex;


      void vert (inout appdata_full v, out Input o) {

          //v.vertex.x += sin(_Time * 30) * .3;
          v.vertex.x += sin(_Time.x * 70 + v.vertex.y*2) * .7;

          UNITY_INITIALIZE_OUTPUT(Input,o);
      }
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      ENDCG
    }
    Fallback "Diffuse"
  }