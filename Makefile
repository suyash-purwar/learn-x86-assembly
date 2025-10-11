.PHONY: clear project_info message

ASM=nasm

ifeq ($(PPATH), "")
	PPATH=.
endif

$(PPATH)/main: $(PPATH)/main.o
	sudo ld -m elf_i386 -o $(PPATH)/main $(PPATH)/main.o

$(PPATH)/main.o: $(PPATH)/main.asm
	sudo $(ASM) -f elf32 -o $(PPATH)/main.o $(PPATH)/main.asm

run: $(PPATH)/main
	./$(PPATH)/main

clear:
	sudo rm $(PPATH)/*.o $(PPATH)/main

project_info:
	@echo Project name: $(PPATH)
