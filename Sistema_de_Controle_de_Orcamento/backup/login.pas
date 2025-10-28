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
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Image1: TImage;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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

procedure TLoginF.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if edtSenha.Text <> '' then
  begin
    if Key = VK_RETURN then
      btnEntrarClick(Sender);
  end;

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

end.

