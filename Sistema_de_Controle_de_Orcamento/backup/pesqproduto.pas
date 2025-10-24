unit pesqProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, ZDataset, ZAbstractRODataset;

type

  { TpesqProdutoF }

  TpesqProdutoF = class(TForm)
    btnPesquisa: TSpeedButton;
    dsProduto: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    PanelTop: TPanel;
    qryProduto: TZQuery;
    qryProdutocategoriaprodutoid: TZIntegerField;
    qryProdutods_produto: TZRawStringField;
    qryProdutodt_cadastro_produto: TZDateTimeField;
    qryProdutoobs_produto: TZRawStringField;
    qryProdutoprodutoid: TZIntegerField;
    qryProdutostatus_produto: TZRawStringField;
    qryProdutovl_venda_produto: TZBCDField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqProdutoF: TpesqProdutoF;

implementation

{$R *.lfm}

uses
  Orcamento;

{ TpesqProdutoF }

procedure TpesqProdutoF.FormShow(Sender: TObject);
begin
  qryProduto.Open;
end;

procedure TpesqProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  qryProduto.Close;
end;

procedure TpesqProdutoF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryProduto.SQL.Text:= ('select * from produto p' +
                              ' where p.produtoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryProduto.SQL.Text:= ('select * from produto;');
  end;

  //Reabre a Query
  qryProduto.Open;
end;

procedure TpesqProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  OrcamentoF.qryOrcItemprodutoid.AsInteger := qryProdutoprodutoid.AsInteger;
  OrcamentoF.qryOrcItemvl_unitario.AsFloat := qryProdutovl_venda_produto.AsFloat;
  Close;
end;


end.

