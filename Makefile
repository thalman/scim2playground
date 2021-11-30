all:
	@make -s -C src all

%:
	make -C src $@
