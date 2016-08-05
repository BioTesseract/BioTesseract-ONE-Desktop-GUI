(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Biblioteka_Grow_4;

type

  { TForm5 }

  TForm5 = class(TForm)
    HideTimer: TTimer;
    Image1: TImage;
    ProgressBar: TProgressBar;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HideTimerTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form5: TForm5; 

implementation

{ TForm5 }

procedure TForm5.SpeedButton1Click(Sender: TObject);
begin
  OpenDefaultBrowser('http://www.grow4.eu');
end;

procedure TForm5.HideTimerTimer(Sender: TObject);
Var
  HideShowSpeed:integer=8;
begin

  if Form5.AlphaBlendValue > 0 then
   begin

  if Form5.AlphaBlendValue - HideShowSpeed <= 0 then
   begin
     Form5.AlphaBlendValue:=0;
     Form5.Visible:=false;
     Form5.HideTimer.Enabled:=false;
   end else
    begin
       Form5.AlphaBlendValue := Form5.AlphaBlendValue - HideShowSpeed;
    end;

   end;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin

end;

procedure TForm5.FormHide(Sender: TObject);
begin
  ///HideTimer.Enabled:=true;
  visible:=false;
end;

procedure TForm5.FormShow(Sender: TObject);
begin

  //HideTimer.Enabled:=false;
 // Form5.AlphaBlendValue:=255;
  //Visible:=true;

end;

procedure TForm5.StaticText1Click(Sender: TObject);
begin

end;


initialization
  {$I unit6.lrs}

end.

