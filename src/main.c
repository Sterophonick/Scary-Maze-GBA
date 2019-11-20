#include <libheart.h>
#include "collision.h"
#include "game.h"
#include "sound.h"

int main()
{
	hrt_Init();
	hrt_DSPSetBGMode(3);
	hrt_DSPDisableForceBlank();
	hrt_DSPEnableOBJ();
	smGameMain();
}