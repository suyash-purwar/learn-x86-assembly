.PHONY: all run clean project_info

ASM      := nasm
ASMFLAGS := -f elf32
LD       := ld
LDFLAGS  := -m elf_i386

PPATH ?= .

ASM_FILES := $(wildcard $(PPATH)/*.asm)
OBJ_FILES := $(ASM_FILES:.asm=.o)

OUT := $(PPATH)/main

all: $(OUT)

$(OUT): $(OBJ_FILES)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

run: $(OUT)
	./$(OUT)

clean:
	rm -f $(PPATH)/*.o $(OUT)

project_info:
	@echo "Project path: $(PPATH)"
	@echo "ASM files: $(ASM_FILES)"
	@echo "OBJ files: $(OBJ_FILES)"