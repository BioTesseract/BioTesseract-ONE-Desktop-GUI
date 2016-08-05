unit sshclient;
 
interface
 
uses
  tlntsend, libssh2, ssl_openssl, ssl_openssl_lib, ssl_cryptlib;
 
type
  TSSHClient = class
  private
    FTelnetSend: TTelnetSend;
  public
    constructor Create(AHost, APort, AUser, APass: string);
    destructor Destroy; override;
    procedure SendCommand(ACommand: string);
    procedure LogOut;
    function ReceiveData: string;
    function LogIn: Boolean;
  end;
 
implementation
 
{ TSSHClient }
 
constructor TSSHClient.Create(AHost, APort, AUser, APass: string);
begin
  FTelnetSend := TTelnetSend.Create;
  FTelnetSend.TargetHost := AHost;
  FTelnetSend.TargetPort := APort;
  FTelnetSend.UserName := AUser;
  FTelnetSend.Password := APass;
  FTelnetSend.Sock.;
end;
 
destructor TSSHClient.Destroy;
begin
  FTelnetSend.Free;
  inherited;
end;
 
function TSSHClient.LogIn: Boolean;
begin
  Result := FTelnetSend.SSHLogin;
end;
 
procedure TSSHClient.LogOut;
begin
  FTelnetSend.Logout;
end;
 
function TSSHClient.ReceiveData: string;
var
  lPos: Integer;
begin
  Result := '';
  lPos := 1;
  while FTelnetSend.Sock.CanRead(1000) or (FTelnetSend.Sock.WaitingData>0) do
  begin
    FTelnetSend.Sock.RecvPacket(1000);
    Result := Result + Copy(FTelnetSend.SessionLog, lPos, Length(FTelnetSend.SessionLog));
    lPos := Length(FTelnetSend.SessionLog)+1;
  end;
end;
 
procedure TSSHClient.SendCommand(ACommand: string);
begin
  FTelnetSend.Send(ACommand + #13);
end;
 
end.
