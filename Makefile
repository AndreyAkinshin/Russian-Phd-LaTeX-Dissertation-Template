all: synopsis dissertation

dissertation:
	$(MAKE) -C Dissertation

synopsis:
	$(MAKE) -C Synopsis

clean:
	$(MAKE) clean -C Dissertation
	$(MAKE) clean -C Synopsis

release: all
	git add Dissertation/dissertation.pdf
	git add Synopsis/synopsis.pdf
