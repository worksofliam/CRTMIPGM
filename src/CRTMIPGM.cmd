             CMD        Prompt('Create MI program')
             PARM       KWD(SRC) TYPE(*CHAR) LEN(128) PROMPT('IFS source') ALWUNPRT(*NO)
             PARM       KWD(PGM) TYPE(*CHAR) LEN(20) PROMPT('Qualified program') ALWUNPRT(*NO)
             PARM       KWD(TXT) TYPE(*CHAR) LEN(50) PROMPT('Program text') ALWUNPRT(*NO)
             PARM       KWD(OPTS) TYPE(*CHAR) LEN(22) +
                        PROMPT('Program options') ALWUNPRT(*NO) +
                        DFT('*LIST      *REPLACE')