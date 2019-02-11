#include "UnityCG.cginc"

float _DotScale;
float3 _Color;

struct Attributes
{
    float4 position : POSITION;
};

struct Varyings
{
    float4 position : SV_POSITION;
};

Varyings MakeVaryings(float4 position)
{
    Varyings output;
    output.position = position;
    return output;
}

void vert(inout Attributes input)
{
}

[maxvertexcount(4)]
void geom(
    uint primitiveID : SV_PrimitiveID,
	uint instanceID : SV_GSInstanceID,
	point Attributes input[1],
	inout TriangleStream<Varyings> outStream)
{
    float3 rectangle[] =
    {
        float3(-0.5, -0.5, 0),
        float3(-0.5, 0.5, 0),
        float3(0.5, -0.5, 0),
        float3(0.5, 0.5, 0),
    };
    
    float4 worldPos = mul(UNITY_MATRIX_M, input[0].position);
    float3 zAxis = normalize(_WorldSpaceCameraPos - worldPos.xyz);
    float3 xAxis = normalize(cross(zAxis, float3(0, 1, 0)));
    float3 yAxis = normalize(cross(xAxis, zAxis));

    int i;

    // ビルボード処理 ワールド空間でのオフセット値
    float3 worldRectangle[4];
    for (i = 0; i < 4; i++)
    {
        worldRectangle[i] = float4(rectangle[i].x * xAxis + rectangle[i].y * yAxis + rectangle[i].z * zAxis, 0);
    }

    for (i = 0; i < 4; i++)
    {
        float4 pos = mul(UNITY_MATRIX_VP, worldPos + float4(worldRectangle[i] * _DotScale, 0));
        outStream.Append(MakeVaryings(pos));
    }
    outStream.RestartStrip();
}

half4 frag(Varyings input) : SV_Target
{
    return half4(_Color, 1);
}