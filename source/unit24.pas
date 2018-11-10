(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit24;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterPas, SynMemo, SynEdit,
  synhighlighterunixshellscript, LResources, Forms, Controls, Graphics, Dialogs,
  EditBtn, StdCtrls, Buttons, ComCtrls, ExtCtrls, ColorBox, Biblioteka_Grow_4;

type

  { TForm24 }

  TForm24 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    DirectoryEdit1: TDirectoryEdit;
    DirectoryEdit2: TDirectoryEdit;
    Edit1: TEdit;
    FileNameEdit1: TFileNameEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    PageControl1: TPageControl;
    RadioButton1: TRadioButton;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    SynMemo1: TSynMemo;
    SynUNIXShellScriptSyn1: TSynUNIXShellScriptSyn;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Enter(Sender: TObject);
    procedure LabeledEdit2Enter(Sender: TObject);
    procedure LabeledEdit3Change(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure k(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure SynMemo1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form24: TForm24;

implementation

Uses
  Unit1, Unit22;
{ TForm24 }


procedure TForm24.SpeedButton1Click(Sender: TObject);
var
  i:integer;
  SimList,Macro:TstringList;
begin
  SimList:=Tstringlist.Create;
  Macro:=TstringList.Create;

  // load scene
  Macro.Add('LoadSce '+FileNameedit1.FileName+',Settings=No');
  // change force field
  Macro.Add('ForceField AMBER03,SetPar=No');
  //load sim and save pdb

  FileListFromDirectory(DirectoryEdit2.Directory+'\','*.sim',SimList);

  if Simlist.Count > 0 then
    begin
      for i:=0 to simList.Count -1 do
        begin
          Macro.Add('LoadSim '+DirectoryEdit2.Directory+'\'+SimList[i]+',assignSec=Yes');
          Macro.Add('SavePDB 1,'+DirectoryEdit1.Directory+'\'+Simlist[i]+'.pdb,Format=PDB,Transform=Yes');
        end;
    end else begin showmessage(com148); SimList.free; Macro.Free; exit; end;

  // save macro
  memo1.Clear;
  memo1.Lines.AddStrings(Macro);

 // Macro.SaveToFile(DirectoryEdit1.Directory+'\YasaraMacroSimToPdb.mcr');
 // showmessage('Saved:  '+DirectoryEdit1.Directory+'\YasaraMacroSimToPdb.mcr');

  SimList.free;
  Macro.Free;
end;

procedure TForm24.SpeedButton2Click(Sender: TObject);
begin
  Showmessage('Here are some useful examples how to use functions with correct syntax.'#10#13'They should to look like presented below:'#10#13
              + 'LoadSce C:\XXX.sce'#10#13
              + 'CleanAll '#10#13
              + 'Clear'#10#13
              + 'SwapRes 3letter_res_name res_number,3letter_res_name,Isomer=L'#10#13
              + 'ColorRes Atom atom_number,Color'#10#13
              + 'Experiment Minimization'#10#13
              + 'DelObj object_number'#10#13
              + 'DelAtom atom_number'#10#13
              + 'ForceField AMBER94,SetPar=No'#10#13
              + 'ForceField AMBER99,SetPar=No'#10#13
              + 'ForceField YAMBER,SetPar=No'#10#13
              + 'Style Ribbon'#10#13
              + 'Style Tube'#10#13
              + 'Style Ribbon'#10#13
              + 'Style Cartoon'#10#13
              + 'Style Sidechain=Stick'#10#13
              + 'JoinObj first_object_number - second_object_number,third_object_number'#10#13
              + 'LoadMOL2 file_name'#10#13
              + 'SupObj first_object,secend_object,Match=Yes,Flip=No,Unit=Mol'#10#13);

end;

procedure TForm24.SpeedButton3Click(Sender: TObject);
begin
  UniversalSaveFunction(IndexFilter_11,'','Final_Macro',Memo1.Lines);
end;

procedure TForm24.SpeedButton4Click(Sender: TObject);
begin
  Pagecontrol1.TabIndex:=0;
end;

procedure TForm24.SpeedButton5Click(Sender: TObject);
Var
  dir:string;
begin
  try
    dir:= UniversalOpenFunction(IndexFilter_11,'');
    if dir > '' then
     begin
        SynMemo1.Lines.LoadFromFile(dir);
     end;
  except
    Showmessage(com7);
  end;
end;

procedure TForm24.k(Sender: TObject);

begin

end;

procedure TForm24.SpeedButton6Click(Sender: TObject);
begin
  UniversalSaveFunction(IndexFilter_11,'','Macro',SynMemo1.Lines);
end;

procedure TForm24.SpeedButton7Click(Sender: TObject);
begin
  Showmessage(com160);
end;

procedure TForm24.SpeedButton8Click(Sender: TObject);
begin
  FileToCharacterSeparatedField(labeledEdit3,';');
end;

procedure TForm24.SpeedButton9Click(Sender: TObject);
begin
  FileToCharacterSeparatedField(labeledEdit4,';');
end;

procedure TForm24.FormCreate(Sender: TObject);
begin

end;

procedure TForm24.ComboBox2Change(Sender: TObject);
begin

end;

procedure TForm24.CheckBox1Change(Sender: TObject);
begin
  If Checkbox1.Checked then
    begin
     Labelededit1.Enabled:=false;
    end else begin Labelededit1.Enabled:=true; end;
end;

procedure TForm24.CheckBox1Click(Sender: TObject);
begin

end;

procedure TForm24.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm24.CheckBox2Change(Sender: TObject);
begin
If Checkbox2.Checked then
    begin
     Labelededit2.Enabled:=false;
     Labelededit8.Enabled:=false;
    end else begin
      Labelededit2.Enabled:=true;
      Labelededit8.Enabled:=true;
    end;
end;

procedure TForm24.ComboBox3Change(Sender: TObject);
begin

end;

procedure TForm24.LabeledEdit1Enter(Sender: TObject);
begin

end;

procedure TForm24.LabeledEdit2Enter(Sender: TObject);
begin

end;

procedure TForm24.LabeledEdit3Change(Sender: TObject);
begin

end;

procedure TForm24.SpeedButton10Click(Sender: TObject);
begin
  FileToCharacterSeparatedField(labeledEdit5,';');
end;

procedure TForm24.SpeedButton11Click(Sender: TObject);
Var
  Count,i,a:integer;
  lista,textt, res,mut,val:Tstrings;
begin

{if ((Pos('$Res',memo3.text) > 0) and ( labelededit3.Text > ''))
   or ((Pos('$Mut',memo3.Text) > 0) and ( labelededit4.Text > ''))
   or ((Pos('$Val',memo3.Text) > 0) and ( labelededit5.Text > ''))
then
 begin
   showmessage(com159 + '[1]');
 end
else
begin}

if Memo1.Lines.Count > 0 then
 begin
  if MessageDlg(com22, com146, mtConfirmation,[mbYes, mbNo],0) = mrYes then
    begin
      Memo1.Clear;
    end;
  end;


  res:= Tstringlist.Create;
  mut:= Tstringlist.Create;
  val:= Tstringlist.Create;

  // explode
    ExplodeString(';',labelededit3.Text,res);
    ExplodeString(';',labelededit4.Text,mut);
    ExplodeString(';',labelededit5.Text,val);

  textt:= Tstringlist.Create;

 // If (res.Count = mut.Count) and (mut.Count=val.Count) then
 //   begin
      for i:= 0 to Res.Count -1 do
        begin
          textt.clear;
          textt.AddStrings(SynMemo1.Lines);

          for a:= 0 to textt.Count-1 do
            begin
              try
                textt[a]:= StringReplace(textt[a],'$Dir',Labelededit6.Text,[rfReplaceAll, rfIgnoreCase]);
                textt[a]:= StringReplace(textt[a],'$Res',Res[i],[rfReplaceAll, rfIgnoreCase]);
                textt[a]:= StringReplace(textt[a],'$Mut',Mut[i],[rfReplaceAll, rfIgnoreCase]);
                textt[a]:= StringReplace(textt[a],'$Val',Val[i],[rfReplaceAll, rfIgnoreCase]);
              except
              end;
            end;

          Memo1.Lines.AddStrings(textt);

        end;
  //  end else begin showmessage(com159 + '[2]'); end;

  res.Free;
  mut.Free;
  val.Free;
  textt.Free;

  Pagecontrol1.ActivePage:=TabSheet2;

// end;
end;

procedure TForm24.SpeedButton12Click(Sender: TObject);
begin
  LabeledEdit6.Text:= UniversalDirectoryFunction('');
end;

procedure TForm24.SpeedButton13Click(Sender: TObject);
var
  texti:string;
begin
  texti:='';

  if Combobox2.Text > '' then
    begin
      texti:= Combobox2.Text + ' ';
    end;

  if Combobox3.Text <> 'None' then
    begin
      texti:= texti + ' ' +Combobox3.Text;
    end;

  texti:= texti + ' ' + labelededit7.Text;

  SynMemo1.Lines.Add(texti);
end;

procedure TForm24.SpeedButton14Click(Sender: TObject);
Var
 list1,list_all,lines: Tstringlist ;
 i,a,b,range_from,range_to:integer;
 OpenD:Topendialog;
 reple_f,reple_to:string;

begin

 Lines:=Tstringlist.Create;

// parameters from form
if (checkbox1.Checked = False) and (labelededit1.Text > '') then
  begin
   try
    ExplodeString(';',labelededit1.Text,lines);
   except
     showmessage(com161);
   end;
  end;

if (checkbox2.Checked = False) and (labelededit2.Text > '') and (labelededit8.Text > '')then
  begin
   try
     range_from:= StrToInt(labelededit2.Text);
     range_to:= StrToInt(labelededit8.Text);
   except
     showmessage(com161);
   end;
  end;

if (labelededit9.Text > '') and (labelededit10.Text > '') then
  begin
    reple_f:=labelededit9.Text;
    reple_to:=labelededit10.Text;
  end;


 OpenD:=Topendialog.Create(nil);

    OpenD.Filter:= 'all (*.*)|*.*';
    OpenD.Options := [ofFileMustExist,ofAllowMultiSelect];

    list1:= Tstringlist.Create;
    list_all:= Tstringlist.Create;

      if OpenD.Execute then
       begin
          for i := 0 to OpenD.Files.Count-1 do
           begin
             list1.Clear;
             list1.LoadFromFile(OpenD.Files[i]);

             // extraction process

             for a:=0 to List1.count -1 do // kazda linia pliku
              begin
                if checkbox1.Checked = False then // jak nie wszytskie linie
                 begin
                   for b:=0 to Lines.count -1 do // jesli numer lini odowiada
                    begin
                      if a = strtoint(lines[b])-1 then // wybierz tylko range !!!! +1 bo norlanie plik czyta sie od 1,2,3, itp ulatni ludziom
                       begin
                        if checkbox2.Checked = false then
                         begin
                          if (reple_f <> '') and (reple_to <> '') then
                           begin

                             list_all.add(StringReplace(copy(list1[a],range_from,range_from+range_to),reple_f,reple_to,[rfReplaceAll, rfIgnoreCase]));
                             // dopisz na zwe pliku na pocztaku wiersza
                             if checkBox3.Checked then begin list_all[list_all.Count-1]:= ExtractFileName(OpenD.Files[i])+' '+ list_all[list_all.Count-1] end;

                           end else
                              begin
                                 list_all.add(copy(list1[a],range_from,range_from+range_to));
                                 // dopisz na zwe pliku na pocztaku wiersza
                                 if checkBox3.Checked then begin list_all[list_all.Count-1]:= ExtractFileName(OpenD.Files[i])+' '+ list_all[list_all.Count-1] end;
                              end;
                              // repleace signs
                         end else
                                begin
                                   if (reple_f <> '') and (reple_to <> '') then
                                      begin
                                          list_all.add(StringReplace(list1[a],reple_f,reple_to,[rfReplaceAll, rfIgnoreCase]));
                                          // dopisz na zwe pliku na pocztaku wiersza
                                          if checkBox3.Checked then begin list_all[list_all.Count-1]:= ExtractFileName(OpenD.Files[i])+' '+ list_all[list_all.Count-1] end;
                                      end else
                                         begin
                                           list_all.add(list1[a]);
                                           // dopisz na zwe pliku na pocztaku wiersza
                                          if checkBox3.Checked then begin list_all[list_all.Count-1]:= ExtractFileName(OpenD.Files[i])+' '+ list_all[list_all.Count-1] end;
                                         end;
                                end;
                          end;                                                      ExtractFileName(OpenD.Files[i])
                       end;
                 end else begin list_all.add(list1[a]); end;  // jak nie bierz cala linie
                 end;


             // end
           end;
       end;

 Memo2.Lines.Clear;
 Memo2.Lines.AddStrings(list_all);

 list1.Free;
 list_all.Free;
 lines.Free;

 OpenD.Free;
end;

procedure TForm24.SpeedButton15Click(Sender: TObject);
begin
  UniversalSaveFunction(IndexFilter_4,'','General_results',Memo2.Lines);
end;

procedure TForm24.SpeedButton16Click(Sender: TObject);
Var
 i:integer;
 seq1,seq2,command:string;
 alignment: TstringList;
begin

  Alignment:= Tstringlist.Create;
  Alignment.Add('');

  alignment[0]:='';

   memo3.Lines.Text:= StringReplace(memo3.Lines.Text, #13, '', [rfReplaceAll]);        // ?????????????????????? czemu nie zamienia
   memo3.Lines.Text:= StringReplace(memo3.Lines.Text, #10, '', [rfReplaceAll]);
   memo4.Lines.Text:= StringReplace(memo4.Lines.Text, #13, '', [rfReplaceAll]);
   memo4.Lines.Text:= StringReplace(memo4.Lines.Text, #10, '', [rfReplaceAll]);

  for i:=1 to Length(memo3.Lines.Text) -1 do
   begin

     seq1:= memo3.Lines.Text[i];
     seq2:= memo4.Lines.Text[i];

    if ((combobox5.Text='equal') and (seq1 = seq2)) or ((combobox5.Text='different') and (seq1 <> seq2)) then
     begin

       command:='';

    // do for seq 1

       command:= Combobox1.Text;

       command:= command+ inttostr(strtointdef(labelededit13.Text,0)+i-1);

       If Edit1.Text <> '0' then
        begin
          command:= command+ ' Object '+ Edit1.Text;
        end;

        if combobox1.Text = 'ColorRes' then
         begin
            command:= command+ ' ,'+ Combobox4.Text;
         end;

        Console.AddCommunicate(combobox5.Text+' => '+seq1+' '+copy(alignment[0],i,1)+' '+seq2+'    C:'+command,true);

        memo1.Lines.Add(command);
     end;

   if seq1 = seq2 then
     begin
       alignment[0]:= alignment[0] +'T' ;
     end;

   if seq1 <> seq2 then
     begin
       alignment[0]:= alignment[0] +'F' ;
     end;

   end;

 Pagecontrol1.ActivePageIndex:=2;

 memo1.Lines.Add('#Result:');
 memo1.Lines.Add('#'+memo3.Lines.Text);
 memo1.Lines.Add('#'+alignment[0]);
 memo1.Lines.Add('#'+memo4.Lines.Text);
 //Console.AddCommunicate(#13+#10+seq1+#13+#10+alignment+#13+#10+seq2,true);
end;

procedure TForm24.SpeedButton17Click(Sender: TObject);
begin
  memo1.Lines.Clear;
end;

procedure TForm24.StaticText1Click(Sender: TObject);
begin

end;

procedure TForm24.SynMemo1Change(Sender: TObject);
begin

end;

initialization
  {$I unit24.lrs}

end.

