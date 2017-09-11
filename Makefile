#
# For bootstrapping
#
.PHONY: all bootstrap install default

#
# Bootstrap program is omake-boot
#
default:
	@echo "If you have already built omake, you should use it instead of make."
	@echo "If you need to bootstrap, use "
	@echo " - 'make bootstrap',"
	@echo "       to build the bootstrapping (feature-limited) OMake binary './omake-boot'."
	@echo " - 'make all',"
	@echo "       to bootstrap and then build everything"
	@echo " - 'make install',"
	@echo "       to bootstrap, build, and install everything"
	@exit 1

bootstrap: boot/Makefile
	@cd boot; $(MAKE) Makefile.dep; $(MAKE) omake
	@ln -sf boot/omake omake-boot

boot/Makefile: src/Makefile
	mkdir -p boot
	@touch boot/Makefile.dep
	@sleep 1
	ln -sf ../src/Makefile boot/Makefile

all: bootstrap
	touch .config
	OMAKEFLAGS= OMAKEPATH=lib ./omake-boot --dotomake .omake --force-dotomake -j2 main
	OMAKEFLAGS= OMAKEPATH=lib src/main/omake --dotomake .omake --force-dotomake -j2 all

install: all
	OMAKEFLAGS= OMAKEPATH=lib src/main/omake --dotomake .omake --force-dotomake -j2 install

clean:
	rm -rf .config .omake* boot */*.default omake-boot
	rm -f `find lib -name '*.install'`
	rm -f `find . -name '*.cm*'`
	rm -f `find . -name '*.o'`
	rm -f `find . -name '*.opt'`
	rm -f `find . -name '*.a'`
	rm -f `find . -name '*.magic'`
	rm -f src/libmojave/*.ml*
	rm -f src/clib/fam* src/clib/inotify* src/clib/lm_* src/clib/unixsupport.h
	rm -f src/env/omake_ast_lex.ml src/env/omake_ast_parse.ml src/env/omake_ast_parse.mli src/env/omake_ast_parse.mly src/env/omake_exp_parse.ml src/env/omake_exp_parse.mli src/env/omake_gen_parse src/magic/omake_gen_magic src/magic/omake_magic.ml src/main/cvs_realclean src/main/omake src/main/osh src/shell/omake_shell_parse.ml src/shell/omake_shell_parse.mli src/shell/omake_shell_sys.ml src/util/ocaml_patch.ml
