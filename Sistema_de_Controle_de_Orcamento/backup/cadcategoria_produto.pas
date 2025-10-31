unit cadCategoria_Produto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB, DataModule, LCLType;

type

  { TcadCategoria_ProdutoF }

  TcadCategoria_ProdutoF = class(TXCadPaiF)
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
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryCatProdutoAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  cadCategoria_ProdutoF: TcadCategoria_ProdutoF;

implementation

{$R *.lfm}

{ TcadCategoria_ProdutoF }


//After Insert
procedure TcadCategoria_ProdutoF.qryCatProdutoAfterInsert(DataSet: TDataSet);
begin
  qryCatProdutocategoriaprodutoid.AsInteger := StrToInt(DataModule1.getSequence('categoria_produto_categoriaprodutoid_seq'));
end;

procedure TcadCategoria_ProdutoF.FormShow(Sender: TObject);
begin
  inherited;
  qryCatProduto.Open;
  edtPesquisa.SetFocus;
end;

procedure TcadCategoria_ProdutoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
  qryCatProduto.Close;
end;

procedure TcadCategoria_ProdutoF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (PageControl1.ActivePage = tbCadastro) and Key = VK_ESCAPE then
    PageControl1.ActivePage := tbConsulta;

end;

procedure TcadCategoria_ProdutoF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  //Insert
  qryCatProduto.Insert;

  edtDescricao.SetFocus;
end;

procedure TcadCategoria_ProdutoF.btnPesquisaClick(Sender: TObject);
begin
  //Fecha a Query
  qryCatProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto' +
                              ' where categoriaprodutoid::text like ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto;');
  end;

  //Reabre a Query
  qryCatProduto.Open;
end;

procedure TcadCategoria_ProdutoF.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_RETURN then
  begin
    PageControl1.ActivePage := tbCadastro;
  end;

  if Key = VK_ESCAPE then
  begin
    edtPesquisa.SetFocus;
  end;

end;

procedure TcadCategoria_ProdutoF.edtDescricaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if qryCatProduto.State <> dsBrowse then
  begin
    if Key = VK_RETURN then
    begin
      btnGravar.SetFocus;
    end;
  end;

end;

procedure TcadCategoria_ProdutoF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryCatProduto.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto' +
                              ' where categoriaprodutoid::text like ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryCatProduto.SQL.Text:= ('select * from categoria_produto;');
  end;

  //Reabre a Query
  qryCatProduto.Open;
end;

procedure TcadCategoria_ProdutoF.edtPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if Key = VK_RETURN then
  begin
    DBGrid1.SetFocus;
  end;

end;

procedure TcadCategoria_ProdutoF.btnGravarClick(Sender: TObject);
begin

  if qryCatProdutods_categoria_produto.AsString = '' then
  begin
    ShowMessage('Descrição deve ser Preenchida');
    edtDescricao.SetFocus;
    Abort;
  end;

  inherited; //Vai para Consulta
  //Confirma o Insert
  qryCatProduto.Post;
end;

procedure TcadCategoria_ProdutoF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz Nada
  //Edit
  qryCatProduto.Edit;
end;

procedure TcadCategoria_ProdutoF.btnExcluirClick(Sender: TObject);
var
  existe: Boolean;
begin
  //Checa se existe algum Produto Cadastrado com esse ID
  with DataModule1.qryGenerica do
  begin
    SQL.Text := 'SELECT EXISTS (SELECT 1 FROM produto WHERE categoriaprodutoid = ' +  qryCatProduto.FieldByName('categoriaprodutoid').AsString + ');';
    Open;
    existe := Fields[0].AsBoolean;
    Close;
  end;

  if existe then
    ShowMessage('Não é possível Excluir, existe pelo menos um produto nessa categoria!')
  else
    begin
         ShowMessage('Nenhum produto encontrado nessa categoria.');
         //Exclui
         If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
         begin
           qryCatProduto.Delete;
           inherited; //Vai para Consulta
         end;
    end;

end;

procedure TcadCategoria_ProdutoF.btnCancelarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta

  //Checa se está durante o Insert
  if qryCatProduto.State = dsInsert then
    DataModule1.decreaseSequence('categoria_produto_categoriaprodutoid_seq');

  //Cancela
  qryCatProduto.Cancel;

end;

end.

