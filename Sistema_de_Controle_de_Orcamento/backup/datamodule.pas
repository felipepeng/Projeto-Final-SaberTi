unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    ZConnection1: TZConnection;
    qryGenerica: TZQuery;
    qryGenerica02: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function getSequence(const pNomeSequence: String): String;
    procedure decreaseSequence(const pNomeSequence: String);

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User     := 'postgres';
  ZConnection1.Password := '12345';
  ZConnection1.Port     := 5432;
  ZConnection1.Protocol := 'postgresql';
  ZConnection1.Connected := True;
end;

function TDataModule1.getSequence(const pNomeSequence: String): String;
begin
     Result := '';
 try
     qryGenerica.close;
     qryGenerica.SQL.Clear;
     qryGenerica.SQL.Add('SELECT NEXTVAL(' + QuotedStr(pNomeSequence) + ') AS CODIGO');
     qryGenerica.Open;
     Result := qryGenerica.FieldByName('CODIGO').AsString;
 finally
   qryGenerica.Close;
 end;
end;

procedure TDataModule1.decreaseSequence(const pNomeSequence: String);
begin
try
  qryGenerica02.Close;
  qryGenerica02.SQL.Clear;
  qryGenerica02.SQL.Add('SELECT setval(' + QuotedStr(pNomeSequence) + ', last_value - 1) FROM ' + pNomeSequence + ';');
  qryGenerica02.Open;
finally
  qryGenerica02.Close;
end;
end;

end.

