unit relProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, ZDataset, ZAbstractRODataset;

type

  { TrelProdutoF }

  TrelProdutoF = class(TForm)
    btnRelClientes: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryProduto: TZQuery;
    qryProdutocategoriaprodutoid: TZIntegerField;
    qryProdutods_produto: TZRawStringField;
    qryProdutodt_cadastro_produto: TZDateTimeField;
    qryProdutoobs_produto: TZRawStringField;
    qryProdutoprodutoid: TZIntegerField;
    qryProdutostatus_produto: TZRawStringField;
    qryProdutovl_venda_produto: TZBCDField;
    procedure btnRelClientesClick(Sender: TObject);
  private

  public

  end;

var
  relProdutoF: TrelProdutoF;

implementation

{$R *.lfm}

{ TrelProdutoF }

procedure TrelProdutoF.btnRelClientesClick(Sender: TObject);
begin
  frReport1.LoadFromFile('.\Relatorios\relProduto.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

end.

