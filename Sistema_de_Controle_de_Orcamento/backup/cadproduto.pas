unit cadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, DBExtCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB,
  cadCategoria_Produto, pesqCatProduto,DataModule;

type

  { TcadProdutoF }

  TcadProdutoF = class(TXCadPaiF)
    btnPesquisa: TSpeedButton;
    cbStatus: TDBComboBox;
    dateCadastro: TDBDateEdit;
    edtCatDesc: TDBEdit;
    edtCatId: TDBEdit;
    edtValorVenda: TDBEdit;
    edtObservacao: TDBEdit;
    edtDescricao: TDBEdit;
    edtId: TDBEdit;
    dsCadProduto: TDataSource;
    edtPesquisa: TEdit;
    lblCatId: TLabel;
    lblData: TLabel;
    lblId: TLabel;
    lblDescricao: TLabel;
    lblCategoria: TLabel;
    lblObservacao: TLabel;
    lblValorVenda: TLabel;
    lblPesquisa: TLabel;
    lblStatus: TLabel;
    qryCadProduto: TZQuery;
    qryCadProdutocategoriaprodutoid: TZIntegerField;
    qryCadProdutods_produto: TZRawStringField;
    qryCadProdutodt_cadastro_produto: TZDateTimeField;
    qryCadProdutoobs_produto: TZRawStringField;
    qryCadProdutoprodutoid: TZIntegerField;
    qryCadProdutostatus_produto: TZRawStringField;
    qryCadProdutovl_venda_produto: TZBCDField;
    btnOpenCatProd: TSpeedButton;
    updtCadProduto: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnOpenCatProdClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCatDescChange(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryCadProdutoAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  cadProdutoF: TcadProdutoF;

implementation

{$R *.lfm}

{ TcadProdutoF }

procedure TcadProdutoF.FormShow(Sender: TObject);
begin
  inherited;
  qryCadProduto.Open;
end;

procedure TcadProdutoF.qryCadProdutoAfterInsert(DataSet: TDataSet);
begin
  //Sequence
  qryCadProduto.FieldByName('produtoid').AsInteger := StrToInt(DataModule1.getSequence('produto_produtoid'));
end;

procedure TcadProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  qryCadProduto.Close;
end;

procedure TcadProdutoF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  qryCadProduto.Insert;
  qryCadProduto.FieldByName('dt_cadastro_produto').AsDateTime := Date;

end;

procedure TcadProdutoF.btnOpenCatProdClick(Sender: TObject);
var
  pesqCatProdutoF : TpesqCatProdutoF;
begin
  pesqCatProdutoF := TpesqCatProdutoF.Create(Self);
  pesqCatProdutoF.ShowModal;
end;

procedure TcadProdutoF.btnPesquisaClick(Sender: TObject);
begin
  //Fecha a Query
  qryCadProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCadProduto.SQL.Text:= ('select * from produto p' +
                              ' where p.produtoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryCadProduto.SQL.Text:= ('select * from produto;');
  end;

  //Reabre a Query
  qryCadProduto.Open;
end;

procedure TcadProdutoF.edtCatDescChange(Sender: TObject);
begin

end;

procedure TcadProdutoF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryCadProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCadProduto.SQL.Text:= ('select * from produto p' +
                              ' where p.produtoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryCadProduto.SQL.Text:= ('select * from produto;');
  end;

  //Reabre a Query
  qryCadProduto.Open;
end;

procedure TcadProdutoF.btnGravarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta
  qryCadProduto.Post;
end;

procedure TcadProdutoF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz nada
  qryCadProduto.Edit;
end;

procedure TcadProdutoF.btnExcluirClick(Sender: TObject);
begin
  //Exclui
  If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryCadProduto.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TcadProdutoF.btnCancelarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta

  //Checa se está durante o Insert
  if qryCadProduto.State = dsInsert then
    DataModule1.decreaseSequence('produto_produtoid');

  //Cancel
  qryCadProduto.Cancel;
end;

end.

