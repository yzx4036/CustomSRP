﻿Shader "CustomSRP/SRP0702/UnlitOpaque"
{
	Properties
	{
		[Header(Main)]
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex ("_MainTex (RGBA)", 2D) = "white" {}
		
		[Header(Emission)]
		[HDR]_EmissionColor("Emission Color", Color) = (1,1,1,1)
		[NoScaleOffset] _EmissionTex ("Emission (RGBA)", 2D) = "Black" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			Tags { "LightMode" = "SRP0702_Pass" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Color;
			sampler2D _EmissionTex;
			float4 _EmissionColor;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float4 col = tex2D(_MainTex, i.uv) * _Color;
				float4 emission = tex2D(_EmissionTex, i.uv) * _EmissionColor;
				return col + emission;
			}
			ENDCG
		}
	}
}