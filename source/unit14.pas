(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit14;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Grids, ComCtrls, Buttons, StdCtrls, Menus, Biblioteka_Grow_4,
  Biblioteka_Grow_4_Grafika;

type

  { Tproject_table_form }

  Tproject_table_form = class(TForm)
    ImageList1: TImageList;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu1: TPopupMenu;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1ColRowDeleted(Sender: TObject; IsColumn: Boolean;
      sIndex, tIndex: Integer);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1PickListSelect(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure ToolBar1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton23Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure RecalculateAtomMatrix();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  project_table_form: Tproject_table_form;
  KeyP: Word;

implementation

uses
  Unit1,Unit2,Unit4,Unit12,Unit16,Unit20,Unit22;
{ Tproject_table_form }

procedure Tproject_table_form.RecalculateAtomMatrix();
var
  i,a,b:integer;
  x,y,z,AtomName,ModelNumber: Tstringlist;
begin
x:= Tstringlist.Create;
y:= Tstringlist.Create;
z:= Tstringlist.Create;
AtomName:= Tstringlist.Create;
ModelNumber:=Tstringlist.Create;
 {
  for i:=1 to stringgrid1.ColCount-1 do
    begin
       if stringgrid1.Cells[1,i] = '1' then // checked active
         begin
            if TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cells[0,0] = 'PDB' then
              begin
                 {for b:=1 to TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).RowCount-1 do
                  begin }
                   {if (MainForm.czy_liczba(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cells[8,b]))
                   and (MainForm.czy_liczba(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cells[9,b]))
                   and (MainForm.czy_liczba(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cells[10,b]))
                   and (length(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cells[2,b]) <= 3) then }
                     begin
                       // lista x
                       x.AddStrings(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cols[8]);
                       //lista y
                       y.AddStrings(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cols[9]);
                       // lista z
                       z.AddStrings(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cols[10]);
                       // lista atom name
                       AtomName.AddStrings(TStringGrid(Mainform.pagecontrol.Page[i].Controls[0]).Cols[2]);
                       // lista ModelNumber
                       //ModelNumber.Add(inttostr(i));
                     end;
                  end;
              end;
         end;

x.SaveToFile('x.txt');
y.SaveToFile('y.txt');
z.SaveToFile('z.txt');
AtomName.SaveToFile('an.txt');
//ModelNumber.SaveToFile('mn.txt');;

x.Free;
y.Free;
z.Free;
AtomName.Free;
ModelNumber.Free;   }
end;

procedure Tproject_table_form.FormCreate(Sender: TObject);
begin

   project_table_form.Stringgrid1.SelectedColor:=$00DE8800;

   // pocztakowe polozenie formy
   Project_table_form.Top:=Mainform.Height - Project_table_form.Height - 60;
   Project_table_form.left:=Mainform.width - Project_table_form.width - 35;

  if  IVM.StringGrid1.Visible = true then
    begin
      Project_table_form.left:= Project_table_form.left - IVM.StringGrid1.Width;
    end;

 // Loading project if selected
 if ParamStr(1) > '' then
   begin
   if FileExists(UTF8encode(ParamStr(1)))then
     begin
       OpenProject(True,UTF8encode(ParamStr(1)));
     end else begin Console.AddCommunicate(UTF8encode(ParamStr(1))+#13+com7 +#13'[Parameters ParamStr(1)]',true); end;
   end;

 {Project_table_form.ParentWindow:= Mainform.Panel1.Handle;
 Project_table_form.Left:=0;
 Project_table_form.Top:=0; }
end;

procedure Tproject_table_form.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure Tproject_table_form.FormShow(Sender: TObject);
begin
   project_table_form.BringToFront;
end;

procedure Tproject_table_form.MenuItem1Click(Sender: TObject);
begin
   SeparateGridByColumn(TstringGrid(ActiveGrid),NrColResidueName);
end;

procedure Tproject_table_form.MenuItem2Click(Sender: TObject);
begin
   SeparateGridByColumn(TstringGrid(ActiveGrid),NrColSequenceNr);
end;

procedure Tproject_table_form.SpeedButton11Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.SpeedButton2Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.SpeedButton3Click(Sender: TObject);
begin
  MainForm.SpeedButton3Click(Sender);
end;

procedure Tproject_table_form.SpeedButton5Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.StringGrid1Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.StringGrid1ColRowDeleted(Sender: TObject;
  IsColumn: Boolean; sIndex, tIndex: Integer);

begin

end;

procedure Tproject_table_form.StringGrid1DblClick(Sender: TObject);
Var
  input:string;
begin

  if projecttableXGrid = 4 then
   begin
      If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'PRO' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'DNA';
         exit;
       end;

       If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'DNA' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'LIG';
         exit;
       end;

       If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'LIG' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'COF';
         exit;
       end;

      If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'COF' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'HOH';
         exit;
       end;

       If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'HOH' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'ANA';
         exit;
       end;

        If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'ANA' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'PLA';
         exit;
       end;

       If Stringgrid1.Cells[projecttableXGrid,projecttableYGrid] = 'PLA' then
       begin
         Stringgrid1.Cells[projecttableXGrid,projecttableYGrid]:= 'PRO';
         exit;
       end;

   end;

  if projecttableXGrid = 6 then
   begin
     input:= InputBox('','',Project_Table_Form.StringGrid1.Cells[projecttableXGrid,projecttableYGrid]);

     input:= StringReplace(input,'|','',[rfReplaceAll]);

     Project_Table_Form.StringGrid1.Cells[projecttableXGrid,projecttableYGrid]:= input;
   end;
end;

procedure Tproject_table_form.StringGrid1DrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin

end;

procedure Tproject_table_form.StringGrid1EditingDone(Sender: TObject);
begin

end;

procedure Tproject_table_form.StringGrid1HeaderClick(Sender: TObject;
  IsColumn: Boolean; Index: Integer);
var
 i:integer;
 zaznaczone:boolean;
begin
zaznaczone:=false;
 { if (isColumn = true) and (index = 1) or (index = 2) then
   begin
    for i:= 1 to project_table_form.StringGrid1.RowCount-1 do
      begin
        If project_table_form.StringGrid1.Cells[2,i]='1' then
         begin
           zaznaczone:=true;
         end;
      end;
   if zaznaczone then
    begin
     for i:= 1 to project_table_form.StringGrid1.RowCount-1 do
       begin
         project_table_form.StringGrid1.Cells[index,i]:='0';
         CheckColumn(TstringGrid(MainForm.PageControl.Pages[i].Controls[0]),false,index); // project table form
         CheckColumnIf('Bonds',0,Form2.StringGrid, false, 0, 1,Project_table_form.StringGrid1.Cells[3,i],True); // bound table
       end;
    end
      else
    begin
     for i:= 1 to project_table_form.StringGrid1.RowCount-1 do
       begin
         project_table_form.StringGrid1.Cells[index,i]:='1';
         CheckColumn(TstringGrid(MainForm.PageControl.Pages[i].Controls[0]),true,index);
         CheckColumnIf('Bonds',0,Form2.StringGrid, false, 0, 1,Project_table_form.StringGrid1.Cells[3,i],True); // bound table
       end;
    end;
   end;   }
end;

procedure Tproject_table_form.StringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 32 then
   begin
      KeyP:= Key;
      StringGrid1MouseUp(Sender, mbLeft , Shift , projecttableXGrid, projecttableYGrid);
   end;
end;

procedure Tproject_table_form.StringGrid1KeyPress(Sender: TObject; var Key: char
  );
begin

end;

procedure Tproject_table_form.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure Tproject_table_form.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure Tproject_table_form.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure Tproject_table_form.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col,row:longint;
  zaznacz:boolean;
  zaznaczint:string;
begin
try

  if KeyP = 32 then // jesli spacja
   begin
     col:= x;
     row:= y;
   end else
   begin
      Stringgrid1.MouseToCell(x,y,col,row);
   end;

  if Stringgrid1.Cells[col,row] = '1' then
   begin
     zaznacz:=False;
     zaznaczint:='0';
   end else begin zaznacz:= True; zaznaczint:='1'; end;

  if Button = mbLeft then
   begin
     if (col = 1 ) and (row > 0) or (Col = 2) and (row > 0) then // klikniecie albo w vis albo w inc   // zaznacz in lub vis
      begin
         // project, col, value
         CheckProjectArrayColumn(Row-1,Col,zaznaczint);
         // unselect atoms
            ClearSelection(Row-1);
         //bonds
         CheckBondsArrayColumn(Row-1,Col,zaznaczint);
      end;
   end;

   WhatVisInc();

except
end;
end;

procedure Tproject_table_form.StringGrid1PickListSelect(Sender: TObject);
begin

end;

procedure Tproject_table_form.StringGrid1SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
Var
  x:integer;

begin

// sprawrdza co klikniete co nie np. czy C klikniete w vis i inc

 projecttablexGrid:=aCol; //x
 projecttableyGrid:=aRow; //y

end;

procedure Tproject_table_form.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin

end;

procedure Tproject_table_form.ToolBar1Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.ToolButton10Click(Sender: TObject);
begin
  if project_table_form.FormStyle = fsStayonTop then
  begin
     project_table_form.FormStyle:= fsNormal;
     ToolButton10.Down := false;
  end
   else
   begin
     project_table_form.FormStyle:= fsStayonTop;
     ToolButton10.Down := true;
   end;
end;

procedure Tproject_table_form.ToolButton11Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.ToolButton13Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.ToolButton14Click(Sender: TObject);
begin

end;

procedure Tproject_table_form.ToolButton15Click(Sender: TObject);

var
 i,b,row,col,temp,numer,temp_inc,ost:integer;
 connect,lista_numer:TstringList;

begin

  Form2.show;

end;

procedure Tproject_table_form.ToolButton16Click(Sender: TObject);
begin
  PDBEditor.Show;
end;

procedure Tproject_table_form.ToolButton17Click(Sender: TObject);
Var
 i:integer;
begin
  // pierwszy checkiniety
  i:=FirstCheckedRowNumber(Project_table_form.StringGrid1,2);

  If (i-1 > 0) then
   begin
      CheckColumn(Project_table_form.StringGrid1,False,2); // odznacz wszytskie
    //   CheckColumn(Form2.StringGrid, false, 0);    // wszytskie odnzacz wiazania
      Project_table_form.StringGrid1.Cells[2,i-1]:= '1';
    //    CheckColumnIf('Bonds',0,Form2.StringGrid, true, 0, 1,Project_table_form.StringGrid1.Cells[3,i-1],True); // bound table
   end
     else
   begin
      CheckColumn(Project_table_form.StringGrid1,False,2); // odznacz wszytskie
      Project_table_form.StringGrid1.Cells[2,Project_table_form.StringGrid1.RowCount-1]:= '1';

     // CheckColumn(Form2.StringGrid, false, 0);    // odznacz wszytskie wiazania
     // CheckColumnIf('Bonds',0,Form2.StringGrid, true, 0, 1,Project_table_form.StringGrid1.Cells[3,Project_table_form.StringGrid1.RowCount-1],True); // bound table

   end;
end;

procedure Tproject_table_form.ToolButton18Click(Sender: TObject);
Var
 i:integer;
begin
  // pierwszy checkiniety
  i:=FirstCheckedRowNumber(Project_table_form.StringGrid1,2);

  If (i > 0) and ( i+1 < Project_table_form.StringGrid1.RowCount) then
   begin
      CheckColumn(Project_table_form.StringGrid1,False, 2); // odznacz wszytskie gridy w table borm
    //  CheckColumn(Form2.StringGrid, false, 0);    // odznacz wszytskie wiazania
      Project_table_form.StringGrid1.Cells[2,i+1]:= '1'; // zaznacz table form wtbrana molekula
   //    CheckColumnIf('Bonds',0,Form2.StringGrid, true, 0, 1,Project_table_form.StringGrid1.Cells[3,i+1],True); // bound table
   end
     else
   begin
      Project_table_form.StringGrid1.Cells[2,Project_table_form.StringGrid1.RowCount-1]:= '0';
      Project_table_form.StringGrid1.Cells[2,1]:= '1';
    //  CheckColumn(Form2.StringGrid, false, 0);    // wiazania
    //  CheckColumnIf('Bonds',0,Form2.StringGrid, true, 0, 1,Project_table_form.StringGrid1.Cells[3,1],True); // bound table
   end;

end;

procedure Tproject_table_form.ToolButton19Click(Sender: TObject);
begin
  if (ToolButton19.Down = false) then
   begin
  if (MessageDlg(com32,com50, mtConfirmation,[mbYes, mbNo],0) = mrYes) then
    begin
      ToolButton19.Down:=true;
      project_table_form.ToolButton19.Down:=true;
    end
    end
      else
    begin
      ToolButton19.Down:=true;
      project_table_form.ToolButton19.Down:=true;
    end;
end;

procedure Tproject_table_form.ToolButton1Click(Sender: TObject);
begin
   MainForm.Nowyprojekt1Click(Sender);
end;

procedure Tproject_table_form.ToolButton20Click(Sender: TObject);
var
  fraza:string;
begin

  TstringGrid(activeGrid).Repaint; // znika stare zaznaczenie

  fraza:= inputBox(com22,com99,'');

  if fraza > '' then
   begin
     FindFraseInGrid(TStringGrid(activeGrid),fraza);
   end;
end;

procedure Tproject_table_form.ToolButton21Click(Sender: TObject);
begin
  // split by
end;

procedure Tproject_table_form.ToolButton22Click(Sender: TObject);
begin
  RenumberAtoms();
end;

procedure Tproject_table_form.ToolButton23Click(Sender: TObject);
Var
 i:integer;
begin
 {for i:= 0 to StringGrid1.RowCount -1 do
  begin
 if StringGrid1.Cells[2,i] = '1' then
  begin

  AddRecordToPtojectTable('1','1','Duplicate:'+Stringgrid1.Cells[3,i],
        Stringgrid1.Cells[4,i],Stringgrid1.Cells[5,i],'','','');

 if  DuplicateGrid('Duplicate:'+Stringgrid1.Cells[3,i],
                  TstringGrid(MainForm.PageControl.Pages[i].Controls[0]))
  then
   begin
     Console.AddCommunicate('Duplicate:'+Stringgrid1.Cells[3,i]);
   end;
  end;
  end;}
end;

procedure Tproject_table_form.ToolButton2Click(Sender: TObject);
begin
   MainForm.MenuItem22Click(Sender);
end;

procedure Tproject_table_form.ToolButton3Click(Sender: TObject);
begin
   MainForm.MenuItem10Click(Sender);
end;

procedure Tproject_table_form.ToolButton6Click(Sender: TObject);
begin

end;


initialization
  {$I unit14.lrs}

end.

