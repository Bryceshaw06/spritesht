SRC = src
INC = inc
BUILD = build
OBJ = $(BUILD)/obj
OUT = $(BUILD)/out

# Homebrew paths for Apple Silicon
BREW_PREFIX = /opt/homebrew
LIBPNG_PATH = $(BREW_PREFIX)/opt/libpng
ZLIB_PATH = $(BREW_PREFIX)/opt/zlib

CFLAGS = -I$(LIBPNG_PATH)/include -I$(ZLIB_PATH)/include -I$(INC) -g
LDFLAGS = -L$(LIBPNG_PATH)/lib -L$(ZLIB_PATH)/lib -lpng -lz
DEP = $(INC)/spritesht_lib.h

all: $(OUT)/spritesht $(OUT)/libspritesht.a

clean:
	rm -rf $(BUILD)

$(OBJ)/%.o: $(SRC)/%.c $(DEP)
	@mkdir -p $(dir $(@))
	gcc -c $(CFLAGS) -o $@ $<

SPRITESHT_OBJ = $(OBJ)/spritesht_lib.o $(OBJ)/spritesht.o
$(OUT)/spritesht: $(SPRITESHT_OBJ)
	@mkdir -p $(dir $(@))
	gcc $(LDFLAGS) -o $@ $(SPRITESHT_OBJ)

$(OUT)/libspritesht.a: $(OBJ)/spritesht_lib.o
	@mkdir -p $(dir $(@))
	ar rcs $@ $<