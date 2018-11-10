(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit1;


interface

uses
  {$ifdef unix}
  cthreads,
  cmem,
  {$endif}
  LCLIntf, SysUtils, FileUtil, Classes, Graphics, Controls, Process, Forms,
  Dialogs, Math, Menus, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  LResources, EditBtn, unit2, unit3, unit4, Unit5, Unit6, Unit7, LCLtype, unit8,
  Unit9, Unit10, Unit11, Unit12, Unit13, Unit14, Unit15, Unit16, Unit17, Unit18,
  Unit19, Unit20, Unit21, Unit22, Unit23, Unit24, Unit25, Clipbrd, gettext, Printers,
  FileCtrl, PairSplitter, IniPropStorage, Biblioteka_Grow_4, General_dll,
  Biblioteka_Grow_4_grafika, Biblioteka_Grow_4_konsola, SdfData, db, ShellApi, import_dll;

ResourceString

{$I stale.inc} // dolacz stale i zmienne globalne
{$I zmienne_globalne.inc}  // zmienne globalne

//-- NEW
{$I coms_errors.inc}
{$I Objects_def.inc}

type

  { TMainForm }

  TMainForm = class(TForm)
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem114: TMenuItem;
    MenuItem126: TMenuItem;
    MenuItem127: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem131: TMenuItem;
    MenuItem132: TMenuItem;
    MenuItem133: TMenuItem;
    MenuItem134: TMenuItem;
    MenuItem135: TMenuItem;
    MenuItem136: TMenuItem;
    MenuItem137: TMenuItem;
    MenuItem138: TMenuItem;
    MenuItem139: TMenuItem;
    MenuItem140: TMenuItem;
    MenuItem141: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem79: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem80: TMenuItem;
    MenuItem81: TMenuItem;
    MenuItem82: TMenuItem;
    MenuItem83: TMenuItem;
    MenuItem84: TMenuItem;
    MenuItem85: TMenuItem;
    MenuItem86: TMenuItem;
    MenuItem87: TMenuItem;
    MenuItem88: TMenuItem;
    MenuItem89: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem90: TMenuItem;
    MenuItem91: TMenuItem;
    MenuItem92: TMenuItem;
    MenuItem93: TMenuItem;
    MenuItem94: TMenuItem;
    MenuItem95: TMenuItem;
    MenuItem96: TMenuItem;
    MenuItem97: TMenuItem;
    MenuItem98: TMenuItem;
    MenuItem99: TMenuItem;
    OpenDialog1: TOpenDialog;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PopupMenu5: TPopupMenu;
    SaveDialog1: TSaveDialog;
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Nowyprojekt1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton26: TToolButton;
    ToolButton2: TToolButton;
    ToolButton28: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    abeladanych1: TMenuItem;
    Dodajwiersz1: TMenuItem;
    Dodajwpis1: TMenuItem;
    Usu1: TMenuItem;
    Zmienazw1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox6Click(Sender: TObject);
    procedure ListBox2SelectionChange(Sender: TObject; User: boolean);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem100Click(Sender: TObject);
    procedure MenuItem101Click(Sender: TObject);
    procedure MenuItem102Click(Sender: TObject);
    procedure MenuItem103Click(Sender: TObject);
    procedure MenuItem104Click(Sender: TObject);
    procedure MenuItem105Click(Sender: TObject);
    procedure MenuItem106Click(Sender: TObject);
    procedure MenuItem107Click(Sender: TObject);
    procedure MenuItem108Click(Sender: TObject);
    procedure MenuItem109Click(Sender: TObject);
    procedure MenuItem110Click(Sender: TObject);
    procedure MenuItem111Click(Sender: TObject);
    procedure MenuItem112Click(Sender: TObject);
    procedure MenuItem113Click(Sender: TObject);
    procedure MenuItem114Click(Sender: TObject);
    procedure MenuItem115Click(Sender: TObject);
    procedure MenuItem116Click(Sender: TObject);
    procedure MenuItem117Click(Sender: TObject);
    procedure MenuItem118Click(Sender: TObject);
    procedure MenuItem119Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem120Click(Sender: TObject);
    procedure MenuItem121Click(Sender: TObject);
    procedure MenuItem122Click(Sender: TObject);
    procedure MenuItem123Click(Sender: TObject);
    procedure MenuItem124Click(Sender: TObject);
    procedure MenuItem125Click(Sender: TObject);
    procedure MenuItem126Click(Sender: TObject);
    procedure MenuItem127Click(Sender: TObject);
    procedure MenuItem128Click(Sender: TObject);
    procedure MenuItem129Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem130Click(Sender: TObject);
    procedure MenuItem131Click(Sender: TObject);
    procedure MenuItem132Click(Sender: TObject);
    procedure MenuItem133Click(Sender: TObject);
    procedure MenuItem134Click(Sender: TObject);
    procedure MenuItem135Click(Sender: TObject);
    procedure MenuItem136Click(Sender: TObject);
    procedure MenuItem137Click(Sender: TObject);
    procedure MenuItem138Click(Sender: TObject);
    procedure MenuItem139Click(Sender: TObject);
    procedure MenuItem140Click(Sender: TObject);
    procedure MenuItem141Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);

    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject;auto:string='');
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem67Click(Sender: TObject);
    procedure MenuItem68Click(Sender: TObject);
    procedure MenuItem69Click(Sender: TObject);
    procedure MenuItem70Click(Sender: TObject);
    procedure MenuItem71Click(Sender: TObject);
    procedure MenuItem72Click(Sender: TObject);
    procedure MenuItem73Click(Sender: TObject);
    procedure MenuItem78Click(Sender: TObject);
    procedure MenuItem79Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem80Click(Sender: TObject);
    procedure MenuItem81Click(Sender: TObject);
    procedure MenuItem82Click(Sender: TObject);
    procedure MenuItem83Click(Sender: TObject);
    procedure MenuItem84Click(Sender: TObject);
    procedure MenuItem86Click(Sender: TObject);
    procedure MenuItem87Click(Sender: TObject);
    procedure MenuItem88Click(Sender: TObject);
    procedure MenuItem89Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem90Click(Sender: TObject);
    procedure MenuItem91Click(Sender: TObject);
    procedure MenuItem92Click(Sender: TObject);
    procedure MenuItem93Click(Sender: TObject);
    procedure MenuItem94Click(Sender: TObject);
    procedure MenuItem96Click(Sender: TObject);
    procedure MenuItem97Click(Sender: TObject);
    procedure MenuItem98Click(Sender: TObject);
    procedure MenuItem99Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure Okna1Click(Sender: TObject);
    procedure OpenDialog1Show(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PairSplitter1Resize(Sender: TObject);
    procedure PairSplitterSide2Resize(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure StringGridBeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGridCheckboxToggled(sender: TObject; aCol, aRow: Integer;
      aState: TCheckboxState);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure StringGridEditingDone(Sender: TObject);
    procedure StringGridExit(Sender: TObject);
    procedure StringGridHeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure StringGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGridSelection(Sender: TObject; aCol, aRow: Integer);
    procedure Timer1StopTimer(Sender: TObject);
    procedure ToolBar1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton23Click(Sender: TObject);
    procedure ToolButton24Click(Sender: TObject);
    procedure ToolButton25Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton28Click(Sender: TObject);
    procedure ToolButton29Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure ToolButton31Click(Sender: TObject);
    procedure ToolButton32Click(Sender: TObject);
    procedure ToolButton34Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure PageControlPageChanged(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Nowyprojekt1Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure ukryjPasekBocznyExecute(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Dodajkolumne1Click(Sender: TObject);
    procedure Dodajwiersz1Click(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ToggleTreeViewCheckBoxes(Node:TTreeNode);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

procedure TMainForm.ToggleTreeViewCheckBoxes(Node:TTreeNode);
var
  tmp:TTreeNode;
  i:integer;
begin
  if Assigned(Node) then
  begin
    if Node.StateIndex = 0 then
      begin
        Node.StateIndex := 1;
        i:=1;
      end
    else if Node.StateIndex = 1 then
      begin
        Node.StateIndex := 0;
        i:=0;
      end;

    tmp := tmp.getFirstChild;

    while Assigned(tmp) do
      begin

          tmp.StateIndex := i;

          tmp := tmp.getNextSibling;
      end;
    end;
end;

procedure TMainForm.StringGridDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  Tstringgrid(sender).SelectedColor:=$00DE8800;
end;

procedure TMainForm.StringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TMainForm.StringGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

// Funkcje nie wyliczeniowe
//begin

procedure TMainForm.MenuItem12Click(Sender: TObject);
begin
  CutGridToClipboard();
end;

procedure TMainForm.MenuItem130Click(Sender: TObject);
begin
   Form13.Show;
end;

procedure TMainForm.MenuItem131Click(Sender: TObject);
begin
  //FillSectionAs('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(activeGrid),0,'ATOM');
end;

procedure TMainForm.MenuItem132Click(Sender: TObject);
begin
 // FillSectionAs('Project',MainForm.PageControl.ActivePageIndex-1,TstringGrid(activeGrid),0,'HETATM');
end;

procedure TMainForm.MenuItem133Click(Sender: TObject);
begin
  GridGetSelection(Sender);  // get selection
end;

procedure TMainForm.MenuItem134Click(Sender: TObject);
begin
  if menuitem134.Checked then
   begin
     IVM.StringGrid1.Width:=250;
   end
    else
  begin
     IVM.StringGrid1.Width:=0;
  end;
end;

procedure TMainForm.MenuItem135Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem136Click(Sender: TObject);
begin
  Form15.Show;
end;

procedure TMainForm.MenuItem137Click(Sender: TObject);
begin
  Form16.show;
end;

procedure TMainForm.MenuItem138Click(Sender: TObject);
begin
  Form17.Show;
end;

procedure TMainForm.MenuItem139Click(Sender: TObject);
begin
  Console.Show;
end;

procedure TMainForm.MenuItem140Click(Sender: TObject);
begin
   SaveProjectAs(Sender);
end;

procedure TMainForm.MenuItem141Click(Sender: TObject);
begin
  Form24.show;
end;

procedure TMainForm.MenuItem15Click(Sender: TObject);
begin
   PasteGridFromClipboard();
end;

procedure TMainForm.MenuItem16Click(Sender: TObject);
begin
   Form3.Show;
end;

procedure TMainForm.MenuItem11Click(Sender: TObject);
begin
  Form3.Show;
  form3.BringToFront;
end;

procedure TMainForm.MenuItem120Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem121Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem122Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem123Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem124Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem125Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem126Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem127Click(Sender: TObject);
begin
  Form13.Show;
end;

procedure TMainForm.MenuItem128Click(Sender: TObject);
begin
  Form13.Show;
end;

procedure TMainForm.MenuItem129Click(Sender: TObject);
begin
   Form13.Show;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  x: Integer;
begin

  if (Project_table_form.StringGrid1.RowCount > 1) then
   begin

     x:= MessageDlg('Close the program?', Com142, mtWarning, [mbYes, mbNo], 0 , mbNo);

     if x = mrYes then
      begin
       settings.SpeedButton1Click(sender); // save setings form ( do or not ?)
       Exit;
      end
     else
     begin
       CloseAction := caNone;
     end;
   end;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_LEFT: g4g_rotationy := g4g_rotationy - 3;
    VK_RIGHT: g4g_rotationy := g4g_rotationy + 3;
    VK_UP: g4g_rotationx := g4g_rotationx + 3;
    VK_DOWN: g4g_rotationx := g4g_rotationx - 3;
  end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 32 then // spacja pokaż konsole
    begin
      MainForm.ToolButton16Click(nil);
    end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if  PairSplitterSide2.Height > 5 then
  begin
     PairSplitter1.Position:=PairSplitter1.Height;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  PairSplitter1.Position:=PairSplitter1.Height;
  Mainform.WindowState:= wsMaximized;
  IVM.WindowState:=wsMaximized;
end;

procedure TMainForm.GroupBox6Click(Sender: TObject);
begin

end;

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin

end;

procedure TMainForm.Edit1Exit(Sender: TObject);
begin

end;

procedure TMainForm.FormClick(Sender: TObject);

begin

end;

procedure TMainForm.Button1Click(Sender: TObject);

begin
  {  TempRecord[ObjectsList_Included]:= '0';

    TempRecord[ObjectsList_Name]:= 'name';
    TempRecord[ObjectsList_Type]:= 'type';
    TempRecord[ObjectsList_Original_File_Name]:= 'org file name';
    TempRecord[ObjectsList_Comment]:= 'comment';
    TempRecord[ObjectsList_Visualization_Type]:= 'vis_type';

    object_number:= AddObject();
        }
    ArrayToConsole('ObjectsList');

end;

procedure TMainForm.Button2Click(Sender: TObject);
begin

    {TempRecordClear();

    TempRecord[Object_Type]:= inttostr(Object_Type)+'Object_Type';
    TempRecord[Object_Vis]:= inttostr(Object_Vis)+'Object_Vis';
    TempRecord[Object_Inc]:= inttostr(Object_Inc)+'Object_Inc';

    TempRecord[Atom_ID]:= inttostr(Atom_ID)+'Atom_ID';
    TempRecord[Atom_Name]:= inttostr(Atom_Name)+'Atom_Name';
    TempRecord[Atom_AlternateLocationIndicator]:=inttostr(Atom_AlternateLocationIndicator)+'Atom_AlternateLocationIndicator';
    TempRecord[Atom_ResidueName]:= inttostr(Atom_ResidueName)+'Atom_ResidueName';
    TempRecord[Atom_ChainIdentifier]:= inttostr(Atom_ChainIdentifier)+'Atom_ChainIdentifier';
    TempRecord[Atom_SequenceNr]:= inttostr(Atom_SequenceNr)+'Atom_SequenceNr';
    TempRecord[Atom_Code_insertion_residues]:=inttostr(Atom_Code_insertion_residues)+'Atom_Code_insertion_residues';
    TempRecord[Atom_X]:= inttostr(random(100));
    TempRecord[Atom_Y]:= inttostr(random(100));
    TempRecord[Atom_Z]:= inttostr(random(100));
    TempRecord[Atom_Occupancy]:= inttostr(Atom_Occupancy)+'Atom_Occupancy';
    TempRecord[Atom_TemperatureFactor]:= inttostr(Atom_TemperatureFactor)+'Atom_TemperatureFactor';
    TempRecord[Atom_ElementSymbol]:= inttostr(Atom_ElementSymbol)+'Atom_ElementSymbol';
    TempRecord[Atom_ChargeOnTheAtom]:= inttostr(Atom_ChargeOnTheAtom)+'Atom_ChargeOnTheAtom';


    TempRecord[Object_Radius]:=inttostr(Object_Radius)+ 'Object_Radius';
    TempRecord[Ocject_Color]:= inttostr(Ocject_Color)+ 'Ocject_Color';

     AddRecord(Object_Type_Atom,object_number);

     Console.Memo1.Lines.Clear;}

     ArrayToConsole('Objects');


end;

procedure TMainForm.ListBox2SelectionChange(Sender: TObject; User: boolean);
begin
  //Pagecontrol.ActivePageIndex:=listbox2.ItemIndex+1;
end;

procedure TMainForm.Memo1Change(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem100Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem101Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem102Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem103Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem104Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem105Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem106Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem107Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem108Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem109Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem110Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem111Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem112Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem113Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem114Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem115Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem116Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem117Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem118Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem119Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem17Click(Sender: TObject);
var
  kol,litery:TstringList;
  x,s:integer;
  cur: array of currency;
  nazwa_kolumny:string;
begin
  kol:= TstringList.Create;
  litery:=TstringList.Create;
  kol.AddStrings(TstringGrid(activeGrid).Cols[xGrid]);
  nazwa_kolumny:=kol[0];
  kol.Delete(0);
s:=-1;
SetLength(cur,kol.Count);
 for x:=0 to kol.Count-1 do
    begin
      if (strtocurrdef(kol[x],-1)>-1) or (strtocurrdef(kol[x],1)<1) and (trim(kol[x])<>'') then
        begin
          s:=s+1;
          cur[s]:=strtocurr(kol[x]);
        end
         else
        begin
          litery.Add(kol[x]);
        end;
    end;
SetLength(cur,s+1);
//sortowanie begin
QuickSort(cur,low(cur),high(cur));
//sortowanie end
 kol.Clear;
 litery.Sort;
 kol.AddStrings(litery);
 for x:=0 to high(cur) do
 begin
   kol.Add(currtostr(cur[x]));
 end;

  kol.Insert(0,nazwa_kolumny);
  TstringGrid(activeGrid).Cols[xGrid].Clear;
  TstringGrid(activeGrid).Cols[xGrid].AddStrings(kol);

 kol.Free;
 litery.Free;
 SetLength(cur,0);
end;

procedure TMainForm.MenuItem20Click(Sender: TObject);
begin

end;


procedure TMainForm.MenuItem22Click(Sender: TObject;auto:string);
begin
  OpenProject(False,'');
end;

procedure TMainForm.MenuItem23Click(Sender: TObject);
begin
  Dodajkolumne1Click(sender);
  ponumeruj_kolumny(sender);
end;

procedure TMainForm.MenuItem24Click(Sender: TObject);
begin
  Dodajwiersz1Click(sender);
  ponumeruj_kolumny(sender);
end;

procedure TMainForm.MenuItem25Click(Sender: TObject);
begin
   Tstringgrid(activeGrid).DeleteColRow(True,xGrid);
   ponumeruj_kolumny(activeGrid);
end;

procedure TMainForm.MenuItem26Click(Sender: TObject);
begin
  Tstringgrid(activeGrid).DeleteColRow(false,yGrid);
  ponumeruj_kolumny(activeGrid);
end;

procedure TMainForm.MenuItem27Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem28Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem29Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem31Click(Sender: TObject);
var
  pdb_code:string;
  pdb_code_list:TstringList;
  SaveDialog:TselectDirectoryDialog;
begin

  pdb_code:= inputbox(com26,com37,'');

  pdb_code_list := TstringList.Create;

  ExplodeString(';',pdb_code,pdb_code_list);

  if (pdb_code_list.Count > 0) and (length(pdb_code) > 0) then
    begin

      SaveDialog:=TselectDirectoryDialog.Create(MainForm);
      Savedialog.InitialDir:= ExtractFilePath(Application.ExeName) +'local_PDB';

     if Savedialog.Execute then
       begin
        if Savedialog.FileName > '' then
          begin

           Console.AddCommunicate(com147+'Start '+IntToStr(pdb_code_list.Count)+' file(s)',true);

        if DownloadPDBfiles(pdb_code_list,UTF8decode(Savedialog.FileName)) = true then
          begin
           Console.AddCommunicate(com147+'Compleated '+IntToStr(pdb_code_list.Count)+' file(s)',true);

         { if MessageDlg(com40+'[local_PDB], import now?', mtConfirmation, mbYesNo, 0) = mrYes then
             begin
             end;}

           end else begin Console.AddCommunicate(com147+'Download failed for '+IntToStr(pdb_code_list.Count)+' file(s)',true); end;
         end;
    end;
Savedialog.Free;
end;
end;

procedure TMainForm.MenuItem32Click(Sender: TObject);
begin
  Form12.show;
end;

procedure TMainForm.MenuItem33Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem34Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem35Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem36Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem37Click(Sender: TObject);
begin
  form7.show;
end;

procedure TMainForm.MenuItem38Click(Sender: TObject);
begin
   mainform.Close;
end;

procedure TMainForm.MenuItem39Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem40Click(Sender: TObject);
begin
  //  http://www.cgl.ucsf.edu/home/meng/grpmt/structalign.html
  //  http://mspc.bii.a-star.edu.sg/minhn/
  //  http://bioinfo3d.cs.tau.ac.il/MultiProt/
end;


procedure TMainForm.MenuItem41Click(Sender: TObject);
begin
  form7.show;
end;

procedure TMainForm.MenuItem42Click(Sender: TObject);
begin
  form7.Show;
end;

procedure TMainForm.MenuItem44Click(Sender: TObject);
begin
  form7.show;
end;

procedure TMainForm.MenuItem45Click(Sender: TObject);
begin
  form7.Show;
end;

procedure TMainForm.MenuItem46Click(Sender: TObject);
begin
   SelectAllGrid();
end;

procedure TMainForm.MenuItem47Click(Sender: TObject);
begin
  Grid_as_CSV(TstringGrid(activegrid),';');
end;

procedure TMainForm.MenuItem48Click(Sender: TObject);
begin
  //PrintGrid(Tstringgrid(activegrid),PageControl.activepage.caption );
end;

procedure TMainForm.MenuItem49Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem50Click(Sender: TObject);
begin
  GridGetSelection(Sender);
end;

procedure TMainForm.MenuItem51Click(Sender: TObject);
begin
  Form9.Show;
end;

procedure TMainForm.MenuItem52Click(Sender: TObject);
begin
  Console.AddCommunicate(com44,true);
end;

procedure TMainForm.MenuItem53Click(Sender: TObject);
begin
  Form10.show;
end;

procedure TMainForm.MenuItem54Click(Sender: TObject);
begin
  //Savedialog1.FileName:= Pagecontrol.ActivePage.Caption + '.mol2';
  Savedialog1.Filter:= 'MOL2 (*.mol2)|*.mol2';
  if SaveDialog1.Execute then
   begin
     if Savedialog1.FileName > '' then
      begin
       If Copy(Savedialog1.FileName,Pos('.',Savedialog1.FileName),Length(Savedialog1.FileName)-Pos('.',Savedialog1.FileName)+1) <> '.xml' Then Savedialog1.FileName := Savedialog1.FileName + '.xml';
       try
         begin
            TstringGrid(activegrid).SaveToFile(UTF8decode(Savedialog1.FileName));
         end;
       except
         Console.AddCommunicate(com7,true);
       end;
      end;
   end;
end;

procedure TMainForm.MenuItem55Click(Sender: TObject);
var
 modele:TstringList;
 b,i,connect,ilosc_connect:integer;

begin

if (project_table_form.StringGrid1.RowCount > 1) then
begin
  //Savedialog1.FileName:= Pagecontrol.ActivePage.Caption + '.pdb';
  Savedialog1.Filter:= 'PDB (*.pdb)|*.pdb';

  modele := TstringList.Create;

  for i:=1 to project_table_form.stringgrid1.RowCount-1 do
    begin
       if (project_table_form.stringgrid1.Cells[1,i] = '1')
        or (project_table_form.stringgrid1.Cells[2,i] = '1') then // checked Inc.
         begin
           modele.Add(inttostr(i));
         end;
    end;


if SaveDialog1.Execute then
   begin
     if Savedialog1.FileName > '' then
      begin
       If Copy(Savedialog1.FileName,Pos('.',Savedialog1.FileName),Length(Savedialog1.FileName)-Pos('.',Savedialog1.FileName)+1) <> '.pdb'
         Then Savedialog1.FileName := Savedialog1.FileName + '.pdb';


   // zapisz normalnie z conect z tabeli , false bo nie koordynaty tymczasowe
     Save_as_PDB(modele,UTF8Decode(Savedialog1.FileName),false);

   end;
end;
  modele.Free;
end;
end;

procedure TMainForm.MenuItem56Click(Sender: TObject);
begin
   GridAsxMOL(Sender);
end;

procedure TMainForm.MenuItem57Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem59Click(Sender: TObject);
begin
  TrimGrid();
end;


procedure TMainForm.MenuItem5Click(Sender: TObject);
begin
  form4.Show;
end;


procedure TMainForm.MenuItem62Click(Sender: TObject);
begin
  //project_table_form.StringGrid1.Cells[1,Pagecontrol.ActivePageIndex]:= '1';
  //CheckColumn(TstringGrid(MainForm.PageControl.ActivePage.Controls[0]),True,1);
end;

procedure TMainForm.MenuItem63Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem64Click(Sender: TObject);
begin
  Console.AddCommunicate('opcja dostępna po doinstalowaniu modulu PDF!',true);
end;

procedure TMainForm.MenuItem65Click(Sender: TObject);
begin
  settings.Show;
end;

procedure TMainForm.MenuItem66Click(Sender: TObject);
begin
  Form13.Show;
end;

procedure TMainForm.MenuItem67Click(Sender: TObject);
begin
  ProjectAsHTML(Sender);
end;

procedure TMainForm.MenuItem68Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem69Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem70Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem71Click(Sender: TObject);
begin
  GridTranspozeRowsToColumns();
end;

procedure TMainForm.MenuItem72Click(Sender: TObject);
begin
  GridTranspozeColumnsToRows();
end;

procedure TMainForm.MenuItem73Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem78Click(Sender: TObject);
begin
  project_table_form.show;
end;

procedure TMainForm.MenuItem79Click(Sender: TObject);
begin
  MenuItem55Click(Sender);
end;

procedure TMainForm.MenuItem7Click(Sender: TObject);
begin
  ExportAsXML(Sender);
end;

procedure TMainForm.MenuItem80Click(Sender: TObject);
begin
  ExportAsXML(Sender);
end;

procedure TMainForm.MenuItem81Click(Sender: TObject);
begin
  Grid_as_CSV(TstringGrid(activegrid),';');
end;

procedure TMainForm.MenuItem82Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem83Click(Sender: TObject);
begin
  GridAsxMOL(Sender);
end;

procedure TMainForm.MenuItem84Click(Sender: TObject);
begin
  ProjectAsHTML(Sender);
end;

procedure TMainForm.MenuItem86Click(Sender: TObject);
var
 options:string;
 i:integer;
begin

 MainForm.Opendialog1.Filter:= IndexFilter_2;  // TODO: ADD MOL2 and OPEN BABEL

 MainForm.Opendialog1.Options := MainForm.Opendialog1.Options + [ofAllowMultiSelect]; // allow multislection

 If MainForm.OpenDialog1.Execute then // open dilaog
begin
 for i:=0 to Mainform.Opendialog1.Files.Count -1 do
  begin
     ImportAsPDB(Mainform.OpenDialog1.Files[i]); // load files
  end;
end;

 //MoveCoordinateSystemTo(0,0,0);

 //g4g_center:=true;

 MainForm.Opendialog1.Options := MainForm.Opendialog1.Options - [ofAllowMultiSelect]; // allow multislection
end;

procedure TMainForm.MenuItem87Click(Sender: TObject);
begin
  ImportGridAsXML(Sender);
end;

procedure TMainForm.MenuItem88Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem89Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin
  ImportGridAsXML(Sender);
end;

procedure TMainForm.MenuItem90Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem91Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem92Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem93Click(Sender: TObject);
begin
  CloseProject();
end;

procedure TMainForm.MenuItem94Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem96Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem97Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem98Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem99Click(Sender: TObject);
begin

end;


procedure TMainForm.MenuItem9Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TMainForm.Okna1Click(Sender: TObject);
begin

end;

procedure TMainForm.OpenDialog1Show(Sender: TObject);
begin

end;

procedure TMainForm.PageControlChange(Sender: TObject);
begin

end;

procedure TMainForm.PairSplitter1Resize(Sender: TObject);
begin
 { if (IVM.Visible = true) then
     begin
       IVM.Left:=  0;
       IVM.Width:= MainForm.PageControl.Width ;
       IVM.Top:= 0;
       IVM.Height:= MainForm.Panel2.Height;
     end;   }
end;

procedure TMainForm.PairSplitterSide2Resize(Sender: TObject);
begin
  Console.Top:=0;
  Console.Left:=5;
  Console.Width:=PairsplitterSide2.Width-10;
  Console.Height:=PairsplitterSide2.Height;
end;

procedure TMainForm.Panel1Click(Sender: TObject);
begin

end;

procedure TMainForm.Panel2Resize(Sender: TObject);
begin

end;

procedure TMainForm.Panel3Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton10Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton15Click(Sender: TObject);
begin
  WhatVisInc();
end;

procedure TMainForm.SpeedButton16Click(Sender: TObject);
begin
  WhatVisInc();
end;

procedure TMainForm.SpeedButton17Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton19Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton20Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton21Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton22Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton23Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton24Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton25Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton26Click(Sender: TObject);
begin
  PopUpMenu5.PopUp();
end;

procedure TMainForm.SpeedButton27Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton29Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin

end;


procedure TMainForm.SpeedButton5Click(Sender: TObject);

begin
Try

 // TCustomGrid(ActiveGrid) // undo

except
end;
end;

procedure TMainForm.SpeedButton6Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton7Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton8Click(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton9Click(Sender: TObject);
begin

end;

procedure TMainForm.StringGridBeforeSelection(Sender: TObject; aCol,
  aRow: Integer);
begin

end;

procedure TMainForm.StringGridCheckboxToggled(sender: TObject; aCol,
  aRow: Integer; aState: TCheckboxState);
begin

end;

procedure TMainForm.StringGridClick(Sender: TObject);
begin

end;

procedure TMainForm.StringGridDblClick(Sender: TObject);
begin
  ToolButton34Click(Sender);
end;

procedure TMainForm.StringGridEditingDone(Sender: TObject);
begin

end;

procedure TMainForm.StringGridExit(Sender: TObject);
begin

end;

procedure TMainForm.StringGridHeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin

end;

procedure TMainForm.StringGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  doCol,doRow,col,row,i,leftP,topP:integer;
begin


 if Button= mbLeft then
   begin

   end;

if Button= mbRight then
begin


end;

end;

procedure TMainForm.StringGridMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure TMainForm.StringGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

end;

procedure TMainForm.StringGridSelection(Sender: TObject; aCol, aRow: Integer);
begin

end;

procedure TMainForm.Timer1StopTimer(Sender: TObject);
begin

end;

procedure TMainForm.ToolBar1Click(Sender: TObject);
begin

end;

procedure TMainForm.ToolButton10Click(Sender: TObject);
begin
  OpenProject(True,'D:\test.proj4g');
end;

procedure TMainForm.ToolButton11Click(Sender: TObject);
begin
 Form2.Show;
end;

procedure TMainForm.ToolButton12Click(Sender: TObject);
begin
  form24.Show;
end;

procedure TMainForm.ToolButton13Click(Sender: TObject);
var
 options:string;
 i:integer;
begin

 MainForm.Opendialog1.Filter:= IndexFilter_2;
 MainForm.Opendialog1.Options := MainForm.Opendialog1.Options + [ofAllowMultiSelect]; // allow multislection

 If MainForm.OpenDialog1.Execute then // open dilaog
begin

// show progress box

 ProgressBox.Show();

 for i:=0 to Mainform.Opendialog1.Files.Count -1 do
  begin
     ImportFile_as_PDB(Mainform.OpenDialog1.Files[i]); // load files
  end;
end;

 // hide progress box

  ProgressBox.StaticText1.Caption:= pleasewait+' (100%)';
  ProgressBox.Hide();

 MainForm.Opendialog1.Options := MainForm.Opendialog1.Options - [ofAllowMultiSelect]; // allow multislection
end;

procedure TMainForm.ToolButton14Click(Sender: TObject);
begin

end;

procedure TMainForm.ToolButton15Click(Sender: TObject);
begin
  project_table_form.Show;
  project_table_form.BringToFront;
end;

procedure TMainForm.ToolButton16Click(Sender: TObject);
begin
 if  PairSplitterSide2.Height > 5 then
  begin
     PairSplitter1.Position:=PairSplitter1.Height;
  end else begin

     Console.Memo1.SelStart:= Length(Console.Memo1.Text);
     Console.Memo1.SetFocus;

    PairSplitter1.Position:=PairSplitter1.Height-200; end;
end;

procedure TMainForm.ToolButton18Click(Sender: TObject);
begin
  ProgressBox.Hide;
end;

procedure TMainForm.ToolButton1Click(Sender: TObject);
Var
 i,a:integer;
 distance:currency;
begin
  //MoveCoordinateSystemTo(StrToCurr(Selected[0,NrColX]),StrToCurr(Selected[0,NrColY]),StrToCurr(Selected[0,NrColZ]));
  //ClearSelection(-1);

  for i:=1 to Project_Table_form.StringGrid1.RowCount - 1 do
   begin
     if Project_table_form.StringGrid1.Cells[NrColProj_Inc,i] = '1' then
      begin
        for a:=0 to ProjectArrayFunctions('RowCount',i-1) -1 do
         begin
           distance:= dlugosc_wektora(0,0,0,StrToCurr(Project[i-1, a, NrColX]),StrToCurr(Project[i-1, a, NrColy]),StrToCurr(Project[i-1, a, NrColx]),1);

           Project[i-1, a, NrColX]:= CurrToStr(StrToCurr(Project[i-1, a, NrColX]) + distance /  (abs(StrTocurr(Project[i-1, a, NrColZ]))));
           Project[i-1, a, NrColY]:= CurrToStr(StrToCurr(Project[i-1, a, NrColY]) + distance /  (abs(StrTocurr(Project[i-1, a, NrColZ]))));

           //Project[i-1, a, NrColZ]:= '0';  // zutowanie na z więc jestrowny zero
         end;
      end;
   end;

end;

procedure TMainForm.ToolButton22Click(Sender: TObject);
begin
  // invert selection of Inc.
  InvertSelectionIncRecordsFromGrid(TstringGrid(ActiveGrid),NrColInc);
end;

procedure TMainForm.ToolButton23Click(Sender: TObject);
begin
  Settings.Show;
end;

procedure TMainForm.ToolButton24Click(Sender: TObject);
begin
  PDBrequest.Show;
end;

procedure TMainForm.ToolButton25Click(Sender: TObject);
Var
 ColNrFrazy,Frazy:TstringList;
begin
  ColNrFrazy:=TstringList.Create;
  Frazy:=TstringList.Create;

  ColNrFrazy.Add('6');  Frazy.Add('GLU');
  ColNrFrazy.Add('8');  Frazy.Add('6');

  CheckProjectColumnIf(0,ColNrFrazy,Frazy,true,NrColInc,'1');

  ColNrFrazy.Clear;
  Frazy.Clear;

  ColNrFrazy.Add(inttostr(NrColBonds_SecondResidueName));  Frazy.Add('GLU');
  ColNrFrazy.Add(inttostr(NrColBonds_SecondResidueNumber));  Frazy.Add('6');
  ColNrFrazy.Add(inttostr(NrColBonds_FirstResidueName));  Frazy.Add('GLU');
  ColNrFrazy.Add(inttostr(NrColBonds_FirstResidueNumber));  Frazy.Add('6');

  CheckBondsColumnIf(0,ColNrFrazy,Frazy,true,NrColInc,'1');

 // AssignBondsToMolecule(1,'PRO');

 //  ArrayToConsole('Bonds');

//   ArrayToConsole('Project');

  {Showmessage('Col:'+inttostr(ProjectArrayFunctions('ColCount',0)));
  Showmessage('Row:'+inttostr(ProjectArrayFunctions('RowCount',0)));
  Showmessage('Project:'+inttostr(ProjectArrayFunctions('ProjectCount',0)));
   }
end;

procedure TMainForm.ToolButton26Click(Sender: TObject);
Var
 i:integer;
begin

 { SetLength(Bonds,0,BondsArrayColCount);

  for i:=1 to Project_table_form.StringGrid1.RowCount -1  do
   begin
     AssignBondsToMolecule(i-1,Project_table_form.StringGrid1.Cells[NrColProj_Type,i]);
   end;

  ArrayToGrid('Bonds',Form2.StringGrid);
  }

end;

procedure TMainForm.ToolButton27Click(Sender: TObject);
Var
 Lista:TstringList;
begin
 lista:= TstringList.Create;
  if IncList(lista) = 1 then
   begin
    if StrToInt(lista[0]) - 1 > 0 then
     begin
       TstringGrid(activegrid).ExchangeColRow(false,StrToInt(lista[0]),StrToInt(lista[0])-1);
     end;
   end
    else
   begin
     Console.AddCommunicate(com114,true);
   end;
lista.free;
end;

procedure TMainForm.ToolButton17Click(Sender: TObject);
begin
  ProgressBox.Show;
end;

procedure TMainForm.ToolButton19Click(Sender: TObject);  // cross-platform SysUtils.ExecuteProcess(UTF8ToSys('/full/path/to/binary'), '', []);
begin
 ShellExecute(0, 'open', 'explorer.exe',  PWideChar('ftp://loginname:yourpassword@nameofserver'), nil, SW_SHOW);
end;


procedure TMainForm.ToolButton20Click(Sender: TObject);
var
 i,ii:integer;
 x,y:shortstring;
 ListaX,ListaY:TstringList;
begin

 form6.Show;

{panel3.Visible:=false;

if form6.Visible= true then begin form6.Visible:=False end;

if (panel2.visible=True) and (MessageDlg ('Add a series of ...', 'Do you want to add new data series to the chart?', mtConfirmation,
                 [mbYes, mbNo],0) = mrYes)
 then
  begin
    x:=inputbox('X',com17+' x :','');
    y:=inputbox('Y',com17+' y :','');
    ListaX:=TstringList.Create;
    ListaY:=TstringList.Create;
   if (strtointDef(x,0)>0) and (strtointDef(x,0) < TstringGrid(activeGrid).ColCount-1) and (strtointDef(y,0)>0) then
     begin
      listaX.AddStrings(TstringGrid(activeGrid).Cols[strtoint(x)]);
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

         listaY.AddStrings(TstringGrid(activeGrid).Cols[strtoint(y)]);
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
          //WykresNowaSeria(Form6.Chart,ListaX,ListaY);
          Form6.Show;
          ListaY.Free;
          ListaX.Free;
        end
          else begin Form1.ShowCommunicate(com16); end;
  end
    else
     begin Form1.ShowCommunicate('Brak arkusza danych!!!') end;  }
end;

procedure TMainForm.ToolButton21Click(Sender: TObject);
begin
  //ScriptEditor.show;
 // ssh ftp !!!!
end;

procedure TMainForm.ToolButton28Click(Sender: TObject);
begin
  Form16.Left:=-3;
  Form16.Top:=Mainform.Top+MainForm.Height-Form16.Height-10-statusbar.Height;
  Form16.Width:=MainForm.Width-13;
  Form16.Show;
  Project_table_form.Hide;
end;

procedure TMainForm.ToolButton29Click(Sender: TObject);
begin
  form8.Show;
 form8.PageControl1.PageIndex:=0;
end;

procedure TMainForm.ToolButton2Click(Sender: TObject);
begin
  OpenProject(False,'');
end;

procedure TMainForm.ToolButton30Click(Sender: TObject);
begin
  if IVM.panel1.Visible = true then
   begin
     IVM.panel1.Visible:= false;
   end else begin IVM.panel1.Visible:= true end;
end;

procedure TMainForm.ToolButton31Click(Sender: TObject);
begin

end;

procedure TMainForm.ToolButton32Click(Sender: TObject);
Var
  a,b:string;
  re:boolean;
begin
  a:=inputbox('','','');
  b:=inputbox('','','');
  if BondExists(a,b) = true then
   begin
    Showmessage('true');
   end else begin Showmessage('false');  end;

end;

procedure TMainForm.ToolButton34Click(Sender: TObject);
begin

end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
begin
  if MainForm.ToolButton4.ImageIndex = 24 then
   begin
     console.AddFunction('CONNECT '+settings.LabeledEdit3.Text+' '+settings.LabeledEdit4.Text);
   end
    else if MainForm.ToolButton4.ImageIndex = 25 then
      begin
         MainForm.ToolButton4.ImageIndex:= 24;
      end
       else if MainForm.ToolButton4.ImageIndex = 26 then
        begin
          console.AddFunction('DISCONNECT');
         end;

end;

procedure TMainForm.ToolButton5Click(Sender: TObject);
begin
  Form5.ProgressBar.Hide;
  Form5.StaticText2.Hide;
  Form5.Height:= (Form5.Image1.Top * 2 ) + Form5.Image1.Height;
  Form5.FormStyle:=fsStayOnTop;
  Form5.Show;
end;

procedure TMainForm.ToolButton6Click(Sender: TObject);
begin
  Form14.show;
end;

procedure TMainForm.ToolButton7Click(Sender: TObject);
begin

   ScriptEditor.Show;

 // ScriptEditor.SynEdit1;
{try
  SysUtils.ExecuteProcess(UTF8ToSys(settings.LabeledEdit5.Text), '', []);
except
  console.AddCommunicate(com168,true);
end;}

end;

procedure TMainForm.ToolButton8Click(Sender: TObject);
begin
  form8.Show;
end;

procedure TMainForm.ToolButton9Click(Sender: TObject);
begin
  PDBEditor.Show;
end;

procedure TMainForm.MenuItem14Click(Sender: TObject);
begin
  CopyGridToClipboard();
end;

procedure TMainForm.PageControlPageChanged(Sender: TObject);
begin

end;

procedure TMainForm.Show1Click(Sender: TObject);
begin

end;

procedure TMainForm.FormCreate(Sender: TObject);

begin

//-- Initializong the main arrays of the project -> General_dll

                Initialize_Arrays();

// Utworz katalogi jesli nie ma  modules / localPDB    -----------------------------------------?????????????????? czy ma tworzyc

  if DirectoryExists(ExtractFilePath(Application.ExeName)+'modules')=false then
    begin
      try CreateDir(ExtractFilePath(Application.ExeName)+'modules');
      except
       Console.AddCommunicate(com3+'[modules]',true);
      end;
     end;

   if DirectoryExists(ExtractFilePath(Application.ExeName)+'local_PDB')=false then
     begin
       try CreateDir(ExtractFilePath(Application.ExeName)+'local_PDB');
       except
         Console.AddCommunicate(com3+'[local_PDB]',true);
       end;
     end;

// Pocztatkowe wartosci dla otworz / zapisz
openDialog1.InitialDir := GetCurrentDir;
savedialog1.InitialDir := GetCurrentDir;
end;

procedure TMainForm.MenuItem10Click(Sender: TObject);
begin
  SaveProject(true);
end;

procedure TMainForm.Nowyprojekt1Click(Sender: TObject);
begin
  NewProject(Sender);
end;

procedure TMainForm.ukryjPasekBocznyExecute(Sender: TObject);
begin

end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin

end;


procedure TMainForm.Dodajkolumne1Click(Sender: TObject);
begin
 Tstringgrid(activeGrid).InsertColRow(true,xGrid);
 ponumeruj_kolumny(activeGrid);
end;

procedure TMainForm.Dodajwiersz1Click(Sender: TObject);
begin
 Tstringgrid(activeGrid).InsertColRow(false,yGrid);
 ponumeruj_kolumny(sender);
end;



procedure TMainForm.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
Var
 i:integer;
begin // rozpoznaj zanzaczonego grida
  if activeGrid <> sender then
   begin
     activegrid:=sender;
   end;
end;

initialization
  {$i Unit1.lrs}

end.
