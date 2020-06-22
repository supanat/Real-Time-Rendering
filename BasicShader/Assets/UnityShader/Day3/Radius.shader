Shader "CGM499/Day3/Radius" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		
		_Center("Center",Vector) = (0,0,0,0)
		_Radius("Radius", Float) = 1.0
		_CircleColor("Circle Color", Color) = (1,0,0,1)
		_CircleWidth("Circle Width",Float) = 2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		fixed4 _Color;
		float3 _Center;
		float _Radius;
		fixed4 _CircleColor;
		float _CircleWidth;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			float d = distance(_Center, IN.worldPos);

			if (d > _Radius && d < _Radius+ _CircleWidth) {

				o.Albedo = _CircleColor;
			}
			else {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c.rgb;
			}
			
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
