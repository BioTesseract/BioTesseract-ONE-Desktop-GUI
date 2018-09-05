(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit19;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Grids, ExtCtrls, Buttons, Spin, PairSplitter, StdCtrls, Biblioteka_Grow_4;

type

  { TForm17 }

  TForm17 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    FloatSpinEdit1: TFloatSpinEdit;
    Label1: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form17: TForm17; 

implementation
Uses
 Unit14,Unit1;

{ TForm17 }

procedure TForm17.BitBtn1Click(Sender: TObject);
var
 col,row:integer;
 Obs,Pred:TstringList;
begin
// blokuj przycisk
BitBtn1.Enabled:=false;

  Stringgrid2.RowCount:=1;
  Stringgrid2.ColCount:=Stringgrid1.ColCount;
  Stringgrid2.FixedCols:=1;
 // width pierwszej
  Stringgrid1.ColWidths[0]:=130;
  Stringgrid2.ColWidths[0]:=130;

  Obs:=TstringList.Create;
  Pred:=TstringList.Create;

  Obs.Clear;
  // pierwsza koluna zaiwera obserwacje , jak fixed to zaczynaj od nastepnej
  For row:=Stringgrid1.FixedRows to StringGrid1.RowCount -1 do
    begin
      Obs.Add(StringGrid1.Cells[StringGrid1.FixedCols,row]);
    end;

  // StringGrid1.FixedCols+1 <- zacznij od 2 bo pierwsza obserwacje
  Stringgrid2.RowCount:= Stringgrid2.RowCount+6;   // dodaj tyle wierszy ile jest wyliczen

  For col:=StringGrid1.FixedCols+1 to stringgrid2.ColCount -1 do
   begin
     Pred.Clear;
        For row:=Stringgrid1.FixedRows to StringGrid1.RowCount -1 do
         begin
           Pred.Add(Stringgrid1.Cells[col,row]);
         end;
      // numer komponentow
       Stringgrid2.Cells[0,0]:= com123;
       Stringgrid2.Cells[1,0]:= com122 + CurrtoStr(FloatSpinEdit1.Value);
       Stringgrid2.Cells[col,0]:= IntToStr(CoA_NumberOfCompounds(Obs,Pred,FloatSpinEdit1.Value));

      // CoA - podzielone srednia
       Stringgrid2.Cells[0,1]:= com124;
       Stringgrid2.Cells[1,1]:= com122 + CurrtoStr(FloatSpinEdit1.Value);
       Stringgrid2.Cells[col,1]:= CurrToStr(CoA(Obs,Pred,FloatSpinEdit1.Value));

       // CoA - procent
       Stringgrid2.Cells[0,2]:= com125;
       Stringgrid2.Cells[1,2]:= com122 + CurrtoStr(FloatSpinEdit1.Value);
       Stringgrid2.Cells[col,2]:= CurrToStr(CoA_percent(Obs,Pred,FloatSpinEdit1.Value)) + '%';

       // aCoA - default settings
       Stringgrid2.Cells[0,3]:= com126;
       Stringgrid2.Cells[1,3]:= '-';
       Stringgrid2.Cells[col,3]:= CurrToStr(aCoA(Obs,Pred));

       // CoA 50%
       Stringgrid2.Cells[0,4]:= com127;
       Stringgrid2.Cells[1,4]:= '-';
       Stringgrid2.Cells[col,4]:= CurrToStr(CoA_percent_N(Obs,Pred,50));

       // CoA 100%
       Stringgrid2.Cells[0,5]:= com128;
       Stringgrid2.Cells[1,5]:= '-';
       Stringgrid2.Cells[col,5]:= CurrToStr(CoA_percent_N(Obs,Pred,100));

       // Q2 QSAR
       Stringgrid2.Cells[0,6]:= com129;
       Stringgrid2.Cells[1,6]:= '-';
       Stringgrid2.Cells[col,6]:= CurrToStr(Q2_QSAR(Obs,Pred));

   end;
BitBtn1.Enabled:=true;
end;

procedure TForm17.BitBtn2Click(Sender: TObject);
begin
   ImportCSV(StringGrid1);
end;

procedure TForm17.SpeedButton4Click(Sender: TObject);
begin
  if Stringgrid1.LeftCol +1 <= stringgrid1.ColCount -1 then
   begin
     Stringgrid1.LeftCol:=Stringgrid1.LeftCol +1 ;
     Stringgrid2.LeftCol:=Stringgrid1.LeftCol;
   end;
end;

procedure TForm17.SpeedButton5Click(Sender: TObject);
begin
  if Stringgrid1.LeftCol -1 >= 0 then
   begin
     Stringgrid1.LeftCol:=Stringgrid1.LeftCol -1 ;
     Stringgrid2.LeftCol:=Stringgrid1.LeftCol;
   end;
end;

initialization
  {$I unit19.lrs}

end.

