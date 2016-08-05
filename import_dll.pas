(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Import_dll;

{$mode objfpc}

interface

uses
  Classes, SysUtils, Console_dll, General_dll, Biblioteka_Grow_4_grafika, Biblioteka_Grow_4_Konsola;

  Function ImportFile_as_PDB(FileName:string):boolean;
  Function PDB_line_to_TempRecord(line:string):boolean;
  //Function IsCofactor(name:string):boolean;      //<-----------
                           { TODO : is cofactor? }
implementation

Uses
  Unit1, Unit20, Unit22;

 Function ImportFile_as_PDB(FileName:string):boolean;
 Var
   T_file: TextFile;
   line:string;
   section_type:string = '';
   Add_new_obj:boolean=false;
   Original_File_Name:string;
   Chain:string = '';
   CofactorName:string = '';
   CofactorChain:string = '';
   radius, color:string;
 begin
   if (FileExists(UTF8decode(FileName))) then
   begin
     AssignFile(T_file, UTF8decode(FileName)); // assign file
     Console.AddCommunicate('Loading file: '+ UTF8decode(FileName),true);
     // orginal file name
        Original_File_Name:= Copy(ExtractFileName(FileName),1,Length(FileName)-Length(ExtractFileExt(FileName)));;
    try
      Reset(T_file); // open to read
       while not Eof(T_file) do
        begin
          Readln(T_file, line); // read every line from file


        //-- NEW object?

         if (trim(copy(line,1,6)) = Section_Type_Atom) or (trim(copy(line,1,6)) = Section_Type_Hetatm) then
          begin

            PDB_line_to_TempRecord(line);

             // if section changed ATOM <> HETATM
             if (trim(copy(line,1,6)) <> section_type) then
               begin
                 section_type:= trim(copy(line,1,6));
                 Add_new_obj:= true;
               end;

             // if chain name <> actual chain name
             if (section_type = Section_Type_Atom) and (Chain <> TempRecord[Atom_ChainIdentifier]) and (Chain > '') then
               begin
                 Add_new_obj:= true;
               end;

             // if Cofactor name <> actual Cofactor name
             if (section_type = Section_Type_Hetatm) and (CofactorName <> TempRecord[Atom_ResidueName]) and (CofactorName > '') then
               begin
                 Add_new_obj:= true;
               end;

              // if Cofactor Chain ID <> actual Cofactor Chain ID
              if (section_type = Section_Type_Hetatm) and (CofactorChain <> TempRecord[Atom_ChainIdentifier]) and (CofactorChain > '') then
               begin
                 Add_new_obj:= true;
               end;
          end;

        //-- Add new object

          if Add_new_obj then
            begin

               TempRecord[ObjectsList_Included]:= '0';
               TempRecord[ObjectsList_Original_File_Name]:= Original_File_Name;

               // Name
               if section_type = Section_Type_Atom   then begin TempRecord[ObjectsList_Name] := TempRecord[Atom_ChainIdentifier]; end;
               if section_type = Section_Type_Hetatm then begin TempRecord[ObjectsList_Name] := TempRecord[Atom_ResidueName]+':'+TempRecord[Atom_ChainIdentifier]; end;

               // Chain or Cofactor name
               if section_type = Section_Type_Atom   then begin Chain        := TempRecord[Atom_ChainIdentifier]; end;
               if section_type = Section_Type_Hetatm then begin CofactorName := TempRecord[Atom_ResidueName];
                                                                CofactorChain:= TempRecord[Atom_ChainIdentifier];end;

        { TODO : Zmodyfikowac object type jako kofajtor ligand proteina, komentarz ?, vizualization type ustalic np. CA, balls, sticks itp dodac jak zdefiniwane do more precise as cofactor, ligand etc. !!! }

              // Type of objects
              if section_type = Section_Type_Atom then
                begin
                  TempRecord[ObjectsList_Type]:= Object_type_Protein; // Potein
                end;

               if section_type = Section_Type_Hetatm then
                begin
                  if TempRecord[Atom_ResidueName] = 'HOH' then         //--------------------------add is cofactor ? -? cofactors !!!!!!!!!!!
                   begin
                     TempRecord[ObjectsList_Type]:= Object_type_Water; // Water
                   end else begin
                     TempRecord[ObjectsList_Type]:= Object_type_Ligand; // Ligand
                   end;

                end;

               TempRecord[ObjectsList_Comment]:= '';             { TODO : dodac komentypoznije}
               TempRecord[ObjectsList_Visualization_Type]:= '';  { TODO : dodac styl wizualziacji jak sie juz ustali}

               AddObject();

               Add_new_obj:= false;
            end;

        //-- ATOM

          if (copy(line,1,4)) = Section_Type_Atom then
           begin
            section_type:= Section_Type_Atom;
            PDB_line_to_TempRecord(line);
           end;

        //-- HETATM

          if copy(line,1,6) = Section_Type_Hetatm then
           begin
            section_type:= Section_Type_Hetatm;
            PDB_line_to_TempRecord(line);
           end;

        //--  Atom RADIUS

                Radius:= AtomSymbolTo('R', TempRecord[Atom_ElementSymbol]);

                If Radius = '1' then
                 begin
                   Radius:= AtomSymbolTo('R',TempRecord[Atom_Name]);
                 end;

                TempRecord[Object_Radius]:= Radius;

        //-- Atom COLOR

                Color:= AtomSymbolTo('C',TempRecord[Atom_ElementSymbol]);

                 If Color = 'clFuchsia' then
                 begin
                   Color:= AtomSymbolTo('C', TempRecord[Atom_Name]);
                 end;

                TempRecord[Object_Color] := Color;

        //-- Add record

            AddRecord(section_type,-1); // if -1 add to last object

        end;

      finally

    CloseFile(T_file);

  end;

   end else begin AddCommunicate(error_2, true); end;

 end;

 Function PDB_line_to_TempRecord(line:string):boolean; // http://deposit.rcsb.org/adit/docs/pdb_atom_format.html
 begin

   TempRecord[Object_Type]                      := trim(copy(line,1,6));  // 1  - 6
   TempRecord[Atom_ID]                          := trim(copy(line,7,5));  // 7  - 11  Atom serial number.
   TempRecord[Atom_Name]                        := trim(copy(line,13,4)); // 13 - 16  Atom name.         // AnyAtomNametoPDBname(Trim(copy(linia,13,4))));
   TempRecord[Atom_AlternateLocationIndicator]  := trim(copy(line,17,1)); // 17       Alternate location indicator.
   TempRecord[Atom_ResidueName]                 := trim(copy(line,18,3)); // 18 - 20  Residue name.
   TempRecord[Atom_ChainIdentifier]             := trim(copy(line,22,1)); // 22       Chain identifier.
   TempRecord[Atom_SequenceNr]                  := trim(copy(line,23,4)); // 23 - 26  Residue sequence number.
   TempRecord[Atom_Code_insertion_residues]     := trim(copy(line,27,1)); // 27       Code for insertion of residues.
   TempRecord[Atom_X]                           := trim(copy(line,31,8)); // 31 - 38  Orthogonal coordinates for X in Angstroms.
   TempRecord[Atom_Y]                           := trim(copy(line,39,8)); // 39 - 46  Orthogonal coordinates for Y in Angstroms.
   TempRecord[Atom_Z]                           := trim(copy(line,47,8)); // 47 - 54  Orthogonal coordinates for Z in Angstroms.
   TempRecord[Atom_Occupancy]                   := trim(copy(line,55,6)); // 55 - 60  Occupancy.
   TempRecord[Atom_TemperatureFactor]           := trim(copy(line,61,6)); // 61 - 66  Temperature factor (Default = 0.0).
   TempRecord[Atom_SegmentIdentifier]           := trim(copy(line,73,4)); // 73 - 76  Segment identifier, left-justified.
   TempRecord[Atom_ElementSymbol]               := trim(copy(line,77,2)); // 77 - 78  Element symbol, right-justified.
   TempRecord[Atom_ChargeOnTheAtom]             := trim(copy(line,79,2)); // 79 - 80  Charge on the atom.

 end;

end.

