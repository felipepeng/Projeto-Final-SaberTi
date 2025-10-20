unit MenuPrincipal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Categoria_Produto;

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
  Categoria_ProdutoF : TCategoria_ProdutoF;
begin
  Categoria_ProdutoF := TCategoria_ProdutoF.Create(Self);
  Categoria_ProdutoF.ShowModal;

end;

end.

