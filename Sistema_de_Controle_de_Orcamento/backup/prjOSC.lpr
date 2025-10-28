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
  cadCliente, cadProduto, cadUsuario, pesqCatProduto, Sobre, Orcamento,
  pesqCliente, cadItemOrc, pesqProduto, relClientes, relOrcamento, relProduto,
  relCatProduto, Login;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TLoginF, LoginF);
  Application.CreateForm(TXCadPaiF, XCadPaiF);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TpesqCatProdutoF, pesqCatProdutoF);
  Application.CreateForm(TpesqClienteF, pesqClienteF);
  Application.CreateForm(TpesqProdutoF, pesqProdutoF);
  Application.Run;
end.

