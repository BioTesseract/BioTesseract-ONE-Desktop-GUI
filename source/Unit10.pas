(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit10;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, math,grids, Menus, Biblioteka_Grow_4;

type

  { TForm9 }

  TForm9 = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit20: TLabeledEdit;
    LabeledEdit21: TLabeledEdit;
    LabeledEdit22: TLabeledEdit;
    LabeledEdit23: TLabeledEdit;
    LabeledEdit24: TLabeledEdit;
    LabeledEdit25: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;wynik:TstringList);
    Procedure Calculate();
    Procedure Take_coordinates(Sender:Tobject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form9: TForm9; 

implementation

uses
 Unit1,Unit8,unit2,Unit22;

{ TForm9 }

Procedure TForm9.Take_coordinates(Sender:Tobject); // koniecznie combobox
var
 tab1,tab2,i,w: integer;
 rec:Tstrings;

begin
 { Screen.Cursor := crHourglass;

    labelededit19.Text := '';
    labelededit20.Text := '';
    labelededit21.Text := '';
    labelededit22.Text := '';
    labelededit23.Text := '';
    Labelededit24.Text := '';
    Labelededit25.Text := '';

  tab1:= TCombobox(Sender).ItemIndex+1;

  rec:= TstringList.Create;

for i:=1 to TstringGrid(Mainform.PageControl.Pages[tab1].Controls[0]).RowCount -1 do
 begin
   if Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[2,i] = '1' then
    begin
      rec.Add(IntToStr(i));
    end;
 end;

 // zglos bledy jak nei prawdilowa ilosc parametrow

if rec.Count <> 3 then
 begin
   Console.AddCommunicate(com36);

    // wyczysc jak blad!!!!

    labelededit19.Text := '';
    labelededit20.Text := '';
    labelededit22.Text := '';
    labelededit21.Text :='' ;
    labelededit23.Text := '';
    Labelededit24.Text := '';
    Labelededit25.Text := '';

   if Tcombobox(Sender).Name = 'ComboBox1' then
    begin
     labelededit1.Text := com80;
     labelededit2.Text := com80;
     labelededit3.Text := com80;

     labelededit4.Text := com80;
     labelededit5.Text := com80;
     labelededit6.Text := com80;

     labelededit7.Text := com80;
     labelededit8.Text := com80;
     labelededit9.Text := com80;
     Labelededit25.Text:= com80;
    end;

    if Tcombobox(Sender).Name = 'ComboBox2' then
    begin
     labelededit10.Text := com80;
     labelededit11.Text := com80;
     labelededit12.Text := com80;

     labelededit13.Text := com80;
     labelededit14.Text := com80;
     labelededit15.Text := com80;

     labelededit16.Text := com80;
     labelededit17.Text := com80;
     labelededit18.Text := com80;
     Labelededit24.Text := com80;
    end;

   // zablokuj przycisk

   SpeedButton1.Enabled:=False;

   if rec.Count > 3 then
     begin
       Console.AddCommunicate(com98+'[Name: '+Mainform.PageControl.Pages[tab1].Caption+']');
     end;
 end
   else
 begin  // pobierz dane
 // odblokuj przycisk
    SpeedButton1.Enabled:=True;

   if Tcombobox(Sender).Name = 'ComboBox1' then
    begin
     labelededit1.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[0])];
     labelededit2.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[0])];
     labelededit3.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[0])];

     labelededit4.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[1])];
     labelededit5.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[1])];
     labelededit6.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[1])];

     labelededit7.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[2])];
     labelededit8.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[2])];
     labelededit9.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[2])];
    end;

    if Tcombobox(Sender).Name = 'ComboBox2' then
    begin
     labelededit10.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[0])];
     labelededit11.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[0])];
     labelededit12.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[0])];

     labelededit13.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[1])];
     labelededit14.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[1])];
     labelededit15.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[1])];

     labelededit16.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColX,StrToInt(Rec[2])];
     labelededit17.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColY,StrToInt(Rec[2])];
     labelededit18.Text := Tstringgrid(Mainform.PageControl.Pages[tab1].Controls[0]).Cells[NrColZ,StrToInt(Rec[2])];
    end;

 end;

 rec.Free;
 Screen.Cursor := crDefault;
      }
end;

Procedure Tform9.Calculate();
var
 x1,y1,z1,x2,y2,z2,x3,y3,z3,A1,A2,B1,B2,C1,C2,D1,D2,cz1,cz2,cz3,cosAlfa,x11,y11,z11,x22,y22,z22:currency;
 wynik:TstringList;

begin

SpeedButton3.Enabled:= false;

Screen.Cursor := crHourglass;

x1:= strtocurr(labelededit1.Text);         // plaszczyzna 1
y1:= strtocurr(labelededit2.Text);
z1:= strtocurr(labelededit3.Text);

x2:= strtocurr(labelededit4.Text);
y2:= strtocurr(labelededit5.Text);
z2:= strtocurr(labelededit6.Text);

x3:= strtocurr(labelededit7.Text);
y3:= strtocurr(labelededit8.Text);
z3:= strtocurr(labelededit9.Text);

x11:=(x1+x2+x3)/3;
y11:=(y1+y2+y3)/3;
z11:=(z1+z2+z3)/3;

Labelededit25.Text:= 'X:'+currtostr(x11)+
                     '  Y:'+currtostr(y11)+
                     '  Z:'+currtostr(z11);

wynik:= Tstringlist.Create;

 wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3,wynik);

 A1:=strtocurr(wynik[0]);
 B1:=strtocurr(wynik[1]);
 C1:=strtocurr(wynik[2]);
 D1:=strtocurr(wynik[3]);

 labelededit19.Text:= wynik[0]+'x + '+wynik[1]+'y + '+wynik[2]+'z + '+wynik[3];  // end

x1:= strtocurr(labelededit10.Text);        // plaszcyzna 2
y1:= strtocurr(labelededit11.Text);
z1:= strtocurr(labelededit12.Text);

x2:= strtocurr(labelededit13.Text);
y2:= strtocurr(labelededit14.Text);
z2:= strtocurr(labelededit15.Text);

x3:= strtocurr(labelededit16.Text);
y3:= strtocurr(labelededit17.Text);
z3:= strtocurr(labelededit18.Text);

x22:=(x1+x2+x3)/3;
y22:=(y1+y2+y3)/3;
z22:=(z1+z2+z3)/3;

Labelededit24.Text:= 'X:'+currtostr(x22)+
                     '  Y:'+currtostr(y22)+
                     '  Z:'+currtostr(z22);

 wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3,wynik);

 A2:=strtocurr(wynik[0]);
 B2:=strtocurr(wynik[1]);
 C2:=strtocurr(wynik[2]);
 D2:=strtocurr(wynik[3]);

 labelededit20.Text:= wynik[0]+'x + '+wynik[1]+'y + '+wynik[2]+'z + '+wynik[3];   // end

 if (A1<>0) and (B1<>0) and (C1<>0) and (A2<>0) and (B2<>0) and (C2<>0) then
  begin
    cz1:= A1*A2 + B1*B2 + C1*C2 ;

    cz2:= power(A1,2) + power(B1,2) + power(C1,2);
    cz2:= sqrt(cz2);

    cz3:= power(A2,2) + power(B2,2) + power(C2,2);
    cz3:= sqrt(cz3);

    cosAlfa:= cz1 / (cz2*cz3);

    // labelededit21.Caption:= currtostr(cosAlfa);

    labelededit22.Caption:= currtostr((180 * arccos(cosAlfa))/Pi);

    // drugie możliwe rozwiazanie
    labelededit21.Caption:= currtostr(180 - (180 * arccos(cosAlfa))/Pi);

    labelededit23.Text:=ZnakDVSAM(x11,x22)+ZnakDVSAM(y11,y22)
                       +ZnakDVSAM(z11,z22)+ currtostr(Form7.dlugosc_wektora(x11,y11,z11,x22,y22,z22,0));

    SpeedButton3.Enabled:= true;
    Screen.Cursor := crDefault;

  end
   else
  begin
    Console.AddCommunicate(com35,true);
    labelededit22.Caption:= currtostr(-1);
  end;
end;

procedure Tform9.wsp_plaszczyzny(x1,y1,z1,x2,y2,z2,x3,y3,z3:currency;wynik:TstringList);
var
   A,B,C,D:currency;
begin
   A:= y1*(z2 - z3) + y2*(z3 - z1) + y3*(z1 - z2);   // A = y1 (z2 - z3) + y2 (z3 - z1) + y3 (z1 - z2)
   B:= z1*(x2 - x3) + z2*(x3 - x1) + z3*(x1 - x2);   // B = z1 (x2 - x3) + z2 (x3 - x1) + z3 (x1 - x2)
   C:= x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2);   // C = x1 (y2 - y3) + x2 (y3 - y1) + x3 (y1 - y2)
   D:= x1*(y2*z3 - y3*z2) + x2*(y3*z1 - y1*z3) + x3*(y1*z2 - y2*z1); // - D = x1 (y2 z3 - y3 z2) + x2 (y3 z1 - y1 z3) + x3 (y1 z2 - y2 z1)
   D:= D * -1;

   wynik.Clear;
   wynik.Add(currtostr(A));      // Ax + By + Cz + D = 0
   wynik.Add(currtostr(B));
   wynik.Add(currtostr(C));
   wynik.Add(currtostr(D));

end;

procedure TForm9.SpeedButton1Click(Sender: TObject);

begin

 Calculate();

end;

procedure TForm9.SpeedButton2Click(Sender: TObject);
begin
 If Form9.Height > 400 then
  begin
    Form9.Height:= 145;
    Speedbutton2.Caption:='Show details';
  end else begin Speedbutton2.Caption:='Hide details'; Form9.Height:=446; end;

end;

procedure TForm9.SpeedButton3Click(Sender: TObject);
Var
   xyz:TstringList;
begin

  xyz:=TstringList.Create;

                 xyz.Add(Labelededit1.Text);  // firt plane
                 xyz.Add(Labelededit2.Text);
                 xyz.Add(Labelededit3.Text);
                 xyz.Add(Labelededit4.Text);
                 xyz.Add(labelededit5.Text);
                 xyz.Add(labelededit6.Text);
                 xyz.Add(labelededit7.Text);
                 xyz.Add(labelededit8.Text);
                 xyz.Add(labelededit9.Text);

  AddNewGrid('1','1','Plane - '+combobox1.Text,'PLA','self'); // add grid
  AddPlaneToTable(TstringGrid(ActiveGrid),xyz,'1','A');  // add data

  xyz.Clear; // wyczysc

                  xyz.Add(Labelededit10.Text);   // second plane
                  xyz.Add(Labelededit11.Text);
                  xyz.Add(Labelededit12.Text);
                  xyz.Add(Labelededit13.Text);
                  xyz.Add(labelededit14.Text);
                  xyz.Add(labelededit15.Text);
                  xyz.Add(labelededit16.Text);
                  xyz.Add(labelededit17.Text);
                  xyz.Add(labelededit18.Text);

  AddNewGrid('1','1','Plane - '+combobox2.Text,'PLA','self'); // add grid
  AddPlaneToTable(TstringGrid(ActiveGrid),xyz,'1','B');  // add data

// line with value !!!!!

 xyz.Free;
end;


procedure TForm9.ComboBox1Change(Sender: TObject);
begin
    Take_coordinates(Sender);
end;

procedure TForm9.ComboBox2Change(Sender: TObject);
begin
   Take_coordinates(Sender);
end;

procedure TForm9.FormCreate(Sender: TObject);
begin

end;


procedure TForm9.FormShow(Sender: TObject);
var
 i:integer;
begin
 Combobox1.Clear;
 Combobox2.Clear;

 Combobox1.Text:=com97;
 Combobox2.Text:=com97;

  {for i:=1 to Mainform.PageControl.PageCount-1 do
   begin
      Combobox1.Items.Add(Mainform.PageControl.Pages[i].Caption);
      Combobox2.Items.Add(Mainform.PageControl.Pages[i].Caption);
   end;
   }
end;

procedure TForm9.GroupBox6Click(Sender: TObject);
begin

end;



initialization
  {$I unit10.lrs}

end.

