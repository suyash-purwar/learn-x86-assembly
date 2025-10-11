.PHONY: run clear project_info message

ASM=nasm

ifeq ($(PPATH), "")
	echo "true"
	PPATH=.
endif

main: main.o
	sudo ld -m elf_i386 -o $(PPATH)/main $(PPATH)/main.o

main.o: message $(PPATH)/main.asm
	sudo $(ASM) -f elf32 -o $(PPATH)/main.o $(PPATH)/main.asm

message:
	@echo Building $(PPATH) ...

run:
	./$(PPATH)/main

clear:
	sudo rm $(PPATH)/*.o $(PPATH)/main

project_info:
	@echo Project name: $(PPATH)
