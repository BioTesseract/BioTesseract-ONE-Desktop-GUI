unit mythreads;
{$mode objfpc}{$H+}
interface
uses
  Unit21, Classes, SysUtils, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons,
  Biblioteka_Grow_4_grafika;
  
 Type
    TMyThread = class(TThread)
    private
      procedure CreateAndShowForm();

    protected
      procedure Execute; override;

    public
      property Terminated;
      Constructor Create();
      procedure changeCaption(text:string);
    end;

  var
    frForm:TProgressBox;
 
implementation

  constructor TMyThread.Create();
  begin
    FreeOnTerminate := False;
    inherited Create(false);
  end;

  procedure TMyThread.Execute;
  begin
    Synchronize(@CreateAndShowForm);
  end;

procedure TMyThread.CreateAndShowForm();
  begin
    frForm:=TProgressBox.Create(Application);
    frForm.ShowProgressBox();
  end;

procedure TMyThread.changeCaption(text:string);
begin
  frForm.StaticText1.Caption:=text;
end;
 
end.
