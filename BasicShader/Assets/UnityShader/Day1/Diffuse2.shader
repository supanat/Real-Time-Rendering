Shader "CGM499/Basic/Diffuse2"{
	Properties{
		_Color("Color",Color) = (1,1,1,1)
		_MainTex("Texture",2D) = "white"{}
		_Metallic("Metallic",Range(0,1)) = 0.5
		_Smoothness("Smoothness",Range(0,1)) = 0.0
	}
		SubShader{
			Tags{ "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows
			#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		half _Metallic;
		half _Smoothness;


		void surf(Input IN,inout SurfaceOutputStandard o) {
			
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex)*_Color;
			o.Albedo = c.rgb;

			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;

		}
		ENDCG
	}
	Fallback "Diffuse"
}