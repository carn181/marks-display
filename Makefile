LISP = sbcl
SRC_DIR = ./src
BIN_DIR = ./bin
TEST_DIR = ./test

all: build install

install: build
	sudo cp $(BIN_DIR)/marks-display /usr/bin/
	mkdir -p ~/.local/share/marks-display
	cp -n sample-marks.txt ~/.local/share/marks-display/marks.txt

build: $(wildcard $(SRC_DIR)/*.lisp)
	$(LISP) --noinform \
		--load marks-display.asd \
		--eval '(ql:quickload :marks-display)' \
		--eval '(asdf:make :marks-display)' \
		--eval '(quit)'

clean:
	rm -f $(BIN_DIR)/marks-display
