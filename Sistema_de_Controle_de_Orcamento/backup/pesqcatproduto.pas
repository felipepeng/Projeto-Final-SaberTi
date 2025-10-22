unit pesqCatProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, StdCtrls, ZDataset, ZAbstractRODataset, DataModule;

type

  { TpesqCatProdutoF }

  TpesqCatProdutoF = class(TForm)
    btnPesquisa: TSpeedButton;
    dsPesqCat: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    Panel1: TPanel;
    PanelTop: TPanel;
    qrypesqCat: TZQuery;
    qrypesqCatcategoriaprodutoid: TZIntegerField;
    qrypesqCatds_categoria_produto: TZRawStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqCatProdutoF: TpesqCatProdutoF;

implementation

{$R *.lfm}

uses
  cadProduto;

{ TpesqCatProdutoF }

procedure TpesqCatProdutoF.FormShow(Sender: TObject);
begin
  //Abre a Query
  qrypesqCat.Open;
end;

procedure TpesqCatProdutoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  //Fecha a Query
  qrypesqCat.Close;
end;

procedure TpesqCatProdutoF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qrypesqCat.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qrypesqCat.SQL.Text:= ('select * from categoria_produto c' +
                              ' where c.categoriaprodutoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qrypesqCat.SQL.Text:= ('select * from categoria_produto;');
  end;

  //Reabre a Query
  qrypesqCat.Open;
end;

procedure TpesqCatProdutoF.DBGrid1DblClick(Sender: TObject);
begin
  cadProdutoF.qryCadProdutocategoriaprodutoid.AsInteger := qrypesqCatcategoriaprodutoid.AsInteger;
  cadProdutoF.edtCatDescricao.Text := qrypesqCat.FieldByName('ds_categoria_produto').AsString;
  Close;
end;

end.

