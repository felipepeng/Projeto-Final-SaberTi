unit cadProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, DBExtCtrls, ExtCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate,
  XCadPai, DB, cadCategoria_Produto, pesqCatProduto, DataModule, LCLType;

type

  { TcadProdutoF }

  TcadProdutoF = class(TXCadPaiF)
    btnPesqCat: TBitBtn;
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
    qryCatProdutocategoriaprodutoid: TZIntegerField;
    qryCatProdutods_categoria_produto: TStringField;
    updtCadProduto: TZUpdateSQL;
    qryCatProduto: TZQuery;
    procedure btnPesqCatClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cbStatusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
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
  qryCatProduto.Open;
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
  qryCatProduto.Close;
end;

procedure TcadProdutoF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  qryCadProduto.Insert;
  qryCadProduto.FieldByName('dt_cadastro_produto').AsDateTime := Date;

  edtDescricao.SetFocus;
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

procedure TcadProdutoF.cbStatusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if qryCadProduto.State <> dsBrowse then
  begin
    if Key = VK_RETURN then
    begin
      btnGravar.SetFocus;
    end;
  end;

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

  if qryCadProdutods_produto.AsString = '' then
  begin
    ShowMessage('Descrição deve ser Preenchida');
    edtDescricao.SetFocus;
    Abort;
  end;

  if qryCadProdutoobs_produto.AsString = '' then
  begin
    ShowMessage('Observação deve ser Preenchida');
    edtObservacao.SetFocus;
    Abort;
  end;

  if qryCadProdutovl_venda_produto.AsString = '' then
  begin
    ShowMessage('Valor de Venda deve ser Preenchida');
    edtValorVenda.SetFocus;
    Abort;
  end;

  if qryCadProdutocategoriaprodutoid.AsString = '' then
  begin
    ShowMessage('Uma Categoria deve ser escolhida');
    //edtCatId.SetFocus;
    btnPesqCatClick(Sender);
    cbStatus.SetFocus;
    Abort;
  end;

  if qryCadProdutostatus_produto.AsString = '' then
  begin
    ShowMessage('Status deve ser Preenchida');
    cbStatus.SetFocus;
    Abort;
  end;

  inherited; //Vai para Consulta
  qryCadProduto.Post;
end;

procedure TcadProdutoF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz nada
  qryCadProduto.Edit;
end;

procedure TcadProdutoF.btnExcluirClick(Sender: TObject);
var
  existe: Boolean;
begin

  //Checa se existe algum Produto Cadastrado com esse ID
  with DataModule1.qryGenerica do
  begin
    SQL.Text := 'SELECT EXISTS (SELECT 1 FROM orcamento_item WHERE produtoid = ' +  qryCadProduto.FieldByName('produtoid').AsString + ');';
    Open;
    existe := Fields[0].AsBoolean;
    Close;
  end;

  if existe then
    ShowMessage('Não é possível Excluir, existe pelo menos um item de orçamento com este produto!')
  else
    begin
         ShowMessage('Nenhum item de orçamento com este produto.');
         //Exclui
         If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
         begin
           qryCadProduto.Delete;
           inherited; //Vai para Consulta
         end;
    end;



end;

procedure TcadProdutoF.btnCancelarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta

  //Decrementa a Sequence
  if qryCadProduto.State = dsInsert then
    DataModule1.decreaseSequence('produto_produtoid');

  //Cancel
  qryCadProduto.Cancel;
end;

procedure TcadProdutoF.btnPesqCatClick(Sender: TObject);
begin
  pesqCatProdutoF.ShowModal;
end;

end.

