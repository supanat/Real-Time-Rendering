Shader "CGM499/Basic/ScrollingUV"{
	Properties{
		_Color("Color",Color) = (1,1,1,1)
		_MainTex("Texture",2D) = "white"{}
		_Metallic("Metallic",Range(0,1)) = 0.5
		_Smoothness("Smoothness",Range(0,1)) = 0.0

		_ScrollX("X Speed",Range(0,10)) = 4
		_ScrollY("Y Speed",Range(0,10)) = 4
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

		fixed _ScrollX;
		fixed _ScrollY;

		void surf(Input IN,inout SurfaceOutputStandard o) {

			fixed2 scrollUV = IN.uv_MainTex;

			fixed xScroll = _ScrollX * _Time;
			fixed yScroll = _ScrollY * _Time;

			scrollUV += fixed2(xScroll, yScroll);

			fixed4 c = tex2D(_MainTex, scrollUV);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
		Fallback "Diffuse"
}