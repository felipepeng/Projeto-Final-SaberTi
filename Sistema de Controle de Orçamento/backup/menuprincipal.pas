unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
           cadCategoria_Produto, cadCliente;

type

  { TMenuPrincipalF }

  TMenuPrincipalF = class(TForm)
    MainMenu1: TMainMenu;
    MenuCadastros: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCategoriaClick(Sender: TObject);
    procedure MenuItemClienteClick(Sender: TObject);
    procedure MenuItemSairClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalF: TMenuPrincipalF;

implementation

{$R *.lfm}

{ TMenuPrincipalF }

procedure TMenuPrincipalF.FormCreate(Sender: TObject);
begin

end;

procedure TMenuPrincipalF.MenuItemCategoriaClick(Sender: TObject);
var
  cadCategoria_ProdutoF : TcadCategoria_ProdutoF;
begin
  cadCategoria_ProdutoF := TcadCategoria_ProdutoF.Create(Self);
  cadCategoria_ProdutoF.ShowModal;
end;

procedure TMenuPrincipalF.MenuItemClienteClick(Sender: TObject);
begin

end;

procedure TMenuPrincipalF.MenuItemSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

