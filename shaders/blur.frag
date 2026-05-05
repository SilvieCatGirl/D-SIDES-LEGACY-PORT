// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define iResolution vec3(openfl_TextureSize, 0.)
#define iChannel0 bitmap
#define texture flixel_texture2D

uniform int blurammount;
// end of ShadertoyToFlixel header

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    int blurSize = blurammount; // take that many pixels in each direction, so (blurSize+1)^2 pixels total
    
    if(fragCoord.x > iResolution.x) {
        fragColor = texture(iChannel0, fragCoord/iResolution.xy);
    }
    else {
        fragColor = vec4(0, 0, 0, texture(iChannel0, fragCoord / iResolution.xy).a);
        for(int x = -blurSize; x <= blurSize; x++) {
            for(int y = -blurSize; y <= blurSize; y++) {
                vec2 coord = fragCoord + vec2(float(x), float(y));
                fragColor += texture(iChannel0, coord/iResolution.xy) / pow(float(2*blurSize+1), 2.0);
            }
        }
    }
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}