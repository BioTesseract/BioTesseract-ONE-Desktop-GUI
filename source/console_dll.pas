(*
Program name: BioTesseract™ ONE Desktop
Version: 1.4.900.670 pre-release Build: 670
Authorship: The project was initially invented and developed by Dr Rafal Urniaz, actually it is developed by BioTesseract™ ONE community.
Description: This file is a part of the BioTesseract™ ONE Desktop project, for details please visit http://www.biotesseract.com
*)

unit Console_dll;

{$mode objfpc}

interface

uses
  Classes, SysUtils;

  Function AddCommunicate(communicate:string;ShowConsole:boolean):boolean;

implementation

Uses
  Unit1, Unit22;

Function AddCommunicate(communicate:string;ShowConsole:boolean):boolean;
 begin
  if ShowConsole then
    begin
       Mainform.PairSplitter1.Position:=Mainform.PairSplitter1.Height-200;
    end;

    Console.Memo1.Lines.add(DateTimeToStr(now)+': '+communicate);
    Console.Memo1.SelStart:= Length(Console.Memo1.Text)+1;

    result:=true;
end;

end.

