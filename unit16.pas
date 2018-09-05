(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit16;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, Buttons, Grids, ExtCtrls, Biblioteka_Grow_4, Biblioteka_Grow_4_grafika,
  types, General_dll;

type

  { TForm14 }

  TForm14 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox3: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Apply_Functions();
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure CheckBox7Change(Sender: TObject);
    procedure CheckBox8Change(Sender: TObject);
    procedure CheckGroup1Click(Sender: TObject);
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure ComboBox4Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form14: TForm14; 

implementation

uses
  Unit1, Unit4, Unit14, Unit12, Unit20;

{ TForm14 }

// rekurencja
procedure TForm14.Button1Click(Sender: TObject);
Var
 range:integer;
begin
{If Combobox2.ItemIndex = Combobox3.ItemIndex then
 begin
   Apply_Functions();
 end else
 begin
  For range:= Combobox2.ItemIndex to Combobox3.ItemIndex - Combobox2.ItemIndex do
   begin
     MainForm.PageControl.ActivePageIndex:= range + 1;
     ActiveGrid:=  MainForm.PageControl.ActivePage.Controls[0];
     Apply_Functions();
   end;
 end;
 MainForm.PageControl.ActivePageIndex:= Combobox2.ItemIndex + 1;
 ActiveGrid:=  MainForm.PageControl.ActivePage.Controls[0];   }
end;

procedure TForm14.Apply_Functions();
Var
 i,od,doo:integer;
 fraza:string;
begin
 { fraza:= Edit1.Text;


if CheckGroup1.Checked[0] then  // option include
 begin
  od:= pos('-',fraza)-1;
  doo:=  pos('>',fraza)+1;
  // jesli = 1->4 to zaznacz wartosci od 1 do 4 mozna zapsiać warunek tam
  If od + doo > 0 then
   begin
     for i:=StrToIntDef(Copy(fraza,0,od),0) to StrToIntDef(Copy(fraza,doo,Length(fraza)),0) do
      begin
        //Inc-2
        CheckColumnIf('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(ActiveGrid),CheckGroup1.Checked[0],2,combobox1.ItemIndex+3,Inttostr(i),checkbox3.Checked);
      end;
   end
     else
   begin
     //Inc-2
     CheckColumnIf('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(ActiveGrid),CheckGroup1.Checked[0],2,combobox1.ItemIndex+3,fraza,checkbox3.Checked);
   end;
 end;

 if CheckGroup1.Checked[1] then   // excludowanie wylaczenie
 begin
  od:= pos('-',fraza)-1;
  doo:=  pos('>',fraza)+1;
  // jesli = 1->4 to zaznacz wartosci od 1 do 4 mozna zapsiać warunek tam
  If od + doo > 0 then
   begin
     for i:=StrToIntDef(Copy(fraza,0,od),0) to StrToIntDef(Copy(fraza,doo,Length(fraza)),0) do
      begin
        //Inc-2
        CheckColumnIf('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(ActiveGrid),False,2,combobox1.ItemIndex+3,Inttostr(i),checkbox3.Checked);
      end;
   end
     else
   begin
     //Inc-2
     CheckColumnIf('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(ActiveGrid),False,2,combobox1.ItemIndex+3,fraza,checkbox3.Checked);
   end;
 end;

 if CheckGroup1.Checked[2] then // fill column
  begin
    FillSectionAs('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(ActiveGrid),ComboBox1.ItemIndex+3,fraza);
  end;

 // sortowanie

 if CheckGroup1.Checked[4] then
   begin
     TstringGrid(ActiveGrid).SortColRow(true,Combobox1.ItemIndex+3);
   end;

 // usuwanie
 if CheckGroup1.Checked[5] then
   begin
     DeleteIncRecordsFromGrid(TstringGrid(ActiveGrid),NrColInc,False);
   end;

  if CheckGroup1.Checked[6] then
   begin
     InvertSelectionIncRecordsFromGrid(TstringGrid(ActiveGrid),NrColInc);
   end;

 WhatVisInc(); }
end;

procedure TForm14.Button2Click(Sender: TObject);
Var
 x,y,z:Currency;

begin
  x:= StrToCurr(TstringGrid(activeGrid).Cells[NrColx,Combobox5.ItemIndex+1]);
  y:= StrToCurr(TstringGrid(activeGrid).Cells[NrColy,Combobox5.ItemIndex+1]);
  z:= StrToCurr(TstringGrid(activeGrid).Cells[NrColz,Combobox5.ItemIndex+1]);

  if MessageDlg(com117+' ['+CurrToStr(x)+','+CurrToStr(y)+','+CurrToStr(z)+'] => [0,0,0]',
                mtConfirmation, mbYesNo, 0) = mrYes
  then
   begin
     MoveCoordinateSystemTo(x,y,z);
   end;

 // MainForm.PageControl.ActivePageIndex:= Combobox4.ItemIndex + 1;
end;

procedure TForm14.Button3Click(Sender: TObject);
begin
 MoveCoordinateSystemToAvarageCenter();
 g4g_center:=true;
end;

procedure TForm14.Button4Click(Sender: TObject);
 Var
  XYZ:TstringList;
begin
  XYZ:= TstringList.Create;

  AverageCooridnatesOfVisibleMolecules(XYZ,true);

  Label4.Caption:= '('+XYZ[0]+','+XYZ[1]+','+XYZ[2]+')';

  XYZ.Free;
end;

procedure TForm14.CheckBox2Change(Sender: TObject);
begin
   Edit1.Enabled:=True;
end;

procedure TForm14.CheckBox4Change(Sender: TObject);
begin
   Edit1.Enabled:=True;
end;

procedure TForm14.CheckBox5Change(Sender: TObject);
begin
   Edit1.Enabled:=True;
end;

procedure TForm14.CheckBox6Change(Sender: TObject);
begin
   Edit1.Enabled:=True;
end;

procedure TForm14.CheckBox7Change(Sender: TObject);
begin
   Edit1.Visible:=false;
end;

procedure TForm14.CheckBox8Change(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm14.CheckGroup1Click(Sender: TObject);
begin

end;

procedure TForm14.CheckGroup1ItemClick(Sender: TObject; Index: integer);
begin
   if CheckGroup1.Checked[4] = true then
    begin
      Statictext3.Visible:=false;
      Edit1.Visible:=false;
   end;

    if CheckGroup1.Checked[4] = false then
    begin
      Statictext3.Visible:=true;
      Edit1.Visible:=true;
   end;
end;

procedure TForm14.ComboBox4Change(Sender: TObject);
 var
  i:integer;
begin
{MainForm.PageControl.ActivePageIndex:= Combobox4.ItemIndex + 1;
Combobox5.Items.Clear;

  for i:=1 to TstringGrid(activeGrid).RowCount -1 do
   begin
      Combobox5.Items.Add(Tstringgrid(activeGrid).Cells[3,i]+'('+Tstringgrid(activeGrid).Cells[4,i]+')');
   end;
 combobox5.ItemIndex:=0; }
end;

procedure TForm14.Edit1Change(Sender: TObject);
begin

end;

procedure TForm14.FormCreate(Sender: TObject);
begin

end;

procedure TForm14.FormShow(Sender: TObject);
Var
 i:integer;
begin
{
  Combobox2.Items.Clear;
  Combobox3.Items.Clear;
  combobox4.Items.Clear;
  combobox6.Items.Clear;
  combobox7.Items.Clear;


  For i:=1 to project_table_form.StringGrid1.RowCount-1 do
   begin
     Combobox2.Items.Add(project_table_form.StringGrid1.Cells[3,i]);
     Combobox3.Items.Add(project_table_form.StringGrid1.Cells[3,i]);
     Combobox4.Items.Add(project_table_form.StringGrid1.Cells[3,i]);
     Combobox6.Items.Add(project_table_form.StringGrid1.Cells[3,i]);
     Combobox7.Items.Add(project_table_form.StringGrid1.Cells[3,i]);
   end;

 Combobox2.ItemIndex:= Mainform.PageControl.ActivePageIndex-1;
 Combobox3.ItemIndex:= Mainform.PageControl.ActivePageIndex-1;
 Combobox4.ItemIndex:= Mainform.PageControl.ActivePageIndex-1;
 Combobox6.ItemIndex:= Mainform.PageControl.ActivePageIndex-1;
 Combobox7.ItemIndex:= Mainform.PageControl.ActivePageIndex-1;
   }

end;

procedure TForm14.GroupBox2Click(Sender: TObject);
begin

end;

procedure TForm14.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm14.SpeedButton10Click(Sender: TObject);
begin
 if Speedbutton10.Flat = true then
   begin
  //   project_table_form.StringGrid1.Cells[2,MainForm.PageControl.ActivePageIndex]:= '1';
     GlobalCheckColumnIf(False,2,16,'P',False);
  //   GlobalCheckColumnIf(False,2,NrColAtomName,'P',True);
     Speedbutton10.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'P',False);
  //  GlobalCheckColumnIf(True,2,NrColAtomName,'P',True);
    Speedbutton10.Flat:= true;
   end;

WhatVisInc();
end;

procedure TForm14.SpeedButton11Click(Sender: TObject);
begin
if Speedbutton11.Flat = true then
   begin
     GlobalCheckColumnIf(False,2,16,'CL',True);
     GlobalCheckColumnIf(False,2,16,'Cl',True);
   //  GlobalCheckColumnIf(False,2,NrColAtomName,'CL',True);
     Speedbutton11.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'CL',True);
    GlobalCheckColumnIf(True,2,16,'Cl',True);
  //  GlobalCheckColumnIf(True,2,NrColAtomName,'CL',True);
    Speedbutton11.Flat:= true;
   end;

WhatVisInc();
end;

procedure TForm14.SpeedButton17Click(Sender: TObject);
begin

end;

procedure TForm14.SpeedButton1Click(Sender: TObject);
var
  i:integer;

begin
 {if MessageDlg (com22,com152, mtConfirmation,[mbYes, mbNo, mbCancel],0) = mrYes then
  begin
   for i:=1 to project_table_form.stringgrid1.rowcount -1 do
    begin

      ConvertAtomNmeToAtomSymbol(TstringGrid(Tstringgrid(Mainform.PageControl.Pages[i].Controls[0])));

    end;

  end else begin ConvertAtomNmeToAtomSymbol(TstringGrid(ActiveGrid)); end;  }
end;

procedure TForm14.SpeedButton29Click(Sender: TObject);
begin

end;

procedure TForm14.SpeedButton2Click(Sender: TObject);
var
  i,row:integer;
  grid:Tstringgrid;
begin
 {if MessageDlg (com22,com152, mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
   for i:=1 to project_table_form.stringgrid1.rowcount -1 do
    begin
      Grid:= Tstringgrid(Mainform.PageControl.Pages[i].Controls[0]);
      for row:=1 to Grid.RowCount -1 do
       begin
         Grid.Cells[NrColAtomName,row]:= ClearAtomName(Grid.Cells[NrColAtomName,row]);
       end;
    end;
  end;  }
end;

procedure TForm14.SpeedButton3Click(Sender: TObject);
var
  i,ac:integer;
begin
{ac:= MainForm.PageControl.ActivePageIndex;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do
   begin
     MainForm.PageControl.ActivePageIndex:= i;
     project_table_form.StringGrid1.Cells[3,i]:= TstringGrid(activeGrid).Cells[NrColResidueName,1];
   end;

 MainForm.PageControl.ActivePageIndex:= ac; }
end;

procedure TForm14.SpeedButton4Click(Sender: TObject);
Var
  ColNrFrazy,Frazy:TstringList;
  Frase,ColNumber,checked:string;
  proj_number:integer;
begin
    ColNrFrazy:=TstringList.Create;
    Frazy:=TstringList.Create;



  //   if Speedbutton4.Flat = true then
  //    begin
        checked:='0';
     {   Speedbutton4.Flat:=false;
        IVM.ToolButton11.ImageIndex:=15;
      end else
      begin
        checked:='1';
        Speedbutton4.Flat:=true;
        IVM.ToolButton11.ImageIndex:=12;
      end;   }

// project


   ColNrFrazy.Add(inttostr(NrColElementSymbol));  Frazy.Add('H');


    for proj_number:=1 to Project_table_form.StringGrid1.RowCount-1 do
     begin
        CheckProjectColumnIf(proj_number-1,ColNrFrazy,Frazy,true,NrColInc,checked);
     end;

        ColNrFrazy.Clear;
        Frazy.Clear;

// bonds
   // (1)

   ColNrFrazy.Add(inttostr(NrColBonds_FirstElementSymbol));  Frazy.Add('H');

   for proj_number:=1 to Project_table_form.StringGrid1.RowCount-1 do
     begin
        CheckBondsColumnIf(proj_number-1,ColNrFrazy,Frazy,true,NrColBonds_Inc,checked);
     end;

   // (2)

   ColNrFrazy.Clear;
   Frazy.Clear;

   ColNrFrazy.Add(inttostr(NrColBonds_SecondElementSymbol));  Frazy.Add('H');

    for proj_number:=1 to Project_table_form.StringGrid1.RowCount-1 do
     begin
        CheckBondsColumnIf(proj_number-1,ColNrFrazy,Frazy,true,NrColBonds_Inc,checked);
     end;


   WhatVisInc();

  ColNrFrazy.Free;
  Frazy.Free;
end;


procedure TForm14.SpeedButton5Click(Sender: TObject);
Var
  i, min,column:integer;
  gridA,gridB:TstringGrid;
begin
 {
  GridA:= TstringGrid(Mainform.PageControl.Pages[combobox6.ItemIndex+1].Controls[0]);
  GridB:= TstringGrid(Mainform.PageControl.Pages[combobox7.ItemIndex+1].Controls[0]);

  column:= StrToInt(inputbox('wartosc','',''));

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Combobox6.Text+', row count: '+inttostr(GridA.RowCount));
  Memo1.Lines.Add(Combobox7.Text+', row count: '+inttostr(GridB.RowCount));

  if GridA.RowCount <> GridB.RowCount then
    begin
      If GridA.RowCount > GridB.RowCount then
        begin
          min:= GridB.RowCount;
        end else begin min:= GridA.RowCount; end;
    end else begin min:= GridA.RowCount; end;

  For i:= 1 to min -1 do
   begin
     If GridA.Cells[column,i] <> GridB.Cells[column,i] then
       begin
         Memo1.Lines.Add('Records number '+inttostr(i)+' are different: '+ GridA.Cells[column,i]+' <> '+GridB.Cells[column,i]+' Atom ID: '+GridA.Cells[NrColAtomId,i]+' ('+GridA.Cells[NrColAtomName,i]+') and '+GridB.Cells[NrColAtomId,i]+' ('+GridB.Cells[NrColAtomName,i]+')');
       end;
   end;   }
end;

procedure TForm14.SpeedButton6Click(Sender: TObject);
begin
   if Speedbutton6.Flat = true then
   begin
  //   project_table_form.StringGrid1.Cells[2,MainForm.Pagecontrol.ActivePageIndex]:= '1';
     GlobalCheckColumnIf(False,2,16,'C',True);

     Speedbutton6.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'C',True);

    Speedbutton6.Flat:= true;
   end;

WhatVisInc();
end;

procedure TForm14.SpeedButton7Click(Sender: TObject);
begin
  if Speedbutton7.Flat = true then
   begin
   //  project_table_form.StringGrid1.Cells[2,MainForm.Pagecontrol.ActivePageIndex]:= '1';
     GlobalCheckColumnIf(False,2,16,'O',False);
  //   GlobalCheckColumnIf(False,2,NrColAtomName,'O',True);
     Speedbutton7.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'O',False);
  //  GlobalCheckColumnIf(True,2,NrColAtomName,'O',True);
    Speedbutton7.Flat:= true;
   end;

WhatVisInc();
end;

procedure TForm14.SpeedButton8Click(Sender: TObject);
begin
  if Speedbutton8.Flat = true then
   begin
  //   project_table_form.StringGrid1.Cells[2,MainForm.Pagecontrol.ActivePageIndex]:= '1';
     GlobalCheckColumnIf(False,2,16,'N',False);
  //   GlobalCheckColumnIf(False,2,NrColAtomName,'N',True);
     Speedbutton8.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'N',False);
  //  GlobalCheckColumnIf(True,2,NrColAtomName,'N',True);
    Speedbutton8.Flat:= true;
   end;

 WhatVisInc();
end;

procedure TForm14.SpeedButton9Click(Sender: TObject);
begin
  if Speedbutton9.Flat = true then
   begin
  //   project_table_form.StringGrid1.Cells[2,MainForm.Pagecontrol.ActivePageIndex]:= '1';
     GlobalCheckColumnIf(False,2,16,'S',False);
 //    GlobalCheckColumnIf(False,2,NrColAtomName,'S',True);
     Speedbutton9.Flat:=false;
   end else begin
    GlobalCheckColumnIf(True,2,16,'S',False);
 //   GlobalCheckColumnIf(True,2,NrColAtomName,'S',True);
    Speedbutton9.Flat:= true;
   end;

 WhatVisInc();
end;

procedure TForm14.TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;


initialization
  {$I unit16.lrs}

end.

