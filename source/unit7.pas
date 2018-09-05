(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Menus, Grids, StdCtrls, ExtCtrls, Buttons, TAGraph;

type

  { Tform6 }

  Tform6 = class(TForm)
    Chart1: TChart;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  form6: Tform6;

implementation

{ Tform6 }

procedure Tform6.MenuItem1Click(Sender: TObject);
begin
  //Chart.ZoomFull;
end;

procedure Tform6.MenuItem4Click(Sender: TObject);
begin

end;

procedure Tform6.MenuItem5Click(Sender: TObject);
begin

end;

procedure Tform6.MenuItem10Click(Sender: TObject);
begin

end;

procedure Tform6.ComboBox1Enter(Sender: TObject);
begin

end;

procedure Tform6.ComboBox1Click(Sender: TObject);
begin

end;

procedure Tform6.ComboBox1DropDown(Sender: TObject);
Var
  i:integer;
begin
  Combobox1.Clear;
  for i:= 1 to Random(200) do
  begin
    Combobox1.Items.Add(inttostr(i));
  end;
end;

procedure Tform6.MenuItem11Click(Sender: TObject);
begin
 // Chart.LeftAxis.Inverted:=true;
end;

procedure Tform6.MenuItem7Click(Sender: TObject);
begin
  //  Chart.ClearSeries;
  //  Chart.ZoomFull;
end;

procedure Tform6.MenuItem9Click(Sender: TObject);
begin

end;

procedure Tform6.SpeedButton1Click(Sender: TObject);
begin
  // funkcja name of serie to number w tabeli
end;


initialization
  {$I unit7.lrs}

end.

