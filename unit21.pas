(*
Program name: BioTesseract™ ONE Desktop
Version: 1.1.1 Build: 206
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Unit21;

{$mode objfpc}

interface

uses
  {$ifdef unix}
  cthreads,
  cmem,
  {$endif}
  Classes, SysUtils, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons,
  Biblioteka_Grow_4_grafika;

 Type
  { TProgressBox }

  TProgressBox = class(TForm)
    Image1: TImage;
    ImageList1: TImageList;
    StaticText1: TStaticText;
    HideTimer: TTimer;
    AnimationTimer: TTimer;
    procedure AnimationTimerTimer(Sender: TObject);
    procedure HideTimerTimer(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);
    procedure HideProgressBox();
    procedure ShowProgressBox();
    // te wywolania
    Procedure Show;
    Procedure Hide;

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  ProgressBox: TProgressBox;
  HideShowSpeed:integer=8;
  Frame:integer=0;

implementation
Uses
  Unit1;

{ TProgressBox }

Procedure TProgressBox.Show();
begin
   HideTimer.Enabled:=false;
   Progressbox.StaticText1.Caption:= pleasewait;
   ProgressBox.Visible:=true;
   AnimationTimer.Enabled:=true;
   ProgressBox.AlphaBlendValue:=225;
end;

Procedure TProgressBox.HideProgressBox();
begin
  HideTimer.Enabled:=True;
end;

Procedure TProgressBox.ShowProgressBox();
begin
  ProgressBox.Show();
end;

Procedure TProgressBox.Hide();
begin
  HideTimer.Enabled:=True;
end;

procedure TProgressBox.ShowTimerTimer(Sender: TObject);
begin
  if ProgressBox.AlphaBlendValue < 225 then
   begin
     ProgressBox.AlphaBlendValue := ProgressBox.AlphaBlendValue + HideShowSpeed;
   end;
end;

procedure TProgressBox.HideTimerTimer(Sender: TObject);
begin

  if ProgressBox.AlphaBlendValue > 0 then
   begin

  if ProgressBox.AlphaBlendValue - HideShowSpeed <= 0 then
   begin
     ProgressBox.AlphaBlendValue:=0;
     ProgressBox.Visible:=false;
     AnimationTimer.Enabled:=false;
     HideTimer.Enabled:=false;
     ProgressBox.Close;
   end else
    begin
       ProgressBox.AlphaBlendValue := ProgressBox.AlphaBlendValue - HideShowSpeed;
    end;

   end;


end;


procedure TProgressBox.AnimationTimerTimer(Sender: TObject);
begin

  if frame < ImageList1.Count then
   begin
     Imagelist1.GetBitmap(frame,Image1.Picture.Bitmap);
     inc(frame)
   end else begin
          frame:=0;
        end;
   Image1.Refresh;
   Image1.Repaint;
end;




initialization
  {$I unit21.lrs}

end.

