// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SeaWeed"
{
	Properties
	{
		_SpecColor("Specular Color",Color)=(1,1,1,1)
		_AnimScale("AnimScale", Range( 0 , 1)) = 0.2773981
		_AnimSpeed("AnimSpeed", Range( 0 , 15)) = 1
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float _AnimSpeed;
		uniform float _AnimScale;
		uniform float4 _Color0;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 unityObjectToClipPos15 = UnityObjectToClipPos( float3( 0,0,0 ) );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 temp_cast_0 = (( unityObjectToClipPos15.z + ( _AnimSpeed * _Time.y ) + ase_vertexNormal.y )).xx;
			float simplePerlin2D10 = snoise( temp_cast_0 );
			float temp_output_12_0 = (( _AnimScale * 0.0 ) + (simplePerlin2D10 - 0.0) * (_AnimScale - ( _AnimScale * 0.0 )) / (1.0 - 0.0));
			float3 temp_cast_1 = (temp_output_12_0).xxx;
			v.vertex.xyz += temp_cast_1;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Albedo = _Color0.rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float4 unityObjectToClipPos15 = UnityObjectToClipPos( float3( 0,0,0 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float2 temp_cast_1 = (( unityObjectToClipPos15.z + ( _AnimSpeed * _Time.y ) + ase_vertexNormal.y )).xx;
			float simplePerlin2D10 = snoise( temp_cast_1 );
			float temp_output_12_0 = (( _AnimScale * 0.0 ) + (simplePerlin2D10 - 0.0) * (_AnimScale - ( _AnimScale * 0.0 )) / (1.0 - 0.0));
			float fresnelNdotV2 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode2 = ( temp_output_12_0 + 1.27 * pow( 1.0 - fresnelNdotV2, 4.36 ) );
			float3 temp_cast_2 = (fresnelNode2).xxx;
			o.Emission = temp_cast_2;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf BlinnPhong keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
7;32;1906;979;1161.973;441.3591;1.140049;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;6;-580.3844,332.7787;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-796.8019,237.6953;Float;False;Property;_AnimSpeed;AnimSpeed;2;0;Create;True;0;0;False;0;1;0.32;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;15;-792.5259,-255.9091;Float;False;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-352.2456,225.7788;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;5;-762.1793,-39.87741;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-288.4801,14.18599;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-783.4863,462.9434;Float;False;Property;_AnimScale;AnimScale;1;0;Create;True;0;0;False;0;0.2773981;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-268.8454,354.8398;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;10;-147.8295,-10.44044;Float;False;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;12;-36.66686,521.9802;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2;-203.5755,-378.8814;Float;True;Standard;WorldNormal;ViewDir;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.07;False;2;FLOAT;1.27;False;3;FLOAT;4.36;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;38.67464,-592.8531;Float;False;Property;_Color0;Color 0;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;458.3524,-338.3873;Float;False;True;2;Float;ASEMaterialInspector;0;0;BlinnPhong;SeaWeed;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;0;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;8;0
WireConnection;7;1;6;0
WireConnection;9;0;15;3
WireConnection;9;1;7;0
WireConnection;9;2;5;2
WireConnection;13;0;11;0
WireConnection;10;0;9;0
WireConnection;12;0;10;0
WireConnection;12;3;13;0
WireConnection;12;4;11;0
WireConnection;2;1;12;0
WireConnection;0;0;16;0
WireConnection;0;2;2;0
WireConnection;0;11;12;0
ASEEND*/
//CHKSM=846F68B7A25C16313BAD8140383F4445C821C8B9