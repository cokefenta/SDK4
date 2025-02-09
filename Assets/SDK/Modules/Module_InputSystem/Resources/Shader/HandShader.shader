﻿// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

// Simplified Diffuse shader. Differences from regular Diffuse one:
// - no Main Color
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.

Shader "Mobile/SCDiffuse" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "white" {}
        _Alpha("Alpha", Range(0.0, 1.0)) = 1.0
        _Color("Color", Color) = (1,1,1,1)
    }
        SubShader
        {
        
            Tags { "RenderType" = "Opaque" }
            LOD 150

                    ZWrite Off
                    Blend SrcAlpha OneMinusSrcAlpha
                    cull back
            
                    CGPROGRAM
                    #pragma surface surf Lambert noforwardadd keepalpha

                    sampler2D _MainTex;
                    fixed _Alpha;
                    fixed4 _Color;

                    struct Input {
                        float2 uv_MainTex;
                    };

                    void surf(Input IN, inout SurfaceOutput o) {
                        fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
                        o.Albedo = c.rgb;
                        o.Alpha = _Alpha;
                    }
        
                    ENDCG
        }

        //Fallback "Mobile/VertexLit"
}
