unit Categoria_Produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, XCadPai;

type

  { TCategoria_ProdutoF }

  TCategoria_ProdutoF = class(TXCadPaiF)
    edtId: TDBEdit;
    edtDescricao: TDBEdit;
    edtPesquisa: TEdit;
    lblId: TLabel;
    lblDescricao: TLabel;
    lblPesquisa: TLabel;
    btnPesquisa: TSpeedButton;
    procedure PanelCadastroCenterClick(Sender: TObject);
  private

  public

  end;

var
  Categoria_ProdutoF: TCategoria_ProdutoF;

implementation

{$R *.lfm}

{ TCategoria_ProdutoF }

procedure TCategoria_ProdutoF.PanelCadastroCenterClick(Sender: TObject);
begin

end;

end.

