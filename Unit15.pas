(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit15;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls, Grids, Menus, Clipbrd, ComCtrls, Math, Biblioteka_Grow_4;

type

  { TForm13 }

  TForm13 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox6Change(Sender: TObject);
    procedure CheckBox6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox7Change(Sender: TObject);
    procedure CheckBox7KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure CheckBox8Change(Sender: TObject);
    procedure CheckBox8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure CheckBox9Change(Sender: TObject);
    procedure CheckBox9KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form13: TForm13; 

implementation

Uses
 Unit14,Unit2,Unit1,Unit9,Unit22;

{ TForm13 }

procedure TForm13.SpeedButton1Click(Sender: TObject);
 var
  i,visIncColNumber,col,row:integer;
  listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
  temp:string;
begin
{
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows

  visIncColNumber:=2;

  listaVisInc := TstringList.Create;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do
   begin
     if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
      begin
        listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

        Stringgrid1.ColCount:= 1+ listaVisInc.Count;
        Stringgrid1.FixedCols:= 1;   // cols

        Stringgrid1.RowCount:= 1+ listaVisInc.Count;
        stringgrid1.FixedRows:= 1;    // rows

        // nazwy kolumn
        StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
        // nazwy rowsow
        StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
      end;
   end;

  // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

  if listaVisInc.Count > 0 then
   begin

     x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
     x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

     for col:=0 to listaVisInc.Count -1 do
      begin
         for row:=0 to listaVisInc.Count -1 do               // sprawdzic jak wyglada lista !!!!
          begin
           if checkbox3.Checked = True then // every atoms
            begin
            if col = row then
             begin             // wewnwtrzyn aAPA
                x1.Clear;
                x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
                x1.Delete(0); // usuniecie naglowka

                y1.Clear;
                y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
                y1.Delete(0);

                z1.Clear;
                z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
                z1.Delete(0);

                // --->
                // przepisanie pierwszego na koniec i usuniecie z pocztaku

                x2.Clear;
                x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
                x2.Delete(0); // usuniecie naglowka
                x2.Add(x2[0]);
                x2.Delete(0);


                y2.Clear; // przepisanie pierwszego atomu na ostatnią pozycję
                y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
                y2.Delete(0);
                y2.Add(y2[0]);
                y2.Delete(0);

                z2.Clear;
                z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
                z2.Delete(0);
                z2.Add(z2[0]);
                z2.Delete(0);

                StringGrid1.Cells[Col+1,Row+1]:= aAnglePlainAnalysis(x1,y1,z1,x2,y2,z2,true);

             end
              else
             begin //  clear lists
                x1.Clear;
                x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
                x1.Delete(0); // usuniecie naglowka

                y1.Clear;
                y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
                y1.Delete(0);

                z1.Clear;
                z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
                z1.Delete(0);
                // --->

                x2.Clear;
                x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
                x2.Delete(0); // usuniecie naglowka

                y2.Clear;
                y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
                y2.Delete(0);

                z2.Clear;
                z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
                z2.Delete(0);

                try
                  StringGrid1.Cells[Col+1,Row+1]:= aAnglePlainAnalysis(x1,y1,z1,x2,y2,z2,true);
                except
                  StringGrid1.Cells[Col+1,Row+1]:= com80 ;
                end;
             end;
            end;
           if checkbox2.Checked = True then
            begin
            if col = row then
             begin             // wewnwtrzyn aAPA
                // lista x1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

                // lista y1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

                // lista z1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

                // --->
                // przepisanie pierwszego na koniec i usuniecie z pocztaku

                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);
                x2.Add(x2[0]);
                x2.Delete(0);

                // przepisanie pierwszego atomu na ostatnią pozycję
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);
                y2.Add(y2[0]);
                y2.Delete(0);

                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);
                z2.Add(z2[0]);
                z2.Delete(0);

                StringGrid1.Cells[Col+1,Row+1]:= aAnglePlainAnalysis(x1,y1,z1,x2,y2,z2,true);

             end
              else
             begin

                // lista X1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

                // lista Y1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

                // lista Z1
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

                // --->
                // lista X2
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);

                // lista Y2
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);

                // lista Z2
                GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);

                try
                  StringGrid1.Cells[Col+1,Row+1]:= aAnglePlainAnalysis(x1,y1,z1,x2,y2,z2,true);
                except
                  StringGrid1.Cells[Col+1,Row+1]:= com80 ;
                end;
             end;
            end
          end;
      end;

      x1.Free; y1.Free; z1.Free;
      x2.Free; y2.Free; z2.Free;
      listaVisInc.Free;

   end
    else begin Form1.ShowCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='APA';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
  }
end;

procedure TForm13.SpeedButton2Click(Sender: TObject);
 var
  i,visIncColNumber,col,row,a:integer;
  listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
  temp:string;
begin                                                        // dodać rangi ilosc + oraz suma odelglosci
{                                                             // suma minusum wi odleglosci minusowych przesyniec
Stringgrid1.ColCount:= 0;                                    // ktora wieksza tam zachodzi srednie pzrsyniecie
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows

  visIncColNumber:=2;

  listaVisInc := TstringList.Create;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do
   begin
     if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
      begin
        listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

        Stringgrid1.ColCount:= 1+ listaVisInc.Count;
        Stringgrid1.FixedCols:= 1;   // cols

        Stringgrid1.RowCount:= 1+ listaVisInc.Count;
        stringgrid1.FixedRows:= 1;    // rows

        // nazwy kolumn
        StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
        // nazwy rowsow
        StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
      end;
   end;

  // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

  if listaVisInc.Count > 0 then
   begin

     x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
     x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

     for col:=0 to listaVisInc.Count -1 do
      begin
         for row:=0 to listaVisInc.Count -1 do
          begin
            if col = row then
             begin
               StringGrid1.Cells[Col+1,Row+1]:='0';
             end
              else
             begin //  clear lists
              // jesli every atoms
      if  checkbox3.Checked then
          begin
                x1.Clear;
                x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
                x1.Delete(0); // usuniecie naglowka

                y1.Clear;
                y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
                y1.Delete(0);

                z1.Clear;
                z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
                z1.Delete(0);
                // --->

                x2.Clear;
                x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
                x2.Delete(0); // usuniecie naglowka

                y2.Clear;
                y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
                y2.Delete(0);

                z2.Clear;
                z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
                z2.Delete(0);

          end;

  // dodaj tylko zaznaczone
  if checkbox2.Checked then
      begin
        for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[2,a] = '1' then
             begin
                x1.Clear; y1.Clear; z1.Clear;
                x1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColx,a]);
                y1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColy,a]);
                z1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColz,a]);
             end;
          end;

       for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[2,a] = '1' then
             begin
                x2.Clear; y2.Clear; z2.Clear;
                x2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColx,a]);
                y2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColy,a]);
                z2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColz,a]);
             end;
          end;
       end;

            // policz CoordinatesListToaDVSAM

       if (x1.Count = x2.Count) and (y1.Count = y2.Count)  and (z1.Count = z2.Count)  then
         begin
             try
                  StringGrid1.Cells[Col+1,Row+1]:= CoordinatesListToaDVSAM(x1,y1,z1,x2,y2,z2,true);
                except
                  StringGrid1.Cells[Col+1,Row+1]:= com80 ;
                end;
         end else begin Form1.ShowCommunicate(com112+inttostr(x1.Count)+','+inttostr(x2.Count)+'['+inttostr(col)+','+inttostr(row)+']'); end;

             end;
          end;
      end;

      x1.Free; y1.Free; z1.Free;
      x2.Free; y2.Free; z2.Free;
      listaVisInc.Free;
   end
    else begin Form1.ShowCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='DVSAM';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
 }
end;

procedure TForm13.SpeedButton3Click(Sender: TObject);
Var
  i,row:integer;
  Lista:Tstrings;
  res_odst:string;
begin
 { Lista:= TstringList.create;
try
  begin
 if (StringGrid1.RowCount > 1) and (StringGrid1.Cells[0,0]='APA') and (Stringgrid1.RowCount = StringGrid1.ColCount) then
   begin

  For row:=0 to StringGrid1.RowCount - 2 do
   begin
     lista.Clear;
    For i:=1 to StringGrid1.RowCount - row -1 do
      begin
         Lista.add(Copy(StringGrid1.Cells[i,i],3,(length(StringGrid1.Cells[i,i]))));
      end;
      res_odst:= res_odst + 'Diagonal N='+IntToStr(row)+'; Sigma aAPA value = ' + odchylenie_standardowe(Lista)+#10#13;
    end;

    Showmessage(res_odst);

   end
     else begin showmessage(com140); end;
  end;
except
    Form1.ShowCommunicate(com138+' sigma aAPA [1]');
  end;
 Lista.free;  }
end;

procedure TForm13.SpeedButton4Click(Sender: TObject);  // http://en.wikipedia.org/wiki/Root-mean-square_deviation_%28bioinformatics%29
var
  i,visIncColNumber,col,row,a:integer;
  listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
  temp:string;
begin
  {
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows


  visIncColNumber:=2;

  listaVisInc := TstringList.Create;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do
   begin
     if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
      begin
        listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

        Stringgrid1.ColCount:= 1+ listaVisInc.Count;
        Stringgrid1.FixedCols:= 1;   // cols

        Stringgrid1.RowCount:= 1+ listaVisInc.Count;
        stringgrid1.FixedRows:= 1;    // rows

        // nazwy kolumn
        StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
        // nazwy rowsow
        StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
      end;
   end;

  // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

  if listaVisInc.Count > 0 then
   begin

     x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
     x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

     for col:=0 to listaVisInc.Count -1 do
      begin
         for row:=0 to listaVisInc.Count -1 do
          begin
            if col = row then
             begin
               StringGrid1.Cells[Col+1,Row+1]:='0';
             end
              else
             begin //  clear lists
         // jesli every atoms
      if  checkbox3.Checked then
          begin
                x1.Clear;
                x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
                x1.Delete(0); // usuniecie naglowka

                y1.Clear;
                y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
                y1.Delete(0);

                z1.Clear;
                z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
                z1.Delete(0);
                // --->

                x2.Clear;
                x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
                x2.Delete(0); // usuniecie naglowka

                y2.Clear;
                y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
                y2.Delete(0);

                z2.Clear;
                z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
                z2.Delete(0);

          end;

  // dodaj tylko zaznaczone
  if checkbox2.Checked then
      begin
        for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[2,a] = '1' then
             begin
                x1.Clear; y1.Clear; z1.Clear;
                x1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColx,a]);
                y1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColy,a]);
                z1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColz,a]);
             end;
          end;

       for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[2,a] = '1' then
             begin
                x2.Clear; y2.Clear; z2.Clear;
                x2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColx,a]);
                y2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColy,a]);
                z2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColz,a]);
             end;
          end;
       end;

            // policz rmsd

       if (x1.Count = x2.Count) and (y1.Count = y2.Count)  and (z1.Count = z2.Count)  then
         begin
             try
                  StringGrid1.Cells[Col+1,Row+1]:= RMSD(x1,y1,z1,x2,y2,z2, true);
                except
                  StringGrid1.Cells[Col+1,Row+1]:= com80 ;
                end;
         end else begin Form1.ShowCommunicate(com112+inttostr(x1.Count)+','+inttostr(x2.Count)+'['+inttostr(col)+','+inttostr(row)+']'); end;
             end;
          end;
      end;

      x1.Free; y1.Free; z1.Free;
      x2.Free; y2.Free; z2.Free;
      listaVisInc.Free;
   end
    else begin Form1.ShowCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='RMSD';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;   }
end;

procedure TForm13.SpeedButton5Click(Sender: TObject);
var
  i,visIncColNumber,col,row,a:integer;
  listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
  temp:string;
begin
  {
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows


  visIncColNumber:=2;

  listaVisInc := TstringList.Create;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do
   begin
     if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
      begin
        listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

        Stringgrid1.ColCount:= 1+ listaVisInc.Count;
        Stringgrid1.FixedCols:= 1;   // cols

        Stringgrid1.RowCount:= 1+ listaVisInc.Count;
        stringgrid1.FixedRows:= 1;    // rows

        // nazwy kolumn
        StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
        // nazwy rowsow
        StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
      end;
   end;

  // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

  if listaVisInc.Count > 0 then
   begin

     x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
     x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

     for col:=0 to listaVisInc.Count -1 do
      begin
         for row:=0 to listaVisInc.Count -1 do
          begin
            if col = row then
             begin
               StringGrid1.Cells[Col+1,Row+1]:='0';
             end
              else
             begin //  clear lists
          // jesli every atoms
      if  checkbox3.Checked then
          begin
                x1.Clear;
                x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
                x1.Delete(0); // usuniecie naglowka

                y1.Clear;
                y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
                y1.Delete(0);

                z1.Clear;
                z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
                z1.Delete(0);
                // --->

                x2.Clear;
                x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
                x2.Delete(0); // usuniecie naglowka

                y2.Clear;
                y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
                y2.Delete(0);

                z2.Clear;
                z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
                z2.Delete(0);

          end;

        // dodaj tylko zaznaczone
  if checkbox2.Checked then
      begin
          for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[2,a] = '1' then
             begin
                x1.Clear; y1.Clear; z1.Clear;
                x1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColx,a]);
                y1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColy,a]);
                z1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cells[NrColz,a]);
             end;
          end;

       for a:= 1 to TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).RowCount -1 do
          begin
            if TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[2,a] = '1' then
             begin
                x2.Clear; y2.Clear; z2.Clear;
                x2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColx,a]);
                y2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColy,a]);
                z2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cells[NrColz,a]);
             end;
          end;
       end;
         if (x1.Count = x2.Count) and (y1.Count = y2.Count)  and (z1.Count = z2.Count)  then
         begin
             try
                  StringGrid1.Cells[Col+1,Row+1]:= RMSDArM(x1,y1,z1,x2,y2,z2);
                except
                  StringGrid1.Cells[Col+1,Row+1]:= com80 ;
                end;
         end else begin Form1.ShowCommunicate(com112+inttostr(x1.Count)+','+inttostr(x2.Count)+'['+inttostr(col)+','+inttostr(row)+']'); end;

             end;
          end;
      end;

      x1.Free; y1.Free; z1.Free;
      x2.Free; y2.Free; z2.Free;
      listaVisInc.Free;
   end
    else begin Form1.ShowCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='RMSD';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
}
end;

procedure TForm13.SpeedButton6Click(Sender: TObject);
var
  i,visIncColNumber,col,row:integer;
  listaVisInc,x1,x2,y1,y2,z1,z2,Naglowki:TStringList;
  temp:string;
begin
{
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows


  visIncColNumber:=2;

  listaVisInc := TstringList.Create;

  for i:=1 to project_table_form.StringGrid1.RowCount -1 do // dodaje numery inc-knietych czasteczek (1)
   begin
     if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
      begin
        listaVisInc.Add(inttostr(i)); // lista vis albo inc
      end;
   end;

if listaVisInc.Count > 0 then
   begin

     x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
     x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

     Naglowki:= TstringList.Create;

   for i:=0 to ListaVisInc.Count -1 do    // pobierz wartosci i naglowki, przygotul listy do kalkulacji (2)
     begin
       for row:=1 to TstringGrid(MainForm.PageControl.Pages[StrToInt(ListaVisInc[i])].Controls[0]).RowCount -1 do // aktualny grid
        begin
          if TstringGrid(MainForm.PageControl.Pages[StrToInt(ListaVisInc[i])].Controls[0]).Cells[visIncColNumber,row] = '1' then
           begin
            naglowki.Add(project_table_form.StringGrid1.Cells[3,StrToInt(ListaVisInc[i])] // nazwa czasteczki
                         +'('+TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColAtomId,row]
                         +')'+TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColAtomName,row]); // pobranie numeru atomu i nazwy molekuly

             x1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColX,row]);
             y1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColY,row]);
             z1.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColZ,row]);
              // --->
             x2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColX,row]);
             y2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColY,row]);
             z2.Add(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[i])].Controls[0]).Cells[NrColZ,row]);

           end;
        end;
     end;

    // policz wartosci, uzupelnij macierz

    StringGrid1.ColCount:= naglowki.Count+1;
    Stringgrid1.FixedCols:= 1;   // cols

    Stringgrid1.RowCount:= naglowki.Count+1;
    stringgrid1.FixedRows:= 1;    // rows

    // nazwij kolumny i wiersze

    for col:=0 to naglowki.Count-1 do
     begin
       Stringgrid1.Cells[0,col+1]:= naglowki[col];
       Stringgrid1.Cells[col+1,0]:= naglowki[col];
     end;

  // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne
  // policz rorna przekatna macierzy
    for col:=0 to StringGrid1.ColCount -2 do
     begin
       for row:=0 to col do                         // molekula referencyjna w kolumnie
        begin
         if row = col then                          // MOLEKULY REFERENCYJNE TO NAGLOWKI KOLUMN !!!
          begin
            Stringgrid1.Cells[col+1,row+1]:= '0';
          end
           else
          begin
            Stringgrid1.Cells[col+1,row+1]:= 'c:'+ ZnakDVSAM(StrToCurr(x1[col]),StrToCurr(x2[row]))
              + ZnakDVSAM(StrToCurr(y1[col]),StrToCurr(y2[row]))
              + ZnakDVSAM(StrToCurr(z1[col]),StrToCurr(z2[row]))
              + currtostr(dlugosc_wektora(strtocurr(x1[col]),strtocurr(y1[col]),strtocurr(z1[col]),strtocurr(x2[row]),strtocurr(y2[row]),strtocurr(z2[row]),0));
          end;
        end;
     end;

  // policz dolna przekatna macierzy

    for row:=0 to StringGrid1.RowCount -2  do
     begin
       for col:=0 to row do                   // molekula referencyjna w rowsie
        begin
         if row = col then
          begin
            Stringgrid1.Cells[col+1,row+1]:= '0';
          end
           else
          begin
            Stringgrid1.Cells[col+1,row+1]:= 'c:' + ZnakDVSAM(StrToCurr(x1[col]),StrToCurr(x2[row]))
              + ZnakDVSAM(StrToCurr(y1[col]),StrToCurr(y2[row]))
              + ZnakDVSAM(StrToCurr(z1[col]),StrToCurr(z2[row]))// przeciwstawna castezcka wzorcowa
              + currtostr(dlugosc_wektora(strtocurr(x1[col]),strtocurr(y1[col]),strtocurr(z1[col]),strtocurr(x2[row]),strtocurr(y2[row]),strtocurr(z2[row]),0));
          end;
        end;
     end;

  // zwolnij pamiec

    x1.Free; y1.Free; z1.Free;
    x2.Free; y2.Free; z2.Free;
    listaVisInc.Free; naglowki.Free;

    end
     else begin Form1.ShowCommunicate(com108); end;

 // nazwij analize
 Stringgrid1.Cells[0,0]:='DVSAM';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
}
end;

procedure TForm13.SpeedButton7Click(Sender: TObject);
var
  i,a,ile_inc_pierwszy,pierwszy_inc:integer;
  IncNumbers,AtomsCoordinate:Tstringlist;
begin
  // jesli zaznaczoe 6 punktow w jednej molekue liczy w jednej
  // 3 punkty to liczy pomiedzy kolejnymi
{
  pierwszy_inc:= FirstCheckedRowNumber(project_table_form.StringGrid1,2);

  ile_inc_pierwszy:= CheckedCount(TstringGrid(Mainform.PageControl.Pages[pierwszy_inc].Controls[0]),2);

  IncNumbers := Tstringlist.Create;
  AtomsCoordinate:= TstringList.Create;

 if (ile_inc_pierwszy = 3) or (ile_inc_pierwszy = 6) then // licz w kolejnych
  begin
     for a:= 1 to Project_table_form.StringGrid1.RowCount -1 do
      begin
        If Project_table_form.StringGrid1.Cells[2,a] = '1' then
         begin
           IncNumbers.Add(IntToStr(a));
         end;
      end;
  end;

     //   jesli 3 bo pokolei z kazdej mozlekuly
 If ile_inc_pierwszy = 3 then
 begin
 // przygotuj grida
     Stringgrid1.ColCount:= IncNumbers.Count -1;
     Stringgrid1.RowCount:= 2;
     Stringgrid1.FixedRows:=1;

   for a:= 0 to IncNumbers.Count - 2 do
        begin

        AtomsCoordinate.Clear; // wyczysc przed ponownym

          For i:=1 to TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).RowCount -1 do
            begin
              If TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColInc,i] = '1' then     // zbierz dane
               begin
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColx,i]); // add X1 coordinate
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColy,i]); // add Y1 coordinate
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColz,i]); // add Z1 coordinate
               end;
            end;


          For i:=1 to TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a+1])].Controls[0]).RowCount -1 do
            begin
              If TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a+1])].Controls[0]).Cells[NrColInc,i] = '1' then
               begin
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a+1])].Controls[0]).Cells[NrColx,i]); // add X1 coordinate
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a+1])].Controls[0]).Cells[NrColy,i]); // add Y1 coordinate
                  AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a+1])].Controls[0]).Cells[NrColz,i]); // add Z1 coordinate
               end;
            end;

         StringGrid1.Cells[a,1]:= CurrToStr(AnglePlainAnalysis(StrToCurr(AtomsCoordinate[0]),StrToCurr(AtomsCoordinate[1]),StrToCurr(AtomsCoordinate[2]),
                                                      StrToCurr(AtomsCoordinate[3]),StrToCurr(AtomsCoordinate[4]),StrToCurr(AtomsCoordinate[5]),
                                                      StrToCurr(AtomsCoordinate[6]),StrToCurr(AtomsCoordinate[7]),StrToCurr(AtomsCoordinate[8]),

                                                      StrToCurr(AtomsCoordinate[9]),StrToCurr(AtomsCoordinate[10]),StrToCurr(AtomsCoordinate[11]),
                                                      StrToCurr(AtomsCoordinate[12]),StrToCurr(AtomsCoordinate[13]),StrToCurr(AtomsCoordinate[14]),
                                                      StrToCurr(AtomsCoordinate[15]),StrToCurr(AtomsCoordinate[15]),StrToCurr(AtomsCoordinate[16])
                                                      ));

   StringGrid1.Cells[a,0]:= Project_table_form.StringGrid1.Cells[3,StrToInt(IncNumbers[a])] +' -APA- '+ Project_table_form.StringGrid1.Cells[3,StrToInt(IncNumbers[a+1])];
        end;
 end;

 // jesli 6
 If ile_inc_pierwszy = 6 then
  begin
  // przygotuj grida
     Stringgrid1.ColCount:= IncNumbers.Count;
     Stringgrid1.RowCount:= 2;
     Stringgrid1.FixedRows:=1;

     for a:= 0 to IncNumbers.Count - 1 do
            begin

            AtomsCoordinate.Clear; // wyczysc przed ponownym

              For i:=1 to TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).RowCount -1 do
                begin
                  If TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColInc,i] = '1' then     // zbierz dane
                   begin
                      AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColx,i]); // add X1 coordinate
                      AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColy,i]); // add Y1 coordinate
                      AtomsCoordinate.Add(TstringGrid(MainForm.PageControl.Pages[StrToInt(IncNumbers[a])].Controls[0]).Cells[NrColz,i]); // add Z1 coordinate
                   end;
                end;

             StringGrid1.Cells[a,1]:= CurrToStr(AnglePlainAnalysis(StrToCurr(AtomsCoordinate[0]),StrToCurr(AtomsCoordinate[1]),StrToCurr(AtomsCoordinate[2]),
                                                          StrToCurr(AtomsCoordinate[3]),StrToCurr(AtomsCoordinate[4]),StrToCurr(AtomsCoordinate[5]),
                                                          StrToCurr(AtomsCoordinate[6]),StrToCurr(AtomsCoordinate[7]),StrToCurr(AtomsCoordinate[8]),

                                                          StrToCurr(AtomsCoordinate[9]),StrToCurr(AtomsCoordinate[10]),StrToCurr(AtomsCoordinate[11]),
                                                          StrToCurr(AtomsCoordinate[12]),StrToCurr(AtomsCoordinate[13]),StrToCurr(AtomsCoordinate[14]),
                                                          StrToCurr(AtomsCoordinate[15]),StrToCurr(AtomsCoordinate[15]),StrToCurr(AtomsCoordinate[16])
                                                          ));

            StringGrid1.Cells[a,0]:= Project_table_form.StringGrid1.Cells[3,StrToInt(IncNumbers[a])] +' -APA- '+ Project_table_form.StringGrid1.Cells[3,StrToInt(IncNumbers[a])];
            end;
  end;

 if (ile_inc_pierwszy <> 3)  and (ile_inc_pierwszy <> 6) then
  begin
    Form1.ShowCommunicate(com145);
  end;

  StringGrid1.AutoSizeColumns;
  IncNumbers.Free;
  AtomsCoordinate.Free;
 }
end;

procedure TForm13.SpeedButton8Click(Sender: TObject);
var
 i,visIncColNumber,col,row:integer;
 listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
 temp:string;
begin
{
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows

 visIncColNumber:=2;

 listaVisInc := TstringList.Create;

 for i:=1 to project_table_form.StringGrid1.RowCount -1 do
  begin
    if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
     begin
       listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

       Stringgrid1.ColCount:= 1+ listaVisInc.Count;
       Stringgrid1.FixedCols:= 1;   // cols

       Stringgrid1.RowCount:= 1+ listaVisInc.Count;
       stringgrid1.FixedRows:= 1;    // rows

       // nazwy kolumn
       StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
       // nazwy rowsow
       StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
     end;
  end;

 // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

 if listaVisInc.Count > 0 then
  begin

    x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
    x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

    for col:=0 to listaVisInc.Count -1 do
     begin
        for row:=0 to listaVisInc.Count -1 do               // sprawdzic jak wyglada lista !!!!
         begin
          if checkbox3.Checked = True then // every atoms
           begin
           if col = row then
            begin             // wewnwtrzyn aAPA
               x1.Clear;
               x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
               x1.Delete(0); // usuniecie naglowka

               y1.Clear;
               y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
               y1.Delete(0);

               z1.Clear;
               z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
               z1.Delete(0);

               // --->
               // przepisanie pierwszego na koniec i usuniecie z pocztaku

               x2.Clear;
               x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
               x2.Delete(0); // usuniecie naglowka
               x2.Add(x2[0]);
               x2.Delete(0);


               y2.Clear; // przepisanie pierwszego atomu na ostatnią pozycję
               y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
               y2.Delete(0);
               y2.Add(y2[0]);
               y2.Delete(0);

               z2.Clear;
               z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
               z2.Delete(0);
               z2.Add(z2[0]);
               z2.Delete(0);

               StringGrid1.Cells[Col+1,Row+1]:= SigmaAPA(x1,y1,z1,x2,y2,z2);

            end
             else
            begin //  clear lists
               x1.Clear;
               x1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColx]);
               x1.Delete(0); // usuniecie naglowka

               y1.Clear;
               y1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColy]);
               y1.Delete(0);

               z1.Clear;
               z1.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]).Cols[NrColz]);
               z1.Delete(0);
               // --->

               x2.Clear;
               x2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColx]);
               x2.Delete(0); // usuniecie naglowka

               y2.Clear;
               y2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColy]);
               y2.Delete(0);

               z2.Clear;
               z2.AddStrings(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]).Cols[NrColz]);
               z2.Delete(0);

               try
                 StringGrid1.Cells[Col+1,Row+1]:= SigmaAPA(x1,y1,z1,x2,y2,z2);
               except
                 StringGrid1.Cells[Col+1,Row+1]:= com80 ;
               end;
            end;
           end;
          if checkbox2.Checked = True then
           begin
           if col = row then
            begin             // wewnwtrzyn aAPA
               // lista x1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

               // lista y1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

               // lista z1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

               // --->
               // przepisanie pierwszego na koniec i usuniecie z pocztaku

               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);
               x2.Add(x2[0]);
               x2.Delete(0);

               // przepisanie pierwszego atomu na ostatnią pozycję
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);
               y2.Add(y2[0]);
               y2.Delete(0);

               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);
               z2.Add(z2[0]);
               z2.Delete(0);

               StringGrid1.Cells[Col+1,Row+1]:= SigmaAPA(x1,y1,z1,x2,y2,z2);

            end
             else
            begin

               // lista X1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

               // lista Y1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

               // lista Z1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

               // --->
               // lista X2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);

               // lista Y2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);

               // lista Z2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);

               try
                 StringGrid1.Cells[Col+1,Row+1]:= SigmaAPA(x1,y1,z1,x2,y2,z2);
               except
                 StringGrid1.Cells[Col+1,Row+1]:= com80 ;
               end;
            end;
           end
         end;
     end;

     x1.Free; y1.Free; z1.Free;
     x2.Free; y2.Free; z2.Free;
     listaVisInc.Free;

  end
   else begin Form1.ShowCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='SigmaAPA';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
}
end;

procedure TForm13.SpeedButton9Click(Sender: TObject);
var
 i,visIncColNumber,col,row:integer;
 listaVisInc,x1,x2,y1,y2,z1,z2:TStringList;
 sign,title:string;
 APD:currency;
begin
  {
Stringgrid1.ColCount:= 0;
Stringgrid1.FixedCols:= 0;   // cols

Stringgrid1.RowCount:= 0;
stringgrid1.FixedRows:= 0;    // rows

 visIncColNumber:=2;

 listaVisInc := TstringList.Create;

 for i:=1 to project_table_form.StringGrid1.RowCount -1 do
  begin
    if project_table_form.StringGrid1.Cells[visIncColNumber,i] = '1' then
     begin
       listaVisInc.Add(inttostr(i)); // lista vis albo inc // spr ok

       Stringgrid1.ColCount:= 1+ listaVisInc.Count;
       Stringgrid1.FixedCols:= 1;   // cols

       Stringgrid1.RowCount:= 1+ listaVisInc.Count;
       stringgrid1.FixedRows:= 1;    // rows

       // nazwy kolumn
       StringGrid1.Cells[0,Stringgrid1.RowCount-1]:=project_table_form.StringGrid1.Cells[3,i];
       // nazwy rowsow
       StringGrid1.Cells[Stringgrid1.ColCount-1,0]:=project_table_form.StringGrid1.Cells[3,i];
     end;
  end;

 // policz macierz dla wszytkich, na przeciecięciu tych samych np. 11 sa wewnetzrne

 if listaVisInc.Count > 0 then
  begin

    x1:= TstringList.Create; y1:= TstringList.Create; z1:= TstringList.Create;
    x2:= TstringList.Create; y2:= TstringList.Create; z2:= TstringList.Create;

    for col:=0 to listaVisInc.Count -1 do
     begin
        for row:=0 to listaVisInc.Count -1 do               // sprawdzic jak wyglada lista !!!!
         begin
           if col = row then
            begin             // WEWNETRZNE

            // lista x1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

               // lista y1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

               // lista z1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

               // --->
               // przepisanie pierwszego na koniec i usuniecie z pocztaku

               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);
               x2.Add(x2[0]);
               x2.Delete(0);

               // przepisanie pierwszego atomu na ostatnią pozycję
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);
               y2.Add(y2[0]);
               y2.Delete(0);

               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);
               z2.Add(z2[0]);
               z2.Delete(0);

             if checkbox6.Checked then
              begin
               StringGrid1.Cells[Col+1,Row+1]:= AnglePlaneDeviation(x1,y1,z1,x2,y2,z2);
              end else begin StringGrid1.Cells[Col+1,Row+1]:= '-' end;

            end
             else
            begin

               // lista X1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColX,X1);

               // lista Y1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColY,Y1);

               // lista Z1
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[col])].Controls[0]),NrColInc,NrColZ,Z1);

               // --->
               // lista X2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColX,X2);

               // lista Y2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColY,Y2);

               // lista Z2
               GridColumnToValues(TstringGrid(Mainform.PageControl.Pages[StrToInt(listaVisInc[row])].Controls[0]),NrColInc,NrColZ,Z2);

               try
                  sign:='';
                  title:='';

                if checkbox1.Checked then  // sign of X
                 begin
                   sign:= SignOfMovement(X1,X2);
                   title:='X';
                 end;

                 if checkbox4.Checked then  // sign of Y
                 begin
                   sign:= sign + SignOfMovement(Y1,Y2);
                   title:= title + 'Y';
                 end;

                 if checkbox5.Checked then  // sign of Z
                 begin
                   sign:= sign + SignOfMovement(Z1,Z2);
                   title:= title + 'Z';
                 end;

                if checkbox6.Checked then //APD
                 begin
                   StringGrid1.Cells[Col+1,Row+1]:= AnglePlaneDeviation(x1,y1,z1,x2,y2,z2);
                 end;

                if checkbox7.Checked then // RMSD
                 begin
                   StringGrid1.Cells[Col+1,Row+1]:= sign + RMSD(x1,y1,z1,x2,y2,z2,false);
                 end;

                if checkbox8.Checked then // APD + RMSD
                 begin
                   StringGrid1.Cells[Col+1,Row+1]:= sign + CurrToStr(StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2)) + StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false)));
                 end;

                  if checkbox9.Checked then // APD / RMSD
                 begin

                  APD:= StrToCurr(AnglePlaneDeviation(x1,y1,z1,x2,y2,z2));

                  if APD = 0 then
                   begin
                      StringGrid1.Cells[Col+1,Row+1]:= 'APD = 0';
                   end else
                     begin
                      StringGrid1.Cells[Col+1,Row+1]:= {sign +} CurrToStr(APD / StrToCurr(RMSD(x1,y1,z1,x2,y2,z2,false)));
                     end;
                 end;

               except
                 StringGrid1.Cells[Col+1,Row+1]:= com80 ;
               end;
            end;

         end;
     end;

     x1.Free; y1.Free; z1.Free;
     x2.Free; y2.Free; z2.Free;
     listaVisInc.Free;

  end
   else begin Console.AddCommunicate(com101); end;

// nazwij analize
Stringgrid1.Cells[0,0]:='';

// dopasuj kolumny
StringGrid1.AutoSizeColumns;
     }
end;

procedure TForm13.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
 a,b:integer;
begin
  //koloruj przekatna i coresponing rows columns
end;

procedure TForm13.StringGrid1HeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin

end;


procedure TForm13.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm13.CheckBox6Change(Sender: TObject);
begin
   if checkbox6.Checked then
   begin
      checkbox7.Checked:=False;
      checkbox8.Checked:=False;
      checkbox9.Checked:=False;
   end;
end;

procedure TForm13.CheckBox6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm13.CheckBox7Change(Sender: TObject);
begin
    if checkbox7.Checked then
   begin
      checkbox6.Checked:=False;
      checkbox8.Checked:=False;
      checkbox9.Checked:=False;
   end;
end;

procedure TForm13.CheckBox7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TForm13.CheckBox8Change(Sender: TObject);
begin
 if checkbox8.Checked then
   begin
      checkbox7.Checked:=False;
      checkbox6.Checked:=False;
      checkbox9.Checked:=False;
   end;
end;

procedure TForm13.CheckBox8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TForm13.CheckBox9Change(Sender: TObject);
begin
     if checkbox9.Checked then
   begin
      checkbox7.Checked:=False;
      checkbox8.Checked:=False;
      checkbox6.Checked:=False;
   end;
end;

procedure TForm13.CheckBox9KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TForm13.MenuItem1Click(Sender: TObject);
var
 temp:Tobject;
begin
  temp:= Tobject.Create;
  temp:= ActiveGrid; // przypisz starego grida
  activeGrid:= StringGrid1; // przypisz nowa
     CutGridToClipboard();   // wykonaj procedure
  activeGrid:=temp; // powróc do starej
end;

procedure TForm13.MenuItem2Click(Sender: TObject);
var
 temp:Tobject;
begin
  temp:= Tobject.Create;
  temp:= ActiveGrid; // przypisz starego grida
  activeGrid:= StringGrid1; // przypisz nowa
     CopyGridToClipboard();   // wykonaj procedure
  activeGrid:=temp; // powróc do starej
end;

procedure TForm13.MenuItem3Click(Sender: TObject);
var
 temp:Tobject;
begin
  temp:= Tobject.Create;
  temp:= ActiveGrid; // przypisz starego grida
  activeGrid:= StringGrid1; // przypisz nowa
     PasteGridFromClipboard();   // wykonaj procedure
  activeGrid:=temp; // powróc do starej
end;

procedure TForm13.MenuItem4Click(Sender: TObject);
begin
  Grid_as_CSV(StringGrid1,';');
end;

procedure TForm13.MenuItem5Click(Sender: TObject);
 Var
  i:integer;
  values,temp:string;
  headers,separate_signs:boolean;
begin
 if  MessageDlg(com22,com39, mtConfirmation, mbYesNo, 0) = mrYes then
  begin                      // eksposruj naglowki
    headers:= true;
  end else begin headers:=false; end;

 if  MessageDlg(com22,com139, mtConfirmation, mbYesNo, 0) = mrYes then
  begin                  // separuj znaki semikolonem
    separate_signs:= true;
  end else begin separate_signs:=false; end;

Values:='';

 For i:=1 to StringGrid1.RowCount -1 do
  begin
    if headers then
     begin
       // nazwy
       Values:= Values + StringGrid1.Cells[0,i] +';' ;
     end;

    if separate_signs then
     begin
        //Wartosci
       Temp:= StringGrid1.Cells[i,i];
       if StringGrid1.Cells[0,0] <> 'DVSAM' then // jesli 3 znak jest liczba to aAPA wstaw po 2
        begin   // jesli nie to DVSAM wstaw po 5
          temp:= Copy(temp,0,2)+';'+Copy(temp,3,length(temp));
        end else begin temp:= Copy(temp,0,2)+';'+ Copy(temp,3,3)+';'+Copy(temp,6,length(temp)); end;

        Values:= Values + temp + #13#10;

     end else begin  //Wartosci
        Values:= Values + StringGrid1.Cells[i,i] + #13#10; end;
  end;

   Clipboard.AsText:= Values;
end;

procedure TForm13.MenuItem6Click(Sender: TObject);
 Var
   i,start_row:integer;
   values,temp:string;
   headers,separate_signs:boolean;
 begin
  if  MessageDlg(com22,com39, mtConfirmation, mbYesNo, 0) = mrYes then
   begin
     headers:= true;
   end else begin headers:=false; end;

  if  MessageDlg(com22,com139, mtConfirmation, mbYesNo, 0) = mrYes then
  begin                  // separuj znaki semikolonem
    separate_signs:= true;
  end else begin separate_signs:=false; end;

 Values:='';

 start_row:= StrToIntDef(InputBox(Com26, Com136+'0-'+IntToStr(StringGrid1.RowCount -2 ), '1'),-1);

if i > -1 then
 begin
  For i:=1 to StringGrid1.RowCount - start_row -1 do
   begin
     if headers then
      begin
        // nazwy
        Values:= Values + StringGrid1.Cells[0,i+start_row] +';' ;
      end;

      if separate_signs then
     begin
        //Wartosci
       Temp:= StringGrid1.Cells[i,i+start_row];

       if StringGrid1.Cells[0,0] <> 'DVSAM' then // jesli 3 znak jest liczba to aAPA wstaw po 2
        begin   // jesli nie to DVSAM wstaw po 5
          temp:= Copy(temp,0,2)+';'+Copy(temp,3,length(temp));
        end else begin temp:= Copy(temp,0,2)+';'+ Copy(temp,3,3)+';'+Copy(temp,6,length(temp)); end;

        Values:= Values + temp + #13#10;

     end else begin  //Wartosci
        Values:= Values + StringGrid1.Cells[i,i+start_row] + #13#10; end;

   end;
    Clipboard.AsText:= Values;

 end else begin Console.AddCommunicate(Com137,true); end;
 end;

procedure TForm13.CheckBox1Change(Sender: TObject);
begin

end;

initialization
  {$I unit15.lrs}

end.

