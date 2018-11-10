(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit General_dll;

{$mode objfpc}

interface

uses
  Classes, SysUtils, Console_dll;

//-- Create and Load Arrays
     Function Initialize_Arrays():boolean;

//-- Temporaty Record
     Function TempRecordClear():boolean;
     Function AddRecord(ObjectType: string; ObjectNumber:integer):integer; // Function adds record to the Objects array and returns the record number / index

//-- OBJECTS LIST functions
     Function AddObject():integer; // Function adds record into the Object List array and returns the new object number / index
     Function ObjectsListRowCount():integer; // Return RowCount for array


//-- odzielne dla bondów !!

//-- OBJECTS functions
     Function  ObjectRowsCount(ObjectNumber:integer):integer;

     Procedure ShowAllObjectRecords(ObjectNumber:integer);
     Procedure HideAllObjectRecords(ObjectNumber:integer);

//-- COORDINATE SYSTEM TRANSLATIONS
     Function  MoveCoordinateSystemToAvarageCenter():boolean;
     Procedure AverageCooridnatesOfVisibleMolecules(XYZ:TstringList;CountOnlyVisible:boolean);
     Procedure MoveCoordinateSystemTo(x,y,z:Currency);
     Function  ArithmeticAverage(kol:Tstrings):string;

//-- ATOMS PROCEDURE
     Procedure AtomProperties();

implementation

Uses
  Unit1, Unit20;

 Function Initialize_Arrays():boolean; // Implemented in OnCreate MainForm Unit1
  begin
   // Objects List
       SetLength(ObjectsList,0,ObjectsList_ColCount);
   // Objects
       SetLength(Objects,0,Objects_ColCount);

   // Load scientific arrays

  end;

 Function TempRecordClear():boolean;
 Var
   i:integer;
  begin
    for i:=0 to Length(TempRecord) -1 do
      begin
        TempRecord[i]:='';
      end;
  end;

 Function AddRecord(ObjectType: string; ObjectNumber:integer):integer;
 Var
  RowCount:integer;
  begin

    // If ObjectNumber < 0 the add to the last object

    if (ObjectNumber < 0) or (ObjectNumber > ObjectsListRowCount()) then
     begin
       ObjectNumber := ObjectsListRowCount() - 1;
     end;

  //- ATOM or HETATM

    If (ObjectType = Section_Type_Atom) or (ObjectType = Section_Type_Hetatm) then
      begin
        // Row count
          RowCount:= ObjectRowsCount(ObjectNumber);
          RowCount:= RowCount + 1;

        // ADD empty ROW
          SetLength(Objects[ObjectNumber], RowCount, Objects_ColCount);

        // fill row

        Objects[ObjectNumber,RowCount -1,Object_Type]:=                      TempRecord[Object_Type];
        Objects[ObjectNumber,RowCount -1,Object_Vis]:=                       TempRecord[Object_Vis];
        Objects[ObjectNumber,RowCount -1,Object_Inc]:=                       TempRecord[Object_Inc];

        Objects[ObjectNumber,RowCount -1,Atom_ID]:=                          TempRecord[Atom_ID];
        Objects[ObjectNumber,RowCount -1,Atom_Name]:=                        TempRecord[Atom_Name];
        Objects[ObjectNumber,RowCount -1,Atom_AlternateLocationIndicator]:=  TempRecord[Atom_AlternateLocationIndicator];
        Objects[ObjectNumber,RowCount -1,Atom_ResidueName]:=                 TempRecord[Atom_ResidueName];
        Objects[ObjectNumber,RowCount -1,Atom_ChainIdentifier]:=             TempRecord[Atom_ChainIdentifier];
        Objects[ObjectNumber,RowCount -1,Atom_SequenceNr]:=                  TempRecord[Atom_SequenceNr];
        Objects[ObjectNumber,RowCount -1,Atom_Code_insertion_residues]:=     TempRecord[Atom_Code_insertion_residues];
        Objects[ObjectNumber,RowCount -1,Atom_X]:=                           TempRecord[Atom_X];
        Objects[ObjectNumber,RowCount -1,Atom_Y]:=                           TempRecord[Atom_Y];
        Objects[ObjectNumber,RowCount -1,Atom_Z]:=                           TempRecord[Atom_Z];
        Objects[ObjectNumber,RowCount -1,Atom_Occupancy]:=                   TempRecord[Atom_Occupancy];
        Objects[ObjectNumber,RowCount -1,Atom_TemperatureFactor]:=           TempRecord[Atom_TemperatureFactor];
        Objects[ObjectNumber,RowCount -1,Atom_SegmentIdentifier]:=           TempRecord[Atom_SegmentIdentifier];
        Objects[ObjectNumber,RowCount -1,Atom_ElementSymbol]:=               TempRecord[Atom_ElementSymbol];
        Objects[ObjectNumber,RowCount -1,Atom_ChargeOnTheAtom]:=             TempRecord[Atom_ChargeOnTheAtom];

        Objects[ObjectNumber,RowCount -1,Object_Radius]:=                    TempRecord[Object_Radius];
        Objects[ObjectNumber,RowCount -1,Object_Color]:=                     TempRecord[Object_Color];

        Result:= RowCount - 1; // Return recird index
      end;

  end;

 Function AddObject():integer;
 Var
   RowCount:integer;
  begin
    RowCount:= ObjectsListRowCount();
    RowCount:= RowCount + 1;

    // Increase OBJECT LIST array records, add row
    SetLength(ObjectsList,RowCount,ObjectsList_ColCount);

    // Increase OBJECTS array records, add record
    SetLength(Objects,Length(Objects)+1);


    // add to the array
    ObjectsList[RowCount - 1, ObjecstList_Object_ID] :=              inttostr(RowCount - 1); // array index

    ObjectsList[RowCount - 1, ObjectsList_Included] :=                TempRecord[ObjectsList_Included];
    ObjectsList[RowCount - 1, ObjectsList_Name] :=                    TempRecord[ObjectsList_Name];
    ObjectsList[RowCount - 1, ObjectsList_Type] :=                    TempRecord[ObjectsList_Type];
    ObjectsList[RowCount - 1, ObjectsList_Original_File_Name] :=      TempRecord[ObjectsList_Original_File_Name];
    ObjectsList[RowCount - 1, ObjectsList_Comment] :=                 TempRecord[ObjectsList_Comment];
    ObjectsList[RowCount - 1, ObjectsList_Visualization_Type] :=      TempRecord[ObjectsList_Visualization_Type];

    // add to the grid
    IVM.ObjetsList.RowCount:= IVM.ObjetsList.RowCount +1;

    IVM.ObjetsList.Cells[ObjecstList_Object_ID, IVM.ObjetsList.RowCount - 1] := inttostr(RowCount - 1);

    IVM.ObjetsList.Cells[ObjectsList_Included, IVM.ObjetsList.RowCount - 1] :=           TempRecord[ObjectsList_Included];
    IVM.ObjetsList.Cells[ObjectsList_Name, IVM.ObjetsList.RowCount - 1] :=               TempRecord[ObjectsList_Name];
    IVM.ObjetsList.Cells[ObjectsList_Type, IVM.ObjetsList.RowCount - 1] :=               TempRecord[ObjectsList_Type];
    IVM.ObjetsList.Cells[ObjectsList_Original_File_Name, IVM.ObjetsList.RowCount - 1] := TempRecord[ObjectsList_Original_File_Name];
    IVM.ObjetsList.Cells[ObjectsList_Comment, IVM.ObjetsList.RowCount - 1] :=            TempRecord[ObjectsList_Comment];
    IVM.ObjetsList.Cells[ObjectsList_Visualization_Type, IVM.ObjetsList.RowCount - 1] := TempRecord[ObjectsList_Visualization_Type];

    Result:= RowCount - 1;
  end;

 Function ObjectsListRowCount():integer;
  begin
    Result:= Length(ObjectsList);
  end;

 Function ObjectRowsCount(ObjectNumber:integer):integer;
  begin
   if Length(Objects) > ObjectNumber then
    begin
      Result:= Length(Objects[ObjectNumber]);
    end
     else begin AddCommunicate(error_1+', object '+inttostr(ObjectNumber)+' from '+inttostr(ObjectsListRowCount()-1), true); end;
  end;

 Procedure ShowAllObjectRecords(ObjectNumber:integer);
 Var
   i:integer;
begin
  for i:=0 to ObjectRowsCount(ObjectNumber) - 1 do
    begin
      Objects[ObjectNumber, i, Object_Vis]:= '1';
      Objects[ObjectNumber, i, Object_Inc]:= '1';
    end;
end;

 Procedure HideAllObjectRecords(ObjectNumber:integer);
Var
  i:integer;
begin
 for i:=0 to ObjectRowsCount(ObjectNumber) - 1 do
   begin
     Objects[ObjectNumber, i, Object_Vis]:= '0';
     Objects[ObjectNumber, i, Object_Inc]:= '0';
   end;
end;

 Function MoveCoordinateSystemToAvarageCenter():boolean;
 Var
  XYZ:TstringList;
 begin
   XYZ:= TstringList.Create;

     AverageCooridnatesOfVisibleMolecules(XYZ,true);
     MoveCoordinateSystemTo(StrToCurr(XYZ[0]),StrToCurr(XYZ[1]),StrToCurr(XYZ[2]));

  XYZ.Free;
 end;

Procedure AverageCooridnatesOfVisibleMolecules(XYZ:TstringList;CountOnlyVisible:boolean);
 Var
   a,b,old_grid:integer;
   ave_x,ave_y,ave_z:TstringList;

 begin

   ave_x:= Tstringlist.Create;
   ave_y:= Tstringlist.Create;
   ave_z:= Tstringlist.Create;


   For a:=0 to ObjectsListRowCount() - 1 do
    begin

     if CountOnlyVisible = true then
      begin
      if ObjectsList[a, ObjectsList_Included] = '1' then
       begin
          for b:= 0 to ObjectRowsCount(a) -1 do
            begin
              if (Objects[a, b, Object_Vis] = '1') or (Objects[a, b, Object_Inc] = '1') then
                begin
                  ave_x.Add(Objects[a, b, Atom_X]);
                  ave_y.Add(Objects[a, b, Atom_Y]);
                  ave_z.Add(Objects[a, b, Atom_Z]);
                end;
            end;
       end;
      end;

   if CountOnlyVisible = false then
    begin
      for b:= 0 to ObjectRowsCount(a) -1 do
            begin
              if (Objects[a, b, Object_Vis] = '1') or (Objects[a, b, Object_Inc] = '1') then
                begin
                  ave_x.Add(Objects[a, b, Atom_X]);
                  ave_y.Add(Objects[a, b, Atom_Y]);
                  ave_z.Add(Objects[a, b, Atom_Z]);
                end;
            end;

    end;
   end;

 if ave_x.Count > 0 then
  begin
      XYZ.Clear;

      XYZ.Add(ArithmeticAverage(ave_x));
      XYZ.Add(ArithmeticAverage(ave_y));
      XYZ.Add(ArithmeticAverage(ave_z));

  end else begin

      XYZ.Add('0');
      XYZ.Add('0');
      XYZ.Add('0');
 end;

 end;

Procedure MoveCoordinateSystemTo(x,y,z:Currency); // http://www.medianauka.pl/przesuniecie_wykresu_funkcji
 var
   shets,rows,old_grid:integer;
   start_value:currency;
  Begin

    for shets:=0 to ObjectsListRowCount() - 1 do
     begin
       for rows:=0 to ObjectRowsCount(shets) -1 do
        begin

          start_value:= StrToCurr(Objects[shets, rows, Atom_X]);
          Objects[shets, rows, Atom_X]:= CurrToStr(start_value - x); // actualize X as in function parameters

          start_value:= StrToCurr(Objects[shets, rows, Atom_Y]);
          Objects[shets, rows, Atom_Y]:= CurrToStr(start_value - y); // actualize Y as in function parameters

          start_value:= StrToCurr(Objects[shets, rows, Atom_Z]);
          Objects[shets, rows, Atom_Z]:= CurrToStr(start_value - z);
        end;
     end;
                                                                     {TODO: Rest of arrays as bond selectors etc. need to be updated here! }
  {// Zaktualizuj selected

     for rows:=0 to Length(Selected) - 1 do
       begin

          wartosc_pocz:= StrToCurr(Selected[rows,NrColX]);
          Selected[rows,NrColX]:= CurrToStr(wartosc_pocz - x);

          wartosc_pocz:= StrToCurr(Selected[rows,NrColY]);
          Selected[rows,NrColY]:= CurrToStr(wartosc_pocz - y);

          wartosc_pocz:= StrToCurr(Selected[rows,NrColZ]);
          Selected[rows,NrColZ]:= CurrToStr(wartosc_pocz - z);

        end;

  // zaktualizuj wszytskie
  for rows:=0 to Length(Bonds) -1 do       // form2 wylaczone bo stringgridd nie jest aktualizowany
     begin

      // zaktualizuj bonds X 1
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_FirstX]);
       Bonds[rows,NrColBonds_FirstX]:= CurrToStr(wartosc_pocz - x);
   //    // Form2.StringGrid.Cells[NrColBonds_FirstX,rows+1]:=Bonds[rows,NrColBonds_FirstX];
     // zaktualizuj bonds Y 1
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_FirstY]);
       Bonds[rows,NrColBonds_FirstY]:= CurrToStr(wartosc_pocz - y);
  //     // Form2.StringGrid.Cells[NrColBonds_FirstY,rows+1]:=Bonds[rows,NrColBonds_FirstY];
     // zaktualizuj bonds Z 1
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_FirstZ]);
       Bonds[rows,NrColBonds_FirstZ]:= CurrToStr(wartosc_pocz - z);
  //     // Form2.StringGrid.Cells[NrColBonds_FirstZ,rows+1]:=Bonds[rows,NrColBonds_FirstZ];
     // zaktualizuj bonds X 2
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_SecondX]);
       Bonds[rows,NrColBonds_SecondX]:= CurrToStr(wartosc_pocz - x);
  //     // Form2.StringGrid.Cells[NrColBonds_SecondX,rows+1]:=Bonds[rows,NrColBonds_SecondX];
     // zaktualizuj bonds Y 2
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_SecondY]);
       Bonds[rows,NrColBonds_SecondY]:= CurrToStr(wartosc_pocz - y);
   //    // Form2.StringGrid.Cells[NrColBonds_SecondY,rows+1]:=Bonds[rows,NrColBonds_SecondY];
     // zaktualizuj bonds Z 2
       wartosc_pocz:= StrToCurr(Bonds[rows,NrColBonds_SecondZ]);
       Bonds[rows,NrColBonds_SecondZ]:= CurrToStr(wartosc_pocz - z);
  //     // Form2.StringGrid.Cells[NrColBonds_SecondZ,rows+1]:=Bonds[rows,NrColBonds_SecondZ];
     end; }

  end;

 Function  ArithmeticAverage(kol:Tstrings):string;
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

Procedure AtomProperties(); // update atom properties panel          {TODO: Rewrite function and add selected array to the main array!}
  var
    i,row,col:integer;
    radius,x,y,z,p:currency;
  begin

   selected_count:= Length(Selected);
{
  if selected_count = 0 then
   begin
     IVM.StringGrid1.RowCount:= 1;

   for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
    begin
      for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
       begin

         x:= StrToCurr(Project[i-1,Row,NrColx]);
         y:= StrToCurr(Project[i-1,Row,NrColy]);
         z:= StrToCurr(Project[i-1,Row,NrColz]);

         radius:= ((StrToCurr(Project[i-1,Row,NrColRadius])) * strtofloat(settings.LabeledEdit1.Text))+ 0.001 ;

  // ------------------------------------------------- 0 selected, 3 properties

     if (selected_count = 0) and (Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1') and (Project[i-1,Row,NrColInc] = '1') and (ThreeDpositionXclick < x + radius) and (ThreeDpositionXclick > x - radius) and (ThreeDpositionYclick < y + radius) and (ThreeDpositionYclick > y - radius) and (ThreeDpositionZclick < z + radius ) and ( ThreeDpositionZclick > z - radius)
        then
          begin

            IVM.StringGrid1.RowCount:= ProjectArrayFunctions('ColCount',i-1);

            for col:=0 to ProjectArrayFunctions('ColCount',i-1) -1 do
              begin
                 IVM.StringGrid1.Cells[0,col]:= Project_col_names[col];
                 IVM.StringGrid1.Cells[1,col]:= Project[i-1,Row,col];
              end;

            // information for localization to edit by values in the grid
             select_1_atom_Project:=i-1; // as in array
             select_1_atom_Row:=Row;  // as in array

             break;
          end;

      end;
    end;
   end;

  // ---------------------------- wyszukuj tylko wtedy gdy nie ma juz zlistowanego

  if (selected_count = 1) and  (IVM.StringGrid1.RowCount < 5) then
   begin

   for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
    begin
      for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
       begin
        if Project[i-1,Row,NrColVis] = '1' then
          begin
           // information for localization to edit by values in the grid
             select_1_atom_Project:=i-1; // as in array
             select_1_atom_Row:=Row;  // as in array

            IVM.StringGrid1.RowCount:= ProjectArrayFunctions('ColCount',i-1);

            for col:=0 to ProjectArrayFunctions('ColCount',i-1) -1 do
              begin
                 IVM.StringGrid1.Cells[0,col]:= Project_col_names[col];
                 IVM.StringGrid1.Cells[1,col]:= Project[i-1,Row,col];
              end;

             break;
          end;

      end;
    end;
   end;

  // ------------------------------------------------------------------ 2 selected

    if (selected_count = 2) then
        begin
          IVM.StringGrid1.RowCount:= 2;
          IVM.StringGrid1.Cells[0,1]:='Distance';
          IVM.StringGrid1.Cells[1,1]:= currtostr(dlugosc_wektora(strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),
                                                                 strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),0));
        end;

  // ------------------------------------------------------------------ 3 selected

      if (selected_count = 3) then
          begin
               IVM.StringGrid1.RowCount:= 9;

               //distance 0,1
               IVM.StringGrid1.Cells[0,1]:='Distance '+Selected[0,NrColAtomName]+'-'+Selected[1,NrColAtomName];
               IVM.StringGrid1.Cells[1,1]:= currtostr(dlugosc_wektora(strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),0));

               //distance 1,2
               IVM.StringGrid1.Cells[0,2]:='Distance '+Selected[1,NrColAtomName]+'-'+Selected[2,NrColAtomName];
               IVM.StringGrid1.Cells[1,2]:= currtostr(dlugosc_wektora(strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),0));

               //distance 2,0
               IVM.StringGrid1.Cells[0,3]:='Distance '+Selected[2,NrColAtomName]+'-'+Selected[0,NrColAtomName];
               IVM.StringGrid1.Cells[1,3]:= currtostr(dlugosc_wektora(strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),0));

               //obwod
               IVM.StringGrid1.Cells[0,4]:='Perimeter ';
               IVM.StringGrid1.Cells[1,4]:= currtostr((strtocurr(IVM.StringGrid1.Cells[1,1]) + strtocurr(IVM.StringGrid1.Cells[1,2]) + strtocurr(IVM.StringGrid1.Cells[1,3])));


               // angle 1                    // angle unicode #2220 ???
                IVM.StringGrid1.Cells[0,5]:=  'Angle '+' '+Selected[0,NrColAtomName]+'-'+Selected[1,NrColAtomName]+'-'+Selected[2,NrColAtomName];
                IVM.StringGrid1.Cells[1,5]:= currtostr(PointsToAngle(strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),
                                                                     strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),
                                                                     strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]), true));
                // angle 2
                IVM.StringGrid1.Cells[0,6]:=  'Angle '+' '+Selected[1,NrColAtomName]+'-'+Selected[2,NrColAtomName]+'-'+Selected[0,NrColAtomName];
                IVM.StringGrid1.Cells[1,6]:= currtostr(PointsToAngle(strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),
                                                                     strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),
                                                                     strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]), true));
                // angle 3
                IVM.StringGrid1.Cells[0,7]:=  'Angle '+' '+Selected[2,NrColAtomName]+'-'+Selected[0,NrColAtomName]+'-'+Selected[1,NrColAtomName];
                IVM.StringGrid1.Cells[1,7]:= currtostr(PointsToAngle(strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),
                                                                     strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),
                                                                     strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]), true));
                // surface area
                IVM.StringGrid1.Cells[0,8]:= 'Surface area  '; // wzór Herona -> http://mposwiatowska.republika.pl/trojkat.htm
                p:= strtocurr(IVM.StringGrid1.Cells[1,4]) / 2;
                                             // sqrt(p razy ( p - a ) *                              (p - b)              *                         (p - c))
                IVM.StringGrid1.Cells[1,8]:=   currtostr(sqrt(p * (p - strtocurr(IVM.StringGrid1.Cells[1,1])) * (p - strtocurr(IVM.StringGrid1.Cells[1,2])) * (p - strtocurr(IVM.StringGrid1.Cells[1,3])))) ;

          end;

   // ------------------------------------------------------------------ 4 selected

    if (selected_count = 4) then
        begin
          IVM.StringGrid1.RowCount:= 2;
          IVM.StringGrid1.Cells[0,1]:='Dihedral angle';                   // pierwsza plaszcyzna od 0 ego atomu
          IVM.StringGrid1.Cells[1,1]:= currtostr(AnglePlaneAnalysis(strtocurr(Selected[0,NrColX]),strtocurr(Selected[0,NrColY]),strtocurr(Selected[0,NrColZ]),
                                                                    strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),
                                                                    strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),
                                                                    // druga plaszczyzna od 1 ego atomu
                                                                    strtocurr(Selected[1,NrColX]),strtocurr(Selected[1,NrColY]),strtocurr(Selected[1,NrColZ]),
                                                                    strtocurr(Selected[2,NrColX]),strtocurr(Selected[2,NrColY]),strtocurr(Selected[2,NrColZ]),
                                                                    strtocurr(Selected[3,NrColX]),strtocurr(Selected[3,NrColY]),strtocurr(Selected[3,NrColZ])));
        end;

  // ---------------------------------------------------------------- > 4 selected
      if (selected_count > 4) then
       begin
         IVM.StringGrid1.RowCount:= 1;
       end;
   }
  end;

end.

