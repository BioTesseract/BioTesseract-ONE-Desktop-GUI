(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit23;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, SynMemo, SynCompletion,
  SynHighlighterPython, LResources, Forms, Controls, Graphics, Dialogs, Grids,
  ComCtrls, Buttons, Menus, StdCtrls, PairSplitter, Biblioteka_Grow_4, ShellApi,
  Windows, Process;

type

  { TScriptEditor }

  TScriptEditor = class(TForm)
    Memo1: TMemo;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    SynEdit1: TSynEdit;
    SynPythonSyn1: TSynPythonSyn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure SynEdit1Change(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ScriptEditor: TScriptEditor;
  GridX:integer;
  GridY:integer;

implementation

Uses
  Unit1, Unit12, Unit22, Unit21;

{ TScriptEditor }


procedure TScriptEditor.FormActivate(Sender: TObject);
begin

end;

procedure TScriptEditor.Button1Click(Sender: TObject);
begin

end;

procedure TScriptEditor.BitBtn1Click(Sender: TObject);
begin

end;

procedure TScriptEditor.FormCreate(Sender: TObject);
begin


end;

procedure TScriptEditor.FormResize(Sender: TObject);
begin

end;

procedure TScriptEditor.MenuItem1Click(Sender: TObject);
begin

end;

procedure TScriptEditor.StringGrid1DblClick(Sender: TObject);
begin

end;

procedure TScriptEditor.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin

end;

procedure TScriptEditor.StringGrid1SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin

end;

procedure TScriptEditor.SynEdit1Change(Sender: TObject);
begin

end;

procedure TScriptEditor.ToolButton1Click(Sender: TObject);
begin

end;

procedure TScriptEditor.ToolButton3Click(Sender: TObject);
const
  BUF_SIZE = 2048; // Buffer size for reading the output in chunks
var
  AProcess     : TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..BUF_SIZE] of byte;
  file_name    : string;

begin
    // if filename not deffined use temp dir
    if file_name = '' then
     begin
       file_name:= SysUtils.GetTempDir+'temp_script.py'
     end;

  SynEdit1.Lines.SaveToFile(file_name);
  Console.AddCommunicate(com40+' '+file_name,true);

  Console.AddCommunicate(com91+DateTimeToStr(Now),true);
  Console.AddCommunicate(processing,true);

  // Set up the process; as an example a recursive directory search is used because that will usually result in a lot of data.
  AProcess := TProcess.Create(nil);

  // The commands for Windows and *nix are different hence the $IFDEFs
  {$IFDEF Windows}
    // In Windows the dir command cannot be used directly because it's a build-in
    // shell command. Therefore cmd.exe and the extra parameters are needed.

  AProcess.Executable := Settings.LabeledEdit6.Text;
  AProcess.Parameters.Add(SysUtils.GetTempDir+'temp_script.py');
  {$ENDIF Windows}

  // Process option poUsePipes has to be used so the output can be captured.
  // Process option poWaitOnExit can not be used because that would block
  // this program, preventing it from reading the output data of the process.

  AProcess.Options := [poUsePipes];  // poWaitOnExit
  Aprocess.ShowWindow:= swoHIDE;

  //ProgressBox.Show;

  // Start the process
  AProcess.Execute;

  // Create a stream object to store the generated output in. This could
  // also be a file stream to directly save the output to disk.
  OutputStream := TMemoryStream.Create;

  // All generated output from AProcess is read in a loop until no more data is available
  repeat
    // Get the new data from the process to a maximum of the buffer size that was allocated.
    // Note that all read(...) calls will block except for the last one, which returns 0 (zero).
    BytesRead := AProcess.Output.Read(Buffer, BUF_SIZE);

    // Add the bytes that were read to the stream for later usage
    OutputStream.Write(Buffer, BytesRead)

  until BytesRead = 0;  // Stop if no more data is available

  // The process has finished so it can be cleaned up
  AProcess.Free;

  // Or the data can be shown on screen
  with TStringList.Create do
  begin
    OutputStream.Position := 0; // Required to make sure all data is copied from the start
    LoadFromStream(OutputStream);

    PairSplitter1.Position:= Round((Scripteditor.Height - toolbar1.Height) / 2);

    Memo1.Lines.Clear;
    Memo1.Lines.AddStrings(Text);

   // Console.Memo1.Lines.AddStrings(Text);

    Free
  end;

  Console.AddCommunicate(com90+DateTimeToStr(Now),true);
  //ProgressBox.Hide;
  // Clean up
  OutputStream.Free;
end;

procedure TScriptEditor.ToolButton5Click(Sender: TObject);
begin
  settings.Show;
end;

procedure TScriptEditor.ToolButton6Click(Sender: TObject);
begin

end;


initialization
  {$I unit23.lrs}

end.

