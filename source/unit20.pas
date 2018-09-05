(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit20;

{$mode objfpc}

interface

uses
  GLUT, Classes, SysUtils, FileUtil, OpenGLContext, LResources, Forms, Controls,
  Graphics, Dialogs, ComCtrls, StdCtrls, GL, GLU, Math, types, LCLType, Grids,
  ExtCtrls, Menus, PairSplitter, Buttons, Biblioteka_Grow_4,
  Biblioteka_Grow_4_grafika, General_dll, Graphics_dll;

type

  { TIVM }

  TIVM = class(TForm)
    IdleTimer1: TIdleTimer;
    ImageList1: TImageList;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    ObjetsList: TStringGrid;
    OpenGLControl1: TOpenGLControl;
    PairSplitter1: TPairSplitter;
    PairSplitter2: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    PairSplitterSide3: TPairSplitterSide;
    PairSplitterSide4: TPairSplitterSide;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    ToolBar4: TToolBar;
    ToolBar5: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
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
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    ToolButton44: TToolButton;
    ToolButton45: TToolButton;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IdleTimer1StartTimer(Sender: TObject);
    procedure IdleTimer1StopTimer(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
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
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure ObjetsListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnAppIdle(Sender: TObject; var Done: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure OpenGLControl1Click(Sender: TObject);
    procedure OpenGLControl1DblClick(Sender: TObject);
    procedure OpenGLControl1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure OpenGLControl1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenGLControl1KeyPress(Sender: TObject; var Key: char);
    procedure OpenGLControl1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenGLControl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OpenGLControl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLControl1Paint(Sender: TObject);
    procedure OpenGLControl1Resize(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBar1Click(Sender: TObject);
    procedure ToolBar2Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ToolButton21MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton22MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton22MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton25Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton28Click(Sender: TObject);
    procedure ToolButton29Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton42Click(Sender: TObject);
    procedure ToolButton43Click(Sender: TObject);
    procedure ToolButton44Click(Sender: TObject);
    procedure ToolButton45Click(Sender: TObject);
    procedure ToolButton46Click(Sender: TObject);
    procedure ToolButton47Click(Sender: TObject);
    procedure ToolButton48Click(Sender: TObject);
    procedure ToolButton49Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }

  end;

var
  IVM: TIVM;
  aCol,aRow:integer;

implementation

Uses
  Unit1, Unit2, Unit12, Unit16, Unit14, Unit22, Unit21;

procedure TIVM.ToolButton3Click(Sender: TObject);
begin
 if g4g_ShowAxes then
   begin
     g4g_ShowAxes:=False;
   end else begin g4g_ShowAxes:=true; end;
end;

procedure TIVM.ToolButton42Click(Sender: TObject);
begin
  AddElementName:='H';
end;

procedure TIVM.ToolButton43Click(Sender: TObject);
begin
    AddElementName:='C';
end;

procedure TIVM.ToolButton44Click(Sender: TObject);
begin
    AddElementName:='O';
end;

procedure TIVM.ToolButton45Click(Sender: TObject);
begin
    AddElementName:='P';
end;

procedure TIVM.ToolButton46Click(Sender: TObject);
begin
    AddElementName:='S';
end;

procedure TIVM.ToolButton47Click(Sender: TObject);
begin
    AddElementName:='Br';
end;

procedure TIVM.ToolButton48Click(Sender: TObject);
begin
    AddElementName:='Cl';
end;

procedure TIVM.ToolButton49Click(Sender: TObject);
begin
    AddElementName:='F';
end;

procedure TIVM.ToolButton4Click(Sender: TObject);
begin
  MainForm.WindowState:=wsFullScreen;
end;

procedure TIVM.ToolButton5Click(Sender: TObject);
begin



  ProgressBox.Show();

  GetOGL_BMP(OpenGLControl1, UniversalSaveFunction('*.bmp|*.bmp',GetEnvironmentVariable('HOMEPATH'),'Picture',nil));

  ProgressBox.HideProgressBox();
  //PrintScreen(IVM.Left,IVM.Top,IVM.Width,IVM.Height);

end;

procedure TIVM.ToolButton6Click(Sender: TObject);
begin
  Start3dDraw:=false;
end;

procedure TIVM.ToolButton7Click(Sender: TObject);
begin
    SetVizualizationTypeForVisibleMolecules('Bounds_and_Balls','0.5');
end;

procedure TIVM.ToolButton8Click(Sender: TObject);
begin
   SetVizualizationTypeForVisibleMolecules('Bounds','0.3');
end;

procedure TIVM.ToolButton9Click(Sender: TObject);
begin
  SetVizualizationTypeForVisibleMolecules('Balls','1');
end;

procedure TIVM.OnAppIdle(Sender: TObject; var Done: Boolean);
begin
  Done:=false;
  OpenGLControl1.Invalidate;
end;

procedure TIVM.IdleTimer1Timer(Sender: TObject);
begin

  Idletimer1.Interval:= 10 * settings.SpinEdit1.Value;   // ustal zcas z setingsow

  g4g_rotationX := g4g_rotationX + 3;
  g4g_rotationY := g4g_rotationY + 3;

end;

procedure TIVM.MenuItem10Click(Sender: TObject);
begin
   g4g_Labels_L:=NrColZ;
end;

procedure TIVM.MenuItem11Click(Sender: TObject);
begin
   g4g_Labels_L:=NrColElementSymbol;
end;

procedure TIVM.MenuItem12Click(Sender: TObject);
begin
     g4g_Labels_L:=NrColTemperatureFactor;
end;

procedure TIVM.MenuItem13Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColOccupancy;
end;

procedure TIVM.MenuItem15Click(Sender: TObject);
begin
  g4g_Labels_L:= NrColChargeOnTheAtom;
end;

procedure TIVM.MenuItem16Click(Sender: TObject);
begin

end;

procedure TIVM.MenuItem18Click(Sender: TObject);
begin
  g4g_Labels_L:=0;
end;

procedure TIVM.MenuItem19Click(Sender: TObject);
begin
  g4g_Labels_P:=0;
end;

procedure TIVM.MenuItem1Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColAtomId;
end;

procedure TIVM.MenuItem20Click(Sender: TObject);
begin
  g4g_Labels_A:=0;
end;

procedure TIVM.MenuItem21Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColAtomId;
end;

procedure TIVM.MenuItem22Click(Sender: TObject);
begin
  g4g_Labels_A:=NrColAtomId;
end;

procedure TIVM.MenuItem23Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColAtomName;
end;

procedure TIVM.MenuItem24Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColAlternateLocationIndicator;
end;

procedure TIVM.MenuItem25Click(Sender: TObject);
begin
  g4g_Labels_A:=NrColAlternateLocationIndicator;
end;

procedure TIVM.MenuItem26Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColResidueName;
end;

procedure TIVM.MenuItem27Click(Sender: TObject);
begin
  g4g_Labels_A:=NrColResidueName;
end;

procedure TIVM.MenuItem28Click(Sender: TObject);
begin
  g4g_Labels_P:=NrChainIdentifier;
end;

procedure TIVM.MenuItem29Click(Sender: TObject);
begin
  g4g_Labels_A:=NrChainIdentifier;
end;

procedure TIVM.MenuItem2Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColAtomName;
end;

procedure TIVM.MenuItem30Click(Sender: TObject);
begin
   g4g_Labels_P:=NrColSequenceNr;
end;

procedure TIVM.MenuItem31Click(Sender: TObject);
begin
   g4g_Labels_A:=NrColSequenceNr;
end;

procedure TIVM.MenuItem32Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColX;
end;

procedure TIVM.MenuItem33Click(Sender: TObject);
begin
  g4g_Labels_A:=NrColX;
end;

procedure TIVM.MenuItem34Click(Sender: TObject);
begin
   g4g_Labels_P:=NrColY;
end;

procedure TIVM.MenuItem35Click(Sender: TObject);
begin
   g4g_Labels_A:=NrColY;
end;

procedure TIVM.MenuItem36Click(Sender: TObject);
begin
   g4g_Labels_P:=NrColZ;
end;

procedure TIVM.MenuItem37Click(Sender: TObject);
begin
   g4g_Labels_A:=NrColZ;
end;

procedure TIVM.MenuItem38Click(Sender: TObject);
begin
  g4g_Labels_P:=NrColOccupancy;
end;

procedure TIVM.MenuItem39Click(Sender: TObject);
begin
  g4g_Labels_A:=NrColOccupancy;
end;

procedure TIVM.MenuItem3Click(Sender: TObject);
begin

end;

procedure TIVM.MenuItem40Click(Sender: TObject);
begin
   g4g_Labels_P:=NrColTemperatureFactor;
end;

procedure TIVM.MenuItem41Click(Sender: TObject);
begin
   g4g_Labels_A:=NrColTemperatureFactor;
end;

procedure TIVM.MenuItem42Click(Sender: TObject);
begin
   g4g_Labels_P:=NrColElementSymbol;
end;

procedure TIVM.MenuItem43Click(Sender: TObject);
begin
   g4g_Labels_A:=NrColElementSymbol;
end;

procedure TIVM.MenuItem44Click(Sender: TObject);
begin
  g4g_Labels_P:= NrColChargeOnTheAtom;
end;

procedure TIVM.MenuItem45Click(Sender: TObject);
begin
  g4g_Labels_A:= NrColChargeOnTheAtom;
end;

procedure TIVM.MenuItem46Click(Sender: TObject);
begin
   MoveCoordinateSystemToAvarageCenter();
   g4g_center:=true;
end;

procedure TIVM.MenuItem4Click(Sender: TObject);
begin
  g4g_Labels_L:=NrChainIdentifier;
end;

procedure TIVM.MenuItem5Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColAlternateLocationIndicator;
end;

procedure TIVM.MenuItem6Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColResidueName;
end;

procedure TIVM.MenuItem7Click(Sender: TObject);
begin
   g4g_Labels_L:=NrColY;
end;

procedure TIVM.MenuItem8Click(Sender: TObject);
begin
     g4g_Labels_L:=NrColSequenceNr;
end;

procedure TIVM.MenuItem9Click(Sender: TObject);
begin
  g4g_Labels_L:=NrColX;
end;

procedure TIVM.ObjetsListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  col,row:integer;
begin

  ObjetsList.MouseToCell(x,y,col,row);

  if (Col = ObjectsList_Included) and (row > -1) then
    begin

      if ObjetsList.Cells[ObjectsList_Included,row] = '0' then
        begin
           ObjectsList[row,ObjectsList_Included]:='1';
           ShowAllObjectRecords(row - ObjetsList.FixedRows);
        end;

      if ObjetsList.Cells[ObjectsList_Included,row] = '1' then
        begin
           ObjectsList[row,ObjectsList_Included]:='0';
           HideAllObjectRecords(row - ObjetsList.FixedRows);
        end;
    end;

end;

procedure TIVM.IdleTimer1StartTimer(Sender: TObject);
begin

end;

procedure TIVM.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 32 then // spacja pokaż konsole
    begin
      MainForm.ToolButton16Click(nil);
    end;
end;

procedure TIVM.IdleTimer1StopTimer(Sender: TObject);
begin

end;

procedure TIVM.FormCreate(Sender: TObject);
begin
  Application.AddOnIdleHandler(@OnAppIdle);

  IVM.ParentWindow:=Mainform.Panel1.Handle; // przypisanie do okna MainForm

  IVM.ObjetsList.RowCount:=0;
  IVM.StringGrid1.RowCount:=0;

end;

procedure TIVM.OpenGLControl1Click(Sender: TObject);
begin
  Mainform.PairSplitter1.Position:=Mainform.PairSplitter1.Height;
end;

procedure TIVM.OpenGLControl1DblClick(Sender: TObject);
begin

end;

procedure TIVM.OpenGLControl1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin

end;

procedure TIVM.OpenGLControl1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TIVM.OpenGLControl1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TIVM.OpenGLControl1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TIVM.OpenGLControl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbLeft then
    begin
      g4g_mouse_button:='left';
    end;
  if Button = mbRight then
    begin
      g4g_mouse_button:='right';
    end;

      g4g_XX:=x;
      g4g_YY:=y;
      g4g_PosTranslateX := g4g_TranslateX ;
      g4g_PosTranslateY := g4g_TranslateY ;

end;

procedure TIVM.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  viewport:   TViewPortArray;
  modelview:  T16dArray;
  projection: T16dArray;
  winZ,winY:  Single;

begin
  if (g4g_mouse_button = 'left') and (BuildingMode = false) and (DeleteMode = false) then
      begin
        g4g_rotationx := g4g_lastY + g4g_YY - y;
        g4g_rotationy := g4g_lastX + g4g_XX - x;
      end;

  if g4g_mouse_button = 'right' then
    begin
     g4g_center:=false;

      // przesunięcie w prawo, lewo
     g4g_TranslateX := g4g_PosTranslateX + g4g_XX - X;

 if g4g_Projections = 'Orthographic' then
   begin
     // przesunięcie w gora, dol
      g4g_TranslateY := g4g_PosTranslateY - g4g_YY + y;
   end;

  if g4g_Projections = 'Perspective' then
   begin
      // przesuniecie gora dol
       g4g_TranslateY := g4g_PosTranslateY + g4g_YY - y;
   end;

    end;

if Start3dDraw then
 begin
    glGetDoublev(GL_MODELVIEW_MATRIX, @modelview );                          // Get the Current Modelview matrix
    glGetDoublev(GL_PROJECTION_MATRIX, @projection );                        // Get the Current Projection Matrix
    glGetIntegerv(GL_VIEWPORT, @viewport );                                  // Get the Current Viewport

    winY := viewport[3] - y;                                                 //Change from Win32 to OpenGL coordinate system

    if( winY = 0 )then winY := 1;

     glReadPixels(X, Round(winY), 1, 1, GL_DEPTH_COMPONENT, GL_FLOAT, @winZ );//Read the Depth value at the current X and Y position

     gluUnProject(X, winY, winZ, modelview, projection, viewport,@ThreeDpositionXclick, @ThreeDpositionYclick, @ThreeDpositionZclick);    // And Return it from the function

    ThreeDpositionXclick:= RoundTo(ThreeDpositionXclick,-2);
    ThreeDpositionYclick:= RoundTo(ThreeDpositionYclick,-2);
    ThreeDpositionZclick:= RoundTo(ThreeDpositionZclick,-2);

     Label1.Caption:= ' X: '+currtostr(ThreeDpositionXclick)+
                      ' Y: '+currtostr(ThreeDpositionYclick)+
                      ' Z: '+currtostr(ThreeDpositionZclick);

  AtomProperties();
 end;

end;

procedure TIVM.OpenGLControl1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  viewport:   TViewPortArray;
  modelview:  T16dArray;
  projection: T16dArray;
  winZ,winY:  Single;
  i,rowcount,row,ProjectTabelRowCount:integer;

begin

  g4g_lastX:=round(g4g_rotationY);
  g4g_lastY:=round(g4g_rotationx);

if g4g_mouse_button = 'left' then
 begin

  glGetDoublev(GL_MODELVIEW_MATRIX, @modelview );                          // Get the Current Modelview matrix
  glGetDoublev(GL_PROJECTION_MATRIX, @projection );                        // Get the Current Projection Matrix
  glGetIntegerv(GL_VIEWPORT, @viewport );                                  // Get the Current Viewport

  winY := viewport[3] - y;                                                 //Change from Win32 to OpenGL coordinate system

  if( winY = 0 )then winY := 1;

  glReadPixels(X, Round(winY), 1, 1, GL_DEPTH_COMPONENT, GL_FLOAT, @winZ );//Read the Depth value at the current X and Y position

  gluUnProject(X, winY, winZ, modelview, projection, viewport,@ThreeDpositionXclick, @ThreeDpositionYclick, @ThreeDpositionZclick);    // And Return it from the function

  ThreeDpositionXclick:= RoundTo(ThreeDpositionXclick,-2);
  ThreeDpositionYclick:= RoundTo(ThreeDpositionYclick,-2);
  ThreeDpositionZclick:= RoundTo(ThreeDpositionZclick,-2);

  Label1.Caption:= ' X: '+currtostr(ThreeDpositionXclick)+
                   ' Y: '+currtostr(ThreeDpositionYclick)+
                   ' Z: '+currtostr(ThreeDpositionZclick);


  // select atoms and generate the list of selected atoms
    Select();

    GenerateListOfSelectedAtoms();

  // Atom properties
     AtomProperties();


 // add new atom
  if BuildingMode = true then
   begin
     AddAtom(AddNewMolecule,AddElementName,AddElementName,Currtostr(ThreeDpositionXclick),Currtostr(ThreeDpositionYclick),Currtostr(ThreeDpositionZclick));
   end;

   AddNewMolecule := false;

// Delete atom
  if DeleteMode = True then
   begin
     DeleteAtom(ThreeDpositionXclick,ThreeDpositionYclick,ThreeDpositionZclick);
     ClearSelection(-1);
   end;

 end;

 if (g4g_mouse_button = 'right') and (abs(g4g_TranslateX - g4g_PosTranslateX + g4g_XX - X) < 3) and (abs(g4g_TranslateY - g4g_PosTranslateY + g4g_YY - Y) < 3) then
   begin
      PopupMenu2.PopUp;
   end;

 g4g_mouse_button:='';

end;

procedure TIVM.OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta > 0 then
 begin
  if g4g_scale -  1 > 0 then
   begin
    g4g_scale := g4g_scale -  1;
   end;
 end
   else
 begin
    g4g_scale := g4g_scale + 1;
 end;
end;

procedure TIVM.OpenGLControl1Paint(Sender: TObject);
begin

  Main3DDrawFunction();

end;

procedure TIVM.OpenGLControl1Resize(Sender: TObject);
begin
  if Sender=nil then ;
  if OpenGLControl1.Height <= 0 then exit;
end;

procedure TIVM.PopupMenu2Popup(Sender: TObject);
begin

end;

procedure TIVM.StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
begin

end;

procedure TIVM.StringGrid1Click(Sender: TObject);
begin

end;

procedure TIVM.StringGrid1DblClick(Sender: TObject);
Var
  input:string;
begin
  If (aCol = 1) and (selected_count = 1) then
   begin
     input:=  InputBox('Editing,...','Edit:',StringGrid1.Cells[aCol,aRow]);
       try
         if input > '' then
          begin
           // left panel
             StringGrid1.Cells[aCol,aRow]:= input;
           // proj number   row col
             Project[select_1_atom_Project,select_1_atom_Row,aRow]:= input;
          end;
       except
          showmessage('wrong editing parameters, select_1_atom_Project: '+inttostr(select_1_atom_Project)+'select_1_atom_Row: '+inttostr(select_1_atom_Row)+'aRow: '+inttostr(aRow));
       end;
   end;
end;

procedure TIVM.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Stringgrid1.MouseToCell(x,y,aCol,aRow);
end;

procedure TIVM.ToolBar1Click(Sender: TObject);
begin

end;

procedure TIVM.ToolBar2Click(Sender: TObject);
begin

end;

procedure TIVM.ToolButton10Click(Sender: TObject);
begin

  If ToolButton10.Marked = True then
   begin
     IdleTimer1.Enabled:= False;
     g4g_AutoRotation:= False;
     ToolButton10.Marked:= False;
   end else
   begin
     IdleTimer1.Enabled:= True;
     g4g_AutoRotation:= True;
     ToolButton10.Marked:= True;
   end;

end;

procedure TIVM.ToolButton11Click(Sender: TObject);
begin
  Form14.SpeedButton4.Click;
end;

procedure TIVM.ToolButton12Click(Sender: TObject);
begin
   if g4g_Projections = 'Orthographic' then
   begin
    g4g_Projections := 'Perspective' ;
   end
    else
   begin  g4g_Projections := 'Orthographic'; end;

end;

procedure TIVM.ToolButton14Click(Sender: TObject);
var
  i,row:integer;
begin
  for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
  begin
   if Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1' then
    begin
      for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
       begin
         if (Project[i-1,Row,NrColVis] = '0') then
          begin
            Project[i-1,Row,NrColInc]:='0';
          end;

       end;
    end;
    end;
end;

procedure TIVM.ToolButton15Click(Sender: TObject);
var
  i,row:integer;
begin
  for i:=1 to Project_table_form.StringGrid1.RowCount -1 do
  begin
   if Project_table_form.StringGrid1.Cells[NrColProj_Inc, i] = '1' then
    begin
      for row:=0 to ProjectArrayFunctions('RowCount',i-1)-1 do
       begin
         Project[i-1,Row,NrColVis]:='0';
       end;
    end;
    end;

  selected_count:=0;
  IVM.StringGrid1.RowCount:= 1;
end;

procedure TIVM.ToolButton16Click(Sender: TObject);
Var
  N:string;
  C:Tcolor;
begin
  n:= Inputbox('Plane','Insert name:','');

  if MainForm.ColorDialog1.Execute then
   begin
     C:= MainForm.ColorDialog1.Color;
   end;
  AddPlane(N,ColorToString(C));
end;

procedure TIVM.ToolButton17Click(Sender: TObject);
begin
  // apa
end;

procedure TIVM.ToolButton18Click(Sender: TObject);
begin
   ClearSelection(-1);
end;

procedure TIVM.ToolButton19Click(Sender: TObject);
begin
  AddBond();
end;

procedure TIVM.ToolButton1Click(Sender: TObject);
begin
 MoveCoordinateSystemToAvarageCenter();
 g4g_center:=true;
end;

procedure TIVM.ToolButton20Click(Sender: TObject);
begin
  DeleteBondBetweenSelectedAtoms();
end;

procedure TIVM.ToolButton21Click(Sender: TObject);
begin


end;

procedure TIVM.ToolButton21MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

 ClearSelection(-1);

  if BuildingMode = false  then
  begin
    HideObject(-1);

    BuildingMode := true;
    ToolButton21.ImageIndex := 23;
    AddNewMolecule := true;

    Toolbar5.Visible:=true;

     if DeleteMode = true then
      begin
        DeleteMode := false;
        ToolButton22.ImageIndex := 31;
      end;

   end
    else
   begin
    BuildingMode := false;
                                                  // IVM.ToolBar1Click(nil);   ?????????????????
    AddNewMolecule:= true;
    ToolButton21.ImageIndex := 30;
    Toolbar5.Visible:=false;
    end;

end;

procedure TIVM.ToolButton22Click(Sender: TObject);
begin



end;

procedure TIVM.ToolButton22MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TIVM.ToolButton22MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if DeleteMode = false  then
  begin
    DeleteMode := true;
    ToolButton22.ImageIndex := 24;

     if BuildingMode = true then
      begin
        BuildingMode := false;
        ToolButton21.ImageIndex := 30;
        Toolbar5.Visible:=false;
      end;
   end
    else
   begin
    DeleteMode := false;
    ToolButton22.ImageIndex := 31;
    end;

end;

procedure TIVM.ToolButton25Click(Sender: TObject);
begin

  if ToolBar3.visible = true then
  begin
    ToolBar3.visible := false;
  end
   else
  begin
    ToolBar3.visible := true;
  end;

end;

procedure TIVM.ToolButton26Click(Sender: TObject);
begin

 if ToolBar4.visible = true then
  begin
    ToolBar4.visible := false;
  end
   else
  begin
    ToolBar4.visible := true;
  end;

end;

procedure TIVM.ToolButton27Click(Sender: TObject);
begin
    if ToolBar2.visible = true then
  begin
    ToolBar2.visible := false;
  end
   else
  begin
    ToolBar2.visible := true;
  end;
end;

procedure TIVM.ToolButton28Click(Sender: TObject);
begin
  SetVizualizationTypeForVisibleMolecules('Carbon_Alpha','0.5');
end;

procedure TIVM.ToolButton29Click(Sender: TObject);
begin

    if g4g_rendering_quality = 'Low' then
   begin
     g4g_rendering_quality:= 'Best';
     console.AddCommunicate(g4g_rendering_quality,true);
     exit;
   end;

  if g4g_rendering_quality = 'Best' then
   begin
     g4g_rendering_quality:= 'Low';
     console.AddCommunicate(g4g_rendering_quality,true);
     exit;
   end;

   console.AddCommunicate(g4g_rendering_quality,true);
end;

procedure TIVM.ToolButton2Click(Sender: TObject);
begin
  Start3dDraw:=true;
  //Refresh3Ddraw();
end;


initialization
  {$I unit20.lrs}

end.

