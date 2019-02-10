Shader "Unlit/GeometryShader1"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#include "GeometryShader1.hlsl"
			ENDCG
		}
	}
}