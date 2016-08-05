library general;

{$mode objfpc}{$H+}

uses
  Classes
  { you can add units after this };

begin
  Procedure myMes;
  begin
    showmessage('hello');
  end;


  exports myMes;
end.

