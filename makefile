HEADERS =
OBJECTS = build/main.o build/collision.o build/game.o build/sound.o build/boo.o build/level1.o build/level2.o build/level3.o build/player.o
CPPFILES =
# SOURCES = src/main.c src/mem.c src/cpu.c src/hardware.c src/keypad.c
ASM =
CFLAGS = -DHRT_WITH_LIBHEART -Wall -march=armv4t -Wno-switch -Wno-multichar -ffast-math -mlong-calls -mcpu=arm7tdmi -mtune=arm7tdmi -marm -faggressive-loop-optimizations -fverbose-asm 
ARCH =  -mthumb-interwork
SPECS = -specs=gba.specs
PREFIX = C:\devkitPro\devkitARM\bin\arm-none-eabi-

default: scarymaze.gba

build/%.o: src/%.c $(HEADERS)
	$(PREFIX)gcc -Os $(CFLAGS) -Iinclude -mthumb $(ARCH) -c $< -o $@
	
build/%.o: src/%.cpp $(HEADERS)
	$(PREFIX)g++ $(CFLAGS) $(ARCH) -c $< -o $@
	
build/%.out: src/%.s
	$(PREFIX)as -mthumb-interwork -mcpu=arm7tdmi $< -o $@
	
build/main.elf: $(OBJECTS)
	$(PREFIX)gcc $(SPECS) -mthumb $(ARCH) $(OBJECTS) -lheart -lm -o build/main.elf
	
scarymaze.gba: build/main.elf
	$(PREFIX)objcopy -O binary build/main.elf scarymaze.gba
	C:/devkitPro/devkitARM/bin/gbafix scarymaze.gba -tSCARYMAZE -cSCMU -v1
	

clean:
	-rm build/*.o build/*.out build/main.elf
	-rm scarymaze.gba