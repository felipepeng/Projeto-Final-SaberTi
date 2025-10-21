program prjOSC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, XCadPai, MenuPrincipal, cadCategoria_Produto, DataModule, zcomponent,
  cadCliente, cadProduto, cadUsuario;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TMenuPrincipalF, MenuPrincipalF);
  Application.CreateForm(TXCadPaiF, XCadPaiF);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TcadUsuarioF, cadUsuarioF);
  Application.Run;
end.

