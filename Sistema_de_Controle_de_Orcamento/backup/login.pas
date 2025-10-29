unit Login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, LCLType,
  MenuPrincipal, DataModule;

type

  { TLoginF }

  TLoginF = class(TForm)
    btnEntrar: TBitBtn;
    btnSair: TBitBtn;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    btnShowSenha: TSpeedButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtUsuarioChange(Sender: TObject);
    procedure edtUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnShowSenhaClick(Sender: TObject);
    function validaUsuario(pUsuario: String; pSenha: String): Boolean;
  private

  public

  end;

var
  LoginF: TLoginF;

implementation

{$R *.lfm}

{ TLoginF }

function TLoginF.validaUsuario(pUsuario: String; pSenha: String): Boolean;
begin

   if (pUsuario = '') then
   begin
      ShowMessage('Favor Preencha o Usuário!');
      edtUsuario.SetFocus;
      Result := False;
      Exit;
   end;

   if (pSenha = '') then
   begin
      ShowMessage('Favor Preencha a Senha!');
      edtSenha.SetFocus;
      Result := False;
      Exit;
   end;

   DataModule1.qryGenerica.Close;
   DataModule1.qryGenerica.SQL.Clear;
   DataModule1.qryGenerica.SQL.Add('SELECT COUNT(*) AS NUMBER '+
                                   'FROM USUARIOS '+
                                   'WHERE USUARIO = ' +  QuotedStr(pUsuario) + ' ' +
                                   'AND SENHA = ' + QuotedStr(pSenha));
   DataModule1.qryGenerica.Open;

   if DataModule1.qryGenerica.FieldByName('NUMBER').AsInteger = 0 then
   Begin
      ShowMessage('Senha ou Usuário incorretos!');
      edtUsuario.SetFocus;
      Result := False;
   end
   else
   begin
      Result := True;
   end;

end;

procedure TLoginF.btnEntrarClick(Sender: TObject);
begin
  if ValidaUsuario(edtUsuario.Text,edtSenha.Text) = True then
  begin
    MenuPrincipalF := TMenuPrincipalF.Create(Self);
    MenuPrincipalF.ShowModal;

    edtUsuario.Text := '';
    edtSenha.Text := '';
    edtUsuario.SetFocus;
  end;
end;

procedure TLoginF.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginF.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if edtSenha.Text <> '' then
  begin
    if Key = VK_RETURN then
      btnEntrarClick(Sender);
  end;

end;

procedure TLoginF.edtUsuarioChange(Sender: TObject);
begin

end;

procedure TLoginF.edtUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if edtUsuario.Text <> '' then
  begin
    if Key = VK_RETURN then
    edtSenha.SetFocus;
  end;

end;

procedure TLoginF.btnShowSenhaClick(Sender: TObject);
begin
  if edtSenha.EchoMode <> emNormal then
  begin
    btnShowSenha.Glyph.LoadFromFile('./icons/view.bmp');
    edtSenha.EchoMode := emNormal;
  end
  else
  begin
    edtSenha.EchoMode := emPassword;
  end;


end;

end.

