(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Biblioteka_Grow_4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLIntf, FileUtil, Graphics, Controls, Process, Forms,
  Dialogs, Math, Menus, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, LCLType,
  LResources, EditBtn, Clipbrd, gettext, Printers, FileCtrl, TAGraph, TASeries,
  ShellApi, WinInet, Biblioteka_Grow_4_grafika, General_dll;

  Procedure ShowObject(ProjectNumber:integer);  // jesli -1 to wszytsko
  Procedure HideObject(ProjectNumber:integer);  // jesli -1 to wszytsko
  Procedure SetVizualizationTypeForVisibleMolecules(VisType:string;ScaleCoefficient:string);
  Function  ClickedCoordinatesToProjectNumber(Xclick,Yclick,Zclick:currency):integer;
  Function  ClickedCoordinatesToRecordNumber(Xclick,Yclick,Zclick:currency):integer;
  Procedure GenerateListOfSelectedAtoms();
  Function  ChangeBondParameter(ColumnNumber:integer;FirstAtomNumber,SecondAtomNumber,Value:string):boolean;
  Function  AddAtom(AddNewMolecule:boolean;AtomType,ElementSymbol,x,y,z:string):boolean;
  Function  DeleteAtom(Xclick,Yclick,Zclick:currency):boolean;
  Function  DeleteBonds(ProjectNumber:integer;AtomNumber:integer):boolean;
  Function  DeleteBond(RowNumber:integer):boolean;
  Function  BondExists(FirstAtomNumber,SecondAtomNumber:string):boolean;
  Function  DeleteBondBetweenSelectedAtoms():boolean;
  Function  AddBond():boolean;
  Function  SelectAtom(number:string):boolean; // select atom , atom number id number as a parameter if not exists return false
  Function  ClearSelection(ProjectNumber:integer):boolean; // -1 clear all
  Function  AddNewProjectTable(vis,inc,name,types,original_filename:string):integer; // project number odpowiada numerowi array !
  Function  AddRecord(ProjectNumber:integer):boolean; // project number odpowiada numerowi array !
  Function  DeleteRecord(ProjectNumber:integer;RecordNumber:integer):boolean; // project number odpowiada numerowi array !
  Function  CopyRecordToTempRecord(ProjectNumber:integer;RecordNumber:integer):boolean; // project number odpowiada numerowi array !
  Function  AddPlane(name,color:string):boolean;
  Function  PointsToAngle(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;internal:boolean):currency; // from 3 points results an angle
// moved to -> general dll ->  Procedure AtomProperties(); // aktua;izuje wlasciwosci atomow w panelu bocznym
  Procedure Select();
  Function  AnyAtomNametoPDBname(name:string):string; // any atom nomenclature to corect PDB nomenclature
  Procedure AssignBondsToMolecule(ArrayNumber:integer;ModelType:string); //type_Proteine = 'PRO'; type_Ligand = 'LIG'; type_DNA = 'DNA'; type_RNA = 'RNA';
  Function  BondType(MoleculeType,Res_name_1,AtomPDBName_1,Res_name_2,AtomPDBName_2,Distance:string):string;
  Procedure DeselectAllVisInc();
  Procedure GridtoArray(ArrayName:string;Grid:TstringGrid); // rewrite grid to array
  Procedure ArrayToGrid(ArrayName:string;Grid:TstringGrid); // rewrite array to grid
  Procedure ArrayToConsole(ArrayName:string); // print virtual array to console
  Function  LoadArrayFromFileToGrid(FileName:string; Grid:TStringGrid; Memo:TMemo):boolean;
  Function  LoadArrayFromFile(FileName, ArrayName:string):boolean; // load array from file
  Function  FillComboBox(Combobox:TComboBox;Grid:TstringGrid;Value:String;ColValue,ColName:integer):integer;
  Function  UniversalDirectoryFunction(InitialDir:string):string; // zwraca directory Univetrsal directory dialog
  Function  UniversalOpenFunction(Filter,InitialDir:string):string; // OpenDialog universal form
  Function  AminoacidToColor(OneLetterCode:string;Classification:String):Tcolor; //Classification: C - Clustal; M - MAEditor
  Function UniversalSaveFunction(Filter,InitialDir,Filename:string;Plik:Tstrings):string; // uniwersalna funkcja okna dialogowego ZAPISU universal saveform
  Procedure ExportFastaFormat(StartForomColumn,StartFromRow:integer;Grid:TStringGrid); // every record is a next sequnence, StartForomColumn column contains names and point start from this value +1 to the end of record
  Function  NucleotideToFeature(Value,OutputType:string):string; // Output type : O-OneLetterCode, N-Name, C -color, M - mass, S -surface,
  Function  AminoacidToFeature(Value,OutputType:string):string;  // All characteristics of the aminoacids = Input one, three, name code Output type : T- ThreeLettersCode, O-OneLetterCode, N-Name, F -chemical formula, M - average mass, S - Surface, V - Volume
  Function  FindTextinMemo(memo:Tmemo;text:string;select:boolean;comm:boolean):boolean;
  Procedure FileToCharacterSeparatedField(Field:TlabeledEdit;separator:string); // zamienia kolejne linie w jesen string odzielony separatorem lub laduje caly jeden rekors
  Procedure GridToValuesList(grid:TstringGrid;Values:Tstringlist); // take all not fixed values and convert as stringlist
  Procedure ValuesListToGrid(Values:Tstringlist;grid:TstringGrid); // fill the grid by values from the list - use only as oposite function as GridToValuesList
  Function  GridToConnections(Grid:TstringGrid;GridVisible:string;GridName:string;IndexInProjectTable:integer):boolean; // translate grid do atoms conection list
  Function  SignOfMovement(a,b:TstringList):string; // return sign of average moevement from a to b a->b
  Function  GlobalCheckColumnIf(check:boolean;ColNr:integer;ColNrFrase:Integer;fraza:string;exactly:boolean):boolean;
  Function  AnglePlaneDeviation(x1,y1,z1,x2,y2,z2:Tstringlist):string;
  Function  XYZtoAngleList(x1,y1,z1,x2,y2,z2,AngleList:TstringList):boolean;
  Function  GridColumnToValues(Grid:TstringGrid;VisIncColumnNumber,ColumnNumber:integer;ValueList:Tstringlist):integer; // colect values from column if vis or inc is true
  Procedure PaintGradientColorGrid(Grid:TstringGrid;BeginColor,EndColor:TColor;Steps:Integer;MarkMinMax:boolean);
  Function  CompareLigandsAPA_RMSD_aDVSAM(GridA,GridB:TstringGrid;Results:TstringList;Analise_Number:integer):boolean;  // prowwnuje ligandy podonie jak to ma z proteinami 1-APA, 2-RMSD, 3- aDVSAM
  Function  CompareProteinsAPA_RMSD_aDVSAM(GridA,GridB:integer;Results:TstringList;Analise_Number:integer):boolean; // porownuje mileuly po residues 1-APA, 2-RMSD, 3- aDVSAM
  Function  ArrayToSequence(ProjectNumber:integer;Seq:TstringList;Numbers:boolean):integer; // zwraca sekwencje z numerem lub bez
// moved to -> general_dll ->  Procedure AverageCooridnatesOfVisibleMolecules(XYZ:TstringList;CountOnlyVisible:boolean); // procedura zamienia zmienne na bierzace srednie x, y ,z
  Procedure PaintGradientColorRowColumn(Grid:TstringGrid;IsColumn:boolean;ColRowNumber:integer;BeginColor,EndColor:TColor;Steps:Integer;MarkMinMax:boolean); //zamienia wartosi w tabeli na kolory i maluje nimi
  Procedure GradientScaleToGrid(ColorBegin,ColorEnd:Tcolor;steps:integer;Value:Tstringlist;Grid:TstringGrid;ClearBefore:boolean); // prepare the gradient scale and full the grid by, headers should be prepared before from,to,color
  Procedure GradientColor(ColorBegin,ColorEnd:Tcolor;steps:integer;Value:Tstringlist); // generuje gradient zapisany w liscie jako nazwy kolorow
  Procedure PrintScreen(left,top,width,height:integer);
  Function  DownloadPDBfiles(Files:TstringList;SaveToDir:string):boolean; // pobierz jedno lub serie plikow PDB
  Function  DownloadfileFromInternet(Url,SaveToDir:string):boolean; // pobierz plik
  Procedure ChangeColumnColor(Grid:Tstringgrid;GridX,GridY,col:integer); // zmien kolor komorki w tabeli
  Procedure ColorColumn(Grid:Tstringgrid;aCol,aRow,Col:integer;aRect: TRect); // koloruj komorki po klorach w artosci komorki
  Function  AddPlaneToTable(Grid:TstringGrid;xyz:TstringList;variant,name:string):boolean;     // dodaje table z wspolzednymi plaszyzny
  Procedure InvertSelectionIncRecordsFromGrid(Grid:TstringGrid;Col:integer); // odwroc zaznaczenie komorkek
  Procedure DeleteIncRecordsFromGrid(Grid:TstringGrid;IncColNr:integer;communicate:boolean);  // usun zaznaczone rekordy
  Function  FormCount():integer;
  Procedure read_initial_settings(Sender:Tobject);
  Function  Q2_QSAR(Observed:TStringList;Predicted:TstringList):Currency;
  Function  CoA_percent_N(Observed:TStringList;Predicted:TstringList;Percent:Currency):Currency;
  Function  aCoA(Observed:TStringList;Predicted:TstringList):Currency;
  Function  CoA_percent(Observed:TStringList;Predicted:TstringList;Adequacy:currency):Currency;
  Function  CoA(Observed:TStringList;Predicted:TstringList;Adequacy:currency):Currency;
  Function  CoA_NumberOfCompounds(Observed:TStringList;Predicted:TstringList;Adequacy:currency):Integer;
  Procedure ImportCSV(grid:TstringGrid);
// moved to -> general_dll ->  Procedure MoveCoordinateSystemTo(x,y,z:Currency);
  Function  DVSAM(x1,y1,z1,x2,y2,z2:string;Labels:boolean):string;  // obliczenie pojedynczego dvsam
  Function  DuplicateGrid(name:string;grid:TstringGrid):boolean; // kopjuje tabele
  Function  IncList(list:TstringList):integer;   // podaje ilosc inkludowanych
  Function  ZnakDVSAM(x1,x2:currency):string;   // zwraca 3 kierunki przesuniecia
  Procedure ConvertAtomNmeToAtomSymbol(grid:TstringGrid);
  Procedure GetMoleculeProporties();                  // pobiera wszystkie mozliwe cechy
  Procedure RewriteColumn(col1,col2:integer;grid:TstringGrid);        // przepisuje z col1 do col2
  Procedure WhatVisInc();                                             // sparwdza przyciski ktore sa atomy zaznaczone
  Procedure FillSectionAs(ArrayName:string;ArrayNumber:integer;grid:TstringGrid;col:integer;frase:string); // wypelnia kolune albo atom albo hetatm
  Procedure OpenDefaultBrowser(url:string);                           // otw. przegladarke
  Procedure RepleaceRows(grid:TstringGrid);                           // zamienia 2 zaznaczone rowsy
  Procedure RenumberAtoms();                                          // renumeruje atomy
  Function  RMSDArM(x1,y1,z1,x2,y2,z2:Tstrings):string;               // RMSD ze sredniej arymetycznej
  Function  RMSD(x1,y1,z1,x2,y2,z2:Tstrings;Labels:boolean):string;                  // RMSD
  Function  CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2:TstringList;Labels:boolean):string; // przeksztalca liste na srednie przesuniecie wyrazone +/-
  Function  dlugosc_wektora(x1,y1,z1,x2,y2,z2,ranga:currency):Currency;
  Function  znak_liczby(liczba:string):string;
  Function  FirstCheckedRowNumber(Grid:TstringGrid;col:integer):integer;  // pierwszy inc w project table
  Function  CheckedCount(Grid:TstringGrid;col:integer):integer;
  Procedure AddRecordToPtojectTable(col2,col3,col4,col5,col6,col7,col8,col9:string); // add record to project table
  Procedure SeparateGridByColumn(Grid:TstringGrid;Col:integer);                      // rozbija na nowe tabele jesli sa zniamy w kolumnie
  Function  aAnglePlaneAnalysis(x1,y1,z1,x2,y2,z2:TStringList;Labels:Boolean):string;
  Procedure wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;wynik:TstringList);
  Function  AnglePlaneAnalysis(x11,y11,z11,x12,y12,z12,x13,y13,z13,x21,y21,z21,x22,y22,z22,x23,y23,z23:Currency):Currency;
  Procedure FindFraseInGrid(Grid : TStringGrid; frase:string);
  Procedure SortGridDecrease(Grid : TStringGrid; SortCol:integer);
  Procedure SortGridIncrease(Grid : TStringGrid; SortCol:integer);
  Procedure BondsFromStream(Stream:TstringList);
  Procedure NewProjectGridFromStream(GridNumber:integer;Stream:TstringList);
  Procedure GridFromStream(Grid:Tobject;Stream:TstringList);
  Procedure GridToStream(Grid:Tobject;Stream:TstringList);
  Procedure ArrayToStream(ProjectNumber:integer;Stream:TstringList);
  Function  PredictBoundBaseOnDistance(distance:integer):integer;
  Function  AtomsNumbersToDistatance(AtomA,AtomB:string):currency;     // zamenia numery atomow na odleglosc miedzy nimi
  Function  AtomNumberToAtomName(number:string):string;                // zamenia numer atomu na symbol
  procedure ImportPDBsetionConnect(rekord:string);
  Procedure CheckBondsColumnIf(ArrayNumber:integer;ColNrFrazy:Tstringlist;Frazy:Tstringlist;exactly:boolean;NrColDoWypelnienia:integer;Wartosc:string);
  procedure CheckProjectColumnIf(ArrayNumber:integer;ColNrFrazy:Tstringlist;Frazy:Tstringlist;exactly:boolean;NrColDoWypelnienia:integer;Wartosc:string);
  procedure CheckColumnIf(ArrayName:string;ArrayNumber:integer;grid:TstringGrid;check:boolean;ColNr:integer;ColNrFrase:Integer;fraza:string;exactly:boolean); // ColNr - Vis-1 /Inc-2
  procedure CheckColumn(grid:TstringGrid;check:boolean;ColNr:integer);
  Procedure CheckProjectArrayColumn(ProjectNumber,ColumnNumber:integer;Value:string);
  Procedure CheckBondsArrayColumn(ProjectNumber,ColumnNumber:integer;Value:string);
  procedure ExportAsXML(Sender:Tobject);
  procedure ImportGridAsXML(Sender:Tobject);
  procedure GridAsxMOL(Sender:Tobject);
  Procedure ProjectAsHTML(Sender:Tobject);
  procedure NewProject(Sender:Tobject);
  procedure SaveProjectAs(Sender:Tobject);
  procedure SaveProject(ShowComunicate:boolean);
  procedure CloseProject();
  procedure OpenProject(SenderToParametr:boolean;auto:string);
  procedure GridTranspozeColumnsToRows();
  procedure GridTranspozeRowsToColumns();
  procedure GridGetSelection(Sender:Tobject);
  procedure SelectAllGrid();
  procedure CutGridToClipboard();
  procedure CopyGridToClipboard();
  procedure TrimGrid();
  procedure PasteGridFromClipboard();
  procedure WykresNowaSeria(Chart:Tchart;x,y:TStrings);
  procedure ponumeruj_kolumny(Sender: TObject);
  function  odchylenie_standardowe(kol:Tstrings):string;
  Function  rozstep(kol:Tstrings):Currency ;
  function  wariancja(kol:Tstrings):string;
  function  wspolczynnik_zmiennosci(kol:Tstrings):string;
  procedure QuickSort(var A: array of Currency; iLo, iHi: Integer) ;
// moved to -> general_dll -> and marked as Function average();  -> function  srednia_arytmetyczna(kol:Tstrings):string;
  function  suma(kol:Tstrings):Currency;
  function  mediana(kol:Tstrings):string;
  function  moda(kol:Tstrings):string;
  Function  MinMax(kolumna:Tstrings;isMax:Boolean=True):Currency;
  Function  MinMaxToListIndex(kolumna:Tstrings;isMax:Boolean=True):integer; // zwraca numer indexu w Stringlist
  function  srednia_geometryczna(kol:Tstrings):string;
  function  wspolczynnik_skosnosci(kol:Tstrings):string;
  function  kurtoza(kol:Tstrings):string;
  function  moment4rzedu(kol:Tstrings):string;
  function  kurtoza2(kol:Tstrings):string;
  Function  czy_liczba(liczba:string):Boolean;
  Procedure get_col(TylkoLiczby:integer;NumerKolumny:integer;lista:TStringList;grid:TstringGrid);
  procedure tylko_liczby(Sender: TObject; Key: Char);
  procedure PrintGrid(sGrid: TStringGrid; sTitle: string);
  procedure Grid_as_CSV(grid: TstringGrid; separator: string);
  procedure LoadTranslation(language:string);
  Procedure Show_Model(cm_prog:string;temp:boolean);
  procedure ZaznaczenieNaListe(zaznaczenie:string;lista:Tstrings);
  function  FontToString(Font : TFont ) : string;
  procedure StringToFont(sFont : string; Font : TFont );
  Procedure ListaNaTylkoLiczby(lista:TStringList);
  procedure FileListFromDirectory(dir:string;extention:string;lista:TstringList); // zwraca liste plików w danym folderze
  procedure ExplodeString(delimiter:string;t:string;Lista:Tstrings); // delimiter,string,lista oststni musi konczyc sie separatorem !
  function  TabNameToIndex(pg:Tpagecontrol;nazwa:string):integer;
  procedure ChangeGridFont(Grid:TStringGrid);  // zmien czcionke grida
  procedure ChangeGridColor(Grid:TStringGrid;i:integer); // zmien kolor rowsow patzystych lub nie
  Function  AddNewGrid(vis,inc,name,types,original_filename:string):integer; // add new grid and returns the nmber of the grid
  procedure Save_as_PDB(modele:TStringList;url:string;temp:boolean);
  procedure CloneProperties(const Source: TControl; const Dest: TControl);
  procedure ImportAsPDB(FileName:String);
  procedure PDBlineAsList(linia:string;List:Tstringlist);
  Function  ProjectArrayFunctions(FunctionName:string; ProjectNumber:integer):integer;

implementation

Uses
  Unit1,Unit2,Unit14,Unit9,Unit4,Unit16,Unit17,Unit12,Unit21,Unit22,Unit23,Unit20;

Procedure ShowObject(ProjectNumber:integer);
Var
  i,row:integer;
begin
     for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
    begin
        if ProjectNumber = -1 then
          begin
            for row:= 0 to ProjectArrayFunctions('RowCount',i-1) -1 do
               begin
                  Project[i-1,row,NrColInc]:= '1';
                end;
             Project_table_form.StringGrid1.Cells[NrColProj_Inc,i]:='1';
           end
        else
           begin
              if ProjectNumber = ProjectNumber then
                 begin
                    for row:= 0 to ProjectArrayFunctions('RowCount',ProjectNumber) -1 do
                      begin
                        Project[ProjectNumber,row,NrColInc]:= '1';
                      end;
                      Project_table_form.StringGrid1.Cells[NrColProj_Inc,ProjectNumber+1]:='1';
                  end;
           end;

        end;
end;

Procedure HideObject(ProjectNumber:integer);
Var
  i,row:integer;
begin

  for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
    begin
        if ProjectNumber = -1 then
          begin
            for row:= 0 to ProjectArrayFunctions('RowCount',i-1) -1 do
               begin
                  Project[i-1,row,NrColInc]:= '0';
                end;
             Project_table_form.StringGrid1.Cells[NrColProj_Inc,i]:='0';
           end
        else
           begin
              if ProjectNumber = ProjectNumber then
                 begin
                    for row:= 0 to ProjectArrayFunctions('RowCount',ProjectNumber) -1 do
                      begin
                        Project[ProjectNumber,row,NrColInc]:= '0';
                      end;
                      Project_table_form.StringGrid1.Cells[NrColProj_Inc,ProjectNumber+1]:='0';
                  end;
           end;


        end;
end;

Procedure SetVizualizationTypeForVisibleMolecules(VisType:string;ScaleCoefficient:string);
Var
  i:integer;
begin
  for i:=1 to Project_Table_Form.StringGrid1.RowCount - 1 do
   begin
     if Project_table_form.StringGrid1.Cells[NrColProj_Inc,i] = '1' then
      begin
       if (Project_table_form.StringGrid1.Cells[NrColProj_Type,i] = type_Protein) and (VisType = 'Carbon_Alpha') then
            begin
              Project_table_form.StringGrid1.Cells[NrColProj_Vis_type,i] := 'Carbon_Alpha';
            end
             else
            begin
              Project_table_form.StringGrid1.Cells[NrColProj_Vis_type,i] := VisType;
              g4g_visualisation_type:= VisType;
            end;
      end;
   end;

  Settings.LabeledEdit1.Text:=ScaleCoefficient;

end;

Procedure GenerateListOfSelectedAtoms();
Var
 Proj,Row:integer;
Begin
// --------------------------------------------------------- clear list Selected
 SetLength(Selected, 0, SelectedArrayColCount);
//
  for Proj:=0 to Project_Table_Form.StringGrid1.RowCount-2 do
   begin
     for Row:= 0 to ProjectArrayFunctions('RowCount',Proj) -1 do
      begin
        if Project[Proj,Row,NrColVis] = '1' then
         begin
           CopyRecordToTempRecord(Proj,Row);

           TempRecord[NrColSelected_ProjectNumber]:= inttostr(Proj);
           TempRecord[NrColSelected_OriginalRowNumber]:= inttostr(Row);
           TempRecord[NrColSelected_ObjectType]:= type_Atom;

           AddRecord(-2);
         end;
      end;
   end;
end;

Function  ChangeBondParameter(ColumnNumber:integer;FirstAtomNumber,SecondAtomNumber,Value:string):boolean;
var
 row:integer;          // <- zrobic selected jako odzielna tablice
Begin

  For Row:=0 to Length(Bonds) -1 do
   begin
     if (Bonds[row,NrColBonds_FirstAtomNumber] = FirstAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = SecondAtomNumber)
       or (Bonds[row,NrColBonds_FirstAtomNumber] = SecondAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = FirstAtomNumber) then
     begin
       Bonds[row,ColumnNumber]:=Value;
       Result:=True;
     end;
   end;
  Result:=False;
end;

Function AddAtom(AddNewMolecule:boolean;AtomType,ElementSymbol,x,y,z:string):boolean;
Var
  i:integer;
  Radius,color:string;
Begin

 if AddNewMolecule = true then
   begin
     i:= AddNewProjectTable('0','1','New molecule',type_Ligand,'self');
   end
  else
    begin i:= ProjectArrayFunctions('ProjectCount',-1) -1 end;


   TempRecord[NrColSection]:=type_HeteroAtom;
   TempRecord[NrColVis]:='0';
   TempRecord[NrColInc]:='1';

   inc(LastConectNumber);
   TempRecord[NrColAtomId]:= inttostr(LastConectNumber);

   TempRecord[NrColAtomName]:=AtomType;  //AnyAtomNametoPDBname(name:string):string;
   TempRecord[NrColAlternateLocationIndicator]:='';
   TempRecord[NrColResidueName]:='';
   TempRecord[NrChainIdentifier]:='';
   TempRecord[NrColSequenceNr]:='';
   TempRecord[NrColx]:= x;              //<---------------------------------- poprawić koordynaty
   TempRecord[NrColy]:= y;
   TempRecord[NrColz]:= z; // bo na plasko dodaj na powierzchnie
   TempRecord[NrColOccupancy]:='0';
   TempRecord[NrColTemperatureFactor]:='0';
   TempRecord[NrColElementSymbol]:=ElementSymbol;
   TempRecord[NrColChargeOnTheAtom]:='';

   // radius

     Radius:= AtomSymbolTo('R',ElementSymbol);

     If Radius = '1' then
       begin
         Radius:= AtomSymbolTo('R',AtomNameToElement(AtomType));
       end;

     TempRecord[NrColRadius]:=Radius;

   // color

    Color:= AtomSymbolTo('C',ElementSymbol);

    If Color = 'clFuchsia' then
      begin
        Color:= AtomSymbolTo('C',
        AtomNameToElement(AtomType));
      end;

   TempRecord[NrColColor]:=Color;

   AddRecord(i);

end;

Function  ClickedCoordinatesToProjectNumber(Xclick,Yclick,Zclick:currency):integer;
var
   i,row:integer;
   xs,ys,zs:string;
   radius,x,y,z:currency;

begin
  for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
   begin
     for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
      begin

        x:= StrToCurr(Project[i-1,Row,NrColx]);
        y:= StrToCurr(Project[i-1,Row,NrColy]);
        z:= StrToCurr(Project[i-1,Row,NrColz]);

        radius:= (StrToCurr(Project[i-1,Row,NrColRadius]) + 0.1) * strtofloat(settings.LabeledEdit1.Text);


  if  (Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1') and (Project_table_form.StringGrid1.Cells[NrColProj_Type, i] <> type_Plane) then
     begin
       if (Project[i-1,Row,NrColInc] = '1') and (Xclick < x + radius) and (Xclick > x - radius)
                                            and (Yclick < y + radius) and (Yclick > y - radius)
                                            and (Zclick < z + radius) and (Zclick > z - radius)
       then
         begin
          // identyfie click as a project number
          Result:= i - 1;
           Exit;
         end;
      end;
     end;
   end;
// jak nie zzlaeziono to -1
Result:= -1;
end;

Function ClickedCoordinatesToRecordNumber(Xclick,Yclick,Zclick:currency):integer;
var
   i,row:integer;
   xs,ys,zs:string;
   radius,x,y,z:currency;

begin
  for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
   begin
     for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
      begin

        x:= StrToCurr(Project[i-1,Row,NrColx]);
        y:= StrToCurr(Project[i-1,Row,NrColy]);
        z:= StrToCurr(Project[i-1,Row,NrColz]);

        radius:= (StrToCurr(Project[i-1,Row,NrColRadius]) + 0.1) * strtofloat(settings.LabeledEdit1.Text);


  if  (Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1') and (Project_table_form.StringGrid1.Cells[NrColProj_Type, i] <> type_Plane) then
     begin
       if (Project[i-1,Row,NrColInc] = '1') and (Xclick < x + radius) and (Xclick > x - radius)
                                            and (Yclick < y + radius) and (Yclick > y - radius)
                                            and (Zclick < z + radius) and (Zclick > z - radius)
       then
         begin
          // identyfie click as a record number
           Result:= Row;
           Exit;
         end;
      end;
     end;
   end;

 // jak nie znalziono to -1
 Result:= -1;

end;


Function  DeleteAtom(Xclick,Yclick,Zclick:currency):boolean;
Var
  ProjectNumber,RecordNumber:integer;
begin
// ----------------------------------------------------- Delete record with Atom
    ProjectNumber:= ClickedCoordinatesToProjectNumber(Xclick,Yclick,Zclick);
    RecordNumber:=  ClickedCoordinatesToRecordNumber(Xclick,Yclick,Zclick);

if  (ProjectNumber <> -1) and (RecordNumber <> -1) then
  begin
    DeleteBonds(ProjectNumber,strtoint(Project[ProjectNumber,RecordNumber,NrColAtomId]));
    DeleteRecord(ProjectNumber,RecordNumber); // project number odpowiada numerowi array !

    //Console.AddCommunicate(inttostr(ProjectNumber)+'->'+inttostr(RecordNumber));

     if ProjectArrayFunctions('RowCount', ProjectNumber) = 0 then
     begin
       Project_table_form.StringGrid1.DeleteRow(ProjectNumber + 1);
     end;
  end
end;

Function DeleteBonds(ProjectNumber:integer;AtomNumber:integer):boolean;
Var
 row, col, RowCount, RowEnd :integer;
begin
// ------------------------------------ Delete assigned Bonds to the atom number
// ----------------- Look up for FirstAtomNumber or SecondAtomNumber combination
RowCount:= Length(Bonds);

For Row:=0 to RowCount -1 do
  begin
    RowEnd:= RowCount - 1 - Row;
   // ----------------------------------------- project number or -1 all projects
   if (ProjectNumber = -1) or (ProjectNumber = strtoint(Bonds[RowEnd, NrColBonds_ProjectNumber])) then
     begin
       if (strtoint(Bonds[RowEnd, NrColBonds_FirstAtomNumber]) = AtomNumber) or  (strtoint(Bonds[RowEnd, NrColBonds_SecondAtomNumber]) = AtomNumber) then
         begin
           DeleteBond(RowEnd);
         end;
      end;
  end;
end;

Function  DeleteBond(RowNumber:integer):boolean;
Var
 Col, StartRow: integer;
begin

  for StartRow:= RowNumber to Length(Bonds) -2 do //--------- -2 bo ostatni row
    begin
     for Col:=0 to BondsArrayColCount -1 do
       begin
         Bonds[StartRow,Col] := Bonds[StartRow+1,Col];
       end;
    end;

 Form2.StringGrid.DeleteRow(RowNumber+1);
 SetLength(Bonds,Length(bonds)-1,BondsArrayColCount);

end;

Function BondExists(FirstAtomNumber,SecondAtomNumber:string):boolean;
var
 row:integer;
Begin

  For Row:=0 to Length(Bonds) -1 do
   begin
     if (Bonds[row,NrColBonds_FirstAtomNumber] = FirstAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = SecondAtomNumber)
       or (Bonds[row,NrColBonds_FirstAtomNumber] = SecondAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = FirstAtomNumber) then
     begin
       Result:=True;
       exit;
     end;
   end;
  Result:=False;
end;

Function DeleteBondBetweenSelectedAtoms():boolean;
var
 i,row,StartRow,rowcount,col:integer;
 FirstAtomNumber,SecondAtomNumber:string;
 first:boolean=true;
Begin
// ------------------------------------------------------ do if 2 atoms selected
if  selected_count = 2 then
 begin
 // ----------------------------------------------- find selected atoms' numbers
 For i:=1 to Project_table_form.StringGrid1.RowCount-1 do
  begin
    rowcount:= ProjectArrayFunctions('RowCount',i-1);
     for row:=0 to rowcount -1 do
      begin

      if (Project[i-1,row,NrColVis] = '1') and (First = False) then // second atom
         begin
           SecondAtomNumber:= Project[i-1,row,NrColAtomID];
         end;

      if (Project[i-1,row,NrColVis] = '1') and (First = true) then // first atom
         begin
           FirstAtomNumber:= Project[i-1,row,NrColAtomID];
           First:=false;
         end;

      end;
  end;

// ----------------------------------------- found bond between atoms if exists

// ---------------- Look up for FirstAtomNumber and SecondAtomNumber combination
  For Row:=0 to Length(Bonds) -1 do
   begin
     if (Bonds[row,NrColBonds_FirstAtomNumber] = FirstAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = SecondAtomNumber) then
     begin
       // -------------------------------------------- Rewrite succeding records
         for StartRow:= Row to Length(Bonds) -2 do //--------- -2 bo ostatni row
          begin
            for Col:=0 to BondsArrayColCount -1 do
             begin
               Bonds[StartRow,Col] := Bonds[StartRow+1,Col];
             end;
          end;
        Form2.StringGrid.DeleteRow(Row+1);
        SetLength(Bonds,Length(bonds)-1,BondsArrayColCount);
        break;
     end;
   end;

// ---------------- Look up for SecondAtomNumber and FirstAtomNumber combination
 For Row:=0 to Length(Bonds) -1 do
   begin
     if (Bonds[row,NrColBonds_FirstAtomNumber] = SecondAtomNumber) and  (Bonds[row,NrColBonds_SecondAtomNumber] = FirstAtomNumber) then
     begin
       // -------------------------------------------- Rewrite succeding records
         for StartRow:= Row to Length(Bonds) -2 do //--------- -2 bo ostatni row
          begin
            for Col:=0 to BondsArrayColCount -1 do
             begin
               Bonds[StartRow,Col] := Bonds[StartRow+1,Col];
             end;
          end;
        Form2.StringGrid.DeleteRow(Row+1);
        SetLength(Bonds,Length(bonds)-1,BondsArrayColCount);
        break;
     end;
   end;

// ------------------------------------------------------------- clear selection
   ClearSelection(-1);

   Result:=True;

 end else begin showmessage(com167);  Result:=False; end;
end;

Function  AddBond():boolean;
var
  i,row,rowcount:integer;
  first:boolean=true;
  distance,x1,x2,y1,y2,z1,z2:currency;
begin

if selected_count = 2 then
begin
 for i:=1 to Project_table_form.StringGrid1.RowCount-1 do
  begin
    rowcount:= ProjectArrayFunctions('RowCount',i-1);
     for row:=0 to rowcount -1 do
      begin
      if (Project[i-1,row,NrColVis] = '1') and (First = true) then // first atom
         begin
           TempRecord[NrColBonds_ProjectNumber]:= inttostr(i);
           TempRecord[NrColBonds_Vis]:='0';
           TempRecord[NrColBonds_Inc]:='1';
           TempRecord[NrColBonds_FirstResidueName]:= Project[i-1,row,NrColResidueName];
           TempRecord[NrColBonds_FirstResidueNumber]:= Project[i-1,row,NrColSequenceNr];
           TempRecord[NrColBonds_FirstAtomSymbolPDB]:= Project[i-1,row,NrColAtomName];
           TempRecord[NrColBonds_FirstAtomNumber]:= Project[i-1,row,NrColAtomID];

           TempRecord[NrColBonds_FirstAtomColor]:= Project[i-1,row,NrColColor];

           TempRecord[NrColBonds_FirstX]:= Project[i-1,row,NrColX];
           x1:= strtocurr(Project[i-1,row,NrColX]);

           TempRecord[NrColBonds_FirstY]:= Project[i-1,row,NrColY];
           y1:= strtocurr(Project[i-1,row,NrColY]);

           TempRecord[NrColBonds_FirstZ]:= Project[i-1,row,NrColZ];
           z1:= strtocurr(Project[i-1,row,NrColZ]);

           TempRecord[NrColBonds_FirstElementSymbol]:= Project[i-1,row,NrColElementSymbol];;

           First:=false;
         end;

       if (Project[i-1,row,NrColVis] = '1') and (First = False) then // first atom
         begin // second atom
           TempRecord[NrColBonds_SecondResidueName]:= Project[i-1,row,NrColResidueName];
           TempRecord[NrColBonds_SecondResidueNumber]:= Project[i-1,row,NrColSequenceNr];
           TempRecord[NrColBonds_SecondAtomSymbolPDB]:= Project[i-1,row,NrColAtomName];
           TempRecord[NrColBonds_SecondAtomNumber]:= Project[i-1,row,NrColAtomID];

           TempRecord[NrColBonds_SecondAtomColor]:= Project[i-1,row,NrColColor];

           TempRecord[NrColBonds_SecondX]:= Project[i-1,row,NrColX];
           x2:= strtocurr(Project[i-1,row,NrColX]);

           TempRecord[NrColBonds_SecondY]:= Project[i-1,row,NrColY];
           y2:= strtocurr(Project[i-1,row,NrColY]);

           TempRecord[NrColBonds_SecondZ]:= Project[i-1,row,NrColZ];
           z2:= strtocurr(Project[i-1,row,NrColZ]);

           TempRecord[NrColBonds_SecondElementSymbol]:= Project[i-1,row,NrColElementSymbol];
         end;

         TempRecord[NrColBonds_Distance]:= CurrtoStr(dlugosc_wektora(x1,y1,z1,x2,y2,z2,0));

         TempRecord[NrColBonds_BondType]:= 'S';

      end;
  end;

 if (StrToCurr(TempRecord[NrColBonds_Distance]) > 3) then
  begin
   if (MessageDlg(com22, com166, mtConfirmation,[mbYes, mbNo],0) = mrYes) then
    begin
      AddRecord(-1); // add to Bonds array
    end;
  end else begin AddRecord(-1); end;
end
 else begin showmessage(com165); end;
end;

Function  SelectAtom(number:string):boolean;
var
  i,row,rowcount:integer;
begin

for i:=1 to Project_table_form.StringGrid1.RowCount-1 do
  begin

    rowcount:= ProjectArrayFunctions('RowCount',i-1);

     for row:=0 to rowcount -1 do
      begin
      if (Project[i-1,row,NrColAtomId] = number) then // first atom
         begin
           Project[i-1,row,NrColVis] := '1';
           Result:= true;
           exit;
         end;

      end;
     Result:=false;
   end;
end;

Function  ClearSelection(ProjectNumber:integer):boolean; // -1 clear all slection
Var
 NrProj,Row:integer;
begin

for NrProj:=0 to Project_table_form.StringGrid1.RowCount -2 do
   begin

     Project_table_form.StringGrid1.Cells[NrColProj_Vis,NrProj+1]:='0';

     if (NrProj = ProjectNumber) or (ProjectNumber = -1) then
      begin
        for Row:= 0 to ProjectArrayFunctions('RowCount',NrProj)-1 do
          begin
            Project[NrProj,Row,NrColVis]:='0';
          end;
      end;
   end;
// --------------------------------------------------------- Clear list Selected
SetLength(Selected, 0, SelectedArrayColCount);

end;

Function AddNewProjectTable(vis,inc,name,types,original_filename:string):integer; // result:= numer projektu
Var
 nowa:TTabsheet;
 grid:Tstringgrid;
 i:integer;
 dir:string;
 number:integer;

begin
// --------------------------------------------------------- Switch OFF draw 3D
//Start3dDraw:=false;
//---------------------------------------------------------- Add new StringGrid

// ------------------------------------------------------ Add new Project Array
  SetLength(Project,Length(Project)+1);
// --------------------------------------- Add new record to Project Table Form
   // add entry to project table
     project_table_form.StringGrid1.RowCount:=project_table_form.StringGrid1.RowCount+1;
   // NO.
     project_table_form.StringGrid1.Cells[0,project_table_form.StringGrid1.RowCount-1]:= inttostr(newGrid -1);
   // vis / inc
     project_table_form.StringGrid1.Cells[1,project_table_form.StringGrid1.RowCount-1]:= vis;
     project_table_form.StringGrid1.Cells[2,project_table_form.StringGrid1.RowCount-1]:= inc;
   // Model name
     project_table_form.StringGrid1.Cells[3,project_table_form.StringGrid1.RowCount-1]:= name;
   // TYPE
     project_table_form.StringGrid1.Cells[4,project_table_form.StringGrid1.RowCount-1]:= types;
   // orginal file name
     project_table_form.StringGrid1.Cells[5,project_table_form.StringGrid1.RowCount-1]:= original_filename;

// --------------------------------------------------------------------- Result
Result:= Length(Project)-1; //result:= Numer projektu
// ---------------------------------------------------------- Switch ON draw 3D
project_table_form.StringGrid1.Visible:=true;

//Start3dDraw:=true;
end;

Function AddRecord(ProjectNumber:integer):boolean; // project number odpowiada numerowi array !
Var
 i,RowCount:integer;

begin
// ---------------------------------------------------------- Switch OFF draw 3D
//Start3dDraw:=false;
if ProjectNumber > -1 then  // > -1 -> Grid
 begin
// --------------------------------------------------------- Add Row into Array

    SetLength(Project[ProjectNumber],
              ProjectArrayFunctions('RowCount',ProjectNumber)+1
              ,ProjectArrayColCount);

    RowCount:= ProjectArrayFunctions('RowCount',ProjectNumber);


 for i:=0 to 19 do
    begin
      Project[ProjectNumber,RowCount-1,i]:= TempRecord[i];
    end;
 end;

// --------------------------------------------------- Add record to Bonds array
if ProjectNumber = -1 then  // = -1 -> Bonds
 begin
 // ---------------------------------------------------- Add Row Into Bonds Grid
    Form2.Stringgrid.rowcount := Form2.Stringgrid.rowcount +1;
 // --------------------------------------------------------- Add Row into Array

     SetLength(Bonds,Length(bonds)+1,BondsArrayColCount);

     RowCount:= Length(bonds);

  for i:=0 to 22 do
     begin
       Bonds[RowCount-1,i]:= TempRecord[i];
      // Form2.stringgrid.Cells[i,RowCount]:=TempRecord[i];
     end;
  end;

// ----------------------------------------------------------- Switch ON draw 3D

// ------------------------------------------------ Add record to Selected array
if ProjectNumber = -2 then  // = -2 -> Selected
 begin
// --------------------------------------------------------- Add Row into Array

     SetLength(Selected,Length(Selected)+1,SelectedArrayColCount);

     RowCount:= Length(Selected);

  for i:=0 to SelectedArrayColCount -1 do
     begin
       Selected[RowCount-1,i]:= TempRecord[i];
     end;
  end;
// ---------------------------------------------------------- Switch ON draw 3D

//Start3dDraw:=true;
end;

Function DeleteRecord(ProjectNumber:integer;RecordNumber:integer):boolean; // project number i record number odpowiada numerowi array !
Var
 Row,Col:integer;
begin
// ---------------------------------------------------------- Switch OFF draw 3D
//Start3dDraw:=false;
// ------------------------------------------------------------- Rewrite Records
for row:= RecordNumber to ProjectArrayFunctions('RowCount', ProjectNumber) - 2 do
 begin
  for col:=0 to ProjectArrayFunctions('ColCount', ProjectNumber) -1 do
   begin
     Project[ProjectNumber,Row,Col]:= Project[ProjectNumber,Row+1,Col];
   end;
 end;
try
// ------------------------------------------------------------- Delete last row
SetLength(Project[ProjectNumber],Length(Project[ProjectNumber])-1);
except
end;
// ---------------------------------------------------------- Switch ON draw 3D
//Start3dDraw:=true;
end;

Function CopyRecordToTempRecord(ProjectNumber:integer;RecordNumber:integer):boolean; // project number odpowiada numerowi array !
Var
 i,RowCount:integer;
begin
// --------------------------------------------------- Rewrite Row on TempRecord
 for i:=0 to 19 do
    begin
      TempRecord[i]:=Project[ProjectNumber,RecordNumber,i];
    end;
end;

Function AddPlane(name,color:string):boolean;
Var
  i,row,NewTableNumber:integer;
Begin
// ----------------------------------------------------- Selected atom count = 3
if selected_count = 3 then
 begin
// --------------------------------------------------------------- Add new table
  NewTableNumber:= AddNewProjectTable('0','0',name,type_Plane,'');
// --------------------------------------------- Rewrite selected (Vis.) Records
  For i:= 1 to Project_Table_Form.StringGrid1.RowCount -2 do
    begin
      For row:=0 to ProjectArrayFunctions('RowCount',i-1) -1 do
        begin
          if Project[i-1,Row,NrColVis] = '1' then
           begin
             CopyRecordToTempRecord(i-1,row);
             TempRecord[NrColVis]:= '1';
             TempRecord[NrColColor]:= color;
             AddRecord(NewTableNumber);
           end;
        end;
    end;
// ---------------------------------------------------- Post rewrite end options
ClearSelection(-1); // clear selection all project

Project_Table_Form.StringGrid1.Cells[NrColProj_Vis,Project_Table_Form.StringGrid1.RowCount-1]:='0';
Project_Table_Form.StringGrid1.Cells[NrColProj_Inc,Project_Table_Form.StringGrid1.RowCount-1]:='1';
 end;
end;

Function  PointsToAngle(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;internal:boolean):currency; // from 3 points results an angle
Var
  vx1,vy1,vz1,vx2,vy2,vz2:currency;
  v1mag,v1normX,v1normY,v1normZ,v2mag,v2normX,v2normY,v2normZ,res:currency;
begin
  vx1:= x1 - x2;
  vy1:= y1 - y2;
  vz1:= z1 - z2;
  vx2:= x3 - x2;
  vy2:= y3 - y2;
  vz2:= z3 - z2;

  // normalize vector1
  v1mag:= sqrt(vx1 * vx1 + vy1 * vy1 + vz1 * vz1);
  v1normX:= vx1 / v1mag;
  v1normY:= vy1 / v1mag;
  v1normZ:= vz1 / v1mag;

 // normalize vector 2
  v2mag:= sqrt(vx2 * vx2 + vy2 * vy2 + vz2 * vz2);
  v2normX:= vx2 / v2mag;
  v2normY:= vy2 / v2mag;
  v2normZ:= vz2 / v2mag;

  res:= v1normX * v2normX + v1normY * v2normY + v1normZ * v2normZ;

  Result:= RadToDeg(arccos(res));

end;

Procedure Select();
var
  i,row:integer;
  xs,ys,zs:string;
  radius,x,y,z:currency;
begin
 for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
  begin
    for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
     begin

       x:= StrToCurr(Project[i-1,Row,NrColx]);
       y:= StrToCurr(Project[i-1,Row,NrColy]);
       z:= StrToCurr(Project[i-1,Row,NrColz]);

       radius:= (StrToCurr(Project[i-1,Row,NrColRadius]) + 0.1) * strtofloat(settings.LabeledEdit1.Text);


 if  (Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1') and (Project_table_form.StringGrid1.Cells[NrColProj_Type, i] <> type_Plane) then
    begin
       if (Project[i-1,Row,NrColInc] = '1') and (ThreeDpositionXclick < x + radius) and (ThreeDpositionXclick > x - radius) and (ThreeDpositionYclick < y + radius) and (ThreeDpositionYclick > y - radius) and (ThreeDpositionZclick < z + radius ) and ( ThreeDpositionZclick > z - radius)
      then
        begin
          if Project[i-1,Row,NrColVis] = '1' then
            begin
               Project[i-1,Row,NrColVis]:='0';
            end
           else
            begin
               Project[i-1,Row,NrColVis]:='1';
            end;
        end;

     end;
    end;

  end;
end;

Function AnyAtomNametoPDBname(name:string):string;  // chnage the nomenclature from any atoms names to PDB name
Var
  row,col:integer;
  nazwa:string;
  easyconversion:string;
begin
                                                                               //-> sprawdzic
  if Czy_liczba(Copy(name,1,1)) = true then
   begin
    easyconversion:= Copy(name,2,Length(name))+Copy(name,1,1);

   // console.AddCommunicate(name+'='+easyconversion,true);

         for row:=0 to Length(Protein_bonds_def) -1 do  // all rows in array
           begin
             for col:=2 to Length(Protein_bonds_def[0]) -1 do // all columns like sybyl nomenclature etc.
               begin
                 if Uppercase(Protein_bonds_def[row,col]) = Uppercase(easyconversion) then
                   begin
                     Result:= Uppercase(Protein_bonds_def[row,col]);
                     exit;
                   end

               end;
         end;
    end;


  for row:=0 to Length(Atoms_nomenclature) -1 do  // all rows in array
    begin
      for col:=2 to Length(Atoms_nomenclature[0]) -1 do // all columns like sybyl nomenclature etc.
        begin
        if Uppercase(Atoms_nomenclature[row,col]) = Uppercase(name) then
           begin
             Result:= Uppercase(Atoms_nomenclature[row,1]); // 1 bo kolumna PDB name
             exit;
           end
            else
            begin //nazwa:= name;
              if Czy_liczba(Copy(name,1,1)) = true then    //------------------------------------------------------------> to do
                 begin
                   nazwa:= Copy(name,2,Length(name))+Copy(name,1,1);
                 end;

            end; // jak nie znaleziono to wzroc to co bylo na pocztaku
        end;
    end;

 Result:= nazwa;
end;

Procedure AssignBondsToMolecule(ArrayNumber:integer;ModelType:string); //type_Protein = 'PRO'; type_Ligand = 'LIG'; type_DNA = 'DNA'; type_RNA = 'RNA';
var
  i,row,rowcount,Bonds_start_rows_count,position:integer;
  Bonddtype,x1,y1,z1,x2,y2,z2,MoleculeType,Res_name_1,AtomPDBName_1,Res_name_2,AtomPDBName_2 :string;
  distance:currency;
begin

 rowcount:= ProjectArrayFunctions('RowCount',ArrayNumber);

 Bonds_start_rows_count:= Length(Bonds);

 SetLength(Bonds,Bonds_start_rows_count+(rowcount*5),BondsArrayColCount);

 position:=Bonds_start_rows_count-1; // pocztakowa wartosc dopisywanego wiersza

 for i:=0 to rowcount -1 do // przejdz przez wszytskie rowsy
    begin
      for row:=0 to rowcount -1 do // przejdz przez wszytskie rowsy szukanie
        begin

          x1:= Project[ArrayNumber,row,NrColx];
          y1:= Project[ArrayNumber,row,NrColy];
          z1:= Project[ArrayNumber,row,NrColz];

          x2:= Project[ArrayNumber,i,NrColx];
          y2:= Project[ArrayNumber,i,NrColy];
          z2:= Project[ArrayNumber,i,NrColz];

          distance:= dlugosc_wektora(strtocurr(x1),
                                     strtocurr(y1),
                                     strtocurr(z1),
                                     strtocurr(x2),
                                     strtocurr(y2),
                                     strtocurr(z2),0);

             Res_name_1:= Project[ArrayNumber,row,NrColResidueName];
          AtomPDBName_1:= Project[ArrayNumber,row,NrColAtomName];

             Res_name_2:= Project[ArrayNumber,i,NrColResidueName];
          AtomPDBName_2:= Project[ArrayNumber,i,NrColAtomName];

           Bonddtype:= BondType(ModelType,       // MoleculeType
                               Res_name_1,      // Res_name_1
                               AtomPDBName_1,   // AtomPDBName_1
                               Res_name_2,      // Res_name_2
                               AtomPDBName_2,   // AtomPDBName_2
                               currtostr(distance)); // Distance

        if Bonddtype <> 'N' then
           begin

             inc(position); // zwaksz o jeden pozycje wiersza

             Bonds[position,0]:=  inttostr(ArrayNumber);                      // [0]  Molecule number = project number = array numer
             Bonds[position,1]:=  Project[ArrayNumber,row,NrColVis];          // [1]  Vis.
             Bonds[position,2]:=  Project[ArrayNumber,row,NrColInc];          // [2]  Inc.
             Bonds[position,3]:=  Res_name_1;                                 // [3]  First residue name (3 leter code)
             Bonds[position,4]:=  Project[ArrayNumber,row,NrColSequenceNr];   // [4]  First residue number
             Bonds[position,5]:=  AtomPDBName_1;                              // [5]  First atom symbol PDB
             Bonds[position,6]:=  Project[ArrayNumber,row,NrColAtomId];       // [6]  First atom number
             Bonds[position,7]:=  Res_name_2;                                 // [7]  Second residue name
             Bonds[position,8]:=  Project[ArrayNumber,i,NrColSequenceNr];     // [8]  Second residue number
             Bonds[position,9]:=  AtomPDBName_2;                              // [9]  Second atom symbol PDB
             Bonds[position,10]:= Project[ArrayNumber,i,NrColAtomId];         // [10] Second atom number
             Bonds[position,11]:= Bonddtype;                                  // [11] Bond type
             Bonds[position,12]:= currtostr(Distance);                        // [12] Distance

           if Bonddtype > '' then
            begin
             Bonds[position,13]:= AtomSymbolTo('C',Project[ArrayNumber,row,NrColElementSymbol]); // [13] First atom color
             Bonds[position,14]:= AtomSymbolTo('C',Project[ArrayNumber,i,NrColElementSymbol]); // [14] Second atom color
            end;

             Bonds[position,15]:= x1;                                         //[15] First X
             Bonds[position,16]:= y1;                                         //[16] First Y
             Bonds[position,17]:= z1;                                         //[17] First Z
             Bonds[position,18]:= x2;                                         //[18] Second X
             Bonds[position,19]:= y2;                                         //[19] Second Y
             Bonds[position,20]:= z2;                                         //[20] Second Z
             Bonds[position,21]:= Project[ArrayNumber,row,NrColElementSymbol];//[21] First element symbol
             Bonds[position,22]:= Project[ArrayNumber,i,NrColElementSymbol];  //[22] Second element symbol
            end;

           end;
        end;
 // obetnij nadmiar pustych
 SetLength(Bonds,Position,BondsArrayColCount);

end;

{
Function Searh_H_Bonds(object1; object2, distance_min,distance_max);
begin
if (StrToCurr(Distance) > 1.7) and (StrToCurr(Distance) < 3.5) then
 begin
   // wiazaie wodorowe //  dac mozliwosc ustalenia
 end;
end;
}

Function BondType(MoleculeType,Res_name_1,AtomPDBName_1,Res_name_2,AtomPDBName_2,Distance:string):string; // N-none, S-single,D-double,T-friple, AR -aromatic, HB- hydrogen bond
var                                                                                                           // U - undefined
 i,b:integer;                                                                                                   // ? - unknown
 result_bond:string;
 radius:currency;
begin                 // PRO, LIG, DNA  // Res_name 3 letter code

if (StrToCurr(Distance) > 0) and (StrToCurr(Distance) <= 1.9) then  // nomenklatura wiazan jak w http://www.bmrb.wisc.edu/ref_info/atom_nom.tbl
begin
 // PROTEIN
if MoleculeType = type_Protein then // PRO
  begin
    If Res_name_1 = Res_name_2 then // jak naleza do tego samego residue
      begin

       result_bond:='N';

       for i:=0 to length(Protein_bonds_def)-1 do
          begin     // Three letter code                   First element name (PDB nomenclature)      Second element name (PDB nomenclature)
            if (Uppercase(Protein_bonds_def[i,1]) = Uppercase(Res_name_1))
            and (Uppercase(Protein_bonds_def[i,3]) = Uppercase(AtomPDBName_1))
            and (Uppercase(Protein_bonds_def[i,5]) = Uppercase(AtomPDBName_2)) then
              begin
                Result:= Protein_bonds_def[i,7];
                exit;
              end;
          end;

        // dodoac koncowe residue  c i n koniec OTX
        {
        # Terminal carboxyl atoms  -> OXT
        }
       Result := 'N'
      end
     else
       begin // jesli rozne residue, to tylko wiazanie
        if ((Uppercase(AtomPDBName_1) = 'C') and (Uppercase(AtomPDBName_2) = 'N')) then
          begin
            Result:= 'S';
          end;
       end;
  end;

// DNA & RNA

  if MoleculeType = type_DNA then // DNA
    begin
      showmessage('Scientific assays for DNA and RNA not implemented.');
    end;


// LIGAND

if MoleculeType = type_Ligand then // Lig
    begin

     radius:=0;

       if (Uppercase(AtomNameToElement(AtomPDBName_1)) = 'H') and (Uppercase(AtomNameToElement(AtomPDBName_2)) = 'H') then
        begin
         Result := 'N';
        end
         else
        begin

          for i:=1 to length(Atoms_def)-1 do // od 1 bo bez wodoru
            begin
              if (Uppercase(Protein_bonds_def[i,1]) = Uppercase(AtomPDBName_1))
              or (Uppercase(Protein_bonds_def[i,1]) = Uppercase(AtomPDBName_2)) then
                begin
                  radius:= radius + strtocurr(Atoms_def[i,6]);
                end;
            end;

         if radius <= strtocurr(Distance) then
           begin
             Result := 'S'
           end
            else begin Result := 'N' end;

         end;

    end;


end
  else begin Result:='N' end;

end;

Procedure GridtoArray(ArrayName:string;Grid:TstringGrid); // rewrite grid to array
Var
 row,col,rowcount,colcount,project_number:integer;
begin

if Copy(ArrayName,0,7) = 'Project' then
   begin

    project_number:= strtoint(Copy(ArrayName,8,Length(ArrayName)));

    rowcount:= TstringGrid(grid).RowCount;
    colcount:= TstringGrid(grid).ColCount;

     for row:=0 to rowcount -2 do
       begin
         for col:=0 to colcount -1 do
           begin
             Project[project_number,row,col]:=TstringGrid(grid).cells[col,row+1];
           end;
       end;
       SetLength(Project[project_number],TstringGrid(grid).RowCount -1);
    end;

end;

Procedure ArrayToGrid(ArrayName:string;Grid:TstringGrid); // rewrite array to grid
Var
 row,col,rowcount,colcount,project_number:integer;
begin

if ArrayName = 'Bonds' then
   begin
    rowcount:= Length(Bonds);
    colcount:= Length(Bonds[0]);

    TstringGrid(grid).rowcount:= rowcount +1;

     for row:=0 to rowcount -1 do
       begin
         for col:=0 to colcount -1 do
           begin
             TstringGrid(grid).cells[col,row+1]:= Bonds[row,col];
           end;
       end;
    end;

if Copy(ArrayName,0,7) = 'Project' then
   begin

    project_number:= strtoint(Copy(ArrayName,8,Length(ArrayName)));

    rowcount:= ProjectArrayFunctions('RowCount',project_number);
    colcount:= ProjectArrayFunctions('ColCount',project_number);

    TstringGrid(grid).rowcount:= rowcount +1;

     for row:=0 to rowcount -1 do
       begin
         for col:=0 to colcount -1 do
           begin
             TstringGrid(grid).cells[col,row+1]:= Project[project_number,row,col];
           end;
       end;
    end;

if Copy(ArrayName,0,7) = 'Objects' then
   begin

    project_number:= strtoint(Copy(ArrayName,8,Length(ArrayName)));

    rowcount:= ObjectRowsCount(project_number);
    colcount:= Objects_ColCount;

    TstringGrid(grid).rowcount:= rowcount +1;

     for row:=0 to rowcount -1 do
       begin
         for col:=0 to colcount -1 do
           begin
             TstringGrid(grid).cells[col,row+1]:= Objects[project_number,row,col];
           end;
       end;
    end;

end;

Procedure DeselectAllVisInc();
Var
 i,rows:integer;
begin
  For i:=1 to Project_table_form.StringGrid1.RowCount-1 do    // Atoms
   begin

     Project_table_form.StringGrid1.Cells[NrColProj_Vis,i]:='0';
     Project_table_form.StringGrid1.Cells[NrColProj_Inc,i]:='0';

   for rows:=0 to ProjectArrayFunctions('RowCount',i-1) -1 do
     begin

       Project[i-1,rows,NrColVis]:='0';
       Project[i-1,rows,NrColInc]:='0';

     end;
   end;

  For rows:=1 to Form2.StringGrid.RowCount -1 do   //Bonds
     begin
         Form2.StringGrid.Cells[NrColVis,rows]:='0';
         // Form2.StringGrid.Cells[NrColInc,rows]:='0';

        Bonds[rows-1,NrColVis]:='0';
        Bonds[rows-1,NrColInc]:='0';
       end;
end;

Procedure ArrayToConsole(ArrayName:string);
Var
 Col,Row,i:integer;
 line:string;
begin
  Console.Show;

If UpperCase(ArrayName) = UpperCase('Objects') then
 begin
For i:=0 to Length(Objects) -1 do
 begin
  For Row:=0 to Length(Objects[i]) -1 do
   begin
    line:=inttostr(i)+': ';
     For Col:=0 to Length(Objects[i,Row]) - 1 do
      begin
        line:= line+ ' | '+ Objects[i,Row,Col]+' | ';
      end;
     Console.Memo1.Lines.Add(line);
   end;
  end;
 end;

If UpperCase(ArrayName) = UpperCase('ObjectsList') then
   begin
    For Row:=0 to Length(ObjectsList) -1 do
     begin
      line:='';
       For Col:=0 to Length(ObjectsList[0]) - 1 do
        begin
          line:= line+ ObjectsList[Row,Col]+' ';
        end;
       Console.Memo1.Lines.Add(line);
     end;
   end;

If UpperCase(ArrayName) = UpperCase('Selected') then
   begin
    For Row:=0 to Length(Selected) -1 do
     begin
      line:='';
       For Col:=0 to Length(Selected[0]) - 1 do
        begin
          line:= line+ Selected[Row,Col]+' ';
        end;
       Console.Memo1.Lines.Add(line);
     end;
   end;

If UpperCase(ArrayName) = UpperCase('Bonds') then
  begin
   For Row:=0 to Length(Bonds) -1 do
    begin
     line:='';
      For Col:=0 to Length(Bonds[0]) - 1 do
       begin
         line:= line+ Bonds[Row,Col]+' ';
       end;
      Console.Memo1.Lines.Add(line);
    end;
  end;

If UpperCase(ArrayName) = UpperCase('Protein_bonds_def') then
  begin
   For Row:=0 to Length(Protein_bonds_def) -1 do
    begin
     line:='';
      For Col:=0 to Length(Protein_bonds_def[0]) - 1 do
       begin
         line:= line+ Protein_bonds_def[Row,Col]+' ';
       end;
      Console.Memo1.Lines.Add(line);
    end;
  end;

If UpperCase(ArrayName) = UpperCase('Atoms_def') then
 begin
  For Row:=0 to Length(Atoms_def) -1 do
   begin
    line:='';
     For Col:=0 to Length(Atoms_def[0]) - 1 do
      begin
        line:= line+ Atoms_def[Row,Col]+' ';
      end;
     Console.Memo1.Lines.Add(line);
   end;
 end;

If UpperCase(ArrayName) = UpperCase('Atoms_nomenclature') then
 begin
  For Row:=0 to Length(Atoms_nomenclature) -1 do
   begin
    line:='';
     For Col:=0 to Length(Atoms_nomenclature[0]) - 1 do
      begin
        line:= line+ Atoms_nomenclature[Row,Col]+' ';
      end;
     Console.Memo1.Lines.Add(line);
   end;
 end;

If UpperCase(ArrayName) = UpperCase('Project') then
 begin
For i:=0 to Length(Project) -1 do
 begin
  For Row:=0 to Length(Project[i]) -1 do
   begin
    line:=inttostr(i)+': ';
     For Col:=0 to Length(Project[i,Row]) - 1 do
      begin
        line:= line+ Project[i,Row,Col]+' ';
      end;
     Console.Memo1.Lines.Add(line);
   end;
  end;
 end;


end;

Function LoadArrayFromFileToGrid(FileName:string; Grid:TStringGrid; Memo:TMemo):boolean;
Var
 Plik,temp:TstringList;
 linia,headers:string;
 Col,Row,bbegin,eend,i,a:integer;
begin

// create list
 Plik:= TstringList.Create;
 Temp:=TstringList.Create;
// load file
 Plik.LoadFromFile(UTF8decode(FileName));

  Col:=0;
  Row:=0;
  bbegin:=0;
  eend:=0;
  Memo.Lines.Clear;

   Grid.ColCount:=0;
   Grid.RowCount:=0;

 for i:=0 to Plik.Count -1 do
 begin

  Linia:=Plik[i];

  if Copy(Linia,0,1) = '#' then  // komentarz do Memo
    begin
      Memo.Lines.Add(linia);
    end;
  if Copy(Linia,0,1) <> '#' then  // nie komentarz
    begin

      If Pos('Col',Copy(Linia,0,6)) > 0 then
       begin                                // number of columns
         Col:= StrToInt(Copy(Linia,Pos('<',Linia)+1,Pos('>',Linia)-Pos('<',Linia)-1));
       end;
      If Pos('Row',Copy(Linia,0,6)) > 0 then
       begin                              // number of rows
         Row:= StrToInt(Copy(Linia,Pos('<',Linia)+1,Pos('>',Linia)-Pos('<',Linia)-1));
       end;

      If Copy(Linia,0,7) = 'Headers' then
       begin                              //
         headers:= Copy(Linia,Pos('<',Linia)+1,Pos('>',Linia)-Pos('<',Linia)-1);
       end;

      If Copy(Linia,0,5) = 'Begin' then
       begin                              //
         bbegin:= i+1; // bo od nastepnej lini
       end;

       If Copy(Linia,0,3) = 'End' then
       begin                              //
         eend:= i;
       end;

    end;
 end;

 if  (Col <> 0) and (Row <> 0) and (bbegin <> 0) and (eend <> 0) then
    begin
       //   SetLength
       Grid.ColCount:=Col;
       Grid.FixedRows:=1;
       Grid.RowCount:=Row+1;

       // Headers
       ExplodeString(';',Headers,Temp);

          for a:= 0 to Temp.Count-1 do
            begin
              Grid.Cells[a,0]:=Temp[a];
            end;

       // all rows
        for i:=1 to Grid.RowCount -1 do
          begin

          if Copy(Linia,0,1) <> '#' then // na wszelki wypadek jak momentazre albo wylazceie czegos w content
           begin

            ExplodeString(';',Plik[bbegin+i-1],Temp);

                for a:= 0 to Temp.Count-1 do // all colas fill by tempa values explode from line
                  begin
                    Grid.Cells[a,i]:= Temp[a];
                  end;

           end;
          end;

         Result:=True;
    end
     else begin Showmessage('Cannot load array, syntax error in file: '+FileName+'.gtbl'); Result:=False; end;

 Grid.AutoSizeColumns;

 Plik.Free;
 Temp.Free;
end;

Function LoadArrayFromFile(FileName, ArrayName:string):boolean;
Var
 Plik,temp:TstringList;
 linia:string;
 Col,Row,bbegin,eend,i,a:integer;
begin

// create list
 Plik:= TstringList.Create;
 Temp:=TstringList.Create;
// load file
 Plik.LoadFromFile(UTF8decode(FileName));

  Col:=0;
  Row:=0;
  bbegin:=0;
  eend:=0;

 for i:=0 to Plik.Count -1 do
 begin

  Linia:=Plik[i];

  if Copy(Linia,0,1) <> '#' then  // nie komentarz
    begin

      If Pos('Col',Copy(Linia,0,6)) > 0 then
       begin                                // number of columns
         Col:= StrToInt(Copy(Linia,Pos('<',Linia)+1,Pos('>',Linia)-Pos('<',Linia)-1));
       end;
      If Pos('Row',Copy(Linia,0,6)) > 0 then
       begin                              // number of rows
         Row:= StrToInt(Copy(Linia,Pos('<',Linia)+1,Pos('>',Linia)-Pos('<',Linia)-1));
       end;

      If Copy(Linia,0,5) = 'Begin' then
       begin                              // number of rows
         bbegin:= i+1; // bo od nastepnej lini
       end;

       If Copy(Linia,0,3) = 'End' then
       begin                              // number of rows
         eend:= i-1;
       end;

    end;
 end;


 if  (Col <> 0) and (Row <> 0) and (bbegin <> 0) and (eend <> 0) then
    begin
                                                      // Protein_bonds_def
  if ArrayName = 'Protein_bonds_def' then
       begin
       //   SetLength -  row - col
       SetLength(Protein_bonds_def, Row, Col);

        for i:=0 to Row -1 do // all rows
          begin

          if Copy(Linia,0,1) <> '#' then // na wszelki wypadek jak momentazre albo wylazceie czegos w content
           begin

            ExplodeString(';',Plik[bbegin+i],Temp);

                for a:= 0 to Temp.Count-1 do // all colas fill by tempa values explode from line
                  begin
                    Protein_bonds_def[i,a]:= Temp[a];
                  end;

           end;
          end;
       end;                                               // Atoms_def

  if ArrayName = 'Atoms_def' then
       begin
       //   SetLength -  row - col
       SetLength(Atoms_def, Row, Col);

        for i:=0 to Row -1 do // all rows
          begin

          if Copy(Linia,0,1) <> '#' then // na wszelki wypadek jak momentazre albo wylazceie czegos w content
           begin

            ExplodeString(';',Plik[bbegin+i],Temp);

                for a:= 0 to Temp.Count-1 do // all colas fill by tempa values explode from line
                  begin
                    Atoms_def[i,a]:= Temp[a];
                  end;

           end;
          end;
       end;
                                                         // Atoms_nomenclature
  if ArrayName = 'Atoms_nomenclature' then
       begin
       //   SetLength -  row - col
       SetLength(Atoms_nomenclature, Row, Col);

        for i:=0 to Row -1 do // all rows
          begin

          if Copy(Linia,0,1) <> '#' then // na wszelki wypadek jak momentazre albo wylazceie czegos w content
           begin

            ExplodeString(';',Plik[bbegin+i],Temp);

                for a:= 0 to Temp.Count-1 do // all colas fill by tempa values explode from line
                  begin
                    Atoms_nomenclature[i,a]:= Temp[a];
                  end;

           end;
          end;
       end;

    end
     else begin Showmessage('Cannot load array, syntax error in file: '+ArrayName+'.gtbl'); end;

 Plik.Free;
 Temp.Free;
end;

Function FillComboBox(Combobox:TComboBox;Grid:TstringGrid;Value:String;ColValue,ColName:integer):integer;
Var
 i:integer;
begin
Combobox.Clear;

  for i:=1 to Grid.RowCount -1 do
   begin
    if Grid.Cells[ColValue,i] = Value then
     begin
        Combobox.Items.Add(Grid.Cells[ColName,i]);
     end;
   end;

  Combobox.ItemIndex:=0;
end;

Function  UniversalDirectoryFunction(InitialDir:string):string;
Var
 DirDialog:TSelectDirectoryDialog;
Begin
// stworzr forme
DirDialog:= TSelectDirectoryDialog.Create(nil);

// Parameter

// Initial directory
If (InitialDir = '') then
 begin
  DirDialog.InitialDir := ExtractFileDir(GetCurrentDir);
 end else begin DirDialog.InitialDir := InitialDir; end;

If DirDialog.Execute then
 begin
   Try
     Result:= SysToUTF8(DirDialog.FileName);
   except
     showmessage(Copy(com7,3,length(com7))+'[UniversalDirectoryFunction]');
   end;
 end;

DirDialog.Free;
end;

Function UniversalOpenFunction(Filter,InitialDir:string):string; // zwraca directory
Var
 OpenDialog:TOpenDialog;
begin
 // stworzr forme
 OpenDialog:= TopenDialog.Create(nil);
 // Parameter

 //Filter
 If (Filter = '') then
  begin
   OpenDialog.Filter:= IndexFilter_any;
  end else begin OpenDialog.Filter:=Filter; end;

 // Initial directory
 If (InitialDir = '') then
  begin
   OpenDialog.InitialDir := ExtractFileDir(GetCurrentDir);
  end else begin OpenDialog.InitialDir := InitialDir; end;

 If OpenDialog.Execute then
  begin
    Try
      Result:= SysToUTF8(Opendialog.FileName);
    except
      showmessage(Copy(com7,3,length(com7))+'[UniversalOpenFunction]');
    end;
  end;

 OpenDialog.Free;
end;

Function  AminoacidToColor(OneLetterCode:string;Classification:String):Tcolor; // http://www.bioinformatics.nl/~berndb/aacolour.html
begin

// Clustal
  if Classification = 'C' then // http://www.ebi.ac.uk/Tools/msa/clustalw2/help/faq.html#24
   begin
     // Clustal R, K - Basic - H
     If (UpperCase(OneLetterCode) = 'R') or (UpperCase(OneLetterCode) = 'K') then
      begin
        Result:=clFuchsia; // magenta
        exit;
      end;
      // Clustal  red : A V F P M I L W - Small (small+ hydrophobic (incl.aromatic -Y))
     If (UpperCase(OneLetterCode) = 'A') or (UpperCase(OneLetterCode) = 'V') or (UpperCase(OneLetterCode) = 'F')
     or (UpperCase(OneLetterCode) = 'P') or (UpperCase(OneLetterCode) = 'M') or (UpperCase(OneLetterCode) = 'I')
     or (UpperCase(OneLetterCode) = 'L') or (UpperCase(OneLetterCode) = 'W') then
      begin
        Result:=clRed;
        exit;
      end;
      // Clustal  D, E - Acidic
     If (UpperCase(OneLetterCode) = 'D') or (UpperCase(OneLetterCode) = 'E') then
      begin
        Result:=clBlue;
        exit;
      end;
     // Clustal  S T Y H C N G Q
     If (UpperCase(OneLetterCode) = 'S') or (UpperCase(OneLetterCode) = 'T') or (UpperCase(OneLetterCode) = 'Y')
     or (UpperCase(OneLetterCode) = 'H') or (UpperCase(OneLetterCode) = 'C') or (UpperCase(OneLetterCode) = 'N')
     or (UpperCase(OneLetterCode) = 'G') or (UpperCase(OneLetterCode) = 'Q') then
      begin
        Result:=clGreen;
        exit;
      end;

     // Result:=clGray;
     // exit;

   end;

// MAEditor

  if Classification = 'M' then
     begin
       // MAEditor A, G
       If (UpperCase(OneLetterCode) = 'A') or (UpperCase(OneLetterCode) = 'G') then
        begin
          Result:=$A6D785; // light green
          exit;
        end;
        // MAEditor  C
       If (UpperCase(OneLetterCode) = 'C')  then
        begin
          Result:=clGreen;
          exit;
        end;
        // MAEditor D, E, N, Q
       If (UpperCase(OneLetterCode) = 'D') or (UpperCase(OneLetterCode) = 'E') or (UpperCase(OneLetterCode) = 'N') or (UpperCase(OneLetterCode) = 'Q') then
        begin
          Result:=$61B329; // dark green
          exit;
        end;
       // MAEditor I, L, M, V	Blue
       If (UpperCase(OneLetterCode) = 'I') or (UpperCase(OneLetterCode) = 'L') or (UpperCase(OneLetterCode) = 'M')  or (UpperCase(OneLetterCode) = 'V') then
        begin
          Result:=clBlue;
          exit;
        end;
       // MAEditor F, W, Y
       If (UpperCase(OneLetterCode) = 'F') or (UpperCase(OneLetterCode) = 'W') or (UpperCase(OneLetterCode) = 'Y') then
        begin
          Result:=$C8A2C8;
          exit;
        end;
        // MAEditor  H
       If (UpperCase(OneLetterCode) = 'H') then
        begin
          Result:=$008AFF; // dark blue
          exit;
        end;
        // MAEditor  K, R
     If (UpperCase(OneLetterCode) = 'K') or (UpperCase(OneLetterCode) = 'R') then
      begin
        Result:=$FFB400; // orange
        exit;
      end;
      // MAEditor P
       If (UpperCase(OneLetterCode) = 'P') then
        begin
          Result:=$EA8BE9; // pink
          exit;
        end;
      //  MAEditor S, T
       If (UpperCase(OneLetterCode) = 'S') or (UpperCase(OneLetterCode) = 'T') then
      begin
        Result:=ClRed;
        exit;
      end;
     end;

 Result:=clNone; // jak nie znaleziono

end;

Function UniversalSaveFunction(Filter,InitialDir,Filename:string;Plik:Tstrings):string; // jak plik to zapisz plik textowy jak nie ma to zwroc directoy
Var
 SaveDialog:TSaveDialog;
begin
 // stworzr forme
 SaveDialog:= TSaveDialog.Create(nil);
 // Parameter

 //Filter
 If (Filter = '') then
  begin
   SaveDialog.Filter:= IndexFilter_any;
  end else begin SaveDialog.Filter:=Filter; end;

 // Initial directory
 If (InitialDir = '') then
  begin
   SaveDialog.InitialDir := ExtractFileDir(GetCurrentDir);
  end else begin SaveDialog.InitialDir := InitialDir; end;

 // File name
 If (filename = '') then
  begin
   SaveDialog.FileName := '';
  end else begin SaveDialog.FileName := filename; end;

  // Options
  Savedialog.Options:= SaveDialog.Options + [ofOverwritePrompt];

 If SaveDialog.Execute then
  begin
   if plik <> nil then    // jak plik to zapisz plik textowy jak nie ma to zwroc directoy
    begin
       Try
        Plik.SaveToFile(UTF8tosys(SaveDialog.FileName));
       except
         showmessage(Copy(com7,3,length(com7))+'[UniversalSaveFunction]');
       end;
    end
     else begin Result:= SaveDialog.FileName; end;
  end;

 SaveDialog.Free;
end;

Procedure ExportFastaFormat(StartForomColumn,StartFromRow:integer;Grid:TStringGrid);
Var
 a,b:integer;
 plik:Tstringlist;
 seq:string;
Begin
 plik:= Tstringlist.Create;

 For b:= StartFromRow to TstringGrid(grid).RowCount -1  do   // kolejne rowsy
  begin
     seq:=''; // wyczysc zmienna bo nowa sewekcja
     For a:= StartForomColumn +1 to Tstringgrid(grid).ColCount -1 do // kolejne kolumny z sekwesnja
       begin
         seq:= seq + Trim(TstringGrid(grid).Cells[a,b]); // kolejene aminokwasy
       end;
     plik.Add('> ' + TstringGrid(grid).Cells[StartForomColumn,b]); // dodaj nazwe
     plik.Add(seq);// dodaj sekwencje
  end;
   // universalan forma zapisu
 UniversalSaveFunction(IndexFilter_10,'','Sequence.fasta',Plik);

end;

Function NucleotideToFeature(Value,OutputType:string):string; // Output type : O-OneLetterCode, N-Name, C -color, M - mass, S -surface,
Var

 Names : Array[0..4] of string =('Adenosine','Cytidine','Guanosine','Thymidine','Uridine');
 TwoLettersCode : Array[0..4] of string =('DA','DC','DG','DT','DU');
 OneLetterCode : Array[0..4] of string =('A','C','G','T','U'); // nie uzywac bo tak samo jak aminokwasy
 Formula:Array[0..4] of string = ('C10H13N5O4','C9H13N3O5','C10H13N5O5','C10H14N2O6','C9H12N2O6');   //http://education.expasy.org/student_projects/isotopident/htdocs/bases.html
 Mass:Array[0..4] of string = ('267.24132','243.21662','283.24072','258.22796','244.20138'); //  PubChem
 Surface:Array[0..4] of string = ('!','!','!','!','!');  // dodac wartosci
 Volume:Array[0..4] of string = ('!','!','!','!','!');  // didiac wartosci
 Color:Array[0..4] of string = ('clYellow','clLime','clRed','clBlue','clPurple');  // didiac wartosci

 i:integer;
Begin

  For i:=0 to High(TwoLettersCode) do // wszytskie listy maja rowna dligosc
     begin
       // jesli jakakolwiek wartosc z listy jest znaleziona to zwroc wartosc zadana
       //                    3 litery                                   // 1 jedna litera                                           // Nazwa                                            // Formula                                             // Mass                                           // Surface                                          // Volume                                              // znaki nie bedace aninokwasami
      if (UpperCase(TwoLettersCode[i]) = UpperCase((Trim(Value)))) or (UpperCase(OneLetterCode[i]) = UpperCase((Trim(Value)))) or (UpperCase(Names[i]) = UpperCase((Trim(Value)))) or (UpperCase(Formula[i]) = UpperCase((Trim(Value)))) or (UpperCase(Mass[i]) = UpperCase((Trim(Value)))) or (UpperCase(Surface[i]) = UpperCase((Trim(Value)))) or (UpperCase(Volume[i]) = UpperCase((Trim(Value)))) or ('-' = UpperCase((Trim(Value)))) or ('*' = UpperCase((Trim(Value)))) then
       begin
        if UpperCase(OutputType) = 'T' then
         begin
           Result:= TwoLettersCode[i]; // zwroc 2 litery
           exit;
         end;

       if UpperCase(OutputType) = 'O' then // zwroc 1 litery
         begin
           Result:= OneLetterCode[i];
           exit;
         end;

       if UpperCase(OutputType) = 'N' then // zwroc nazwe
         begin
           Result:= Names[i];
           exit;
         end;

       if UpperCase(OutputType) = 'F' then //  formula chemiczna chemical formula
         begin
           Result:= Formula[i];
           exit;
         end;

       if UpperCase(OutputType) = 'M' then //  average mass
         begin
           Result:= Mass[i];
           exit;
         end;

       if UpperCase(OutputType) = 'S' then //  Surface [Angstrom 2]
         begin
           Result:= Surface[i];
           exit;
         end;

       if UpperCase(OutputType) = 'V' then //  Volume [Angstrom 3]
         begin
           Result:= Volume[i];
           exit;
         end;

       if UpperCase(OutputType) = 'C' then // kolor
         begin
           Result:= Color[i];
           exit;
         end;

       if ('-' = UpperCase((Trim(Value)))) or ('*' = UpperCase((Trim(Value)))) then //  - lub *
         begin
           Result:= Value;
           exit;
         end;
       end;

  end;

 Result:= ''; // zwroc pustke jak  nie okreslone
end;

Function AminoacidToFeature(Value,OutputType:string):string; // Output type : T- ThreeLettersCode, O-OneLetterCode, N-Name
Var

 Names : Array[0..21] of string =('Alanine','Arginine','Asparagine','Aspartic acid','Asparagine or Aspartic acid','Cysteine','Clutamic acid','Glutamine','Glutamine or Glutamic acid','Glycine','Histidine','Isoleucine','Leucine','Lysine','Methionine','Phenylalanine','Proline','Serine','Threonine','Tryptophan','Tyrosine','Valine');
 ThreeLettersCode : Array[0..21] of string =('Ala','Arg','Asn','Asp','Asx','Cys','Glu','Gln','Glx','Gly','His','Ile','Leu','Lys','Met','Phe','Pro','Ser','Thr','Trp','Tyr','Val');
 OneLetterCode : Array[0..21] of string =('A','R','N','D','B','C','E','Q','Z','G','H','I','L','K','M','F','P','S','T','W','Y','V');
 Formula:Array[0..21] of string = ('C3H5ON','C6H12ON4','C4H6O2N2','C4H5O3N','0','C3H5ONS','C5H7O3N','C5H8O2N2','0','C2H3ON','C6H7ON3','C6H11ON','C6H11ON','C6H12ON2','C5H9ONS','C9H9ON','C5H7ON','C3H5O2N','C4H7O2N','C11H10ON2','C9H9O2N','C5H9ON');   // http://education.expasy.org/student_projects/isotopident/htdocs/aa-list.html
 Mass:Array[0..21] of string = ('71.0788','156.1875','114.1038','115.0886','0','103.1388','129.1155','128.1307','0','57.0519','137.1411','113.1594','113.1594','128.1741','131.1926','147.1766','97.1167','87.0782','101.1051','186.2132','163.176','99.1326'); // http://education.expasy.org/student_projects/isotopident/htdocs/aa-list.html
 Surface:Array[0..21] of string = ('115','225','160','150','0','135','190','180','0','75','195','175','170','200','185','210','145','115','140','255','230','155');                                      // sparwdzic wartosci
 Volume:Array[0..21] of string = ('88.6','173.4','114.1','111.1','0','108.5','138.4','143.8','0','60.1','153.2','166.7','166.7','168.6','162.9','189.9','112.7','89','116.1','227.8','193.6','140');     // sparwdzic wartosci

 i:integer;
Begin

  For i:=0 to High(ThreeLettersCode) do // wszytskie listy maja rowna dligosc
     begin
       // jesli jakakolwiek wartosc z listy jest znaleziona to zwroc wartosc zadana
       //                    3 litery                                   // 1 jedna litera                                           // Nazwa                                            // Formula                                             // Mass                                           // Surface                                          // Volume                                              // znaki nie bedace aninokwasami
      if (UpperCase(ThreeLettersCode[i]) = UpperCase((Trim(Value)))) or (UpperCase(OneLetterCode[i]) = UpperCase((Trim(Value)))) or (UpperCase(Names[i]) = UpperCase((Trim(Value)))) or (UpperCase(Formula[i]) = UpperCase((Trim(Value)))) or (UpperCase(Mass[i]) = UpperCase((Trim(Value)))) or (UpperCase(Surface[i]) = UpperCase((Trim(Value)))) or (UpperCase(Volume[i]) = UpperCase((Trim(Value)))) or ('-' = UpperCase((Trim(Value)))) or ('*' = UpperCase((Trim(Value)))) then
       begin
        if UpperCase(OutputType) = 'T' then
         begin
           Result:= ThreeLettersCode[i]; // zwroc 3 litery
           exit;
         end;

       if UpperCase(OutputType) = 'O' then // zwroc 1 litery
         begin
           Result:= OneLetterCode[i];
           exit;
         end;

       if UpperCase(OutputType) = 'N' then // zwroc nazwe
         begin
           Result:= Names[i];
           exit;
         end;

       if UpperCase(OutputType) = 'F' then //  formula chemiczna chemical formula
         begin
           Result:= Formula[i];
           exit;
         end;

       if UpperCase(OutputType) = 'M' then //  average mass
         begin
           Result:= Mass[i];
           exit;
         end;

       if UpperCase(OutputType) = 'S' then //  Surface [Angstrom 2]
         begin
           Result:= Surface[i];
           exit;
         end;

       if UpperCase(OutputType) = 'V' then //  Volume [Angstrom 3]
         begin
           Result:= Volume[i];
           exit;
         end;

       if ('-' = UpperCase((Trim(Value)))) or ('*' = UpperCase((Trim(Value)))) then //  - lub *
         begin
           Result:= Value;
           exit;
         end;
       end;

  end;

 Result:= ''; // zwroc pustke jak  nie okreslone
end;

Function  FindTextinMemo(memo:Tmemo;text:string;select:boolean;comm:boolean):boolean;
var
  I, L: Integer;
begin

  I:= Pos(text, Memo.Text);

if I > 0 then begin
// L := SendMessage(Memo.Handle, 201, I - 1, 0);

 Result:=True;

{if comm then
  begin
    ShowMessage('Found '+ text +' at line: ' + IntToStr(L));
  end; }

// if you need to select the text found:
{if select then
  begin
    Memo.SelStart := I - 1;
    Memo.SelLength := Length(text);
    Memo.SetFocus;
  end; }
end else begin Result:=False; end;

end;

Procedure FileToCharacterSeparatedField(Field:TlabeledEdit; separator:string);
Var
  dialog:TopenDialog;
  plik:Tstringlist;
  i:integer;
begin
  dialog:= Topendialog.Create(nil);
  plik:=TstringList.Create;

  dialog.Filter:= IndexFilter_8 +'|'+ IndexFilter_9; // for values see stale

  Field.Clear;

  if  dialog.Execute then
   begin
     plik.LoadFromFile(UTF8decode(dialog.FileName));

     if plik.Count = 1 then
      begin
        field.Text:=plik[0];
      end
       else
      begin

         field.Text:= plik[0];

        for i:=1 to plik.Count -1 do
         begin
           field.Text:=field.Text + separator + plik[i];
         end;
      end;

   end;

  dialog.Free;
  plik.Free;
end;

Procedure GridToValuesList(grid:TstringGrid;Values:Tstringlist);
Var
 col,row:integer;
Begin

 // wyczysc
 Values.Clear;

// zbierz dane
  for col:=Grid.FixedCols to grid.ColCount -1 do
   begin
     for row:= Grid.FixedRows to grid.RowCount - 1 do
      begin
         Values.add(Grid.Cells[col,row]);
      end;
   end;
end;

Procedure ValuesListToGrid(Values:Tstringlist;grid:TstringGrid);
Var
 col,row,index:integer;
Begin
//zacznij zapisywanie od pocztaku
index:= 0;

// uzupelniaj dane
  for col:=Grid.FixedCols to grid.ColCount -1 do
   begin
     for row:= Grid.FixedRows to grid.RowCount - 1 do
      begin
         Grid.Cells[col,row]:= Values[index];
         inc(index);
      end;
   end;
end;

Function GridToConnections(Grid:TstringGrid;GridVisible:string;GridName:string;IndexInProjectTable:integer):boolean;
Var
 i,b:integer;
 akt_residue,BondsType,MoleculeType,Res_name_1,Res_name_2,AtomName_1,AtomName_2:string;
 distance:currency;

begin
  For i:=1 to Grid.RowCount -1 do
   begin

    akt_residue:= Grid.Cells[NrColResidueName,i];

    BondsType:='';

     For b:=1 to Grid.RowCount -1 do
      begin

       if b <> i then // nie prownuj tych samych bo rowne 0

        distance:= dlugosc_wektora(StrToCurr(Grid.Cells[NrColX,i]),StrToCurr(Grid.Cells[NrColY,i]),StrToCurr(Grid.Cells[NrColZ,i]),
                           StrToCurr(Grid.Cells[NrColX,b]),StrToCurr(Grid.Cells[NrColY,b]),StrToCurr(Grid.Cells[NrColZ,b]),
                           0);

        // tutaj sparwdzenie !!! rodzaj wiazania a nie tylko dystans

        MoleculeType := Project_Table_form.StringGrid1.Cells[NrColProj_Type,IndexInProjectTable];

        Res_name_1 := Grid.Cells[NrColResidueName,i];
        AtomName_1 := Grid.Cells[NrColAtomName,i];

        Res_name_2 := Grid.Cells[NrColResidueName,b];
        AtomName_2 := Grid.Cells[NrColAtomName,b];

        BondsType:= BondType(MoleculeType,Res_name_1,AtomName_1,Res_name_2,AtomName_2,currtostr(distance));

     if BondsType <> 'N' then
        begin
           Form2.StringGrid.RowCount:= Form2.StringGrid.RowCount +1; // dodaj rekord

           // Form2.StringGrid.Cells[0,Form2.StringGrid.RowCount -1]:= GridVisible;
           // Form2.StringGrid.Cells[1,Form2.StringGrid.RowCount -1]:= GridName;
           // Form2.StringGrid.Cells[2,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColAtomId,i];
           // Form2.StringGrid.Cells[3,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColElementSymbol,i]; // atom name A
           // Form2.StringGrid.Cells[4,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColAtomId,b];
           // Form2.StringGrid.Cells[5,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColElementSymbol,b]; // atom name B

       // Bonds verification - function bond type

           // Form2.StringGrid.Cells[6,Form2.StringGrid.RowCount -1]:= BondsType; // bound type standard sigle - S

      //
           // Form2.StringGrid.Cells[7,Form2.StringGrid.RowCount -1]:= currtostr(distance);

           // Form2.StringGrid.Cells[8,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColX,i];
           // Form2.StringGrid.Cells[9,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColY,i];
           // Form2.StringGrid.Cells[10,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColZ,i];

           // Form2.StringGrid.Cells[11,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColX,b];
           // Form2.StringGrid.Cells[12,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColY,b];
           // Form2.StringGrid.Cells[13,Form2.StringGrid.RowCount -1]:= Grid.Cells[NrColZ,b];

           // Form2.StringGrid.Cells[14,Form2.StringGrid.RowCount -1]:= AtomSymbolTo('C',Grid.Cells[NrColElementSymbol,i]); //+'-'+AtomSymbolToColor(Grid.Cells[NrColElementSymbol,b]); // colour

           // Form2.StringGrid.Cells[15,Form2.StringGrid.RowCount - 1]:= IntToStr(IndexInProjectTable);
        end;
      end;
   end;
  Result:=True;
end;

Function SignOfMovement(a,b:TstringList):string; // sign of average moevement from a to b a->b
var
 i,count_petla,plus,minus:integer;
begin

 if (a.Count = b.Count)  then
   begin

     if (a.Count > b.Count) then
      begin
        count_petla:= b.Count;
      end;

      if (a.Count < b.Count) then
      begin
        count_petla:= a.Count;
      end;
   end;

 For i:=0 to count_petla -1 do
    begin  // wylicz srednie  i policz wstapienia + i -


      if ZnakDVSAM(StrToCurr(a[i]),StrToCurr(b[i])) = '+' then   // zlicz ilosc wystapien +
       begin
         inc(plus);
       end;

      if ZnakDVSAM(StrToCurr(a[i]),StrToCurr(b[i])) = '-' then   // zlicz ilosc wystapien -
       begin
         inc(minus);
       end;

    end;

    if plus = minus then  // equal 0
        begin
          Result:= '0';
        end else
        begin
           if plus > minus then  // plus
             begin
               Result:= '+';
             end else begin Result:= '-'; end; // minus
        end;
end;

Function  GlobalCheckColumnIf(check:boolean;ColNr:integer;ColNrFrase:Integer;fraza:string;exactly:boolean):boolean;
var
  i:integer;
begin
try

for i:=1 to Project_table_form.stringgrid1.rowcount -1 do
  begin      // CheckColumnIf(ArrayName:string;ArrayNumber:integer;grid:TstringGrid;check:boolean;ColNr:integer;ColNrFrase:Integer;fraza:string;exactly:boolean);
    CheckColumnIf('Project',i-1,nil,check,ColNr,ColNrFrase,fraza,exactly);

  end;

finally
  Result:=true;
end;
end;

Function AnglePlaneDeviation(x1,y1,z1,x2,y2,z2:TstringList):string; // verif OK
Var
  Lista:TstringList;
begin

 Lista:=TstringList.Create;

 if XYZtoAngleList(x1,y1,z1,x2,y2,z2,Lista) then   // suma kwadratów roznic przez n i pod pierwistkiem
  begin
    Result:= odchylenie_standardowe(lista);
  end else begin Result:= com80; end;

lista.Free;
end;

Function XYZtoAngleList(x1,y1,z1,x2,y2,z2,AngleList:TstringList):boolean; // verif OK
var
  count_petla:integer; // stwierzda ile ma razy isc petla przy C wariancie i przy F vawiancie
  i:integer;
begin

 AngleList.Clear;

// dopisanie wartosci na koniec listy
if (x1.Count > 2) and (y2.Count > 2) and (y1.Count > 2) and (z2.Count> 2)
   and (z1.Count > 2) and (x2.Count > 2) then
begin

x1.Add(x1[0]);   // dopianie wartosci na koniec list
x1.Add(x1[1]);

y1.Add(y1[0]);
y1.Add(y1[1]);

z1.Add(z1[0]);
z1.Add(z1[1]);

x2.Add(x2[0]);
x2.Add(x2[1]);

y2.Add(y2[0]);
y2.Add(y2[1]);

z2.Add(z2[0]);
z2.Add(z2[1]);
// end

if (x1.Count = y2.Count) and (y1.Count = z2.Count) and (z1.Count = x2.Count) then
   begin

   for i:=0 to count_petla - 3 do // bo nie mozna wyliczyć dla 2 ostatnich, bo nie ma kolejnej wartosci
    begin
      AngleList.Add(CurrToStr(AnglePlaneAnalysis(
        StrToCurr(x1[i]),
        StrToCurr(y1[i]),
        StrToCurr(z1[i]),
        StrToCurr(x1[i+1]),
        StrToCurr(y1[i+1]),
        StrToCurr(z1[i+1]),
        StrToCurr(x1[i+2]),
        StrToCurr(y1[i+2]),
        StrToCurr(z1[i+2]),

        StrToCurr(x2[i]),
        StrToCurr(y2[i]),
        StrToCurr(z2[i]),
        StrToCurr(x2[i+1]),
        StrToCurr(y2[i+1]),
        StrToCurr(z2[i+1]),
        StrToCurr(x2[i+2]),
        StrToCurr(y2[i+2]),
        StrToCurr(z2[i+2]))));

    end;

    Result:=True;

  end
    else begin Result:=False; Console.AddCommunicate(com16+'[XYZtoAngleList][2]',true); end;

end
 else begin Result:=False; Console.AddCommunicate(com16+'[XYZtoAngleList][1]',true); end;

end;

Function  GridColumnToValues(Grid:TstringGrid;VisIncColumnNumber,ColumnNumber:integer;ValueList:Tstringlist):integer;
Var
 i, count:integer;
begin

ValueList.Clear;
count:=0;

  For i:=Grid.FixedRows to Grid.RowCount -1 do
   begin
     if Grid.Cells[VisIncColumnNumber,i] = '1' then
      begin
        ValueList.Add(Grid.Cells[ColumnNumber,i]);
        inc(count);
      end;
   end;

  Result:=count;
end;

Procedure  PaintGradientColorGrid(Grid:TstringGrid;BeginColor,EndColor:TColor;Steps:Integer;MarkMinMax:boolean);
Var
 col,row,index,min,max:integer;
 ListaWartosciKonvertNaKolory:Tstringlist;
Begin

 ListaWartosciKonvertNaKolory:= Tstringlist.Create;

// zbierz dane
  GridToValuesList(Grid,ListaWartosciKonvertNaKolory);

// znajdz index min max
  min:= MinMaxToListIndex(ListaWartosciKonvertNaKolory,False);
  max:= MinMaxToListIndex(ListaWartosciKonvertNaKolory,True);

// konwert na kolory
  GradientColor(BeginColor,EndColor,steps,ListaWartosciKonvertNaKolory);

// kolorowanie
Index:=0;

 for col:= Grid.FixedCols to grid.ColCount -1 do
   begin
     for row:= Grid.FixedRows to grid.RowCount - 1 do
      begin
        try
         //  standardowe malowanie gradientu

          Grid.Canvas.Brush.Color:= StringToColor(ListaWartosciKonvertNaKolory[Index]);
          Grid.Canvas.FillRect(Grid.CellRect(col,row));

         // oznacz wartosi min max

        if (index = min) and (MarkMinMax = True) then
          begin
            Grid.Canvas.Pen.Color:= clBlack;
            Grid.Canvas.Pen.Width:=3;
            Grid.Canvas.Ellipse(Grid.CellRect(col,row));
          end;

        if (index = max) and (MarkMinMax = True) then
          begin
            Grid.Canvas.Pen.Color:= clBlack;
            Grid.Canvas.Pen.Width:=3;
            Grid.Canvas.Ellipse(Grid.CellRect(col,row));
          end;

        inc(Index);
        except
         showmessage(com151+#13#10+ListaWartosciKonvertNaKolory[Index]+'<PaintGradientColorGrid>[1]');
        end;
      end;
   end;

 ListaWartosciKonvertNaKolory.free;

end;

Function  CompareLigandsAPA_RMSD_aDVSAM(GridA,GridB:TstringGrid;Results:TstringList;Analise_Number:integer):boolean;
var
 i:integer;
 x1,y1,z1,x2,y2,z2, seq1,seq2:TstringList;

Begin

x1:= TstringList.Create; // tworzebnie list
y1:= TstringList.Create;
z1:= TstringList.Create;

x2:= TstringList.Create;
y2:= TstringList.Create;
z2:= TstringList.Create;

// ------------------------------

// oblicza wartosci

Results.Clear;

for i:=1 to gridA.RowCount -1 do
 begin

   // ((AnsiCompareStr(GridA.Cells[NrColResidueName,i],GridB.Cells[NrColResidueName,i]) <> 0)) and - wprowadzic porówanie czy te same nazwy atomów !!!!

if (GridA.Cells[NrColInc,i] = '1') and (GridB.Cells[NrColInc,i] = '1') then
  begin

     // dodaj wartosci dla liganda wszyskie x,y,z
    x1.Add(gridA.Cells[NrColx,i]);
    y1.Add(gridA.Cells[NrColy,i]);
    z1.Add(gridA.Cells[NrColz,i]);

    x2.Add(gridB.Cells[NrColx,i]);
    y2.Add(gridB.Cells[NrColy,i]);
    z2.Add(gridB.Cells[NrColz,i]);
  end;

 end;

 if x1.Count > 0 then
  begin
  // obliczenia ostatniej kolumny
  if Analise_Number = 1 then
      begin
        Results.Add(CurrToStr(StrToCurr(aAnglePlaneAnalysis(x1,y1,z1,x2,y2,z2,false))));
      end;

  if Analise_Number = 2 then
      begin
        Results.Add(CurrToStr(StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;

   if Analise_Number = 3 then
      begin
        Results.Add(CurrToStr(StrToCurr(CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2,false))));
      end;
  end else begin showmessage(com162 + '1'); end;

 if x1.Count > 2 then
  begin
  if Analise_Number = 4 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2))));
      end;

   if Analise_Number = 5 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2)) + StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;
  end else begin showmessage(com162 + '3'); end;

x1.Free; y1.Free; z1.Free;
x2.Free; y2.Free; z2.Free;
end;

Function  CompareProteinsAPA_RMSD_aDVSAM(GridA,GridB:integer;Results:TstringList;Analise_Number:integer):boolean;
var
 i:integer;
 CurrRes:string;
 x1,y1,z1,x2,y2,z2, seq1,seq2:TstringList;

Begin
x1:= TstringList.Create; // tworzebnie list
y1:= TstringList.Create;
z1:= TstringList.Create;

x2:= TstringList.Create;
y2:= TstringList.Create;
z2:= TstringList.Create;

// ------------------------------
// sprawdz czy sekwencje sie zgzdzaja
   seq1:= TstringList.Create;
   seq2:= TstringList.Create;

   ArrayToSequence(GridA,Seq1,False);
   ArrayToSequence(GridB,Seq2,False);

 for i:=0 to Seq1.Count -1 do
  begin
    if Seq1.Count = Seq2.Count then
     begin
       if AnsiCompareStr(seq1[i],seq2[i]) <> 0 then
        begin
          Console.AddCommunicate(com116+' Residue name: '+seq1[i]+'<>'+seq2[i]+' [2]',true); exit;
        end;
     end else begin Console.AddCommunicate(com116+' A count: '+inttostr(Seq1.Count)+'; B count: '+ inttostr(Seq2.Count)+' [1]',true); exit; end;
  end;

   seq1.Free;
   seq2.Free;
// ------------------------------
// oblicza wartosci

Results.Clear;
CurrRes:= Project[GridA,1,NrColResidueName]; // residue pocztakowe

for i:=1 to ProjectArrayFunctions('RowCount',GridA) -1 do
 begin // zlicza dopuki residue jest to samo

if ((AnsiCompareStr(currRes,Project[GridB,i,NrColResidueName]) <> 0)) and (Project[GridA,i,NrColInc] = '1') and (Project[GridB,i,NrColInc] = '1') then
  begin

    if Analise_Number = 1 then
      begin
        Results.Add(CurrToStr(StrToCurr(aAnglePlaneAnalysis(x1,y1,z1,x2,y2,z2,false))));
      end;

     if Analise_Number = 2 then
      begin
        Results.Add(CurrToStr(StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;

      if Analise_Number = 3 then
      begin
        Results.Add(CurrToStr(StrToCurr(CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2,false))));
      end;

      if Analise_Number = 4 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2))));
      end;

       if Analise_Number = 5 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2)) + StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;


    x1.Clear;
    y1.Clear;
    z1.Clear;

    x2.Clear;
    y2.Clear;
    z2.Clear;

    currRes:= Project[GridA,i,NrColResidueName];
  end;

if (Project[GridA,i,NrColInc] = '1') and (Project[GridB,i,NrColInc] = '1') then
  begin
     // dodaj wartosci

    x1.Add(Project[GridA,i,NrColx]);
    y1.Add(Project[GridA,i,NrColy]);
    z1.Add(Project[GridA,i,NrColz]);

    x2.Add(Project[GridB,i,NrColx]);
    y2.Add(Project[GridB,i,NrColy]);
    z2.Add(Project[GridB,i,NrColz]);
  end;

 end;

 if x1.Count > 1 then
  begin
  // obliczenia ostatniej kolumny
  if Analise_Number = 1 then
      begin
        Results.Add(CurrToStr(StrToCurr(aAnglePlaneAnalysis(x1,y1,z1,x2,y2,z2,false))));
      end;

  if Analise_Number = 2 then
      begin
        Results.Add(CurrToStr(StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;

   if Analise_Number = 3 then
      begin
        Results.Add(CurrToStr(StrToCurr(CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2,false))));
      end;
  end;

 if x1.Count > 2 then
  begin
  if Analise_Number = 4 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2))));
      end;

   if Analise_Number = 5 then
      begin
        Results.Add(CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2)) + StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false))));
      end;
  end;

x1.Free; y1.Free; z1.Free;
x2.Free; y2.Free; z2.Free;
end;

Function ArrayToSequence(ProjectNumber:integer;Seq:TstringList;Numbers:boolean):integer;
Var
 i:integer;
 CurrRes,CurrNumber:string;
begin

CurrRes:='';
CurrNumber:='';

Seq.clear;

for i:=0 to ProjectArrayFunctions('RowCount',ProjectNumber) -1 do
 begin
   if (AnsiCompareStr(currRes,Project[ProjectNumber,i,NrColResidueName]) <> 0) or (AnsiCompareStr(CurrNumber,Project[ProjectNumber,i,NrColSequenceNr]) <> 0)then
    begin
      if Numbers then // ja number to dodaj z numerem
         begin
           Seq.add(Project[ProjectNumber,i,NrColResidueName]+' '+Project[ProjectNumber,i,NrColSequenceNr]);
         end
           else begin  Seq.add(Project[ProjectNumber,i,NrColResidueName]); end; // jak nie to sama nazwa

        currRes:= Project[ProjectNumber,i,NrColResidueName];
        CurrNumber:= Project[ProjectNumber,i,NrColSequenceNr];
    end;
 end;
  Result:= Seq.count;
end;

Procedure PaintGradientColorRowColumn(Grid:TstringGrid;IsColumn:boolean;ColRowNumber:integer;BeginColor,EndColor:TColor;Steps:Integer;MarkMinMax:boolean);
Var
 i,index,min,max,i_list,a,DoCount,Col_Nr,Row_Nr,col,row:integer;
 ListaWartosciKonvertNaKolory:Tstringlist;
 Rect:Trect;
begin

ListaWartosciKonvertNaKolory:=Tstringlist.Create;
i:=0;
a:=0;

  if IsColumn then // jesli kolumna to count cols
   begin
     DoCount:= Grid.RowCount;
   end else begin DoCount:= Grid.ColCount; end;

  if IsColumn then // jesli  kolumna to count fixed cols
   begin
     i:= Grid.FixedCols;
   end else begin i:= Grid.FixedRows; end;

   Row_Nr:=0;
   Col_Nr:=0;

  if IsColumn then // jesli  kolumna to ilosc kolumn
   begin
     Col_Nr:=ColRowNumber;
   end else begin Row_Nr:= ColRowNumber; end;

  for a:= i to DoCount -1 do
   begin
     if isColumn then
      begin  // jest zdefiniowana kolumna ro rows ma byc zmienny
        ListaWartosciKonvertNaKolory.Add(Grid.Cells[Col_Nr,a]);
      end
    else
      begin // jest zdefiniowany rekord to kolumna ma byc zmienna
        ListaWartosciKonvertNaKolory.Add(Grid.Cells[a,Row_Nr]);
      end;
   end;

  min:= MinMaxToListIndex(ListaWartosciKonvertNaKolory,False);
  max:= MinMaxToListIndex(ListaWartosciKonvertNaKolory,True);

  // jak utowozono liste wartosci to teraz przeksztalc na kolor

    GradientColor(BeginColor,EndColor,steps,ListaWartosciKonvertNaKolory);

  // teraz koloruj rowsy lub kolumny :)

  i_list:=0;
  index:=0;

  for a:=i to DoCount -1 do
   begin
     if isColumn then
      begin  // jest zdefiniowana kolumna ro rows ma byc zmienny
        TstringGrid(Grid).Canvas.Brush.Color:= StringToColor(ListaWartosciKonvertNaKolory[i_list]);
        TstringGrid(Grid).Canvas.FillRect(TstringGrid(Grid).CellRect(Col_Nr,a));
        col:= Col_Nr;
        row:= a;
        inc(i_list);
      end
    else
      begin // jest zdefiniowany rekord to kolumna ma byc zmienna
        TstringGrid(Grid).Canvas.Brush.Color:= StringToColor(ListaWartosciKonvertNaKolory[i_list]);
        TstringGrid(Grid).Canvas.FillRect(TstringGrid(Grid).CellRect(a,Row_Nr));
        col:= a;
        row:= Row_Nr;
        inc(i_list);
      end;

    // oznacz wartosi min max

        if (index = min) and (MarkMinMax = True) then
          begin
            Grid.Canvas.Pen.Color:= clBlack;
            Grid.Canvas.Pen.Width:=3;
            Grid.Canvas.Ellipse(Grid.CellRect(col,row));
          end;

        if (index = max) and (MarkMinMax = True) then
          begin
            Grid.Canvas.Pen.Color:= clBlack;
            Grid.Canvas.Pen.Width:=3;
            Grid.Canvas.Ellipse(Grid.CellRect(col,row));
          end;

        inc(Index);

   end;

 ListaWartosciKonvertNaKolory.Free;

 end;

Procedure GradientScaleToGrid(ColorBegin,ColorEnd:Tcolor;steps:integer;Value:Tstringlist;Grid:TstringGrid;ClearBefore:boolean);
var
 i,b,R1,B1,G1,R2,B2,G2,Rgradient_step,Bgradient_step,Ggradient_step:integer;
 ColorList:TstringList;
 MinValue,MaxValue,ValueStep,Percent:currency;
begin

  R1:=Round(Red(ColorBegin));  // RBG koloru pocztakowego
  B1:=Round(Blue(ColorBegin));
  G1:=Round(Green(ColorBegin));

  R2:=Round(Red(ColorEnd)); // RBG koloru koncowoego
  B2:=Round(Blue(ColorEnd));
  G2:=Round(Green(ColorEnd));

if Value.count > 1 then
begin
  MinValue:= MinMax(Value,False); // value; isMax
  MaxValue:= MinMax(Value,True);

  ValueStep:= (ABS(MaxValue - MinValue) / steps); // RoundTo(((MaxValue - MinValue) / steps),4);

if ClearBefore then  // start from begining
     begin
       Grid.RowCount:=1; // headers should be prepared before from,to,color
     end;

For b:=0 to steps -1 do
   begin

     Grid.RowCount:= Grid.RowCount +1;

     Grid.Cells[0,Grid.RowCount-1]:= CurrToStr(MinValue + (ValueStep * b));
     Grid.Cells[1,Grid.RowCount-1]:= CurrtoStr(MinValue + (ValueStep * (b+1)));

               // nowa na bazie P = firstCol.R * p + secondCol.R * (1 - p)

     Percent:= (((b+1)* 100) / steps )/ 100;

     Rgradient_step:= Round((R1 * Percent) + (R2 * (1 - Percent)));
     Bgradient_step:= Round((B1 * Percent) + (B2 * (1 - Percent)));
     Ggradient_step:= Round((G1 * Percent) + (G2 * (1 - Percent)));

     Grid.Cells[2,Grid.RowCount-1]:= ColorToString(RGB(Rgradient_step,Ggradient_step,Bgradient_step));// skaloadowa kolory razy step kolory , wartosci

   end;
end;
end;

Procedure GradientColor(ColorBegin,ColorEnd:Tcolor;steps:integer;Value:Tstringlist); //
var
 i,b,R1,B1,G1,R2,B2,G2,Rgradient_step,Bgradient_step,Ggradient_step:integer;
 ColorList:TstringList;
 MinValue,MaxValue,ValueStep,Percent:currency;
 TempValue:string;
begin

  R1:=Round(Red(ColorBegin));  // RBG koloru pocztakowego
  B1:=Round(Blue(ColorBegin));
  G1:=Round(Green(ColorBegin));

  R2:=Round(Red(ColorEnd)); // RBG koloru koncowoego
  B2:=Round(Blue(ColorEnd));
  G2:=Round(Green(ColorEnd));

if Value.count > 1 then
begin
  MinValue:= MinMax(Value,False); // value; isMax
  MaxValue:= MinMax(Value,True);

  ValueStep:= (ABS(MaxValue - MinValue) / steps); // RoundTo(((MaxValue - MinValue) / steps),4);

  For i:=0 to Value.Count -1 do
   begin

    TempValue:= Value[i]; // zeby zapobiedz bledowi konwersji kolor na string !

     for b:=0 to steps + 1 do
       begin
         // przedzialy wieksze od poprzedniej wartosi i mniejsze od kolejnej
           if (ABS(StrToCurr(TempValue)) >= MinValue + (ValueStep * b)) and (ABS(StrToCurr(TempValue)) <= MinValue + (ValueStep * (b+1))) then
             begin

               // nowa na bazie P = firstCol.R * p + secondCol.R * (1 - p)

               Percent:= (((b+1)* 100) / steps )/ 100;

               Rgradient_step:= Round((R1 * Percent) + (R2 * (1 - Percent)));
               Bgradient_step:= Round((B1 * Percent) + (B2 * (1 - Percent)));
               Ggradient_step:= Round((G1 * Percent) + (G2 * (1 - Percent)));

               Value[i]:= ColorToString(RGB(Rgradient_step,Ggradient_step,Bgradient_step));// skaloadowa kolory razy step kolory , wartosci

              break;
             end;
         end;

     // maxinal value
     if ABS(StrToCurr(TempValue)) > MaxValue - (ValueStep / 2 ) then
       begin
         Value[i]:= ColorToString(ColorBegin);
       end;

     // minimal value
     if ABS(StrToCurr(TempValue)) < MinValue + (ValueStep / 2) then
         begin
           Value[i]:= ColorToString(ColorEnd);
         end;

   end;
 end;
end;

Procedure PrintScreen(left,top,width,height:integer);
var
  MyBitmap: TBitmap;
  ScreenDC: HDC;
  savedialog:TSaveDialog;
begin
  MyBitmap := TBitmap.Create;
  ScreenDC := GetDC(0);
  MyBitmap.LoadFromDevice(ScreenDC);
  ReleaseDC(0,ScreenDC);

  savedialog:= TsaveDialog.Create(nil);
  savedialog.Filter:='PNG file (*.png)|*.png';

  if savedialog.Execute then
    begin
      if savedialog.FileName > '' then
        begin
           MyBitmap.Canvas.CopyRect(Rect(50,100,150,200),MyBitmap.Canvas,Rect(0,0,MyBitmap.Canvas.Width,MyBitmap.Canvas.Height));
           MyBitmap.SaveToFile(savedialog.FileName+'.png');
        end;
    end;

  mybitmap.Free;
  savedialog.Free;
end;


Function  DownloadPDBfiles(Files:TstringList;SaveToDir:string):boolean;
Var
 i:integer;
 url:string;
begin
Try
Try
 url:= PDB_ID_URL;
  for i:= 0 to Files.count -1 do
   begin
      DownloadfileFromInternet(Url+Files[i]+'.pdb',SaveToDir+'\'+Files[i]+'.pdb');
   end;
except
  Console.AddCommunicate(com7+'[3][download PDB]',true);
  Result:=False;
end;
  finally
    Result:=true;
  end;
end;

Function  DownloadfileFromInternet(Url,SaveToDir:string):boolean; // SaveToDir - pelna sciezka z nazwa pliku !!!
CONST
  BufferSize = 1024;
VAR
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
begin
try
 sAppName := ExtractFileName(Application.ExeName) ;
 hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0) ;
 { be aware that InternetOpen  need only be called once in your application!!!!!!!!!!!!!! }
 TRY
  hURL := InternetOpenURL(hSession, PChar(URL), nil, 0, 0, 0) ;
  TRY
   AssignFile(f, SaveToDir) ;
   Rewrite(f, 1) ;
   REPEAT
    InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
    BlockWrite(f, Buffer, BufferLen)
   UNTIL BufferLen = 0;
   CloseFile(f) ;
   Result:= True;
  FINALLY
   InternetCloseHandle(hURL)
  end
 FINALLY
  InternetCloseHandle(hSession)
 END;
 except
    result := false;
 end;
END;

Procedure ChangeColumnColor(Grid:Tstringgrid;GridX,GridY,col:integer);
Var
 ColorDialog:TColorDialog;
begin
If GridX = Col then
  begin
    if GridY > 0 then
     begin
       ColorDialog:= TcolorDialog.Create(nil);
       if ColorDialog.Execute then
        begin
          TstringGrid(Grid).Cells[GridX,GridY]:= ColorToString(ColorDialog.Color);
        end;
        ColorDialog.Free;
     end;
  end;

end;

Procedure ColorColumn(Grid:Tstringgrid;aCol,aRow,Col:integer;aRect: TRect);
begin
try
 if ((aCol = Col) and (aRow > 0)) then
   begin
     try
       begin
         TstringGrid(Grid).Canvas.Brush.Color:= StringToColor(TstringGrid(Grid).Cells[aCol,aRow]);
         TstringGrid(Grid).Canvas.FillRect(aRect);
       end
        except
          TstringGrid(Grid).Canvas.Brush.Color:= clWhite;
          TstringGrid(Grid).Canvas.FillRect(aRect);
        end;
   end;
except
end;
end;

Function AddPlaneToTable(Grid:TstringGrid;xyz:TstringList;variant,name:string):boolean;
Var
 i,variant_ver:integer;
begin

variant_ver:=0; // pocz takowa wartowsc wariant

  Grid.RowCount:= Grid.RowCount+1;
    Grid.Cells[NrColSection,Grid.RowCount-1]:= type_HeteroAtom; // section type
    Grid.Cells[NrColVis,Grid.RowCount-1]:= '1'; // Vis Inc true
    Grid.Cells[NrColInc,Grid.RowCount-1]:= '1';
    Grid.Cells[NrColAtomId,Grid.RowCount-1]:= '1'; // number 1
    Grid.Cells[NrColAtomName,Grid.RowCount-1]:= 'P1'+name; // point 1
    Grid.Cells[NrColResidueName,Grid.RowCount-1]:= variant;// variant
    Grid.Cells[NrChainIdentifier,Grid.RowCount-1]:= name;// variant
    Grid.Cells[NrColx,Grid.RowCount-1]:= xyz[0]; // add x y z variables
    Grid.Cells[NrColy,Grid.RowCount-1]:= xyz[1];
    Grid.Cells[NrColz,Grid.RowCount-1]:= xyz[2];
    Grid.Cells[NrColElementSymbol,Grid.RowCount-1]:='PLA';

  Grid.RowCount:= Grid.RowCount+1;
    Grid.Cells[NrColSection,Grid.RowCount-1]:= type_HeteroAtom;
    Grid.Cells[NrColVis,Grid.RowCount-1]:= '1';
    Grid.Cells[NrColInc,Grid.RowCount-1]:= '1';
    Grid.Cells[NrColAtomId,Grid.RowCount-1]:= '2';
    Grid.Cells[NrColAtomName,Grid.RowCount-1]:= 'P2'+name;
    Grid.Cells[NrColResidueName,Grid.RowCount-1]:= variant;// variant
    Grid.Cells[NrChainIdentifier,Grid.RowCount-1]:= name;// variant
    Grid.Cells[NrColx,Grid.RowCount-1]:= xyz[3];
    Grid.Cells[NrColy,Grid.RowCount-1]:= xyz[4];
    Grid.Cells[NrColz,Grid.RowCount-1]:= xyz[5];
    Grid.Cells[NrColElementSymbol,Grid.RowCount-1]:='PLA';

  Grid.RowCount:= Grid.RowCount+1;
    Grid.Cells[NrColSection,Grid.RowCount-1]:= type_HeteroAtom;
    Grid.Cells[NrColVis,Grid.RowCount-1]:= '1';
    Grid.Cells[NrColInc,Grid.RowCount-1]:= '1';
    Grid.Cells[NrColAtomId,Grid.RowCount-1]:= '3';
    Grid.Cells[NrColAtomName,Grid.RowCount-1]:= 'P3'+name;
    Grid.Cells[NrColResidueName,Grid.RowCount-1]:= variant;// variant
    Grid.Cells[NrChainIdentifier,Grid.RowCount-1]:= name;// variant
    Grid.Cells[NrColx,Grid.RowCount-1]:= xyz[6];
    Grid.Cells[NrColy,Grid.RowCount-1]:= xyz[7];
    Grid.Cells[NrColz,Grid.RowCount-1]:= xyz[8];
    Grid.Cells[NrColElementSymbol,Grid.RowCount-1]:='PLA';

Result:= True;

{
      Container.StringGrid1.Cells[0,Container.StringGrid1.RowCount-1]:='Plane '+IntToStr(Container.StringGrid1.RowCount -1); // nazwa , name

      Container.StringGrid1.Cells[1,Container.StringGrid1.RowCount-1]:='1'; // inc
      //Container.StringGrid1.Cells[2,Container.StringGrid1.RowCount-1]:='Plane'+"nazwa molekuly z kyorej pochodzi plane"; // type of content

      for i:=1 to settings.planes.RowCount -1 do
       begin
         if settings.planes.Cells[1,i] = inttostr(variant) then
          begin
            variant_ver:= i;
          end;

         if variant_ver = 0 then
          begin
             variant_ver:= 1;
          end;
       end;

      Container.StringGrid1.Cells[3,Container.StringGrid1.RowCount-1]:= settings.planes.Cells[1,variant_ver]; // color

      Container.StringGrid1.Cells[4,Container.StringGrid1.RowCount-1]:= inttostr(variant_ver); // variant

 }
end;

Procedure InvertSelectionIncRecordsFromGrid(Grid:TstringGrid;Col:integer);
Var
 i:integer;
Begin
  For i:=1 to TstringGrid(grid).rowcount - 1 do
   begin
     If Tstringgrid(grid).cells[Col,i] = '1' then
      begin
        Tstringgrid(grid).cells[Col,i]:= '0';
      end else begin Tstringgrid(grid).cells[Col,i]:= '1'; end;
   end;
end;

Procedure DeleteIncRecordsFromGrid(Grid:TstringGrid;IncColNr:integer;communicate:boolean);
Var
  i,b,com:integer;
begin

if communicate then
 begin
   com := MessageDlg(com22, com146, mtConfirmation,[mbYes, mbNo],0) ;
 end;

if (communicate = false) or (com = mrYes) then
 begin
   For b:= 1  to Grid.rowcount -1 do
    begin
   for i:= 1  to Grid.rowcount -1 do
   begin
     if i > Tstringgrid(Grid).rowcount -1 then
       begin
          break;
       end else
        begin
          if Grid.cells[IncColNr,Grid.rowcount -i]= '1' then
            begin
              Grid.DeleteColRow(false,Grid.rowcount -i);
            end;
        end;
   end;
 end;

 end;
end;

Function FormCount():integer;
var
 i,Res:Integer;
begin
Res:=0;
   try
   for i:=0 to Application.ComponentCount-1 do begin
   if (Application.Components[i] is TForm) then
       Inc(Res);
   end;
     except
       Result := 1;
     end;
 Result:=Res;
end;

// settings read

Procedure read_initial_settings(Sender:Tobject);
var
 config_list:TstringList;
 i,a:integer;
begin
  config_list:=TstringList.Create;

{if fileexists(ExtractFilePath(Application.ExeName)+'\config.ini') then
begin
  try config_list.LoadFromFile(ExtractFilePath(Application.ExeName)+'\config.ini');
  except
    Console.AddCommunicate(com7+'  [config.ini]');
  end;

  for i:=0 to  config_list.Count-1 do
   begin

    // language

    // default project
   { if copy(config_list[i],0,length(config_list[i]))= '[default_project]' then
      begin
        settings.Label2.Caption:= (config_list[i+1]);
        if config_list[i+1] <> 'none' then
        begin
         //  speedbutton5.Down:=true;
          // project_table_form.SpeedButton5.Down:=true;

         if FileExistsUTF8((config_list[i+1]))then
          begin
            // MenuItem22Click(nil,(config_list[i+1])); // wywolanie otwierania
          end else begin
         // speedbutton5.Down:=false;
          //project_table_form.SpeedButton5.Down:=false;
          Console.AddCommunicate((config_list[i+1])+ com7 +'[default_project]'); end;
        end;
      end;}

    // default directory
    if copy(config_list[i],0,length(config_list[i]))= '[default_directory]' then
      begin
         settings.DirectoryEdit1.Text:=config_list[i+1];
         MainForm.Opendialog1.InitialDir:=config_list[i+1];
         MainForm.Savedialog1.InitialDir:=config_list[i+1];
      end;

   // external programs directories
   if copy(config_list[i],0,length(config_list[i]))= '[external_programs]' then
      begin
        settings.FileNameEdit1.Text:=config_list[i+1];
        settings.FileNameEdit2.Text:=config_list[i+2];
        settings.FileNameEdit3.Text:=config_list[i+3];
        settings.FileNameEdit4.Text:=config_list[i+4];
        settings.FileNameEdit5.Text:=config_list[i+5];
        settings.FileNameEdit6.Text:=config_list[i+6];
     end;

   if copy(config_list[i],0,length(config_list[i]))= '[mode]' then
      begin
        if copy(config_list[i+1],0,length(config_list[i+1]))= 'GRAPH' then
         begin settings.checkbox10.Checked := true end
         else begin settings.checkbox11.Checked := true end;
      end;

      if copy(config_list[i],0,length(config_list[i]))= '[show_captions]' then
      begin
        settings.CheckBox18.Checked:=StrToBool(config_list[i+1]);
      end;

     if copy(config_list[i],0,length(config_list[i]))= '[atoms_representation]' then
      begin
        if copy(config_list[i+1],0,length(config_list[i+1]))= 'WIRE' then
         begin
            settings.CheckBox2.Checked:= true;
         end;
        if copy(config_list[i+1],0,length(config_list[i+1]))= 'SOLID' then
         begin
            settings.CheckBox2.Checked:= true;
         end;
      end;

       if copy(config_list[i],0,length(config_list[i]))= '[axe_x]' then
      begin
        settings.checkbox12.Checked:= StrToBool(config_list[i+1]);
        settings.checkbox17.Checked:= StrToBool(config_list[i+2]);
        settings.Colorbutton1.ButtonColor:=StringToColor(config_list[i+3]);
        settings.FloatSpinEdit7.Value:= StrToCurr(config_list[i+4]);
        settings.FloatSpinEdit9.Value:= StrToCurr(config_list[i+5]);
        settings.FloatSpinEdit8.Value:= StrToCurr(config_list[i+6]);
      end;

      if copy(config_list[i],0,length(config_list[i]))= '[axe_y]' then
      begin
        settings.checkbox13.Checked:= StrToBool(config_list[i+1]);
        settings.checkbox16.Checked:= StrToBool(config_list[i+2]);
        settings.Colorbutton2.ButtonColor:=StringToColor(config_list[i+3]);
        settings.FloatSpinEdit5.Value:= StrToCurr(config_list[i+4]);
        settings.FloatSpinEdit12.Value:= StrToCurr(config_list[i+5]);
        settings.FloatSpinEdit11.Value:= StrToCurr(config_list[i+6]);
      end;

      if copy(config_list[i],0,length(config_list[i]))= '[axe_z]' then
      begin
        settings.checkbox14.Checked:= StrToBool(config_list[i+1]);
        settings.checkbox15.Checked:= StrToBool(config_list[i+2]);
        settings.Colorbutton3.ButtonColor:=StringToColor(config_list[i+3]);
        settings.FloatSpinEdit6.Value:= StrToCurr(config_list[i+4]);
        settings.FloatSpinEdit14.Value:= StrToCurr(config_list[i+5]);
        settings.FloatSpinEdit13.Value:= StrToCurr(config_list[i+6]);
      end;

       // alerts and comunications

      if copy(config_list[i],0,length(config_list[i]))= '[ALERTS]' then
      begin
        settings.checkbox20.Checked:= StrToBool(config_list[i+1]);
      end;

      // type of visualization in APD-RMSD analisis - checkbox21 Solid Cube
      if copy(config_list[i],0,length(config_list[i]))= '[CUBEVISTYPE]' then
      begin
        settings.checkbox21.Checked:= StrToBool(config_list[i+1]);
        settings.checkbox22.Checked:= StrToBool(config_list[i+2]);
      end;

      // Bacground Color for 3d view
      if copy(config_list[i],0,length(config_list[i]))= '[BACKGROUNDCOLOR]' then
      begin
        settings.BackgroundColor.ButtonColor:= StringToColor(config_list[i+1]);
      end;

    end;
  end;

  config_list.Free; }


end;


Function  Q2_QSAR(Observed:TStringList;Predicted:TstringList):Currency; // SPRAWDZIC I PPRAWIC !!!!
Var
  i:integer;
  temp,temp2,srednia_observed,srednia_predicted,suma_roznic_observed,suma_roznica_predicted,Q2:currency;
begin
  srednia_observed:= StrToCurr(ArithmeticAverage(Observed));  // Q2  z publikacji :  Implementing the Fisher’s Discriminant Ratio in a k-Means Clustering Algorithm for Feature Selection and Data Set Trimming

  suma_roznic_observed:= 0;
  suma_roznica_predicted:= 0;

  For i:=0 to Observed.count -1 do
   begin
      suma_roznic_observed:= suma_roznic_observed + Power((StrToCurr(Observed[i]) - StrToCurr(Predicted[i])),2); // E(obs[i] - pred[i])2
      suma_roznica_predicted:= suma_roznica_predicted + Power((StrToCurr(Observed[i]) - srednia_observed),2); //  E(obs[i] - sr.obs)2
   end;

   Q2:= suma_roznic_observed / suma_roznica_predicted;
   Q2:= 1 - Q2;

   //temp:= RoundTo(temp,3);
    temp2:= power(10, 3);
    temp := round(Q2*temp2)/temp2;

   Result:= temp;
end;

Function  CoA_percent_N(Observed:TStringList;Predicted:TstringList;Percent:Currency):Currency; // podac perocent jako np.  100%
Var
 i,do_wartosci,wynik:integer;
 ilosc_spelniajcych_kryterium,wspolczynnik:currency;
Begin
 ilosc_spelniajcych_kryterium:= Observed.Count * Percent;
 ilosc_spelniajcych_kryterium:= ilosc_spelniajcych_kryterium / 100;

 //showmessage('Spelniajacych: '+ CurrtoStr(ilosc_spelniajcych_kryterium));
 wspolczynnik:= 0.001;
 do_wartosci:= Round(MinMax(Observed,True) / wspolczynnik) ; // wspolczynnik 0.001 co ile skok

 For i:=0 to do_wartosci do
  begin
   wynik:= CoA_NumberOfCompounds(Observed,Predicted,i*wspolczynnik);
    If wynik >= ilosc_spelniajcych_kryterium then
     begin
      Result:= i * wspolczynnik;
      break;
     end;
  end;
end;

Function  aCoA(Observed:TStringList;Predicted:TstringList):Currency;
Var
 temp,temp2:currency;
 i,do_wartosci:integer;
 suma,wspolczynnik:currency;
begin
Wspolczynnik:= 0.001; // wspolczynnik który ma liczyc
suma:=0;

  do_wartosci:= Round(MinMax(Observed,True) / wspolczynnik) ;

  for i:=0 to do_wartosci do
   begin                 // sumuje CoA dla kazdej prezyzji  agequacy
      suma:= suma + CoA(Observed,Predicted,i*wspolczynnik);
   end;
   // temp dana wejsciowa do zaooraglenia
   temp:= suma / do_wartosci;
  //temp:= RoundTo(temp,3);
    temp2:= power(10, 4);
    temp := round(temp*temp2)/temp2;
  Result:= temp;
end;

Function  CoA_percent(Observed:TStringList;Predicted:TstringList;Adequacy:currency):Currency;
Var
 temp,temp2,temp3:currency;
begin
  temp:= CoA_NumberOfCompounds(Observed,Predicted,Adequacy) *100;
  temp:= temp / Observed.count;
  //temp:= RoundTo(temp,3);
    temp2:= power(10, 2);
    temp := round(temp*temp2)/temp2;
  Result:= temp;
end;

Function  CoA(Observed:TStringList;Predicted:TstringList;Adequacy:currency):Currency;
Var
 temp,temp2:currency;
begin
  temp:= CoA_NumberOfCompounds(Observed,Predicted,Adequacy);
  temp:= temp / Observed.count;
  //temp:= RoundTo(temp,3);
    temp2:= power(10, 3);
    temp := round(temp*temp2)/temp2;
  Result:= temp;
end;

Function CoA_NumberOfCompounds(Observed:TStringList;Predicted:TstringList;Adequacy:currency):integer;
Var
 i,count:integer;
 Temporary:TstringList;
Begin
  Temporary:= TstringList.create;

  if Observed.count = Predicted.count then
   begin
    For i:=0 to Observed.Count -1 do
     begin
       Temporary.add(CurrToStr(Abs(StrToCurr(Observed[i])-StrToCurr(Predicted[i]))));
     end;

   Count:=0;
   for i:=0 to Temporary.count-1 do
    begin
      If (StrToCurr(Temporary[i]) < Adequacy) then begin inc(Count) end;
    end;

    Result:=Count;
   end
    else begin Console.AddCommunicate(com121,true); Result:=-1;  end;

end;

Procedure ImportCSV(grid:TstringGrid);
var
  OD : TOpenDialog;
  header,row,col,col_move: Integer;
  CSV,lista : TStrings;
  separator:string;
begin
 Try
  OD := TOpenDialog.Create(MainForm);
  OD.Filter := 'CSV (*.csv)|*.CSV';
If OD.Execute Then
Begin
    CSV := TStringList.Create;
    Lista:= TstringList.Create;
 if OD.FileName > '' then
 begin
    CSV.LoadFromFile(UTF8encode(OD.FileName));
    Grid.ColCount:=0;
    Grid.RowCount:=1;
    Try
      begin
       separator:= InputBox(com22,com120,';');
       row:=0;
       if MessageDlg(com22,com118, mtConfirmation, mbYesNo, 0) = mrYes then
         begin
           ExplodeString(separator,CSV[0],Lista);
           Grid.ColCount:=Lista.Count; // dodaj kolumny
           Grid.RowCount:=Grid.RowCount+1; // dodaj rowsy
           Grid.FixedRows:=1;
           for header:=0 to Lista.Count -1 do
            begin
              Grid.Cells[header,0]:=Lista[header];
              row:=1;
            end;
         end;

         // ptanie o czy pierwsza kolumna zawiera nazy

       Grid.FixedCols:=1;
       col_move:=1;
       if MessageDlg(com22,com119, mtConfirmation, mbYesNo, 0) = mrYes then
         begin
           col_move:=0; // dodaj kolumny
         end;

       for row:=row to Csv.Count -1 do
        begin
         ExplodeString(separator,CSV[row],Lista);
      // dodaj brakujace koluny i wierze
       if Grid.ColCount < Lista.Count then
        begin
             Grid.ColCount:=Lista.Count;
        end;
       If Grid.RowCount < Csv.Count then
        begin
             Grid.RowCount:=Csv.Count;
        end;
         // wypelnij komorki
           for col:= col_move to Lista.Count -1 do
            begin
              Grid.Cells[col,row]:=Lista[col];
            end;
        end;

         //ExplodeString(delimiter:string;t:string;Lista:Tstrings);
                               // zamien na inny seperator
       end;
    Finally
      CSV.Free;
    End;
  End;
end;
  Finally
    OD.Free;
  End;
end;

Function  DVSAM(x1,y1,z1,x2,y2,z2:string;Labels:boolean):string;
var
  Result_t:string;
begin
// obliczenie pojedynczego dvsam
if labels then
 begin
   Result_t:= ZnakDVSAM(StrToCurr(x1),StrToCurr(x2))
            + ZnakDVSAM(StrToCurr(y1),StrToCurr(y2))
            + ZnakDVSAM(StrToCurr(z1),StrToCurr(z2));
 end else begin Result_t:='' end;

  Result:= Result_t + currtostr(dlugosc_wektora(strtocurr(x1),strtocurr(y1),strtocurr(z1),strtocurr(x2),strtocurr(y2),strtocurr(z2),0));
end;

Function  DuplicateGrid(name:string;grid:TstringGrid):boolean;
var
  a,b:integer;
Begin

 // nowy_grid(name,true);

try
 TstringGrid(activeGrid).rowcount := TstringGrid(grid).rowcount ;

 for a:= 1 to TstringGrid(grid).colcount -1 do
   begin
    for b:= 1 to TstringGrid(grid).rowcount -1 do
     begin
       TstringGrid(activegrid).Cells[a,b]:= TstringGrid(grid).Cells[a,b] ;
     end;
   end;

  Result:=True;

except
   Console.AddCommunicate(com115+'['+name+']',true);
   Result:=False;
end;
end;

Function IncList(list:TstringList):integer; // inkludowane w tabeli!!!!
Var
 i,count:integer;
begin
count:=0;
  for i:=1 to TstringGrid(activeGrid).RowCount -1 do
   begin
     if TstringGrid(activeGrid).Cells[NrColInc,i] = '1' then
      begin
        list.Add(IntToStr(i));
        count:=count + 1;
      end;
   end;
 Result:= count;
end;

Function  ZnakDVSAM(x1,x2:currency):string;  // przesuniecie od x1 -> x2
var
  temp:string;
begin                // ok

if (x1 >= 0) and (x2 > 0) then // + +
   begin
     if x1 > x2 then // <-
      begin
        temp:= '-';
      end else begin temp:= '+'; end;  // ->
   end;

  if (x1 <= 0) and (x2 < 0) then   // - -
   begin
     if x1 < x2 then  // ->
      begin
        temp:= '+';
      end else begin temp:= '-'; end; // <-
   end;

   if ((x1 < 0) and (x2 > 0)) or ((x1 > 0) and (x2 < 0))then
   begin
     if x2 > 0 then
      begin
        temp:= '+';
      end else begin temp:= '-'; end;
   end;


if x1 = x2 then
   begin
     temp:= '0';
   end;

 Result:= temp;
end;

Procedure ConvertAtomNmeToAtomSymbol(grid:tstringGrid);
var
 i:integer;
begin
  for i:=1 to TStringGrid(grid).RowCount-1 do
   begin
     TstringGrid(grid).Cells[NrColElementSymbol,i]:= AtomNameToElement(TstringGrid(grid).Cells[NrColAtomName,i]);
   end;
end;

Procedure GetMoleculeProporties();
var
 i,inc_count:integer;
begin
  IVM.StringGrid1.RowCount:= 1;

  // podaj ilosc elementow

  IVM.StringGrid1.RowCount:= IVM.StringGrid1.RowCount +1;
  IVM.StringGrid1.Cells[0,IVM.StringGrid1.RowCount-1]:= com111;
  IVM.StringGrid1.Cells[1,IVM.StringGrid1.RowCount-1]:= inttostr(Tstringgrid(activeGrid).RowCount-1);

  // ilosc includowanych elementow

  inc_count:=0;

  for i:= 1 to Tstringgrid(ActiveGrid).RowCount -1 do
   begin
    if TstringGrid(ActiveGrid).Cells[2,i] = '1' then
     begin
       inc_count:=inc_count + 1;
     end;
   end;
     IVM.StringGrid1.RowCount:= IVM.StringGrid1.RowCount +1;
     IVM.StringGrid1.Cells[0,IVM.StringGrid1.RowCount-1]:= com113;
     IVM.StringGrid1.Cells[1,IVM.StringGrid1.RowCount-1]:= inttostr(inc_count);
   // end
end;

Procedure RewriteColumn(col1,col2:integer;grid:TstringGrid);
var
 i:integer;
begin
  for i:=1 to TstringGrid(grid).rowcount - 1 do
   begin
     TstringGrid(grid).cells[col2,i]:= TstringGrid(grid).cells[col1,i];
   end;
end;

Procedure WhatVisInc();
Var
 i,d,a:integer;
 inc:TstringList;
Begin

Inc:= TstringList.Create;

for d:= 1 to project_table_form.StringGrid1.RowCount -1 do
 begin

if project_table_form.StringGrid1.Cells[2,d] = '1' then
 begin

 For i:=0 to ProjectArrayFunctions('RowCount',d-1) -1 do   // lista zaznaczonycy atomow
  begin

   if Project[d-1,i,NrColInc]  = '1' then // inc
     begin
       // NrColElementSymbol
       inc.Add(UpperCase(Project[d-1,i,NrColElementSymbol]));
     end;
   end;

// odznacz wszytskie Inc
Form14.SpeedButton4.Flat:=False;
Form14.SpeedButton6.Flat:=False;
Form14.SpeedButton7.Flat:=False;
Form14.SpeedButton8.Flat:=False;
Form14.SpeedButton9.Flat:=False;
Form14.SpeedButton10.Flat:=False;
Form14.SpeedButton11.Flat:=False;

for a:=0 to Inc.Count-1 do
 begin
   if CompareStr(UpperCase(Inc[a]), 'CL') = 0 then
    begin
      Form14.SpeedButton11.Flat:=true;
    end;
   if Pos('P',Inc[a]) > 0 then
    begin
      Form14.SpeedButton10.Flat:=true;
    end;
   if Pos('H',Inc[a]) > 0 then
    begin
      Form14.SpeedButton4.Flat:=true;
    end;
   if CompareStr(UpperCase(Inc[a]), 'C') = 0 then
    begin
      Form14.SpeedButton6.Flat:=true;
    end;
   if Pos('O',Inc[a]) > 0 then
    begin
      Form14.SpeedButton7.Flat:=true;
    end;
   if Pos('N',Inc[a]) > 0 then
    begin
      Form14.SpeedButton8.Flat:=true;
    end;
   if Pos('S',Inc[a]) > 0 then
    begin
      Form14.SpeedButton9.Flat:=true;
    end;
  end;
 end;

 {
if Vis.Count = 0 then
 begin
   project_table_form.StringGrid1.Cells[1,d]:= '0';
 end else begin project_table_form.StringGrid1.Cells[1,d]:= '1'; end;
 }


 end;
inc.Free;
end;

Procedure FillSectionAs(ArrayName:string;ArrayNumber:integer;grid:TstringGrid;col:integer;frase:string);
var
  i:integer;
begin
 for i:=1 to TstringGrid(grid).RowCount -1 do
   begin
     TstringGrid(grid).Cells[col,i]:= frase;

     if ArrayName = 'Project' then
      begin
        Project[ArrayNumber,i-1,col]:=frase;
      end;
   end;
end;

Procedure OpenDefaultBrowser(url:string);
begin
 ShellExecute(MainForm.Handle,'open',PChar(url),nil,nil,0);
end;

Procedure RepleaceRows(grid:TstringGrid);
var
 i,lineA,lineB:integer;
begin

LineA:=0;
LineB:=0;

 for i:= 1 to TstringGrid(grid).RowCount -1 do
 begin
  if (TstringGrid(grid).Cells[2,i] = '1') and (LineB = -1)  then   // included to 2
    begin
      LineB:=i;
    end;

   if (TstringGrid(grid).Cells[2,i] = '1') and (LineA = 0)  then
    begin
      LineA:=i;
      LineB:=-1;
    end;
 end;

 if (LineA > 0) and (LineB > 0) then
   begin
      TstringGrid(grid).ExchangeColRow(false,LineA,LineB);
      Console.AddCommunicate(com105+intToStr(LineA)+' and '+intToStr(LineB),true);
   end else begin Console.AddCommunicate(com106,true);  end;
end;

Procedure RenumberAtoms();
var
 a,b,P1,P2,liczba:integer;
 temp:string;
begin
{if MessageDlg (com22, com107, mtConfirmation,[mbYes, mbNo],0) = mrYes then
 begin
  liczba:=0;
for a:=1 to mainform.PageControl.PageCount -1 do
 begin
  for b:=1 to TstringGrid(mainform.PageControl.Page[a].Controls[0]).RowCount -1 do
   begin
      Liczba:= Liczba +1;
      temp:= TstringGrid(mainform.PageControl.Page[a].Controls[0]).Cells[NrColAtomId,b]; // stara wartosc
      For P1:=1 to Form2.StringGrid.RowCount -1 do
       begin
         For P2:=0 to Form2.StringGrid.ColCount -1 do
          begin
             if AnsiCompareText(temp,// Form2.StringGrid.Cells[P2,P1]) = 0 then   // jak znajdziesz to zamien
              begin
                 // Form2.StringGrid.Cells[P2,P1] := inttostr(liczba);
              end;
          end;
       end;
     TstringGrid(mainform.PageControl.Page[a].Controls[0]).Cells[NrColAtomId,b]:= inttostr(liczba);
   end;
 end;
 // number last
   LastConectNumber:= StrToInt(Tstringgrid(mainform.PageControl.Page[mainform.PageControl.PageCount -1].Controls[0])
        .cells[3,Tstringgrid(mainform.PageControl.Page[mainform.PageControl.PageCount -1].Controls[0]).rowcount-1]);
 end; }
end;

Function RMSDArM(x1,y1,z1,x2,y2,z2:Tstrings):string;
Var
  i,count_petla:integer;
  suma,ArithmeticAverage:currency;
  wynik:string;
begin
  if (x1.Count = y2.Count) and (y1.Count = z2.Count) and (z1.Count = x2.Count) then
   begin
     wynik:= 'c:';   // compleate
     count_petla:= x1.Count;
   end                                      // sparwdzenie poprawnosci danych wejsciowych
     else                                   // i typu analizy
   begin
     wynik:='f:'; // fragmental
     if (x1.Count > x2.Count) and (y1.Count > y2.Count) and (z1.Count > z2.Count) then
      begin
        count_petla:= x2.Count;   // bo mniejsze
      end;

      if (x1.Count < x2.Count) and (y1.Count < y2.Count) and (z1.Count < z2.Count) then
      begin
        count_petla:= x1.Count; // bo mniejsze ;P
      end;
   end;

   suma:=0;
   ArithmeticAverage:= 0;

    for i:=0 to count_petla-1 do
    begin
      ArithmeticAverage:= ArithmeticAverage + dlugosc_wektora(strtocurr(x1[i]),strtocurr(y1[i]),strtocurr(z1[i]),strtocurr(x2[i]),strtocurr(y2[i]),strtocurr(z2[i]),0);
    end;

    if ArithmeticAverage > 0 then
     begin
       ArithmeticAverage := ArithmeticAverage / count_petla; // srednia arytmetyczna dlugosci

   for i:=0 to count_petla-1 do //  suma kwadratow roznic srednia od aktualnego wektora
    begin
      suma:= suma + Power(ArithmeticAverage - dlugosc_wektora(strtocurr(x1[i]),strtocurr(y1[i]),strtocurr(z1[i]),strtocurr(x2[i]),strtocurr(y2[i]),strtocurr(z2[i]),0),2);                                                                                                 // suma kwadratów
    end;

    if count_petla > 0 then
     begin
       suma := suma / count_petla ; // podziel przez ilosc sumy
       suma:= sqrt(suma);
       Result:= wynik + currtostr(suma);   // pierwisatek
     end
       else
    begin
      Result:= com9 + '[RMSDArM][2]';
    end;

   end else begin Result:= com9 + '[RMSDArM][1]';   end;
end;

Function RMSD(x1,y1,z1,x2,y2,z2:Tstrings;Labels:boolean):string;
Var
  i,count_petla:integer;
  suma:currency;
  wynik:string;
begin
  if (x1.Count = y2.Count) and (y1.Count = z2.Count) and (z1.Count = x2.Count) then
   begin
     if Labels then
      begin
        wynik:= 'c:';   // compleate
      end;

     count_petla:= x1.Count;
   end                                      // sparwdzenie poprawnosci danych wejsciowych
     else                                   // i typu analizy
   begin
     if Labels then
       begin
         wynik:='f:'; // fragmental
       end;

     if (x1.Count > x2.Count) and (y1.Count > y2.Count) and (z1.Count > z2.Count) then
      begin
        count_petla:= x2.Count;   // bo mniejsze
      end;

      if (x1.Count < x2.Count) and (y1.Count < y2.Count) and (z1.Count < z2.Count) then
      begin
        count_petla:= x1.Count; // bo mniejsze ;P
      end;
   end;

   suma:=0;

   for i:=0 to count_petla-1 do
    begin
      suma:= suma + Power(dlugosc_wektora(strtocurr(x1[i]),strtocurr(y1[i]),strtocurr(z1[i]),strtocurr(x2[i]),strtocurr(y2[i]),strtocurr(z2[i]),0),2); //  dlugosci wektorow zerowa ranga brak rangi                                                                                                                                                  // suma kwadratów
    end;

    if count_petla > 0 then
     begin
       suma := suma / count_petla ; // podziel przez ilosc sumy
       suma:= sqrt(suma);
       Result:= wynik + currtostr(suma);   // pierwisatek
     end
       else
    begin
      Result:= com9 + '[RMSD][1]';
    end;
end;

Function  CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2:TstringList;Labels:boolean):string;     // to do!!!!!!
var
 i,count_petla,plusX,plusY,plusZ,minusX,minusY,minusZ,dzielnik:integer;
 suma,wektor:currency;
 wynik:string;
begin
 if (x1.Count = y2.Count) and (y1.Count = z2.Count) and (z1.Count = x2.Count) then
   begin
     if labels then
      begin
        wynik:= 'c:';   // compleate
      end;
     count_petla:= x1.Count;
   end                                      // sparwdzenie poprawnosci danych wejsciowych
     else                                   // i typu analizy
   begin
     if labels then
      begin
        wynik:='f:'; // fragmental
      end;

     if (x1.Count > x2.Count) and (y1.Count > y2.Count) and (z1.Count > z2.Count) then
      begin
        count_petla:= x2.Count;   // bo mniejsze
      end;

      if (x1.Count < x2.Count) and (y1.Count < y2.Count) and (z1.Count < z2.Count) then
      begin
        count_petla:= x1.Count; // bo mniejsze ;P
      end;
   end;

   suma:=0;
   plusX:=0;  plusY:=0;  plusZ:=0;
   minusX:=0; minusY:=0; minusZ:=0;
   dzielnik:=0;

   For i:=0 to count_petla -1 do
    begin  // wylicz srednie  i policz wstapienia + i -

      wektor:= dlugosc_wektora(
                               StrToCurr(x1[i]),
                               StrToCurr(y1[i]),
                               StrToCurr(z1[i]),
                               StrToCurr(x2[i]),
                               StrToCurr(y2[i]),
                               StrToCurr(z2[i]),
                               0); //ranga = 0

      if wektor > -1 then
      begin
        suma:= suma + wektor;
        dzielnik:= dzielnik + 1;
      end
        else
       begin Console.AddCommunicate(com104+'[aDVSAM]',true); end;

      if ZnakDVSAM(StrToCurr(x1[i]),StrToCurr(x2[i])) = '+' then   // zlicz ilosc wystapien + w x2
       begin
         plusX:= plusX + 1 ;
       end;                                                 // zliczenie wystapien

      if ZnakDVSAM(StrToCurr(y1[i]),StrToCurr(y2[i])) = '+' then  // + Y
       begin
         plusY:= plusY + 1 ;
       end;

      if ZnakDVSAM(StrToCurr(z1[i]),StrToCurr(z2[i])) = '+' then // + Z
       begin
         plusZ:= plusZ + 1 ;
       end;
      if ZnakDVSAM(StrToCurr(x1[i]),StrToCurr(x2[i])) = '-' then   // zlicz ilosc wystapien - w x2
       begin
         minusX:= minusX + 1 ;
       end;

      if ZnakDVSAM(StrToCurr(y1[i]),StrToCurr(y2[i])) = '-' then  // - Y
       begin
         minusY:= minusY + 1 ;
       end;

      if ZnakDVSAM(StrToCurr(z1[i]),StrToCurr(z2[i])) = '-' then // - Z
       begin
         minusZ:= minusZ + 1 ;
       end;

    end;

    if dzielnik > 0 then
     begin
       if plusX = minusX then
        begin
          wynik:= wynik + '0';    // ocen X
        end else
        begin
           if plusX > minusX then   // dodaj plusa lub minusa do wyniku
             begin
               wynik:= wynik + '+';
             end else begin wynik:= wynik + '-'; end;
        end;

       if plusY = minusY then
         begin
           wynik:= wynik + '0';
         end else
            begin
              if plusY > minusY then
                begin
                  wynik:= wynik + '+';
                end else begin wynik:= wynik + '-'; end;
            end;

       if plusZ = plusZ then
         begin
           wynik:= wynik + '0';
         end else
          begin
            if plusZ > minusZ then
              begin
                wynik:= wynik + '+';
              end else begin wynik:= wynik + '-'; end;
          end;

      suma:= suma / dzielnik ; // srednia arytmetyczna wystapien

      if Labels then
        begin
          wynik:= wynik + CurrToStr(suma);
        end else begin wynik:= CurrToStr(suma); end;


      Result:=wynik;
     end
    else
     begin Result:=com80+'['+com9+']' end;
end;

// funkcja zwaraca znak liczby ujemny dodatni albo 0
Function znak_liczby(liczba:string):string;
begin
  if strtocurr(liczba) <= 0 then   // sparwdzenie znaku
   begin
      if strtocurr(liczba) = 0 then
        begin
          Result:= '0' ;
        end
         else
        begin
          Result:= '-' ;
        end;
   end else
      begin Result:= '+' end;
end;

Function dlugosc_wektora(x1,y1,z1,x2,y2,z2,ranga:currency):Currency; // zamienia wspolrzedne na dlugosc wektora
var
 xc,yc,zc,temp:currency;
begin
     xc:= x2 - x1;  // roznica wspolzednych
     xc:= Power(xc,2); //kwadrat wspolzednej

     yc:= y2 - y1;
     yc:= Power(yc,2);

     zc:= z2 - z1;
     zc:= Power(zc,2);

     temp:= xc+yc+zc;    // suma potegowanych
     temp:= sqrt(temp);  // pierwiastek z sumy, czyli odleglosc DLUGOSC WEKTORA

     if ranga > 0 then   // uwzglednienie rangi jesli jest wieksza od 0
       begin
         temp:= temp * ranga;
       end;

    if temp >= 0 then
     begin
      Result:=  temp;
     end else begin Result:= -1; end;
end;

Function  FirstCheckedRowNumber(Grid:TstringGrid;col:integer):integer;  // pierwszy inc w project table
var
 i:integer;
Begin
 for i:=1 to TStringGrid(Grid).RowCount-1 do
  begin
    if StrToInt(TStringGrid(Grid).Cells[col,i]) = 1 then
     begin
       Result:= i;
       Break;
     end;
  end;
end;

Function  CheckedCount(Grid:TstringGrid;col:integer):integer;
var
 i,res:integer;
Begin
res:=0;
 for i:=1 to TStringGrid(Grid).RowCount-1 do
  begin
    if StrToInt(TStringGrid(Grid).Cells[col,i]) = 1 then
     begin
       res := res + 1;
     end;
  end;
 Result:=res;
end;

Procedure AddRecordToPtojectTable(col2,col3,col4,col5,col6,col7,col8,col9:string);
begin
  Project_table_form.StringGrid1.RowCount:= Project_table_form.StringGrid1.RowCount+1;
  Project_table_form.StringGrid1.Cells[0,Project_table_form.StringGrid1.RowCount-1]:= IntToStr(Project_table_form.StringGrid1.RowCount); // No.
  Project_table_form.StringGrid1.Cells[1,Project_table_form.StringGrid1.RowCount-1]:= col2; // vis
  Project_table_form.StringGrid1.Cells[2,Project_table_form.StringGrid1.RowCount-1]:= col3; // inc
  Project_table_form.StringGrid1.Cells[3,Project_table_form.StringGrid1.RowCount-1]:= col4; // name
  Project_table_form.StringGrid1.Cells[4,Project_table_form.StringGrid1.RowCount-1]:= col5; // type
  Project_table_form.StringGrid1.Cells[5,Project_table_form.StringGrid1.RowCount-1]:= col6; // file orginal name from where taken
  Project_table_form.StringGrid1.Cells[6,Project_table_form.StringGrid1.RowCount-1]:= col7; // comments
//  Project_table_form.StringGrid1.Cells[7,Project_table_form.StringGrid1.RowCount-1]:= col8;
//  Project_table_form.StringGrid1.Cells[8,Project_table_form.StringGrid1.RowCount-1]:= col9;
end;

Procedure SeparateGridByColumn(Grid:TstringGrid;Col:integer);
var
 i:integer;
 wzor:string;
 pierwszy:boolean=false;

begin
if CheckedCount(project_table_form.StringGrid1,2) <> 1 then
 begin
   Console.AddCommunicate(com103,true);
 end
  else
 begin
 if MessageDlg (com22,com102, mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
   wzor:='';

   for i:=1 to TStringGrid(grid).rowcount - 1 do
    begin

     if CompareStr(TStringGrid(grid).Cells[col,i],wzor) <> 0 then
       begin
            wzor:= TStringGrid(grid).cells[col,i]; // przepisz na zmienna tymczasową i porownuj z nia

            // dodanie do project form
            AddRecordToPtojectTable('0','1',wzor,
            Project_Table_Form.StringGrid1.Cells[4,FirstCheckedRowNumber(grid,2)],
            Project_Table_Form.StringGrid1.Cells[5,FirstCheckedRowNumber(grid,2)],
            '','','');


          //  nowy_Grid(wzor,True); // nowy grid ktory bedzie aktive grid

            TstringGrid(ActiveGrid).rowcount:=2;
            Tstringgrid(ActiveGrid).rows[1]:= Tstringgrid(grid).rows[i]; // ?

       end;

       if CompareStr(TStringGrid(grid).Cells[col,i],wzor) = 0 then
         begin
             TstringGrid(ActiveGrid).rowcount:= TstringGrid(ActiveGrid).rowcount+1;
             Tstringgrid(ActiveGrid).rows[TstringGrid(ActiveGrid).rowcount-1]:= Tstringgrid(grid).rows[i];
         end;

    end;
   end;
end;
end;

Function aAnglePlaneAnalysis(x1,y1,z1,x2,y2,z2:TStringList;Labels:Boolean):string; // sama lista wartosci bez dopisanych na dole
var                                                                 // fukcja sama dopisze wartosci pierwsza i druga na koniec
  wynik:string;                                                     // listy !!!
  lista:TstringList;
  count_petla:integer; // stwierzda ile ma razy isc petla przy C wariancie i przy F vawiancie
  i:integer;
  suma:currency;
begin
lista := TstringList.Create;
// dopisanie wartosci na koniec listy
if (x1.Count > 2) and (y2.Count > 2) and (y1.Count > 2) and (z2.Count> 2)
   and (z1.Count > 2) and (x2.Count > 2) then
begin

x1.Add(x1[0]);   // dopianie wartosci na koniec list
x1.Add(x1[1]);

y1.Add(y1[0]);
y1.Add(y1[1]);

z1.Add(z1[0]);
z1.Add(z1[1]);

x2.Add(x2[0]);
x2.Add(x2[1]);

y2.Add(y2[0]);
y2.Add(y2[1]);

z2.Add(z2[0]);
z2.Add(z2[1]);
// end

  if (x1.Count = y2.Count) and (y1.Count = z2.Count) and (z1.Count = x2.Count) then
   begin
    if Labels then
     begin
        wynik:= 'c:';   // compleate
     end;
     count_petla:= x1.Count;
   end                                      // sparwdzenie poprawnosci danych wejsciowych
     else                                   // i typu analizy
   begin
     if Labels then
      begin
        wynik:='f:'; // fragmental
      end;

     if (x1.Count > x2.Count) and (y1.Count > y2.Count) and (z1.Count > z2.Count) then
      begin
        count_petla:= x2.Count; // bo mniejsza wartosc
      end; // else Console.AddCommunicate(com16+'[aAnglePlaneAnalysis][2]');

      if (x1.Count < x2.Count) and (y1.Count < y2.Count) and (z1.Count < z2.Count) then
      begin
        count_petla:= x1.Count;  // bo mniejsza wartosc
      end; // else Console.AddCommunicate(com16+'[aAnglePlaneAnalysis][2]');
   end;

   for i:=0 to count_petla - 3 do // bo nie mozna wyliczyć dla 2 ostatnich, bo nie ma kolejnej wartosci
    begin
      lista.Add(CurrToStr(AnglePlaneAnalysis(
        StrToCurr(x1[i]),
        StrToCurr(y1[i]),
        StrToCurr(z1[i]),
        StrToCurr(x1[i+1]),
        StrToCurr(y1[i+1]),
        StrToCurr(z1[i+1]),
        StrToCurr(x1[i+2]),
        StrToCurr(y1[i+2]),
        StrToCurr(z1[i+2]),

        StrToCurr(x2[i]),
        StrToCurr(y2[i]),
        StrToCurr(z2[i]),
        StrToCurr(x2[i+1]),
        StrToCurr(y2[i+1]),
        StrToCurr(z2[i+1]),
        StrToCurr(x2[i+2]),
        StrToCurr(y2[i+2]),
        StrToCurr(z2[i+2]))));
    end;


  Result:= wynik + ArithmeticAverage(lista);

end
 else Console.AddCommunicate(com16+'[aAnglePlaneAnalysis][1]',true);

lista.Free;
end;

Procedure wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;wynik:TstringList);
var
   A,B,C,D:currency;
begin
   A:= y1*(z2 - z3) + y2*(z3 - z1) + y3*(z1 - z2);   // A = y1 (z2 - z3) + y2 (z3 - z1) + y3 (z1 - z2)
   B:= z1*(x2 - x3) + z2*(x3 - x1) + z3*(x1 - x2);   // B = z1 (x2 - x3) + z2 (x3 - x1) + z3 (x1 - x2)
   C:= x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2);   // C = x1 (y2 - y3) + x2 (y3 - y1) + x3 (y1 - y2)
   D:= x1*(y2*z3 - y3*z2) + x2*(y3*z1 - y1*z3) + x3*(y1*z2 - y2*z1); // - D = x1 (y2 z3 - y3 z2) + x2 (y3 z1 - y1 z3) + x3 (y1 z2 - y2 z1)
   D:= D * -1;    // -D

   wynik.Clear;
   wynik.Add(currtostr(A));      // Ax + By + Cz + D = 0
   wynik.Add(currtostr(B));
   wynik.Add(currtostr(C));
   wynik.Add(currtostr(D));

end;

Function  AnglePlaneAnalysis(x11,y11,z11,x12,y12,z12,x13,y13,z13,x21,y21,z21,x22,y22,z22,x23,y23,z23:currency):Currency;
var
 A1,A2,B1,B2,C1,C2,D1,D2,cz1,cz2,cz3,cosAlfa,APA1,APA2:currency;
 wynik:TstringList;

begin

 // plaszczyzna 1

wynik:= Tstringlist.Create;

 wsp_plaszczyzny(x11,y11,z11,x12,y12,z12,x13,y13,z13,wynik);

 A1:=strtocurr(wynik[0]);
 B1:=strtocurr(wynik[1]);
 C1:=strtocurr(wynik[2]);
 D1:=strtocurr(wynik[3]);

  // plaszczyzna 2

 wsp_plaszczyzny(x21,y21,z21,x22,y22,z22,x23,y23,z23,wynik);

 A2:=strtocurr(wynik[0]);
 B2:=strtocurr(wynik[1]);
 C2:=strtocurr(wynik[2]);
 D2:=strtocurr(wynik[3]);


 if (A1<>0) and (B1<>0) and (C1<>0) and (A2<>0) and (B2<>0) and (C2<>0) then
  begin
   try
    cz1:= A1*A2 + B1*B2 + C1*C2 ;                     // wspólczynnik

    cz2:= power(A1,2) + power(B1,2) + power(C1,2);
    cz2:= sqrt(cz2);

    cz3:= power(A2,2) + power(B2,2) + power(C2,2);
    cz3:= sqrt(cz3);

    cosAlfa:= cz1 / (cz2*cz3);


   if cosAlfa < -1 then
     begin
       cosAlfa:= -1;
     end;

   if cosAlfa > 1 then
     begin
       cosAlfa:= 1;
     end;


    APA1:= 180 - ((180 * arccos(cosAlfa))/Pi);
    APA2:= (180 * arccos(cosAlfa))/Pi;

    If ABS(APA1) > ABS(APA2) then
      begin
         Result:= ABS(APA2)
      end else begin  Result:= ABS(APA1)  end;

   except
     Result:=0;
   end;
  end
   else
  begin
    Result:= 0; // kat rowny jest zero kiedy sa wspolliniowe
  end;
end;

Procedure FindFraseInGrid(Grid : TStringGrid; frase:string);
var
  row,col:integer;
begin

grid.Repaint; // znika stare zaznaczenie

  For col:=grid.FixedCols to grid.ColCount-1 do
   begin
     For row:=grid.FixedRows to grid.RowCount-1 do
      begin
        if Pos(frase, grid.Cells[col,row]) > 0 then
         begin
            grid.Canvas.Brush.Color := clYellow;
            grid.Canvas.FillRect(grid.CellRect(col,row));
            grid.Canvas.TextOut(grid.CellRect(col,row).Left + 2,
                  grid.CellRect(col,row).Top + 2, grid.Cells[Col,Row]);
         end;
      end;
   end;
end;

procedure SortGridDecrease(Grid : TStringGrid; SortCol:integer);
{A simple exchange sort of grid rows}
var
   i,j : integer;
   temp:tstringlist;
   zamien:boolean;
begin

  temp:=tstringlist.create;

with Grid do
begin
  for i := FixedRows to RowCount - 2 do  {because last row has no next row}
begin
  for j:= i+1 to rowcount-1 do {from next row to end}
begin

if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) < 0 then
     begin
        temp.assign(rows[j]);
        rows[j].assign(rows[i]);
        rows[i].assign(temp);
     end;

if Czy_liczba(Cells[SortCol, i]) and Czy_Liczba(Cells[SortCol,j]) then
    begin
      if StrToCurr(Cells[SortCol, i]) < StrToCurr(Cells[SortCol, j]) then
       begin
         temp.assign(rows[j]);
         rows[j].assign(rows[i]);
         rows[i].assign(temp);
       end;
    end;

end;
end;
  temp.free;
end;
end;

procedure SortGridIncrease(Grid : TStringGrid; SortCol:integer);
{A simple exchange sort of grid rows}
var
   i,j : integer;
   temp:tstringlist;
   zamien:boolean;
begin

  temp:=tstringlist.create;

with Grid do
begin
  for i := FixedRows to RowCount - 2 do  {because last row has no next row}
begin
  for j:= i+1 to rowcount-1 do {from next row to end}
begin

if AnsiCompareText(Cells[SortCol, i], Cells[SortCol,j]) > 0 then
     begin
        temp.assign(rows[j]);
        rows[j].assign(rows[i]);
        rows[i].assign(temp);
     end;

if Czy_liczba(Cells[SortCol, i]) and Czy_Liczba(Cells[SortCol,j]) then
    begin
      if StrToCurr(Cells[SortCol, i]) > StrToCurr(Cells[SortCol, j]) then
       begin
         temp.assign(rows[j]);
         rows[j].assign(rows[i]);
         rows[i].assign(temp);
       end;
    end;

end;
end;

  temp.free;
end;
end;

Procedure BondsFromStream(Stream:TstringList);
var
 a,b:integer;
 current:string;
 stream2:TstringList;
Begin
   Stream2:=TstringList.Create;
   Stream2.AddStrings(stream);
  // dodaj odpowiedznia ilosc rowsów do wybranego grida projektu
  SetLength(Bonds, Stream2.Count, BondsArrayColCount);
                    // row           col

 for a:=0 to Stream2.Count-1 do
  begin
  b:=0;

    repeat

      current:= Copy(Stream2[a],0,Pos('|',Stream2[a])-1);  // pobierz od zera do bierzacego wystapenia
      Stream2[a]:= Copy(Stream2[a],Length(current)+2,Length(Stream2[a])); // funkcja explode

      try
         // project, row, col
         Bonds[a,b]:= current;

      except

      end;

    inc(b);
    until Pos('|',Stream2[a]) = 0 ;

  end;
end;

Procedure NewProjectGridFromStream(GridNumber:integer;Stream:TstringList);
var
 a,b,od,doo:integer;
 current:string;
 c:boolean;
 stream2:TstringList;
Begin
   Stream2:=TstringList.Create;
   Stream2.AddStrings(stream);
  // dodaj odpowiedznia ilosc rowsów do wybranego grida projektu
  SetLength(Project[GridNumber], Stream2.Count, ProjectArrayColCount);
                                 // row           col

 for a:=0 to Stream2.Count-1 do
  begin
  b:=0;

    repeat

      current:= Copy(Stream2[a],0,Pos('|',Stream2[a])-1);  // pobierz od zera do bierzacego wystapenia
      Stream2[a]:= Copy(Stream2[a],Length(current)+2,Length(Stream2[a])); // funkcja explode

      try
         // project, row, col
         Project[GridNumber,a,b]:= current;

      except

      end;

    inc(b);
    until Pos('|',Stream2[a]) = 0 ;

  end;
end;

Procedure GridFromStream(Grid:Tobject;Stream:TstringList);
var
 a,b,od,doo:integer;
 current:string;
 c:boolean;
Begin

  TstringGrid(Grid).RowCount:= Stream.Count + 1; // dodaj odpowiedznia ilosc rowsów

 for a:=0 to Stream.Count-1 do
  begin
  b:=0;

    repeat

      current:= Copy(Stream[a],0,Pos('|',Stream[a])-1);  // pobierz od zera do bierzacego wystapenia
      Stream[a]:= Copy(Stream[a],Length(current)+2,Length(Stream[a])); // funkcja explode
      try
        if TstringGrid(Grid).ColCount < b+1 then
         begin
           TstringGrid(Grid).Columns.Add; // jak sie sypie to tutaj !!!!
           TstringGrid(Grid).Columns.Items[b].Title.Caption:='Value '+ inttostr(b);
         end;

        TstringGrid(Grid).Cells[b,a+1]:= current;

      except
      end;
    inc(b);
    until Pos('|',Stream[a]) = 0 ;

  end;
end;

Procedure GridToStream(Grid:Tobject;Stream:TstringList);
var
  a,b:integer;
begin
  For a:= 1 to TStringGrid(Grid).rowcount -1 do
   begin
    Stream.add(''); // dodaj pusty
     For b:= 0 to TStringGrid(Grid).colcount-1 do
      begin

        if Stream[Stream.count-1] > '' then
         begin
          Stream[Stream.count-1]:= Stream[Stream.count-1]
            +'|'+ TStringGrid(Grid).cells[b,a] ; // delimiter '|'
         end
          else begin
             Stream[Stream.count-1]:= TStringGrid(Grid).cells[b,a];
          end;
      end;
     Stream[Stream.count-1]:= Stream[Stream.count-1] + '|'; // dodaj na koniec osttani
    end;
end;

Procedure ArrayToStream(ProjectNumber:integer;Stream:TstringList);
var
  a,b:integer;
begin
  For a:= 0 to ProjectArrayFunctions('RowCount',ProjectNumber) -1 do
   begin
    Stream.add(''); // dodaj pusty
     For b:= 0 to ProjectArrayFunctions('ColCount',ProjectNumber) -1 do
      begin

        if Stream[Stream.count-1] > '' then
         begin
          Stream[Stream.count-1]:= Stream[Stream.count-1]
            +'|'+ Project[ProjectNumber,a,b]; // delimiter '|'
         end
          else begin
             Stream[Stream.count-1]:= Project[ProjectNumber,a,b];
          end;
      end;
     Stream[Stream.count-1]:= Stream[Stream.count-1] + '|'; // dodaj na koniec osttani
    end;
end;

Function PredictBoundBaseOnDistance(distance:integer):integer;
begin

end;

Function  AtomsNumbersToDistatance(AtomA,AtomB:string):currency;
var
 a,b:integer;
 x1,x2,y1,y2,z1,z2:currency;
begin
    // szukaj Atom A
  for a:=1 to Project_table_form.StringGrid1.RowCount -1 do
   begin
     for b:=0 to ProjectArrayFunctions('RowCount',a-1) -1 do
      begin
        if Project[a-1,b,NrColAtomId] = AtomA then
          begin
            x1:= StrToCurr(Project[a-1,b,NrColx]);
            y1:= StrToCurr(Project[a-1,b,NrColy]);
            z1:= StrToCurr(Project[a-1,b,NrColz]);
          end;
      end;
   end;
    // szukaj Atom B
   for a:=1 to Project_table_form.StringGrid1.RowCount -1 do
   begin
     for b:=0 to ProjectArrayFunctions('RowCount',a-1) -1 do
      begin
        if Project[a-1,b,NrColAtomId] = AtomB then
          begin
            x2:= StrToCurr(Project[a-1,b,NrColx]);
            y2:= StrToCurr(Project[a-1,b,NrColy]);
            z2:= StrToCurr(Project[a-1,b,NrColz]);
          end;
      end;
   end;

   if czy_liczba(CurrToStr(dlugosc_wektora(x1,y1,z1,x2,y2,z2,0))) then
     begin
       Result:= dlugosc_wektora(x1,y1,z1,x2,y2,z2,0);
     end else begin Result:= -1 end;
   end;

Function AtomNumberToAtomName(number:string):string;
var
 a,b:integer;
 res:string;
begin

res:='-1';

  for a:=1 to ProjectArrayFunctions('ProjectCount',0) - 1 do
   begin
     for b:=0 to ProjectArrayFunctions('RowCount',a-1) - 1 do
      begin
        if Project[a-1,b,NrColAtomId] = number then
          begin
            Res := Project[a-1,b,NrColAtomName];
          end;
      end;
   Result:= Res;
   end;
end;

procedure ImportPDBsetionConnect(rekord:string);  // details: http://www.bmsc.washington.edu/CrystaLinks/man/pdb/part_69.html
var
 i:integer;
 List:TstringList;
begin
  List:=TstringList.Create;

  list.Add(copy(rekord,7,5)); // 7 - 11 -  Atom serial number

  if (copy(rekord,12,5) > '') then
    begin
      list.Add(copy(rekord,12,5)); // 12 - 16 Serial number of bonded atom
    end;

  if (copy(rekord,17,5) > '') then
    begin
      list.Add(copy(rekord,17,5)); //  17 - 21  Serial number of bonded atom
    end;

  if (copy(rekord,22,5) > '') then
    begin
      list.Add(copy(rekord,22,5));  // 22 - 26 Serial number of bonded atom
    end;

   if (copy(rekord,27,5) > '') then
    begin
      list.Add(copy(rekord,27,5));  //  27 - 31 Serial number of bonded atom
    end;

   for i:=1 to List.Count-1 do
    begin
      Console.AddCommunicate('bond added '+list[1]+'/'+List[i+1],true);

      ClearSelection(-1);

      if (SelectAtom(list[1])) and (SelectAtom(List[i+1])) then
       begin
         AddBond();
       end;
    end;

  list.Free;
end;

procedure CheckBondsColumnIf(ArrayNumber:integer;ColNrFrazy:Tstringlist;Frazy:Tstringlist;exactly:boolean;NrColDoWypelnienia:integer;Wartosc:string);
Var
 row,b,wystapienia:integer;
begin
  For row:=0 to Length(Bonds) -1 do  // row
   begin
     wystapienia:=0;

    for b:=0 to ColNrFrazy.Count -1 do
     begin
       if (exactly = True) and ( CompareStr(UpperCase(Bonds[row,strtoint(ColNrFrazy[b])]), UpperCase(Frazy[b])) = 0) then
        begin
          inc(wystapienia);
        end;

       if (exactly = False) and ( Pos(UpperCase(Frazy[b]),UpperCase(Bonds[row,strtoint(ColNrFrazy[b])])) > 0) then
        begin
          inc(wystapienia);
        end;
     end;


   If wystapienia = ColNrFrazy.Count then
    begin
      // Form2.StringGrid.Cells[NrColDoWypelnienia,row+1]:= Wartosc;
      Bonds[row,NrColDoWypelnienia]:= Wartosc;

     if (NrColDoWypelnienia = 1) or (NrColDoWypelnienia = 2) then
      begin
         Project_table_form.StringGrid1.Cells[NrColProj_Inc,ArrayNumber+1]:='1';
      end;

    end;

end;
end;

procedure CheckProjectColumnIf(ArrayNumber:integer;ColNrFrazy:Tstringlist;Frazy:Tstringlist;exactly:boolean;NrColDoWypelnienia:integer;Wartosc:string);
Var
 row,b,wystapienia:integer;
begin
  For row:=0 to ProjectArrayFunctions('RowCount',ArrayNumber) -1 do  // row
   begin
     wystapienia:=0;

    for b:=0 to ColNrFrazy.Count -1 do
     begin
       if (exactly = True) and ( CompareStr(Project[ArrayNumber,row,strtoint(ColNrFrazy[b])], Frazy[b]) = 0) then
        begin
          inc(wystapienia);
        end;

       if (exactly = False) and ( Pos(UpperCase(Frazy[b]),UpperCase(Project[ArrayNumber,row,strtoint(ColNrFrazy[b])])) > 0) then
        begin
          inc(wystapienia);
        end;
     end;


   If wystapienia = ColNrFrazy.Count then
    begin

      Project[ArrayNumber,row,NrColDoWypelnienia]:= Wartosc;

    if (NrColDoWypelnienia = 1) or (NrColDoWypelnienia = 2) then
      begin
         Project_table_form.StringGrid1.Cells[NrColProj_Inc,ArrayNumber+1]:='1';
      end;

    end;

end;
end;

procedure CheckColumnIf(ArrayName:string;ArrayNumber:integer;grid:TstringGrid;check:boolean;ColNr:integer;ColNrFrase:Integer;fraza:string;exactly:boolean);
Var
 i:integer;
begin
  For i:=1 to TstringGrid(grid).RowCount-1 do
   begin
   If exactly then    // szukaj dokladjen frazy
    begin
    if  CompareStr(TstringGrid(grid).Cells[ColNrFrase,i], fraza) = 0 then
     begin
      if check = True then
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '1' ;
         if ArrayName = 'Project' then  // Array Project
          begin
            Project[ArrayNumber,i-1,ColNr]:='1';
          end;

         if ArrayName = 'Bonds' then  // Array Project
          begin
            Bonds[i-1,ColNr]:='1';
          end;

       end
         else
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '0' ;

         if ArrayName = 'Project' then  // Array Project
          begin
            Project[ArrayNumber,i-1,ColNr]:='0';
          end;

         if ArrayName = 'Bonds' then  // Array Project
          begin
            Bonds[i-1,ColNr]:='0';
          end;

       end;
     end;
     end else
       begin
       // oby tylko zawieralo text
  if Pos(UpperCase(fraza),UpperCase(TstringGrid(grid).Cells[ColNrFrase,i])) > 0 then
     begin
      if check = True then
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '1' ;

         if ArrayName = 'Project' then  // Array Project
          begin
            Project[ArrayNumber,i-1,ColNr]:='1';
          end;

        if ArrayName = 'Bonds' then  // Array Project
          begin
            Bonds[i-1,ColNr]:='1';
          end;

       end
         else
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '0' ;

         if ArrayName = 'Project' then  // Array Project
          begin
            Project[ArrayNumber,i-1,ColNr]:='0';
          end;

         if ArrayName = 'Bonds' then  // Array Project
          begin
            Bonds[i-1,ColNr]:='0';
          end;

       end;
     end;
  end;
end;
end;

procedure CheckColumn(grid:TstringGrid;check:boolean;ColNr:integer);
Var
 i:integer;
begin
  For i:=1 to TstringGrid(grid).RowCount-1 do
   begin
      if check = True then
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '1' ;
       end
         else
       begin
         TstringGrid(grid).Cells[ColNr,i]:= '0' ;
       end;
   end;
end;

Procedure CheckProjectArrayColumn(ProjectNumber,ColumnNumber:integer;Value:string);
Var
 row:integer;
begin
  For row:=0 to ProjectArrayFunctions('RowCount',ProjectNumber) -1 do
   begin
     Project[ProjectNumber,row,ColumnNumber]:=Value;
   end;
end;

Procedure CheckBondsArrayColumn(ProjectNumber,ColumnNumber:integer;Value:string);
Var
 row:integer;
begin
  For row:=0 to Length(Bonds) -1 do
   begin
    //  console.AddCommunicate(Bonds[row,0]+'='+inttostr(ProjectNumber),true);
    if strtoint(Bonds[row,0]) = ProjectNumber then
     begin
       Bonds[row,ColumnNumber]:= Value;
       // Form2.StringGrid.Cells[ColumnNumber,row]:=Value;
     end;
   end;
end;

procedure ExportAsXML(Sender:Tobject);
begin
if MessageDlg (com26, com95, mtConfirmation,[mbYes, mbNo],0) = mrYes
then
begin
  //Mainform.Savedialog1.FileName:= MainForm.Pagecontrol.ActivePage.Caption + '.xml';
  Mainform.Savedialog1.filterindex:=2;

  if Mainform.SaveDialog1.Execute then
   begin
     if Mainform.Savedialog1.FileName > '' then
      begin
       If Copy(Mainform.Savedialog1.FileName,Pos('.',Mainform.Savedialog1.FileName),Length(Mainform.Savedialog1.FileName)-Pos('.',Mainform.Savedialog1.FileName)+1) <> '.xml' Then Mainform.Savedialog1.FileName := Mainform.Savedialog1.FileName + '.xml';
       try TstringGrid(activegrid).SaveToFile(UTF8decode(Mainform.Savedialog1.FileName));
       except
         Console.AddCommunicate(com7,true);
       end;
      end;
   end;
end;
end;

procedure ImportGridAsXML(Sender:Tobject);
begin
  Mainform.Opendialog1.FilterIndex:=3;
  Mainform.Opendialog1.FileName:='';
  if Mainform.Opendialog1.Execute then
   begin
     if Mainform.Opendialog1.FileName > '' then
      begin
       // try
          //nowy_Grid(ExtractFileName(Copy(Mainform.Opendialog1.FileName,0,Pos('.',Mainform.Opendialog1.FileName)-1)),True); // nie laduje z tymczasowego
          Tstringgrid(activegrid).LoadFromFile(UTF8decode(Mainform.Opendialog1.FileName));
      //   except
      //     Console.AddCommunicate(com13);
      //     exit;
      //   end;
      end;
end;
end;

procedure GridAsxMOL(Sender:Tobject);
var
  i,a,b:integer;
  xyzFile: Tstringlist;
begin
xyzFile:= Tstringlist.Create;

 for i:=1 to project_table_form.StringGrid1.RowCount-1 do
    begin
       if project_table_form.stringgrid1.Cells[2,i] = '1' then // checked Inc.
         begin
         // lista ModelNumber
                   xyzFile.Add(inttostr(i));
                 for b:=0 to ProjectArrayFunctions('RowCount',i-1) -1 do
                  begin
                       xyzFile.Add(Project[a-1,b,NrColX] //x
                         +','+ Project[a-1,b,NrColY]     // y
                         +','+ Project[a-1,b,NrColZ]  //z
                         +','+ Project[a-1,b,NrColAtomName] // atom name
                         +','+ inttostr(i-1));  // model number
                  end;

         end;
    end;

if xyzFile.Count > 1 then
 begin
  MainForm.Savedialog1.FilterIndex:=5;
 if MainForm.SaveDialog1.Execute then
   begin
     if MainForm.Savedialog1.FileName > '' then
      begin
       If Copy(MainForm.Savedialog1.FileName,Pos('.',MainForm.Savedialog1.FileName),Length(MainForm.Savedialog1.FileName)-Pos('.',MainForm.Savedialog1.FileName)+1) <> '.xyz' Then MainForm.Savedialog1.FileName := MainForm.Savedialog1.FileName + '.xyz';
          xyzFile.SaveToFile(UTF8Decode(MainForm.savedialog1.FileName));
      end;
   end;
 end else begin Console.AddCommunicate(com59,true); end;

xyzfile.Free;
end;

Procedure ProjectAsHTML(Sender:Tobject);
var
 html:Tstringlist;
 i,a,b:integer;
begin
  //MainForm.Savedialog1.FileName:= MainForm.Pagecontrol.ActivePage.Caption + '.html';
  MainForm.Savedialog1.filterindex:=7;
  if MainForm.SaveDialog1.Execute then
   begin
     if MainForm.Savedialog1.FileName > '' then
      begin
       html:=Tstringlist.Create;
       If Copy(MainForm.Savedialog1.FileName,Pos('.',MainForm.Savedialog1.FileName),Length(MainForm.Savedialog1.FileName)-Pos('.',MainForm.Savedialog1.FileName)+1) <> '.html' Then MainForm.Savedialog1.FileName := MainForm.Savedialog1.FileName + '.html';
       try

       html.Add('<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1250">');
       html.Add('<title>'+ExtractFileName(MainForm.Savedialog1.FileName)+'</title></head><body><center>');

       for i:=1 to project_table_form.StringGrid1.RowCount-1 do
          begin
            if project_table_form.StringGrid1.Cells[2,i] = '1' then  // zaznaczono wiec zacznij tworzyc nowa tabele
             begin
               html.Add('<table border="1">');
               for a:= 1 to  ProjectArrayFunctions('RowCount',i-1) -1 do
                begin
                 html.Add('<tr>');
                  for b:= 1 to  ProjectArrayFunctions('ColCount',i-1) -1 do
                    begin
                      html.Add('<td>'+Project[i-1,a,b]+'&nbsp;</td>');
                    end;
                  html.Add('</tr>');
                end;
                html.Add('</table>');
             end;
          end;
        html.Add('</body></html>');
        html.SaveToFile(UTF8Decode(MainForm.savedialog1.FileName));
       except
         Console.AddCommunicate(com7+'[HTML export]',true);
       end;
      end;
   end;
end;

Procedure NewProject(Sender:Tobject);
var
  file_1,temp1:Tstrings;
begin

xGrid:=1;
yGrid:=1;

projecttablexGrid:=1;
projecttableyGrid:=1;

MainForm.Savedialog1.Filter:=IndexFilter_1;
project_table_form.FormStyle:=fsNormal;

If  project_table_form.StringGrid1.RowCount -1 > 0 then
 begin
   CloseProject(); // close project comand
   NewProject(sender);
 end
  else
 begin
  if MainForm.savedialog1.Execute then
   begin
      project_table_form.StringGrid1.Visible:=false;

      file_1:=TstringList.Create;
      temp1:= TstringList.Create;
      file_1.Add('[file_name]'+ExtractFileName(MainForm.savedialog1.FileName));

      file_1.Add('[grid]');  // dodanie naglowka
      file_1.Add('empty');
      file_1.Add('[end]');


  If Copy(MainForm.Savedialog1.FileName,Pos('.',MainForm.Savedialog1.FileName),Length(MainForm.Savedialog1.FileName)-Pos('.',MainForm.Savedialog1.FileName)+1) <> copy(roz_project,1,length(roz_project)) Then MainForm.Savedialog1.FileName := MainForm.Savedialog1.FileName + roz_project;

  try
    DeleteFile(UTF8ToSyS(MainForm.savedialog1.FileName));
    file_1.SaveToFile(UTF8ToSyS(MainForm.savedialog1.FileName));
  except
    Console.AddCommunicate(com7,true);
  end;

  file_1.Free;
  temp1.Free;
  DeleteFile('grid.temp');
  MainForm.statusbar.SimpleText:= MainForm.savedialog1.FileName;
  project_table_form.StatusBar1.SimpleText:= MainForm.savedialog1.FileName;
  end;
 end;
end;

procedure SaveProjectAs(Sender:Tobject);
begin
  MainForm.Statusbar.SimpleText:= '';
  SaveProject(false);
end;

procedure SaveProject(ShowComunicate:boolean);
var
 dir,tempmemo:string;
 plik,temp:TstringList;
 i,x,y,nr,res:integer;
begin

project_table_form.FormStyle:=fsNormal;

if ShowComunicate = true then
 begin
  res:= MessageDlg (com26, com57, mtConfirmation,[mbYes, mbNo],0);

if res = mrYes then
 begin
 if MainForm.Statusbar.SimpleText = '' then
  begin
   MainForm.Savedialog1.FilterIndex:=7;
   mainform.SaveDialog1.Execute;
   MainForm.Statusbar.SimpleText:= MainForm.Savedialog1.FileName + roz_project;
  end;
 end;
end;

If (ShowComunicate = false) or (res = mrYes) then
 begin
  plik:=TstringList.Create;
  temp := TstringList.Create;

  plik.Add('[file_name]'+ExtractFileName(MainForm.Statusbar.SimpleText));
  tempmemo:='';
     for x:=0 to Form8.Memo2.Lines.Count-1 do
       begin
         tempmemo:= tempmemo + Form8.Memo2.lines[x]+';';
       end;
  plik.Add('[info]'+tempmemo);
  plik.Add('[dir]'+UTF8tosys(MainForm.Statusbar.SimpleText));

// zapis tabeli projektu
  plik.Add('[project_table]');
     GridToStream(Project_table_Form.StringGrid1,plik); // dodaje grida do aktulanego streama plik
  plik.Add('[end]');

  plik.Add('[LastConectNumber]' + IntToStr(LastConectNumber));
//------------------------------------------------------------------------------
   ClearSelection(-1);                  // clear selection
//------------------------------------------------------------------------------
// zapis gridów
dir:= MainForm.statusbar.SimpleText;

nr:=1;        // zmienna z aktualnym numerem grida
for x:=1 to Project_table_form.StringGrid1.RowCount -1 do
begin

    plik.Add('[grid]'+ Project_table_form.StringGrid1.Cells[NrColProj_Name,x] );  // dodanie naglowka
    try ArrayToStream(x-1,plik); // dodaje grida do aktulanego streama plik
     except
       Console.AddCommunicate(com4+' [save file]',true);
     end;
           plik.Add('[end]');

     inc(nr); //zwiekszenie numeru grida o jeden

end;

 // Zapis conectow
   plik.Add('[CONECT]');
     GridToStream(Form2.StringGrid,plik); // dodaje grida do aktulanego streama plik
  plik.Add('[end]');


   plik.Add('[results]');
   plik.AddStrings(Form8.memo1.Lines);
   plik.Add('[end]');

   plik.Add('[model_parameters]');
   plik.AddStrings(Form8.memo3.Lines);
   plik.Add('[end]');

  try
    plik.SaveToFile(UTF8tosys(MainForm.Statusbar.SimpleText));
  except
    Console.AddCommunicate(com7,true);
  end;
  plik.Free;
  temp.Free;
end;
end;

procedure CloseProject();
var
  x:integer;
begin
   SaveProject(true);  //  this command asks about saving

   project_table_form.StringGrid1.Visible:=false; // delete poject table
   project_table_form.StringGrid1.RowCount:=1;

   ScriptEditor.SynEdit1.ClearAll;   // delete script editr

   Form8.Memo2.Lines.Clear;
   project_table_form.StatusBar1.Caption:='';
   project_table_form.StatusBar1.SimpleText:='';
   MainForm.statusbar.Caption:='';
   MainForm.statusbar.SimpleText:='';

end;

procedure OpenProject(SenderToParametr:boolean;auto:string);
var
 plik,zawartosc,prom,temp:TStringList;             // auto bo otwieranie przez parameter w unit14!
 dir,nazwa,tempmemo: string;
 i,x,y,w,grid_number:integer;
 state:boolean;
begin

project_table_form.FormStyle:=fsNormal;

MainForm.Opendialog1.Filter:= IndexFilter_1;

state := false;

if SenderToParametr = True then
 begin
    MainForm.Opendialog1.FileName:= auto;
    state:=true;
    auto:='';
  end;

if SenderToParametr = False then
  begin
     If (MainForm.Opendialog1.Execute) then
      begin
        if MainForm.Opendialog1.FileName > ''  then begin state:=true; end;
      end;
   end;


if (state = true) and (MainForm.Opendialog1.FileName > '') then
begin

 grid_number:=1;

   Screen.Cursor := crHourglass;
   MainForm.Opendialog1.FilterIndex:=0; // ustawienie na filter rozszerzenia projektu

   if Project_table_form.StringGrid1.RowCount > 1 then  // jesli cos otwartego to zapisz
    begin
      CloseProject();  // menu - close project
    end;

     try
       begin
        plik:= TStringList.Create;
        plik.LoadFromFile(UTF8tosys(MainForm.Opendialog1.FileName));
       end;
     except
       Console.AddCommunicate(com12+' '+Com1+' [OpenDialog 1]',true);
     end;

     // przeszukiwanie pliku pod kontem znaczników

 zawartosc:= TStringList.Create;   // tworzenie strima dla zawartosci tabel
 temp:=TstringList.Create;         // tymczasowa lista dla tabel

  for  x:=1 to plik.Count -1 do
      begin

        MainForm.statusbar.SimpleText:= MainForm.Opendialog1.FileName;
        project_table_form.StatusBar1.SimpleText:= MainForm.Opendialog1.FileName;

         if copy(plik[x],1,5)='[info' then
           begin
             Form8.Memo2.Lines.Clear;
             tempmemo:= Copy(plik[x],7,length(plik[x]));
             tempmemo:=StringReplace(tempmemo, ';',#13#10,[rfReplaceAll, rfIgnoreCase]);
             Form8.Memo2.Lines.Add(tempmemo);
           end;

         if copy(plik[x],1,14)='[project_table' then    // project table
            begin
             temp.Clear;
              for y:=x+1 to plik.Count -1 do
               begin
                  if (Copy(plik[y],1,1)='[') then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                     temp.add(plik[y]);
                   end;
               end;
                GridFromStream(Project_Table_Form.StringGrid1,temp);

                // Dodaj ilosc projektów

                SetLength(Project, Project_Table_Form.StringGrid1.RowCount-1);

                project_table_form.StringGrid1.Visible:=True;
            end;

      {   if (copy(plik[x],1,17)='[LastConectNumber')  then
           begin
             LastConectNumber:= StrToIntDef(copy(plik[x],17,Length(plik[x])),-1);
           end;
       }
       if (copy(plik[x],1,5)='[grid') and (copy(plik[x+1],1,5)<>'empty')  then
           begin
             zawartosc.Clear;
             nazwa:= Copy(plik[x],7,length(plik[x])); // pobranie nazwy grida
             for y:=x+1 to plik.Count-1 do
               begin
                 if (Copy(plik[y],1,4)='[end') then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                     zawartosc.add(plik[y]);
                   end;
               end;

              // dodatkowo do Project array
              NewProjectGridFromStream(grid_number-1,zawartosc);

              zawartosc.Clear;

              inc(grid_number);

           end;

   { // opcje wygladu grida

    if (Copy(plik[x],1,7)='[colour') then
                   begin
                     TStringGrid(activeGrid).Color:= StringToColor(copy(plik[x],Pos(']',plik[x])+1,length(plik[x])));
                   end;

                 if (Copy(plik[x],1,16)='[alternate_color') then
                   begin
                     TStringGrid(activeGrid).AlternateColor:= StringToColor(copy(plik[x],Pos(']',plik[x])+1,length(plik[x])));
                   end;

                 if (Copy(plik[x],1,5)='[font') then
                   begin
                     StringToFont(copy(plik[x],Pos(']',plik[x])+1,length(plik[x])),TStringGrid(activeGrid).font);
                   end;
    }

     if copy(plik[x],1,7)='[CONECT' then
          begin
           zawartosc.Clear;
             for y:=x+1 to plik.Count-1 do
               begin
                 if (Copy(plik[y],1,4)='[end') then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                     zawartosc.add(plik[y]);
                   end;
               end;

           BondsFromStream(zawartosc); // load bonds to array

           GridFromStream(Form2.StringGrid,zawartosc);

           zawartosc.Clear;
          end;

     if copy(plik[x],1,8)='[results' then
          begin
            for y:=x+1 to plik.Count-1 do
             begin
               if Copy(plik[y],1,4)='[end' then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                      Form8.memo1.Lines.add(plik[y]);
                   end;
             end;
          end;
      if copy(plik[x],1,17)='[model_parameters' then
          begin
            for y:=x+1 to plik.Count-1 do
             begin
               if Copy(plik[y],1,4)='[end' then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                      Form8.memo3.Lines.add(plik[y]);
                   end;
             end;
          end;

      {  if copy(plik[x],1,10)='[CONTAINER' then
          begin
           zawartosc.Clear;
             for y:=x+1 to plik.Count-1 do
               begin
                 if (Copy(plik[y],1,4)='[end') then
                   begin
                     break;                          //przepisanie na zawartosc
                   end
                     else
                   begin
                     zawartosc.add(plik[y]);
                   end;
               end;
           GridFromStream(Container.StringGrid1,zawartosc);
           zawartosc.Clear;
          end;   }

      end;
     zawartosc.Free;
     temp.free;

  Screen.Cursor := crDefault;

state:=false;
end;

project_table_form.FormStyle:=fsStayOnTop;
end;

procedure GridTranspozeColumnsToRows();
var
 rowcol:Tstringlist;
begin
 rowcol:=Tstringlist.Create;

    if  (xGrid<>0) and (yGrid<>0) then
      begin
        rowcol.AddStrings(Tstringgrid(activeGrid).Cols[xGrid]);
        Tstringgrid(activeGrid).DeleteColRow(true,xGrid);
        Tstringgrid(activeGrid).RowCount:= Tstringgrid(activeGrid).RowCount+1;
        Tstringgrid(activeGrid).MoveColRow(false,Tstringgrid(activeGrid).RowCount-1,1);
        Tstringgrid(activeGrid).Rows[1].AddStrings(rowcol);
      end;
 rowcol.Free;
end;

procedure GridTranspozeRowsToColumns();
var
 rowcol:Tstringlist;
begin
 rowcol:=Tstringlist.Create;

    if  (xGrid<>0) and (yGrid<>0) then
      begin
        rowcol.AddStrings(Tstringgrid(activeGrid).Rows[yGrid]);
        Tstringgrid(activeGrid).DeleteColRow(false,yGrid);
        Tstringgrid(activeGrid).ColCount:= Tstringgrid(activeGrid).ColCount+1;
        Tstringgrid(activeGrid).MoveColRow(true,Tstringgrid(activeGrid).ColCount-1,1);
        Tstringgrid(activeGrid).Cols[1].AddStrings(rowcol);
      end;
 rowcol.Free;
end;

procedure GridGetSelection(Sender:Tobject);
var
 selection:string;
begin
{    try
    begin
    // Tstringgrid(activeGrid).Cells[selectionAfterEqualityMarkX,selectionAfterEqualityMarky]
    selection := 'Tab_'+inttostr(MainForm.pagecontrol.ActivePageIndex)
                        +'('+inttostr(Tstringgrid(activeGrid).Selection.Left)+','
                        +inttostr(Tstringgrid(activeGrid).Selection.Top)+','
                        +inttostr(Tstringgrid(activeGrid).Selection.Right)+','
                        +inttostr(Tstringgrid(activeGrid).Selection.Bottom)+')';
    // do showka
    if Sender.ClassNameIs('TSpeedButton')then
     begin
      ClipBoard.AsText := selection;
     end;
    //do tabeli
      project_table_form.StringGrid1.Cells[8,Mainform.PageControl.ActivePage.PageIndex]:= selection;
    end
    except

    end;}
end;

procedure SelectAllGrid();
var
  myRect: TGridRect;
begin
  myRect.Left := 0;
  myRect.Top := 0;
  myRect.Right := TstringGrid(activegrid).Colcount-1;
  myRect.Bottom := TstringGrid(activegrid).rowcount-1;
  TstringGrid(activegrid).Selection := myRect;
end;

procedure CutGridToClipboard();
begin
  CopyGridToClipboard();
  Tstringgrid(activeGrid).Clean(Tstringgrid(activeGrid).Selection,[gzNormal]);
end;

procedure CopyGridToClipboard();

var S: string;
    GRect: TGridRect;
    C, R: Integer;

begin
GRect := TStringGrid(activegrid).Selection;
S := '';
  for R := GRect.Top to GRect.Bottom do begin
  for C := GRect.Left to GRect.Right do begin
     if C = GRect.Right then     S := S + TStringGrid(activegrid).Cells[C,R]
     else S := S + TStringGrid(activegrid).Cells[C, R] + #9; end;
      S := S + #13#10; end;
  ClipBoard.AsText := S;
end;

procedure TrimGrid();
var
 i,y:integer;
begin
   if MessageDlg(com32,com48, mtConfirmation,[mbYes, mbNo],0) = mrYes then
    begin
       for i:=1 to TstringGrid(activeGrid).ColCount-1 do
        begin
          for y:=1 to TstringGrid(activeGrid).RowCount-1 do
            begin
              TstringGrid(activeGrid).Cells[i,y]:= trim(TstringGrid(activeGrid).Cells[i,y]);
            end;
        end;
    end
end;

procedure PasteGridFromClipboard();

var Grect: TGridRect; S, CS, F: string; L, R, C: Byte;

begin
  GRect := Tstringgrid(activeGrid).Selection;
  L := GRect.Left;
  R := GRect.Top;
  S := ClipBoard.AsText;
  R := R - 1;

while Pos(#13, S) > 0 do begin
  R := R + 1;
  C := L - 1;
  CS := Copy(S, 1,Pos(#13, S));

while Pos(#9, CS) > 0 do begin C := C + 1;

  if (C <= Tstringgrid(activeGrid).ColCount - 1) and (R <= Tstringgrid(activeGrid).RowCount - 1) then
       Tstringgrid(activeGrid).Cells[C, R] := Copy(CS, 1,Pos(#9, CS) - 1);
       F := Copy(CS, 1,Pos(#9, CS) - 1);
       Delete(CS, 1,Pos(#9, CS)); end;
if (C <= Tstringgrid(activeGrid).ColCount - 1) and (R  <= Tstringgrid(activeGrid).RowCount - 1) then
       Tstringgrid(activeGrid).Cells[C + 1,R] := Copy(CS, 1,Pos(#13, CS) - 1);
       Delete(S, 1,Pos(#13, S));

if Copy(S, 1,1) = #10 then     Delete(S, 1,1);
end;
end;

procedure WykresNowaSeria(Chart:Tchart;x,y:TStrings);
var
 i:integer;
 seria:TLineSeries;
begin
  begin
    seria:= TlineSeries.Create(chart);
    Chart.AddSeries(seria);
    seria.SeriesColor:= 7* random(225);
      for i:=1 to Chart.Series.Count-1 do
        begin
         { if Chart.Series.Items[i].SeriesColor = seria.SeriesColor then
            begin
               seria.SeriesColor:= 17*random(225);
            end; }
        end;
   for i:=0 to x.Count-1 do
    if (StrToFloatDef(x[i],0)<>0) and (StrToFloatDef(y[i],0)<>0) then
     begin
       seria.AddXY(StrToFloat(x[i]),StrToFloat(y[i]));
     end;
  end;
  seria.ShowLines:=true;
end;

procedure ponumeruj_kolumny(Sender: TObject);
var
 x,y:integer;
begin
if sender.ClassNameIs('Tstringgrid')=True then
 begin
  for x:=1 to Tstringgrid(sender).ColCount-1 do
    begin
     if czy_liczba(Tstringgrid(sender).Cells[x,0]) then  // nie zamieniaj oznaczeń tekstowych
       begin
          Tstringgrid(sender).Cells[x,0]:=inttostr(x);
       end;
    end;

  for y:=1 to Tstringgrid(sender).RowCount-1 do
    begin
    if czy_liczba(Tstringgrid(sender).Cells[0,y]) then  // nie zamieniaj oznaczeń tekstowych
       begin
          Tstringgrid(sender).Cells[0,y]:=inttostr(y);
       end;
    end;
 end;
end;

function wariancja(kol:Tstrings):string;
var
 x,a:integer;
 war,sr,sum:Currency;
begin
 a:=0;
 sum:=0;
if czy_liczba(ArithmeticAverage(kol)) then
 begin
   sr:=StrToCurr(ArithmeticAverage(kol));

 for x:=0 to kol.count-1 do
    begin
     if czy_liczba(kol[x]) then
       begin
         war:=0;
         war:=strtocurrdef(kol[x],0)-sr;
         war:=war*war;
         sum:=sum + war;
         a:=a+1;
       end;
    end;

   a:=a-1; // -1 ze wzoru

if a > -1 then
   begin
     Result:=currtostr(sum/a);
   end
    else
   begin
     Result:= com80;  // wariancja zawsze jest dodatnia jak ujemna to bląd
   end;
end else begin Result:= com80 ; end;
end;

function odchylenie_standardowe(kol:Tstrings):string; // verif ok
var
  i:integer;
  suma_kwadratow_roznic,srednia_ar,odst:currency;
begin
 begin
  srednia_ar:= StrToCurr(ArithmeticAverage(kol));

  suma_kwadratow_roznic:=0;

  for i:=0 to kol.Count-1 do
   begin
     suma_kwadratow_roznic := suma_kwadratow_roznic + Power(StrToCurr(kol[i]) - srednia_ar,2); // do kwadrstu
   end;

    odst:= suma_kwadratow_roznic / kol.Count;  // dzielenie przez N elementow
    odst:= Sqrt(odst);  // pierwiastek
 end;

if czy_liczba(CurrToStr(odst)) then
begin
  Result:=currtostr(odst);           // take care about message !
end else begin Result:= com80 ; end;
end;

function wspolczynnik_zmiennosci(kol:Tstrings):string;
var
 odst,sred:Currency;
begin
if czy_liczba(odchylenie_standardowe(kol))
   and czy_liczba(ArithmeticAverage(kol)) then
  begin
     odst:=strtocurr(odchylenie_standardowe(kol));
     if odst > -1 then
      begin
        sred:=strtocurr(ArithmeticAverage(kol));
        Result:=currtostr(odst/sred);
      end
        else
     begin
       Result:=com80;
     end;
  end;
end;

procedure QuickSort(var A: array of Currency; iLo, iHi: Integer) ;

var
 Lo,Hi: Integer;
 Pivot,T:Currency;
begin
if high(A)>0 then
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := A[(Lo + Hi) div 2];
 repeat
    while A[Lo] < Pivot do Inc(Lo) ;
    while A[Hi] > Pivot do Dec(Hi) ;
     if Lo <= Hi then
      begin
          T := A[Lo];
          A[Lo] := A[Hi];
          A[Hi] := T;
          Inc(Lo) ;
          Dec(Hi) ;
      end;
until Lo > Hi;
if Hi > iLo then QuickSort(A, iLo, Hi) ;
if Lo < iHi then QuickSort(A, Lo, iHi) ;
end;
end;

function moda(kol:Tstrings):string;
var
 i,x,powtt,index,temp:integer;
begin
index:=-1;
powtt:=-1;
for i:=0 to kol.Count-1 do   // przelec kazda wartosc
   begin
     temp:=0;
     for x:=0 to kol.Count-1 do // sprawdz ile razy wsytepuje w zbiorze
      begin
        if kol[i] = kol[x] then
          begin
            inc(temp)
          end;
      end;
     if powtt < temp then  // jesli aktulna liczba powrtorzen jest wiekasza pobierz index i wartosc
      begin
        powtt:=temp;
        index:= i;
      end;
   end;
  Result:= kol[index] +' ('+inttostr(powtt)+')';
end;

function mediana(kol:Tstrings):string;
var
 x,ind:integer;
 s:Currency;
begin
 s:=0;
 ind:=0;
 for x:=0 to kol.count-1 do
    begin
      if (strtocurrdef(kol[x],-1)>-1) or (strtocurrdef(kol[x],1)<1) then
        begin
          ind:=ind +1;
        end;
    end;
    if (ind > 0) and (ind mod 2 <> 0) then
      begin
        ind:= ind div 2 ;  // nie pazysta ilosc elementów
        Result:= kol[ind+1];
      end
        else
      begin
        if ind > 0 then
          begin
            ind:= ind div 2 ;    //  pażysta ilosc elementów
            s:=strtocurr(kol[ind]);
            s:= s + strtoCurr(kol[ind+1]);
            s:= s/2;
            Result:= currtostr(s);
          end
            else
          begin Result:= com80; end;
      end;
end;

function suma(kol:Tstrings):Currency;
var
 x:integer;
 s:Currency;
begin
 s:=0;
for x:=0 to kol.count-1 do
      begin
        s:=s+strtocurrdef(kol[x],0);
      end;
     Result:=s;
end;

function ArithmeticAverage(kol:Tstrings):string;
var
 x,a:integer;
 s:Currency;
begin
 s:=0;
 a:=0;
for x:=0 to kol.count-1 do
    begin
     if (strtocurrdef(kol[x],-1) <> -1) and (strtocurrdef(kol[x],1) <> 1)then
       begin
         s:=s+ strtocurr(kol[x]);
         a:=a+1;
       end;
    end;

     s:=s/a;

     Result:=CurrToStr(s);
end;

function kurtoza2(kol:Tstrings):string;
var
 wynik,moment,odchylenie:Currency;
begin
if (czy_liczba(odchylenie_standardowe(kol)))
  and (czy_liczba(moment4rzedu(kol))) then
   begin
      odchylenie:= StrToCurr(odchylenie_standardowe(kol));
      odchylenie:= Power(odchylenie,4);
      moment:= StrToCurr(moment4rzedu(kol));
      wynik:= moment / odchylenie;
      Result:=CurrToStr(wynik);
   end else begin Result:=com80; end;
end;

function moment4rzedu(kol:Tstrings):string;
var
 x,a:integer;
 s,srednia,wynik:Currency;
begin
 s:=1;
 a:=0;
if czy_liczba(ArithmeticAverage(kol)) then
 begin
 srednia:=Strtocurr(ArithmeticAverage(kol));
 wynik:=0;
for x:=0 to kol.count-1 do
    begin
     if (strtocurrdef(kol[x],-1)<>-1) or (strtocurrdef(kol[x],1)<>1)then
       begin
         s:= strtocurr(kol[x]);
         s:= s - srednia;
         s:= Power(s,4);
         wynik:= wynik + s;
         a:=a+1;
       end;
    end;
if (wynik <> 0) and (a<>0) then
   begin
     s:=wynik/a;
     Result:=currtostr(s);
   end
    else
   begin
     Result:=com80;
   end;
 end else begin Result:=com80; end;
end;

function kurtoza(kol:Tstrings):string;
var
 srednia,odchylenie,wynik,sume,a,b,c,d,n:Currency;
 x:integer;
begin
if (czy_liczba(odchylenie_standardowe(kol)))
  and (czy_liczba(ArithmeticAverage(kol)))then
   begin

odchylenie:=strtocurr(odchylenie_standardowe(kol));
srednia:=strtocurr(ArithmeticAverage(kol));
n:=0;
sume:=0;
for x:=0 to kol.Count-1 do
    begin
      if (strtocurrdef(kol[x],-1)>-1) or (strtocurrdef(kol[x],1)<1) then
        begin
          n:=n+1;
          wynik:= strtocurr(kol[x]) - srednia;
	  wynik:= wynik / odchylenie ;
	  wynik:= Power(wynik,4);
           sume:= sume + wynik;
        end;
     end;
     wynik:= sume;
if n > 3 then
     begin
      a:=n+1;
      a:=a*n;
        b:=n-1;
        b:=b*(n-2);
        b:=b*(n-3);
      c:=n-1;
      c:=Power(c,2);
      c:=c*3;
        d:=(n-2);
        d:=d*(n-3);
     a:= a/b;
     c:= c/d;
     wynik:=wynik*a;
     wynik:=(wynik-c);
     Result:=currtostr(wynik);
     end
      else begin Result:= com80; end;
end else begin Result:= com80; end;
end;

function wspolczynnik_skosnosci(kol:Tstrings):string;
var
 wynik:Currency;
begin
if czy_liczba(ArithmeticAverage(kol))
  and czy_liczba(mediana(kol))
  and czy_liczba(odchylenie_standardowe(kol))
    then
     begin
       wynik:= StrToCurr(ArithmeticAverage(kol));
       wynik:= wynik - StrToCurr(mediana(kol));
       wynik:= wynik / StrToCurr(odchylenie_standardowe(kol));
       wynik:= 3 * wynik;
       Result:=currtostr(wynik);
     end else begin Result:=com80; end;
end;

function srednia_geometryczna(kol:Tstrings):string;
var
 x,a:integer;
 s:Currency;
begin
 s:=1;
 a:=0;
  for x:=0 to kol.Count-1 do
    begin
     if czy_liczba(kol[x])then
       begin
         s:=s * strtocurr(kol[x]);
         a:=a+1;
       end;
    end;

  if (s >= 0) and (a > 0) then
   begin
     s:= power(s,1/a);
     Result:=CurrToStr(s);
   end
    else
   begin
     Result:=com80;
   end;
end;

Function rozstep(kol:Tstrings):Currency ;
begin
 Result:= MinMax(kol,True)- MinMax(kol,False);
end;

Function MinMaxToListIndex(kolumna:Tstrings;isMax:Boolean=True):integer; // zwraca numer indexu w Stringlist
Var
  i,Res:integer;
  MinMaxValue:currency;
begin
Res:=-1;

  MinMaxValue:= MinMax(kolumna,isMax);

   for i:=0 to kolumna.Count-1 do
    begin
      if MinMaxValue = StrToCurr(kolumna[i]) then
       begin
         Res:= i;
       end;
    end;

 Result:= Res;

end;

Function MinMax(kolumna:Tstrings;isMax:Boolean=True):Currency ;
var
  kol:TstringList;
  x,s:integer;
  cur: array of currency;
begin
  kol:= TstringList.Create;
  kol.AddStrings(kolumna);

s:=-1;
SetLength(cur,kol.Count);
 for x:=0 to kol.Count-1 do
    begin
      if (strtocurrdef(kol[x],-1)>-1) or (strtocurrdef(kol[x],1)<1) and (trim(kol[x])<>'') then
        begin
          s:=s+1;
          cur[s]:=strtocurr(kol[x]);
        end
    end;
SetLength(cur,s+1);
//sortowanie begin
   QuickSort(cur,low(cur),high(cur));
//sortowanie end
if high(cur) > 0  then
  begin
   if isMax = True then
     begin
       Result:= cur[high(cur)];
     end
      else
     begin
       Result:= cur[low(cur)];
     end;
end
 else
  begin Result:=0; end;
 kol.Free;
 SetLength(cur,0);
end;

Function  czy_liczba(liczba:string):Boolean;
begin
if (strtoFloatDef(liczba,-1) = -1) and (strtoFloatDef(liczba,1) = 1) then
 begin
   Result:= False;
 end else begin Result:= True end;
end;

Procedure get_col(TylkoLiczby:integer;NumerKolumny:integer;lista:TStringList;grid:TstringGrid);
Var
 nowaLista:Tstringlist;
 i:integer;
begin
 // 1 - tylko liczby
 // 2 - tylko tekst
 // 3 - wszytsko bez naglowka

 nowaLista:= Tstringlist.create;

for i:=1 to TstringGrid(grid).RowCount-1 do // pomijaj pierwszy wiersz bo to naglowek kolumny
begin
  if TylkoLiczby = 1 then // tylko liczby
    begin
       if (czy_liczba(trim(TstringGrid(grid).Cells[NumerKolumny,i]))) and (trim(TstringGrid(grid).Cells[NumerKolumny,i]) > '') then
        begin
          NowaLista.Add(trim(TstringGrid(grid).Cells[NumerKolumny,i]));
        end;
    end;

  if TylkoLiczby = 2 then   // tylko tekst
    begin
       if (czy_liczba(trim(TstringGrid(grid).Cells[NumerKolumny,i])) = false) and (trim(TstringGrid(grid).Cells[NumerKolumny,i]) > '') then
        begin
          NowaLista.Add(trim(TstringGrid(grid).Cells[NumerKolumny,i]));
        end;
    end;

  if TylkoLiczby = 3 then // wszytsko bez pustych
    begin
       if (trim(TstringGrid(grid).Cells[NumerKolumny,i]) > '') then
        begin
          NowaLista.Add(trim(TstringGrid(grid).Cells[NumerKolumny,i]));
        end;
    end;

  lista.Clear;
  lista.AddStrings(NowaLista);

  nowalista.Free;
end;
end;

// Begin--> Procedury sprawdzające
procedure tylko_liczby(Sender: TObject; Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-',';', DecimalSeparator]) then
  begin
    Console.AddCommunicate('Invalid key: ' + Key +',only numbers and symbols "-", ";" are allowed',true);
    Key:= #0;
   // StringReplace(TLabeledEdit(Sender).Text,Key,'',[rfReplaceAll, rfIgnoreCase]);
  end
 { else if ((Key = DecimalSeparator) or (Key = '-')) and
          (Pos(Key, (Sender as TEdit).Text) > 0) then begin
    Console.AddCommunicate('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then begin
    Console.AddCommunicate('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;  }
end;

// Drukowanie stringgrida
procedure PrintGrid(sGrid: TStringGrid; sTitle: string);
begin

end;

// Stringgrid as CSV
procedure Grid_as_CSV(grid: TstringGrid; separator: string);
var
  SD : TSaveDialog;
  I,b: Integer;
  CSV : TStrings;
  FileName : String;
begin
  Try
  SD := TSaveDialog.Create(MainForm);
  //SD.FileName:= MainForm.Pagecontrol.ActivePage.Caption + '.csv';
  SD.Filter := 'CSV (*.csv)|*.CSV';
  If SD.Execute = True Then
  Begin
    FileName := SD.FileName;
    If Copy(FileName,Pos('.',FileName),Length(FileName)-Pos('.',FileName)+1) <> '.csv' Then FileName := FileName + '.csv';
    Screen.Cursor := crHourGlass;
    CSV := TStringList.Create;
    Try
      begin
        if MessageDlg(com22,com39, mtConfirmation, mbYesNo, 0) = mrYes then
         begin
           b:=0;
         end else begin b:=1; end;

         For I:=b To Grid.RowCount - 1 Do
          begin                          // zamien na inny seperator
            CSV.Add(StringReplace(Grid.Rows[I].CommaText, ',', separator,[rfReplaceAll, rfIgnoreCase]));
          end;
         CSV.SaveToFile(UTF8decode(FileName));
      end;
    Finally
      CSV.Free;
    End;
  End;

  Finally
    SD.Free;
    Screen.Cursor := crDefault;
  End;
end;

// Funkcje językowe
procedure LoadTranslation(language:string);

begin

end;

// show_model
Procedure Show_Model(cm_prog:string;temp:boolean);
var
  AProcess: TProcess;
  modele:TstringList;
  file_directory:string;
  i:integer;
begin
  file_directory:= 'C:\visio.pdb';

  //UTF8decode(GetEnvironmentVariable('TEMP')+'\visio.pdb'); // << directory with file to load in external program

  modele := Tstringlist.Create;

if project_table_form.StringGrid1.RowCount > 1 then
   begin
    for i:=1 to project_table_form.StringGrid1.RowCount-1 do
      begin
        if (project_table_form.StringGrid1.Cells[2,i] = '1') // Included to 2
          then
        begin
           modele.Add(inttostr(i));
        end;
      end;
   end;

  //Save_as_PDB(modele,UTF8ToSys(ExtractFilePath(Application.ExeName))+'modules\raswin\visio.pdb',false);

  Save_as_PDB(modele,file_directory,temp);

  modele.Free;

  AProcess := TProcess.Create(nil);

  //AProcess.CommandLine :='modules\raswin\RW32B2A.EXE'   //UTF8ToSys(ExtractFilePath(Application.ExeName))+'\
  //                     +' modules\raswin\visio.pdb';

  AProcess.CommandLine := UTF8ToSys(cm_prog)+' '+file_directory;

  AProcess.Options := AProcess.Options ;

  AProcess.Execute;

  AProcess.Free;
end;

procedure ZaznaczenieNaListe(zaznaczenie:string;lista:Tstrings);  // poprawic nie po nazwie tylko po indexie taba
Var
 a,b,c,x1,x2,y1,y2:integer;
 temp:string;

begin
 {if (Pos('(',zaznaczenie)>0) and (Pos(')',zaznaczenie) > 0) then
  begin
   temp:= Copy(zaznaczenie,Pos('(',zaznaczenie)+1,Pos(')',zaznaczenie)-1);
     x1:= strtointDef(Copy(temp,0,Pos(',',temp)-1),-1);
   temp:= copy(temp,Pos(',',temp)+1,length(temp));
     y1:= strtointDef(Copy(temp,0,Pos(',',temp)-1),-1);
   temp:= copy(temp,Pos(',',temp)+1,length(temp));
     x2:= strtointDef(Copy(temp,0,Pos(',',temp)-1),-1);
   temp:= copy(temp,Pos(',',temp)+1,length(temp));
     y2:= strtointDef(Copy(temp,0,Pos(')',temp)-1),-1);

if (x1 = -1) or (x2 = -1) or (y1 = -1) or (y2 = -1) then
 begin
   Console.AddCommunicate(com16+'[2]');
 end
  else
   begin
      lista.Clear; // pusta lista
      b:= Pos('(',zaznaczenie) - Pos('_',zaznaczenie) - 1;
      b:= StrToint(Copy(zaznaczenie,Pos('_',zaznaczenie)+1,b));

      if mainform.PageControl.PageCount-1 < b then
       begin
         Console.AddCommunicate(com16+'[3]');
       end else begin   // zacznij przepisywnaie
       for a:= x1 to x2 do
         begin
          for c:= y1 to y2 do
            begin
              lista.Add(TStringGrid(MainForm.pagecontrol.Page[b].Controls[0]).Cells[a,c]);
            end;
         end;
       end;
    end;
  end else begin Console.AddCommunicate(com16+'[1]'); end; }
end;

// Output format: "Aril", 9, [Bold|Italic], [clAqua]
function FontToString(Font : TFont ) : string;
const
  csfsBold      = '|Bold';
  csfsItalic    = '|Italic';
  csfsUnderline = '|Underline';
  csfsStrikeout = '|Strikeout';
var
  sStyle : string;
begin
  with Font do
  begin
    // convert font style to string
    sStyle := '';

    if( fsBold in Style )then
      sStyle := sStyle + csfsBold;

    if( fsItalic in Style )then
      sStyle := sStyle + csfsItalic;

    if( fsUnderline in Style )then
      sStyle := sStyle + csfsUnderline;

    if( fsStrikeout in Style )then
      sStyle := sStyle + csfsStrikeout;

    if( ( Length( sStyle ) > 0 ) and
        ( '|' = sStyle[ 1 ] ) )then
    begin
      sStyle :=
        Copy( sStyle, 2,
          Length( sStyle ) - 1 );
    end;

    Result := Format(
      '"%s", %d, [%s], [%s]',
      [ Name,
        Size,
        sStyle,
        ColorToString( Color ) ] );
  end;
end;

// Expected format: "Arial", 9, [Bold], [clRed]
procedure StringToFont(sFont : string; Font : TFont );
const
  csfsBold      = '|Bold';
  csfsItalic    = '|Italic';
  csfsUnderline = '|Underline';
  csfsStrikeout = '|Strikeout';

var
  p      : integer;
  sStyle : string;
begin
  with Font do
  begin
    // get font name
    p    := Pos( ',', sFont );
    Name :=
      Copy( sFont, 2, p-3 );
    Delete( sFont, 1, p );

    // get font size
    p    := Pos( ',', sFont );
    Size :=
      StrToInt( Copy( sFont, 2, p-2 ) );
    Delete( sFont, 1, p );

    // get font style
    p      := Pos( ',', sFont );
    sStyle :=
      '|' + Copy( sFont, 3, p-4 );
    Delete( sFont, 1, p );

    // get font color
    Color :=
      StringToColor(
        Copy( sFont, 3,
          Length( sFont ) - 3 ) );

    // convert str font style to
    // font style
    Style := [];

    if( Pos( csfsBold,
          sStyle ) > 0 )then
      Style := Style + [ fsBold ];

    if( Pos( csfsItalic,
          sStyle ) > 0 )then
      Style := Style + [ fsItalic ];

    if( Pos( csfsUnderline,
          sStyle ) > 0 )then
      Style := Style + [ fsUnderline ];

    if( Pos( csfsStrikeout,
          sStyle ) > 0 )then
      Style := Style + [ fsStrikeout ];
  end;
end;

 // tylko liczby w kolumnie
Procedure ListaNaTylkoLiczby(lista:TStringList);
var
  nowaLista:TstringList;
  i:integer;
begin

nowaLista:= Tstringlist.Create;

for i:=0 to lista.Count-1 do
 begin
 if (czy_liczba(trim(Lista[i]))) and (trim(lista[i]) > '') then
   begin
     NowaLista.Add(trim(lista[i]));
   end;
 end;

lista.Clear;
lista.AddStrings(NowaLista);

NowaLista.Free;
end;

// lista plików z rozszezeniem
procedure FileListFromDirectory(dir:string;extention:string;lista:TstringList);
var
  SearchResult : TSearchRec;
begin
if FindFirst(dir+extention, faAnyFile, SearchResult)  = 0 then
  begin
    repeat
      lista.Add(SearchResult.Name);
    until FindNext(SearchResult) <> 0;
      FindClose(searchResult);
    end;
end;

// rozdzielna ciag znaków
procedure ExplodeString(delimiter:string;t:string;Lista:Tstrings); // naprawiona - OK
var
  b:integer;
  current:string;
begin
Lista.Clear;
if Pos(delimiter,t) > 0 then
 begin

  current:='';

  // t:= trim(t); // usun spacje

  if t[length(t)] <> delimiter then
   begin
     t:=t+delimiter;
   end;

  repeat
     current:= Copy(t,0,Pos(delimiter,t)-1);  // pobierz od zera do bierzacego wystapenia
     t:= Copy(t,Length(current)+2,Length(t)); // funkcja explode
     Lista.Add(current);
  until Pos(delimiter,t) = 0;

  if length(t) > 0 then
   begin
      Lista.Add(t);
   end;
end
else begin Lista.Add(t); end;
end;

function  TabNameToIndex(pg:Tpagecontrol;nazwa:string):integer;
var
  i,pom:integer;
begin
{  for i:=0 to Tpagecontrol(pg).PageCount -1 do
   begin
     if trim(Tpagecontrol(pg).Page[i].Caption) = trim(nazwa) then
      begin
        pom:=0;
        Result:= Tpagecontrol(pg).Page[i].PageIndex;
        break;
      end else begin pom:=-1 end;
   end;
if pom = -1 then begin Result := -1; end;}
end;

procedure ChangeGridFont(Grid:TStringGrid);
begin
// opcje czcionki
  if Mainform.fontdialog1.Execute then
   begin
     Grid.Font := MainForm.Fontdialog1.Font;
   end;
end;

procedure ChangeGridColor(Grid:TStringGrid;i:integer);
 begin
  if i = 1 then
   begin
    Mainform.colordialog1.Color :=  Grid.AlternateColor;                   // rowsy
     if Mainform.colordialog1.Execute then
   begin
      Grid.AlternateColor:= Mainform.colordialog1.Color;
   end;
   end;
   if i = 2 then
    begin
     Mainform.colordialog1.Color :=  Grid.Color;                      // color
      if Mainform.colordialog1.Execute then
   begin
      Grid.Color:= Mainform.colordialog1.Color;
   end;
    end;
 end;



Function AddNewGrid(vis,inc,name,types,original_filename:string):integer;
var
 dir:string;
 number:integer;
begin
 {
dir:=MainForm.StatusBar.SimpleText;

try number:= nowy_Grid(name,True); // ustawia nowego grida jako default
  except
    Console.AddCommunicate(com13);
    exit;
  end;

// add entry to project table
  project_table_form.StringGrid1.RowCount:=project_table_form.StringGrid1.RowCount+1;
// NO.
   project_table_form.StringGrid1.Cells[0,project_table_form.StringGrid1.RowCount-1]:= inttostr(number);
// vis / inc
   project_table_form.StringGrid1.Cells[1,project_table_form.StringGrid1.RowCount-1]:= vis;
   project_table_form.StringGrid1.Cells[2,project_table_form.StringGrid1.RowCount-1]:= inc;
// Model name
   project_table_form.StringGrid1.Cells[3,project_table_form.StringGrid1.RowCount-1]:= name;
// TYPE
   project_table_form.StringGrid1.Cells[4,project_table_form.StringGrid1.RowCount-1]:= types;
// orginal file name
   project_table_form.StringGrid1.Cells[5,project_table_form.StringGrid1.RowCount-1]:= original_filename;

 MainForm.PageControl.ActivePageIndex:=number;

 // Project Array - add new table

  //ProjectArrayFunctions('AddTable',-1,0);

 //->

 Mainform.Panel2.Visible:=true;
 project_table_form.StringGrid1.Visible:=true;

 Result:=number;  }
end;

procedure Save_as_PDB(modele:TStringList;url:string;temp:boolean);
var
   plik:TstringList;
   w,x,i,col,spacja:integer;
   rekord,zbiorczy:string;

begin
   plik:= TstringList.create;
   plik.Add('TITLE  ' + ExtractFileName(url));
   plik.Add('REMARK GROW_4');

   for i:=1 to Form8.Memo2.Lines.Count-1 do
   begin
      plik.Add(Form8.Memo2.Lines[i]);
   end;

   // zapisywanie pliku zlożonego z kilku modeli

 for w:=0 to modele.Count-1 do  // modele lista stron do zapisania
   begin

   x:= strtoint(modele[w]);

   if Project[x-1,1,0] = 'HETATM' then
    begin
       plik.Add('MODEL  ' + Project_table_form.StringGrid1.Cells[NrColProj_Name,x]);
    end;

   for i:=1 to ProjectArrayFunctions('RowCount',x-1)-1 do   // od i:=1 pomija naglowki - dobrze
    begin
   zbiorczy:='';
     if (Project[x-1,i,1] = '1')
      or(Project[x-1,i,2] = '1')
      then  // sprawdzaj czy jest visible lub include jest na true
     begin
      for col:= 0 to 17 do
      begin
       if col = 0 then
           begin
             rekord:= Project[x-1,i,0];
             if length(rekord) < 6 then  //section 1-6
               begin
                 for spacja:=1 to 6 - length(rekord) do
                  begin
                    rekord := rekord + ' ';
                  end;
               end;
             zbiorczy:= rekord;
           end;
       if col = 3 then
           begin
             rekord:= Project[x-1,i,3,i];
             if length(rekord) < 5 then  //7-11
               begin
                 for spacja:=1 to 5 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy +rekord+' '; // 12 pozycja spacja
           end;
        if col = 4 then           //13-16
           begin
             rekord:= Project[x-1,i,4];
             if length(rekord) < 4 then
               begin
                 for spacja:=1 to 4 - length(rekord) do
                  begin
                    rekord := rekord + ' ';
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 5 then      //   17
           begin
             rekord:= Project[x-1,i,5] + ' '; // 17
             if length(rekord) <> 1 then
               begin
                 rekord := rekord[1];
               end;
             zbiorczy:=zbiorczy + rekord ;
           end;
        if col = 6 then     // 18-20
           begin
             rekord:= Project[x-1,i,6];
             if length(rekord) < 3 then
               begin
                 for spacja:=1 to 3 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord + ' '; // spacja za pole 21
           end;
        if col = 7 then  // 22
           begin
             rekord:= Project[x-1,i,7] + ' ';
             if length(rekord) <> 1 then
               begin
                 rekord := rekord[1];
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 8 then  // 23-26
           begin
             rekord:= Project[x-1,i,8];
             if length(rekord) < 4 then
               begin
                 for spacja:=1 to 4 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 9 then  // 27
           begin
             rekord:= Project[x-1,i,9] + ' ';
             if length(rekord) <> 1 then
               begin
                 rekord := rekord[1];
               end;
             zbiorczy:=zbiorczy + rekord+'   '; // spacja za kolumne 28,29,30
           end;
        if col = 10 then  //  31-38
           begin
            if temp then // jesli temp true to bierze wspolzedne tymczasoewe
             begin
             //  rekord:= Project[x-1,i,NrColTempX];
             end else
              begin
                rekord:= Project[x-1,i,10];
              end;
             if length(rekord) < 8 then
               begin
                 for spacja:=1 to 8 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 11 then  // 39-46
           begin
             if temp then // jesli temp true to bierze wspolzedne tymczasoewe
             begin
              // rekord:= Project[x-1,i,NrColTempY];
             end else
              begin
                rekord:= Project[x-1,i,11];
              end;
             if length(rekord) < 8 then
               begin
                 for spacja:=1 to 8 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 12 then // 47-54
           begin
           if temp then // jesli temp true to bierze wspolzedne tymczasoewe
             begin
              // rekord:= Project[x-1,i,NrColTempZ];
             end else
              begin
               rekord:= Project[x-1,i,12];
              end;
             if length(rekord) < 8 then
               begin
                 for spacja:=1 to 8 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
         if col = 13 then  // 55-60
           begin
             rekord:= Project[x-1,i,13];
             if length(rekord) < 6 then
               begin
                 for spacja:=1 to 6 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
        if col = 14 then   //  61-66
           begin
             rekord:= Project[x-1,i,14];
             if length(rekord) < 6 then
               begin
                 for spacja:=1 to 6 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord +'  ';  // za spacje 67-72
           end;
        if col = 15 then // 73-76
           begin
             rekord:= Project[x-1,i,15];
             if length(rekord) < 6 then
               begin
                 for spacja:=1 to 6 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord +'  '; // za pozycje 71-72
           end;
        if col = 16 then  // 77-78
           begin
             rekord:= Project[x-1,i,16];
             if length(rekord) < 2 then
               begin
                 for spacja:=1 to 2 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
         if col = 17 then // 79-80
           begin
             rekord:= Project[x-1,i,17];
             if length(rekord) < 2 then
               begin
                 for spacja:=1 to 2 - length(rekord) do
                  begin
                    rekord := ' ' + rekord;
                  end;
               end;
             zbiorczy:=zbiorczy + rekord;
           end;
       end;
     end;


     if length(trim(zbiorczy)) > 15 then
      begin  plik.Add(zbiorczy); end;
    end;

  plik.Add('TER');

  end;

   //-> koniec petli zbierania modeli

   // CONECT

{   For i:=1 to Form2.StringGrid.RowCount-1 do
    begin
    plik.Add('CONECT');            // dodaj rekord
    rekord:= // Form2.StringGrid.Cells[0,i];
      if length(rekord) < 5 then      // odp ilosc znakow spacji
        begin
          for spacja:=1 to 5 - length(rekord) do
            begin
              rekord := ' ' + rekord;
            end;
        end;
     plik[plik.Count-1]:= plik[plik.Count-1] + rekord; // dopisz do biezracego rekordu
     // znajdz drugi conect
     rekord:= // Form2.StringGrid.Cells[2,i];
      if length(rekord) < 5 then      // odp ilosc znakow spacji
        begin
          for spacja:=1 to 5 - length(rekord) do
            begin
              rekord := ' ' + rekord;
            end;
        end;
      plik[plik.Count-1]:= plik[plik.Count-1] + rekord; // dopisz do biezracego rekordu
    end;
        }
  plik.Add('END');

  if url = '' then   // jak puste pobierz folder tymczasowy
   begin
     url:= UTF8decode(GetEnvironmentVariable('TEMP')+'\visio.pdb');
     showmessage(url);
   end;

 try plik.SaveToFile(url)
   except
     Console.AddCommunicate(com7,true);
     Console.AddCommunicate(com93,true);
   end;

 Console.AddCommunicate(com40+url,true);

end;

procedure CloneProperties(const Source: TControl; const Dest: TControl);
var
  ms: TMemoryStream;
  OldName: string;
begin
  OldName := Source.Name;
  Source.Name := ''; // needed to avoid Name collision
  try
    ms := TMemoryStream.Create;
    try
      ms.WriteComponent(Source);
      ms.Position := 0;
      ms.ReadComponent(Dest);
    finally
      ms.Free;
    end;
  finally
    Source.Name := OldName;
  end;
end;

Procedure ImportAsPDB(FileName:String); // jak sie zabiore za import look at !!! : http://deposit.rcsb.org/adit/docs/pdb_atom_format.html
var
  TxtFile : TextFile;
  line, radius, color: string;
  LineNumber:integer=0;
  AllLinesNumber:integer=0;
  pierwszyZnacznik:boolean=true;
  Nr: integer=0;
  Temp:TstringList;
  x,y:integer;
  percent:integer=0;
  i:integer;

  Section:string='';
  CofactorName:string='';

begin // import plików PDB lub ENT

if FileName = '' then  // nie podano nazwy pliku -> to nazwa z opendialog
   begin

     Mainform.OpenDialog1.Filter:=IndexFilter_2; // ustaw filter
     Mainform.OpenDialog1.FileName:=''; // wyszysc nazwe

       if Mainform.OpenDialog1.Execute then  // open dialog i sciezka z tego
         begin
           if (ExtractFileExt(Mainform.OpenDialog1.FileName) = '.pdb') or (ExtractFileExt(Mainform.OpenDialog1.FileName) = '.ent') then
             begin
               try

                 ProgressBox.ShowProgressBox();

                 AssignFile(TxtFile, UTF8decode(Mainform.OpenDialog1.FileName)) ;
                 Reset(TxtFile) ;
                 // orietacyjna liczba lini
                 AllLinesNumber:= Round(FileSize(UTF8decode(Mainform.OpenDialog1.FileName))/ 70);
               except
                 Console.AddCommunicate(com7+'[OpenFile][1]',true);
                 exit;
               end;
             end;
         end;
   end else
     begin // podano nazwe pliku
       try
         AssignFile(TxtFile, UTF8decode(FileName)) ;
         Reset(TxtFile) ;
         // orietacyjna liczba lini
         AllLinesNumber:= Round(FileSize(UTF8decode(FileName))/ 89);
       except
         Console.AddCommunicate(com7+'[OpenFile][2]',true);  // problem z nazwa albo istnieniem pliku
         exit;
       end;
     end;

// czytaj po jednej lini pliku i go
//try
begin

 FileName:= Copy(ExtractFileName(FileName),1,Length(FileName)-Length(ExtractFileExt(FileName)));

// wlasciwa pentla programowa
Console.AddCommunicate('Loading file: '+ FileName,true);


while not EOF(TxtFile) do
   begin

    ReadLn(TxtFile, line) ; // odczytaj linie pliku

    percent:= Round((LineNumber*100)/AllLinesNumber);

 if percent > 99 then
   begin
     percent:=99;
   end;

   ProgressBox.StaticText1.Caption:= pleasewait+' ('+inttostr(percent)+'%)';


 // parsowanie

 If Trim(line) > '' then
 begin

  inc(LineNumber); // aktualny numer lini

  // odczytaj linie i zamień na pdb rekord

  Temp:= Tstringlist.Create;
  PDBlineAsList(line,temp);     // zamien linie w pliku na liste

   // PROTEIN & LIGAND

      if (copy(line,1,4) = 'ATOM') or (copy(line,1,6) = 'HETATM') then  // jesli znacznik atom
            begin


   // reguj jka sie zmieni
        if (section = 'ATOM') then
         begin
           if (copy(line,1,4) <> section) then
             begin
               pierwszyZnacznik:= true;
             end;
         end;

       if (section = 'HETATM') then
        begin
          if (copy(line,1,6) <> section) then
            begin
              pierwszyZnacznik:= true;
            end;
        end;

       if (copy(line,1,6) = 'HETATM') and (CofactorName <> temp[3]) then
         begin
           pierwszyZnacznik:= true;
         end;


           if pierwszyZnacznik then // tylko za pierwszym znacznikiem ma dodawać nowego
                begin

                  inc(Nr); // numer proteiny

                  pierwszyZnacznik:= false;
                  //dodaj rekord
                  project_table_form.StringGrid1.RowCount:= project_table_form.StringGrid1.RowCount +1;

                  // ARRAY - dodaj nowego grida do tablicy
                  SetLength(Project,project_table_form.StringGrid1.RowCount-1);

                  // nie widoczne nie inkludowane
                  project_table_form.StringGrid1.Cells[1,project_table_form.StringGrid1.RowCount-1] := '0';

                  project_table_form.StringGrid1.Cells[2,project_table_form.StringGrid1.RowCount-1] := '0';
                  // orginal file name
                  project_table_form.StringGrid1.Cells[5,project_table_form.StringGrid1.RowCount-1]:= ExtractFileName(Mainform.OpenDialog1.FileName);


                  if copy(line,1,4) = 'ATOM' then
                   begin

                   Section:='ATOM';

                   //  Model number
                   project_table_form.StringGrid1.Cells[0,project_table_form.StringGrid1.RowCount-1]
                      := inttostr(Nr);

                    // name type prot
                    project_table_form.StringGrid1.Cells[3,project_table_form.StringGrid1.RowCount-1] := 'Molecule_'+inttostr(Nr);
                    project_table_form.StringGrid1.Cells[4,project_table_form.StringGrid1.RowCount-1]:= 'PRO';
                   end;

                  if copy(line,1,6) = 'HETATM' then
                   begin
                   //  Model number
                   project_table_form.StringGrid1.Cells[0,project_table_form.StringGrid1.RowCount-1]
                      := inttostr(Nr);

                    // name type prot
                    project_table_form.StringGrid1.Cells[3,project_table_form.StringGrid1.RowCount-1] := temp[3]; // 'Ligand_'+inttostr(Nr);
                    project_table_form.StringGrid1.Cells[4,project_table_form.StringGrid1.RowCount-1]:= 'LIG';

                    CofactorName:= temp[3];

                   end;

                 Console.AddCommunicate('Loading :'+  project_table_form.StringGrid1.Cells[3,project_table_form.StringGrid1.RowCount-1] // name
                         + ' from file: '+ ExtractFileName(Mainform.OpenDialog1.FileName) ,false);
                end;


                 // dodaj rowas do array
                 SetLength(Project[project_table_form.StringGrid1.RowCount-2],
                           ProjectArrayFunctions('RowCount',project_table_form.StringGrid1.RowCount-2)+1
                           ,ProjectArrayColCount);

                 if (copy(line,1,4) = 'ATOM') then // section
                   begin

                    Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColSection]:= 'ATOM';
                   end;

                  if copy(line,1,6) = 'HETATM' then
                   begin

                   Section:='HETATM';

                   Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColSection]:= 'HETATM';

                   end;

                   Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColVis]:= '0';

                   Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColInc]:= '0';

                 for y:= 0 to temp.Count -1 do
                     begin                       // przepisz na rekord tablicy

                      // zamien nomenklature inną na PDB
                    if y = NrColAtomName-3 then // jesli jest atom name w liscie
                     begin
                      temp[y]:= AnyAtomNametoPDBname(temp[y]);
                     end;

                      Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,y+3]:= temp[y];

                     end;                 // y +3 bo zaczyna od 3 wpisywanie

                  temp.free;

                // radius

                Radius:= AtomSymbolTo('R', Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColElementSymbol]);

                If Radius = '1' then
                 begin
                   Radius:= AtomSymbolTo('R',
                               AtomNameToElement(Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColAtomName]));
                 end;

                Project[Project_table_form.StringGrid1.RowCount-2,
                        ProjectArrayFunctions('RowCount',
                        Project_table_form.StringGrid1.RowCount-2)-1,NrColRadius]:= Radius;

               // color

                Color:= AtomSymbolTo('C', Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColElementSymbol]);

                 If Color = 'clFuchsia' then
                 begin
                   Color:= AtomSymbolTo('C',
                               AtomNameToElement(Project[Project_table_form.StringGrid1.RowCount-2,
                              ProjectArrayFunctions('RowCount',
                              Project_table_form.StringGrid1.RowCount-2)-1,NrColAtomName]));
                 end;

                Project[Project_table_form.StringGrid1.RowCount-2,
                        ProjectArrayFunctions('RowCount',
                        Project_table_form.StringGrid1.RowCount-2)-1,NrColColor]:= Color;

              end;

      // END MODEL

      If (copy(line,1,6) = 'ENDMDL') or (copy(line,1,3) = 'TER') then
              begin
                pierwszyZnacznik:= true;
              end;


      // CONNECT

      If (copy(line,1,6) = 'CONECT') then
              begin
                // Dodaj sekcje conect powiekszaona o numer aktualnego numeru - LastConectNumber
                ImportPDBsetionConnect(line);
              end;


     // REST OPTIONS

     If not (copy(line,1,6) = 'HETATM')
        and not (copy(line,1,4) = 'ATOM')
        and not (copy(line,1,6) = 'ENDMDL')
        and not (copy(line,1,3) = 'TER')
        and not (copy(line,1,3) = 'END')
        and not (copy(line,1,6) = 'CONECT') then
            begin
               Form8.Memo2.Lines.Add(line);
            end;

end;
end;  // koniec petli

// dodaj polaczenia meidzy atomami // to-do wizania  -> przypisz wizania podczas importu  ------------------------------> !!!!!! TO DO

 { for i:=1 to Project_Table_form.StringGrid1.RowCount-1 do
   begin

      Console.AddCommunicate('Assigning bonds to '+  project_table_form.StringGrid1.Cells[3,i],false); // name
      AssignBondsToMolecule(i-1,Project_table_form.StringGrid1.Cells[NrColProj_Type,i]);

   end;
  }

  project_table_form.StringGrid1.Visible:=true;


 // jesli wszytsko ok zamknij plik
 CloseFile(TxtFile) ;

 Console.AddCommunicate('File loaded correctly.',false);

 exit;
end;

Console.AddCommunicate('File is corrupted.',true);

end;


procedure PDBlineAsList(linia:string;List:Tstringlist);
begin

//   NrColSection:integer=0;  NrColVis:integer=1;  NrColInc:integer=2;  NrColAtomId:integer=3;
//   NrColAtomName:integer=4;  NrColAlternateLocationIndicator:integer=5;  NrColResidueName:integer=6;
//   NrChainIdentifier:integer=7;  NrColSequenceNr:integer=8;  NrColx:integer=10;  NrColy:integer=11;
//   NrColz:integer=12;  NrColOccupancy:integer=13;  NrColTemperatureFactor:integer=14;  NrColElementSymbol:integer=16;
//   NrColChargeOnTheAtom:integer=17;  NrColRadius:integer=18;  NrColColor:integer=19;

     List.Add(Trim(Copy(linia,7,5)));
     // zwieksz wartosc numeru atomu o aktualna
     // List[0]:= Inttostr(StrtoInt(List[0]));   // atom id
     //

     List.Add(AnyAtomNametoPDBname(Trim(copy(linia,13,4))));  // http://deposit.rcsb.org/adit/docs/pdb_atom_format.html
     List.Add(Trim(copy(linia,17,1)));
     List.Add(Trim(copy(linia,18,3)));         // sprawdzono jest ok
     List.Add(Trim(copy(linia,22,1)));
     List.Add(Trim(copy(linia,23,4)));
     List.Add(Trim(copy(linia,27,1)));
     List.Add(Trim(copy(linia,31,8)));
     List.Add(Trim(copy(linia,39,8)));
     List.Add(Trim(copy(linia,47,8)));
     List.Add(Trim(copy(linia,55,6)));
     List.Add(Trim(copy(linia,61,6)));
     List.Add(Trim(copy(linia,73,4)));
     // was: List.Add(Trim(copy(linia,77,2)));
     List.Add(AtomNameToElement(Trim(copy(linia,13,4))));  // element symbol pbierz z nazwy psb atomu
     List.Add(Trim(copy(linia,79,2)));

end;

Function ProjectArrayFunctions(FunctionName:string; ProjectNumber:integer):integer;
       // Project, Row, Col
var
  col,row:integer;
begin
 if FunctionName = 'ProjectCount' then
  begin
    Result:= Length(Project);
  end;

 if (FunctionName = 'RowCount') and (Length(Project) >= ProjectNumber) then
  begin
    Result:= Length(Project[ProjectNumber]);
  end;

 if (FunctionName = 'ColCount') and (Length(Project[ProjectNumber]) >= 0) and (Length(Project) >= ProjectNumber) then
  begin
    Result:= Length(Project[ProjectNumber,0]);
  end;

 if (FunctionName = 'AddRow') and (Length(Project) >= ProjectNumber) then
  begin
    SetLength(Project[ProjectNumber],  // project number
              ProjectArrayFunctions('RowCount',ProjectNumber)+1, // increasse rows plus 1
              ProjectArrayColCount); // snadrad number of cols
  end;

end;


end.
