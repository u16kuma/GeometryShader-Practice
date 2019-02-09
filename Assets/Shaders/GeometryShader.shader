Shader "Unlit/GeometryShader"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma geometry geom
			#pragma target 5.0

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
            };

			appdata vert(appdata v)
			{
				return v;
			}

			[maxvertexcount(3)]
			void geom(triangle appdata input[3], inout TriangleStream<v2f> outStream)
			{
				//  ポリゴンの中心算出
				float3 center = (input[0].vertex + input[1].vertex + input[2].vertex) / 3;

				// ポリゴンの法線算出
				float3 edge1 = (input[1].vertex.xyz - input[0].vertex.xyz);
				float3 edge2 = (input[2].vertex.xyz - input[0].vertex.xyz);
				float3 normal = normalize(cross(edge1, edge2));

				[unroll]
				for (int i = 0; i < 3; i++)
				{
					appdata v = input[i];
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.normal = normal;
					outStream.Append(o);
				}

				outStream.RestartStrip();
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return float4(i.normal, 1);
			}
            ENDCG
        }
    }
}
