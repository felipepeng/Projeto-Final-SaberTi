unit Categoria_Produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB;

type

  { TCategoria_ProdutoF }

  TCategoria_ProdutoF = class(TXCadPaiF)
    dsCatProduto: TDataSource;
    edtId: TDBEdit;
    edtDescricao: TDBEdit;
    edtPesquisa: TEdit;
    lblId: TLabel;
    lblDescricao: TLabel;
    lblPesquisa: TLabel;
    btnPesquisa: TSpeedButton;
    qryCatProduto: TZQuery;
    qryCatProdutocategoriaprodutoid: TZIntegerField;
    qryCatProdutods_categoria_produto: TZRawStringField;
    updtCatProduto: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
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

procedure TCategoria_ProdutoF.FormShow(Sender: TObject);
begin
  inherited;
  qryCatProduto.Open;
end;

procedure TCategoria_ProdutoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
  qryCatProduto.Close;
end;

end.

