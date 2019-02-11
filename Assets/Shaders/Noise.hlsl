// random noise
float RandomNoise(half2 p)
{
    return frac(sin(dot(p, half2(12.9898, 78.233))) * 43758.5453);
}

// block noise
float BlockNoise(half2 st)
{
    half2 p = floor(st);
    return RandomNoise(p);
}

// value noise
float ValueNoise(half2 st)
{
    half2 p = floor(st);
    half2 f = frac(st);

    float v00 = RandomNoise(p + half2(0, 0));
    float v10 = RandomNoise(p + half2(1, 0));
    float v01 = RandomNoise(p + half2(0, 1));
    float v11 = RandomNoise(p + half2(1, 1));
            
    half2 u = f * f * (3.0 - 2.0 * f);

    float v0010 = lerp(v00, v10, u.x);
    float v0111 = lerp(v01, v11, u.x);
    return lerp(v0010, v0111, u.y);
}

half2 random2(half2 st)
{
    st = half2(dot(st, half2(127.1, 311.7)),
                           dot(st, half2(269.5, 183.3)));
    return -1.0 + 2.0 * frac(sin(st) * 43758.5453123);
}

// perlin noise
float PerlinNoise(half2 st)
{
    half2 p = floor(st);
    half2 f = frac(st);
    half2 u = f * f * (3.0 - 2.0 * f);

    float v00 = random2(p + half2(0, 0));
    float v10 = random2(p + half2(1, 0));
    float v01 = random2(p + half2(0, 1));
    float v11 = random2(p + half2(1, 1));

    return lerp(lerp(dot(v00, f - half2(0, 0)), dot(v10, f - half2(1, 0)), u.x),
                         lerp(dot(v01, f - half2(0, 1)), dot(v11, f - half2(1, 1)), u.x),
                         u.y) + 0.5f;
}

// fbm noise
float FBMNoise(half2 st)
{
    float f = 0;
    half2 q = st;

    f += 0.5000 * PerlinNoise(q);
    q = q * 2.01;
    f += 0.2500 * PerlinNoise(q);
    q = q * 2.02;
    f += 0.1250 * PerlinNoise(q);
    q = q * 2.03;
    f += 0.0625 * PerlinNoise(q);
    q = q * 2.01;

    return f;
}