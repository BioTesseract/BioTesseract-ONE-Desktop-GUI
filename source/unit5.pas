(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin, Math, Grids, Biblioteka_Grow_4;

type

  { TForm4 }

  TForm4 = class(TForm)
    coile: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    wwzb: TLabeledEdit;
    w23: TLabeledEdit;
    w56: TLabeledEdit;
    masa: TLabeledEdit;
    lambda7: TLabeledEdit;
    obj7: TLabeledEdit;
    opuznienie6: TLabeledEdit;
    szybkosc3: TLabeledEdit;
    lambda3: TLabeledEdit;
    obj3: TLabeledEdit;
    opuznienie2: TLabeledEdit;
    szybkosc4: TLabeledEdit;
    lambda4: TLabeledEdit;
    obj4: TLabeledEdit;
    opuznienie3: TLabeledEdit;
    szybkosc5: TLabeledEdit;
    lambda5: TLabeledEdit;
    lambda1: TLabeledEdit;
    obj5: TLabeledEdit;
    opuznienie4: TLabeledEdit;
    szybkosc6: TLabeledEdit;
    lambda6: TLabeledEdit;
    obj6: TLabeledEdit;
    opuznienie5: TLabeledEdit;
    obj1: TLabeledEdit;
    dawka: TLabeledEdit;
    szybkosc1: TLabeledEdit;
    szybkosc2: TLabeledEdit;
    lambda2: TLabeledEdit;
    obj2: TLabeledEdit;
    opuznienie1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    szybkosc7: TLabeledEdit;
    procedure lambda1Change(Sender: TObject);
    procedure lambda2Change(Sender: TObject);
    procedure lambda3Change(Sender: TObject);
    procedure lambda4Change(Sender: TObject);
    procedure lambda5Change(Sender: TObject);
    procedure lambda6Change(Sender: TObject);
    procedure lambda7Change(Sender: TObject);
    function LambdaNaObjetosc(lambda,massa:shortstring):shortstring;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    Procedure wykresZkolumn(x,y:integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4: TForm4; 

implementation
uses
  Unit1,Unit7,unit9,unit22;

{ TForm4 }

function TForm4.LambdaNaObjetosc(lambda,massa:shortstring):shortstring;
var
  lam,mas:Extended;
begin
lam:=StrToFloatDef(lambda,0);
mas:=StrToFloatDef(massa,0);
if (lam=0) or (mas=0) then
 begin
   Console.AddCommunicate(com9,true);
 end
  else
 begin
   lam:=mas/lam;
   lam:=RoundTo(lam,-2);
   Result:=Floattostr(lam);
 end;
end;

procedure TForm4.SpeedButton1Click(Sender: TObject);
var
  sz: array[1..7] of currency ;
  op: array[1..6] of currency ;
  ak_masy:array[0..7] of currency;
  i,p,d,ilosc_podz:integer;
  czas_cal,czas,pom,wspB:currency;
  b:boolean=True;

begin
   sz[1]:= StrToCurrDef(szybkosc1.Text,-1);
   sz[2]:= StrToCurrDef(szybkosc2.Text,-1);
   sz[3]:= StrToCurrDef(szybkosc3.Text,-1);
   sz[4]:= StrToCurrDef(szybkosc4.Text,-1);
   sz[5]:= StrToCurrDef(szybkosc5.Text,-1);
   sz[6]:= StrToCurrDef(szybkosc6.Text,-1);
   sz[7]:= StrToCurrDef(szybkosc7.Text,-1);
      op[1]:= StrToCurrDef(opuznienie1.Text,-1);
      op[2]:= StrToCurrDef(opuznienie2.Text,-1);
      op[3]:= StrToCurrDef(opuznienie3.Text,-1);
      op[4]:= StrToCurrDef(opuznienie4.Text,-1);
      op[5]:= StrToCurrDef(opuznienie5.Text,-1);
      op[6]:= StrToCurrDef(opuznienie6.Text,-1);
   ak_masy[0]:=StrToCurrDef(dawka.Text,-1);
 for p:=1 to 7 do
  begin
    if (sz[p] = -1) or (op[p] = -1) or (ak_masy[0] = -1) then
     begin
       Console.AddCommunicate(com16+' [RU model]',true);
       exit;
     end;
  end;
// dodoaj parametry
Form8.Memo3.Lines.Add('[RU model parameters] [ '+Datetostr(now)+'  '+Timetostr(Now)+' ]');
Form8.Memo3.Lines.Add(linia);
for p:=0 to groupbox1.ControlCount-1 do
 begin
    if groupbox1.Controls[p] is Tlabelededit then
     begin
       Form8.Memo3.Lines.Add(Tlabelededit(groupbox1.Controls[p]).EditLabel.Caption+' = '+ Tlabelededit(groupbox1.Controls[p]).Text);
     end;
 end;
for p:=1 to 7 do
 begin
   Form8.Memo3.Lines.Add(com28+inttostr(p)+' = '+currtostr(sz[p]));
   if p <> 7 then
    begin
       Form8.Memo3.Lines.Add(com29+inttostr(p)+' = '+currtostr(op[p]));
    end;
 end;

// wyliczenia
   ak_masy[1]:=0;
   ak_masy[2]:=0;
   ak_masy[3]:=0;
   ak_masy[4]:=0;
   ak_masy[5]:=0;
   ak_masy[6]:=0;
   ak_masy[7]:=0;
// calkowity czas i ilosc podzialow
czas_cal:=0;
  for i:=1 to high(sz) do
    begin
      czas_cal := czas_cal + ak_masy[0] / sz[i]; // ak_masy[0] dawka poczatkowa
    end;

for i:=1 to high(op) do
    begin
      czas_cal := czas_cal + op[i];
    end;
czas_cal := czas_cal/coile.Value;
ilosc_podz:=Ceil(czas_cal/10);
ilosc_podz:=ilosc_podz+1;
// ->end
if (ilosc_podz>0) and (MessageDlg ('Information', 'Approximate number of measurements '+inttostr(ilosc_podz)+', continue ? ', mtConfirmation,
                 [mbYes, mbNo],0) = mrYes)
 then
   begin
     try
      begin
     // nowy_grid('Symulation_RU_'+inttostr(newGrid),True);
      TstringGrid(ActiveGrid).Cells[0,0]:='RES';
      end
       except
         Console.AddCommunicate(com13,true);
         exit;
       end;

     TstringGrid(ActiveGrid).RowCount:=ilosc_podz+2;
     //TstringGrid(ActiveGrid).ColCount:= 20;

     // naglowki
       TstringGrid(ActiveGrid).Cells[1,1]:='Time [h]';
       TstringGrid(ActiveGrid).Cells[2,1]:='Mass I (ng/ml)- Intestine';
       TstringGrid(ActiveGrid).Cells[3,1]:='Mass II (ng/ml) - Liver';
       TstringGrid(ActiveGrid).Cells[4,1]:='Mass III (ng/ml) - faeces (tot.)';
       TstringGrid(ActiveGrid).Cells[5,1]:='Mass IV (ng/ml) - Bile';
       TstringGrid(ActiveGrid).Cells[6,1]:='Mass V (ng/ml) - Circulatory system';
       TstringGrid(ActiveGrid).Cells[7,1]:='Mass VI (ng/ml) - Brain';

// start

 for i:= 1 to ilosc_podz do
  begin
    czas:= i* coile.Value;
    TstringGrid(ActiveGrid).Cells[1,i+1]:=Currtostr(czas);  // czas -> grid

    ak_masy[1]:= ak_masy[0]- sz[1] * czas;  // 1 - jelito
    If ak_masy[1] < 0 then
     begin ak_masy[1]:=0;  end;

    if ak_masy[1] > 0 then
       begin
         TstringGrid(ActiveGrid).Cells[2,i+1]:=Currtostr(ak_masy[1]);
       end; // jelito -> grid

      if czas >= op[1] then
        begin
         pom:= ak_masy[0] - ak_masy[1];    // 2 - watroba
         pom:= StrToCurr(w23.Text)* pom;
         ak_masy[2]:= pom;
         pom:= czas -  op[1];
         ak_masy[2]:= ak_masy[2] - sz[2] * pom;
        end;

      If ak_masy[2] < 0 then
        begin ak_masy[2]:=0;  end;

      if  czas >= op[1] then                 // 2-  watroba -> grid
        begin
          if ak_masy[2] > 0 then
            begin TstringGrid(ActiveGrid).Cells[3,i+1]:=Currtostr(ak_masy[2]); end;
        end else begin TstringGrid(ActiveGrid).Cells[3,i+1]:='0' end;

  if  b = true then                  // 3 - kal
     begin
      if czas >= op[2]  then
        begin
         pom := 1 - StrToCurr(w23.Text);
         ak_masy[3]:= ak_masy[0] * pom ;
        end;

     if czas >= op[2] then      // 3 - kal -> grid
       begin
         TstringGrid(ActiveGrid).Cells[4,i+1]:=Currtostr(ak_masy[3]);
         b:=false;
       end else begin TstringGrid(ActiveGrid).Cells[4,i+1]:='0' end;
     end;

     if czas >= op[1]+op[3]  then      // 4 -  zólc      <-------------------- tu zobaczyć
        begin
          pom := 1 - StrToCurr(w56.Text);
          ak_masy[4]:= ak_masy[4] + ak_masy[2] * pom;
          pom:= czas - op[1]- op[3];
          ak_masy[4]:= ak_masy[4] - sz[4] * pom;
        end;

     if  czas >= op[1]+op[3] then                 // 4 - zólc -> grid
       begin
        if ak_masy[4] > 0 then
         begin TstringGrid(ActiveGrid).Cells[5,i+1]:=Currtostr(ak_masy[4]); end;
       end
         else begin TstringGrid(ActiveGrid).Cells[5,i+1]:='0' end;

// tu

 if czas >= op[1]+op[4]  then      // 5 -  krwiobieg
        begin
          pom:= czas - op[1] - op[4];
          wspB:=strtocurr(wwzb.Text) / 100 ;
          wspB:= strtocurr(dawka.Text) * 10 * wspB ;  // wspolczynnik B
          ak_masy[5]:= wspB - sz[5] * pom ;
        end;

     If ak_masy[5] < 0 then
        begin ak_masy[5]:=0;  end;

     if  czas >= op[1]+op[4] then                 // 5 - krwiobieg -> grid
       begin
        if ak_masy[5] > 0 then
          begin TstringGrid(ActiveGrid).Cells[6,i+1]:=Currtostr(ak_masy[5]); end;
       end else begin TstringGrid(ActiveGrid).Cells[6,i+1]:='0' end;


{ STARA WESJA

     if czas >= op[1]+op[4]  then      // 5 -  krwiobieg
        begin
          pom:= czas - op[1] - op[4];
          pom:= sz[5] * pom;
          ak_masy[5]:=  ak_masy[2] - pom;
        end;

     If ak_masy[5] < 0 then
        begin ak_masy[5]:=0;  end;

     if  czas >= op[1]+op[4] then                 // 5 - krwiobieg -> grid
       begin
        if ak_masy[5] > 0 then
          begin TstringGrid(ActiveGrid).Cells[6,i+1]:=Currtostr(ak_masy[5]/10); end;
       end else begin TstringGrid(ActiveGrid).Cells[6,i+1]:='0' end;

 }

 // nowa wersja krwionosnego

 if czas >= op[1]+op[4]  then      // 5 -  krwiobieg
        begin
          pom:= czas - op[1] - op[4];
          pom:= (-1 * sz[5]) * pom; // ujemny wspolczynnik kierunkowy a

          ak_masy[5]:= pom ; //+ ak_masy[1];
        end;

     If ak_masy[5] < 0 then
        begin ak_masy[5]:=0;  end;

     if  czas >= op[1]+op[4] then                 // 5 - krwiobieg -> grid
       begin
        if ak_masy[5] > 0 then
          begin TstringGrid(ActiveGrid).Cells[6,i+1]:=Currtostr(ak_masy[5]/10); end;
       end else begin TstringGrid(ActiveGrid).Cells[6,i+1]:='0' end;

 //--> end

     if czas >= op[1]+op[5]+ op[4] then      // 6 - mozg
        begin
          pom:= czas - op[1] - op[5] - op[4] ;
          pom:= sz[6] * pom;
          ak_masy[6]:= ak_masy[5] - pom;
        end;

     if  czas >= op[1]+op[5]+op[4] then                 // 6 - mozg -> grid
       begin
        if ak_masy[6] > 0 then
           begin TstringGrid(ActiveGrid).Cells[7,i+1]:=Currtostr(ak_masy[6]/10); end;
       end else begin TstringGrid(ActiveGrid).Cells[7,i+1]:='0' end;

end; // koniec petli

  for i:=1 to 7 do
   begin
     TstringGrid(ActiveGrid).AutoSizeColumn(i);
   end;

   // rysowanie wykresu
{ for i:=2 to 7 do
   begin
     wykresZkolumn(1,i);
   end;
  Form6.show;}

Form4.Hide;
form8.PageControl1.ActivePageIndex:=2;
form8.Show;

   end;
end;

procedure TForm4.lambda1Change(Sender: TObject);
begin
 if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj1.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda2Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj2.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda3Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj3.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda4Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj4.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda5Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj5.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda6Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj6.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.lambda7Change(Sender: TObject);
begin
  if (TLabeledEdit(sender).Text<>'') and (StrToFloatDef(TLabeledEdit(sender).Text,0)>0) then
  begin
  obj7.Text:=LambdaNaObjetosc(TLabeledEdit(sender).Text,masa.Text);
end;
end;

procedure TForm4.SpeedButton2Click(Sender: TObject);
begin
    lambda1.Text:='10.9';
    lambda2.Text:='10.9';
    lambda3.Text:='10.9';
    lambda4.Text:='10.9';
    lambda5.Text:='10.9';
    lambda6.Text:='10.9';
    lambda7.Text:='10.9';
    opuznienie1.Text:='0.13';
    opuznienie2.Text:='0.3';
    opuznienie3.Text:='1';
    opuznienie4.Text:='0.37';
    opuznienie5.Text:='0.17';
    opuznienie6.Text:='0.79';
    szybkosc1.Text:='7.25';
    szybkosc2.Text:='5.12';
    szybkosc3.Text:='4';
    szybkosc4.Text:='0.1';
    szybkosc5.Text:='3.533';
    szybkosc6.Text:='0.5';
    szybkosc7.Text:='0.1';
    w23.Text:='0.75';
    w56.Text:='0.95';
    wwzb.Text:='20.4';

   {  jesli decimal separator ',' to te dane

    lambda1.Text:='10,9';
    lambda2.Text:='10,9';
    lambda3.Text:='10,9';
    lambda4.Text:='10,9';
    lambda5.Text:='10,9';
    lambda6.Text:='10,9';
    lambda7.Text:='10,9';
    opuznienie1.Text:='0,226';
    opuznienie2.Text:='0,3';
    opuznienie3.Text:='1';
    opuznienie4.Text:='0,25';
    opuznienie5.Text:='0,12';
    opuznienie6.Text:='0,79';
    szybkosc1.Text:='7,25';
    szybkosc2.Text:='5,12';
    szybkosc3.Text:='4';
    szybkosc4.Text:='0,1';
    szybkosc5.Text:='0,47';
    szybkosc6.Text:='0,5';
    szybkosc7.Text:='-';
    w23.Text:='0,75';
    w56.Text:='0,95';}
end;
Procedure TForm4.wykresZkolumn(x,y:integer);
var
 i,ii:integer;
 ListaX,ListaY:TstringList;
begin
    ListaX:=TstringList.Create;
    ListaY:=TstringList.Create;
   if (x>0) and (x < TstringGrid(activeGrid).ColCount-1) and (y>0) then
     begin
      listaX.AddStrings(TstringGrid(activeGrid).Cols[x]);
      listaX.Delete(0);
       for i:=0 to listax.Count-1 do
         begin
           if (StrToFloatDef(ListaX[i],-1)=-1) and (StrToFloatDef(ListaX[i],1)=1) and (ListaX[i]>'')then
             begin
               if listax.Count-1=i then
                begin
                  break;
                end
                 else begin ListaX[i]:='-'; end;
             end;
         end;

         listaY.AddStrings(TstringGrid(activeGrid).Cols[y]);
         listaY.Delete(0);
          for ii:=0 to ListaY.Count-1 do
           begin
            if (StrToFloatDef(ListaY[ii],-1)=-1) and (StrToFloatDef(ListaY[ii],1)=1) and (ListaY[ii]>'') then
              begin
               if listaY.Count-1=ii then
                begin
                  break;
                end
                  else begin ListaY[ii]:='-'; end;
              end;
           end;
         // WykresNowaSeria(Form6.Chart,ListaX,ListaY);
          Form6.Show;
          ListaY.Free;
          ListaX.Free;
        end
          else begin Console.AddCommunicate(com16,true); end;

end;


initialization
  {$I unit5.lrs}

end.

