unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
           cadCategoria_Produto, cadCliente, cadProduto, cadUsuario, Sobre,
           Orcamento, relClientes, relOrcamento, relProduto, relCatProduto;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuCadastros: TMenuItem;
    MenuItemRelCatProduto: TMenuItem;
    MenuItemRelProduto: TMenuItem;
    MenuItemRelClientes: TMenuItem;
    MenuRelatorios: TMenuItem;
    MenuSobre: TMenuItem;
    MenuSair: TMenuItem;
    MenuItemEncerrarSes: TMenuItem;
    MenuItemSair: TMenuItem;
    MenuVendas: TMenuItem;
    MenuItemOrcamento: TMenuItem;
    MenuItemCategoria: TMenuItem;
    MenuItemCliente: TMenuItem;
    MenuItemProduto: TMenuItem;
    MenuItemUsuario: TMenuItem;
    Separator1: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MenuItemCategoriaClick(Sender: TObject);
    procedure MenuItemClienteClick(Sender: TObject);
    procedure MenuItemEncerrarSesClick(Sender: TObject);
    procedure MenuItemOrcamentoClick(Sender: TObject);
    procedure MenuItemProdutoClick(Sender: TObject);
    procedure MenuItemRelCatProdutoClick(Sender: TObject);
    procedure MenuItemRelClientesClick(Sender: TObject);
    procedure MenuItemRelOrcamentoClick(Sender: TObject);
    procedure MenuItemRelProdutoClick(Sender: TObject);
    procedure MenuItemSairClick(Sender: TObject);
    procedure MenuItemUsuarioClick(Sender: TObject);
    procedure MenuSobreClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

procedure TMenuPrincipalF.MenuItemCategoriaClick(Sender: TObject);
begin
  cadCategoria_ProdutoF := TcadCategoria_ProdutoF.Create(Self);
  cadCategoria_ProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TMenuPrincipalF.MenuItemClienteClick(Sender: TObject);
begin
  cadClienteF := TcadClienteF.Create(Self);
  cadClienteF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemEncerrarSesClick(Sender: TObject);
begin
  Close;
end;

procedure TMenuPrincipalF.MenuItemOrcamentoClick(Sender: TObject);
begin
  OrcamentoF := TOrcamentoF.Create(Self);
  OrcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemProdutoClick(Sender: TObject);
begin
  cadProdutoF := TcadProdutoF.Create(Self);
  cadProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemRelCatProdutoClick(Sender: TObject);
begin
  relCatProdutoF := TrelCatProdutoF.Create(Self);
  relCatProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemRelClientesClick(Sender: TObject);
begin
  relClientesF := TrelClientesF.Create(Self);
  relClientesF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemRelOrcamentoClick(Sender: TObject);
begin
  relOrcamentoF := TrelOrcamentoF.Create(Self);
  relOrcamentoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemRelProdutoClick(Sender: TObject);
begin
  relProdutoF := TrelProdutoF.Create(Self);
  relProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenuPrincipalF.MenuItemUsuarioClick(Sender: TObject);
begin
  cadUsuarioF := TcadUsuarioF.Create(Self);
  cadUsuarioF.ShowModal;
end;

procedure TMenuPrincipalF.MenuSobreClick(Sender: TObject);
begin
  SobreF := TSobreF.Create(Self);
  SobreF.ShowModal;
end;

end.

