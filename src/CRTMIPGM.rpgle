**FREE

Ctl-Opt DFTACTGRP(*No);

Dcl-C MAXLINES 500;
Dcl-C MAXOPTS 22; //11 x number of options

/copy 'headers.rpgle'

Dcl-S  gIndex     Int(10);
Dcl-S  gMISrc     Char(80) Dim(MAXLINES);

Dcl-Ds gInputFile LikeDS(File_Temp);

Dcl-Pi CRTMIPGM;
 gIFS     Char(128);
 gPgm     Char(20);
 gPgmText Char(50);
 gPgmOpts Char(MAXOPTS);
End-Pi;

//Ignore vars
Dcl-S iPgmSrcF   Char(20) Inz('*NONE');
Dcl-S iPgmSrcM   Char(10) Inz(' ');
Dcl-S iPgmSrcChg Char(30) Inz(' ');
Dcl-S iPrinter   Char(20) Inz('QSYSPRT   *LIBL     ');
Dcl-S iPRTSTRPAG Int(10)  Inz(1); //Number of printer files?
Dcl-S iPGMPUBAUT Char(10) Inz('*ALL');

//Useful
Dcl-S gOptionCount Int(10) Inz(2);

*InLR = *On;

gInputFile.PathFile = %TrimR(gIFS) + x'00';
gInputFile.OpenMode = 'r' + x'00';
gInputFile.FilePtr  = OpenFile(%addr(gInputFile.PathFile)
                              :%addr(gInputFile.OpenMode));

If (gInputFile.FilePtr <> *Null);
  gIndex = 0;
  dow (ReadFile(%addr(gInputFile.RtvData)
               :%Len(gInputFile.RtvData)
               :gInputFile.FilePtr) <> *null);

    If (%Subst(gInputFile.RtvData:1:1) = x'25');
      Iter;
    ENDIF;

    gInputFile.RtvData =
      %xlate(x'00' + x'25' + x'0D' + x'05':'    ':gInputFile.RtvData);

    gIndex += 1;
    gMISrc(gIndex) = gInputFile.RtvData;

    gInputFile.RtvData = '';
  Enddo;
Endif;

CreateProgram(
  gMISrc:
  gIndex:
  gPgm:
  gPgmText:
  iPgmSrcF:
  iPgmSrcM:
  iPgmSrcChg:
  iPrinter:
  iPRTSTRPAG:
  iPGMPUBAUT:
  gPgmOpts:
  gOptionCount
);

Return;
