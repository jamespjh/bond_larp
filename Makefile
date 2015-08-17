PANDOC=pandoc

ROOT=""

PANDOCARGS= -f markdown -Hheader.tex

CHARACTERS=$(filter-out %-in.md %-nl.md,$(wildcard characters/*.md))

INVENTIVE=characters/Q.md characters/Hochschnell.md characters/Presidente.md characters/Conchita.md

NLCHARS=$(CHARACTERS:.md=-nl.md)

INVENNL=$(INVENTIVE:.md=-nl.md)

INVENIN=$(INVENTIVE:.md=-in.md)

default: characters.pdf WEF.pdf

%-in.md: %-nl.md Makefile general/invention_patent_form.md
	cp $< $@
	echo $$'\pagebreak \n' >> $@
	cat general/invention_patent_form.md >> $@ 
	echo $$'\pagebreak \n' >> $@

%-nl.md: %.md Makefile general/General_Info.md
	cp general/General_Info.md $@
	echo $$'\pagebreak \n' >> $@
	cat $< >> $@
	echo $$'\pagebreak \n' >> $@

characters.md: $(filter-out $(INVENNL),$(NLCHARS)) $(INVENIN)
	cat $^ > $@
	cat general/invention_patent_form.md >> $@ 
	echo $$'\pagebreak \n' >> $@
	cat general/invention_patent_form.md >> $@ 
	echo $$'\pagebreak \n' >> $@
	cat general/invention_patent_form.md >> $@ 
	echo $$'\pagebreak \n' >> $@
	cat general/invention_patent_form.md >> $@ 
	echo $$'\pagebreak \n' >> $@

characters.pdf: characters.md Makefile
	$(PANDOC) $(PANDOCARGS) $< -o $@

WEF.pdf: general/text_WEF_invites.md Makefile 
	$(PANDOC) $(PANDOCARGS)  $< -o $@