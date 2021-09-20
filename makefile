NAME=Create MI Program
BIN_LIB=CRTMIPGM
DBGVIEW=*SOURCE
TGTRLS=V7R1M0

#----------

all: crtmipgm.rpgle crtmipgm.cmd  
	@echo "Built all"

#----------

%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('src/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS))"

%.cmd:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QSOURCE) MBR($*) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('src/$*.cmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QSOURCE.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QSOURCE) SRCMBR($*) TEXT('$(NAME)')"
	-system -qi "DLTF FILE($(BIN_LIB)/QSOURCE)"

clean:
	system "CLRLIB $(BIN_LIB)"