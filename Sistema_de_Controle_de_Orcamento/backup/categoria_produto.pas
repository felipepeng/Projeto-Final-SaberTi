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
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
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

procedure TCategoria_ProdutoF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  //Insert
  qryCatProduto.Insert;
end;

procedure TCategoria_ProdutoF.btnPesquisaClick(Sender: TObject);
begin
  //Fecha a Query
  qryCatProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto' +
                              ' where categoriaprodutoid =' + edtPesquisa.Text);
  end else
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto;');
  end;

  //Reabre a Query
  qryCatProduto.Open;
end;

procedure TCategoria_ProdutoF.btnGravarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta
  //Confirma o Insert
  qryCatProduto.Post;
end;

procedure TCategoria_ProdutoF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz Nada
  //Edit
  qryCatProduto.Edit;
end;

procedure TCategoria_ProdutoF.btnExcluirClick(Sender: TObject);
begin
  //Exclui
   If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryCatProduto.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TCategoria_ProdutoF.btnCancelarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta
  //Cancela
  qryCatProduto.Cancel;
end;

end.

