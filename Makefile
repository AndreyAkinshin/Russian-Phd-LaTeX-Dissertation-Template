all: synopsis dissertation

dissertation:
	$(MAKE) -C Dissertation

synopsis:
	$(MAKE) -C Synopsis

draft:
	$(MAKE) draft -C Dissertation
	$(MAKE) draft -C Synopsis
clean:
	$(MAKE) clean -C Dissertation
	$(MAKE) clean -C Synopsis

distclean:
	$(MAKE) distclean -C Dissertation
	$(MAKE) distclean -C Synopsis

release: all
	git add Dissertation/dissertation.pdf
	git add Synopsis/synopsis.pdf
