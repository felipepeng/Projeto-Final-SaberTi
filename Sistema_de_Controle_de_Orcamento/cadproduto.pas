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
    CombFiltro: TComboBox;
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
    procedure cbStatusClick(Sender: TObject);
    procedure cbStatusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure dateCadastroButtonClick(Sender: TObject);
    procedure dateCadastroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtObservacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryCadProdutoAfterCancel(DataSet: TDataSet);
    procedure qryCadProdutoAfterInsert(DataSet: TDataSet);
    procedure qryCadProdutoBeforePost(DataSet: TDataSet);
  private

  public
    procedure checkEdit(Sender: TObject ;qry: TZQuery);
    procedure checkEdit(Sender: TObject ;qry: TZQuery; button: TBitBtn);
  end;

var
  cadProdutoF: TcadProdutoF;

implementation

{$R *.lfm}

{ TcadProdutoF }

procedure TcadProdutoF.checkEdit(Sender: TObject ;qry: TZQuery);
begin
  if qry.State = dsBrowse then
    begin
      ShowMessage('Para Alterar o campo, primeiro ative o modo de Edição.');
      btnEditar.SetFocus;
      Abort;
    end;
end;

procedure TcadProdutoF.checkEdit(Sender: TObject ;qry: TZQuery; button: TBitBtn);
begin
  if qry.State = dsBrowse then
    begin
      ShowMessage('Para Alterar o campo, primeiro ative o modo de Edição.');
      button.SetFocus;
      Abort;
    end;
end;

procedure TcadProdutoF.FormShow(Sender: TObject);
begin
  inherited;
  qryCadProduto.Open;
  qryCatProduto.Open;

  //Inicia ComboBox
  CombFiltro.Items.Add('ID');
  CombFiltro.Items.Add('Descrição');
  CombFiltro.Items.Add('Observação');
  CombFiltro.Items.Add('Valor');
  CombFiltro.Items.Add('Status');
  CombFiltro.Items.Add('Categoria ID');
  CombFiltro.ItemIndex := 0;  // seleciona o primeiro item;
end;

procedure TcadProdutoF.qryCadProdutoAfterCancel(DataSet: TDataSet);
begin
  btnEditar.Glyph.LoadFromFile('./icons/editar.BMP');
  btnEditar.Enabled := true;
  btnEditar.Font.Style := [];
  btnEditar.Font.Color := clBlack;
end;

procedure TcadProdutoF.qryCadProdutoAfterInsert(DataSet: TDataSet);
begin
  //Sequence
  qryCadProduto.FieldByName('produtoid').AsInteger := StrToInt(DataModule1.getSequence('produto_produtoid'));
end;

procedure TcadProdutoF.qryCadProdutoBeforePost(DataSet: TDataSet);
begin
  if PageControl1.ActivePage = tbConsulta then
    begin
      qryCadProduto.Cancel;
      DataModule1.decreaseSequence('produto_produtoid');
    end;

end;

procedure TcadProdutoF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  qryCadProduto.Close;
  qryCatProduto.Close;
end;

procedure TcadProdutoF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (PageControl1.ActivePage = tbCadastro) and (Key = VK_ESCAPE) then
    PageControl1.ActivePage := tbConsulta;
end;

procedure TcadProdutoF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  qryCadProduto.Insert;
  qryCadProduto.FieldByName('dt_cadastro_produto').AsDateTime := Date;

  edtDescricao.SetFocus;
  btnEditar.Enabled := false;
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

procedure TcadProdutoF.cbStatusClick(Sender: TObject);
begin
  checkEdit(Sender, qryCadProduto);
end;

procedure TcadProdutoF.cbStatusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  begin
    checkEdit(Sender, qryCadProduto);
  end;

  if qryCadProduto.State <> dsBrowse then
  begin
    if Key = VK_RETURN then
    begin
      btnGravar.SetFocus;
    end;
  end;

end;

procedure TcadProdutoF.dateCadastroButtonClick(Sender: TObject);
begin
  checkEdit(Sender, qryCadProduto);
end;

procedure TcadProdutoF.dateCadastroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  checkEdit(Sender, qryCadProduto);
end;

procedure TcadProdutoF.DBGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure TcadProdutoF.edtDescricaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  checkEdit(Sender, qryCadProduto);
end;

procedure TcadProdutoF.edtObservacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  checkEdit(Sender, qryCadProduto);
end;

procedure TcadProdutoF.edtPesquisaChange(Sender: TObject);
var
  campo, filtro: string;
begin
  //filtagem da pesquisa
  if CombFiltro.ItemIndex = -1 then
    Exit;

  campo:= edtPesquisa.Text;
  //pega cada insert do EditConsulta

 case CombFiltro.ItemIndex of
    0: filtro := 'produtoid::text';
    1: filtro := 'ds_produto';
    2: filtro := 'obs_produto';
    3: filtro := 'vl_venda_produto::text';
    4: filtro := 'status_produto';
    5: filtro := 'categoriaprodutoid::text';
  else
    filtro := '';
  end;
  //Busca pelo index do Combobox qual coluna da tabela quero buscar
  // enquanto estiver ativo busca no mesmo
  // obs data não funciona ainda

  if filtro = '' then
    Exit;
  //garante que não busca nada se não tiver o filtro

  qryCadProduto.Close;
  qryCadProduto.SQL.Clear;

  if campo = '' then
  begin
    qryCadProduto.SQL.Add('SELECT * FROM produto ORDER BY produtoid');
  end else begin
    qryCadProduto.SQL.Add('SELECT * FROM produto WHERE ' + filtro + ' ILIKE :campo');
    qryCadProduto.ParamByName('campo').AsString := campo + '%';
  end;
  //se campo estiver vazio mostra tudo
  //concatena cada insert de campo com a query
  qryCadProduto.Open;




  ////Fecha a Query
  //qryCadProduto.Close;
  //
  ////Edita o comando SQL
  //if edtPesquisa.Text <> '' then
  //begin
  //  qryCadProduto.SQL.Text:= ('select * from produto p' +
  //                            ' where p.produtoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  //end else
  //begin
  //  qryCadProduto.SQL.Text:= ('select * from produto;');
  //end;
  //
  ////Reabre a Query
  //qryCadProduto.Open;
end;

procedure TcadProdutoF.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    DBGrid1.SetFocus;
  end;
end;

procedure TcadProdutoF.edtValorVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  checkEdit(Sender, qryCadProduto);
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


  if qryCadProduto.State <> dsBrowse then
  begin
    //Gravar
    qryCadProduto.Post;
    qryCadProduto.Refresh;
    inherited;

    //Troca ìcone Editar
    btnEditar.Glyph.LoadFromFile('./icons/editar.BMP');
    btnEditar.Font.Style := [];
    btnEditar.Font.Color := clBlack;
  end
  else
  begin
    ShowMessage('Para gravar, primeiro ative o modo de edição.');
    btnEditar.SetFocus;
  end;
end;

procedure TcadProdutoF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz nada

  if (qryCadProduto.State <> dsInsert) then
  begin
    //Edit
    qryCadProduto.Edit;
    btnEditar.Glyph.LoadFromFile('./icons/editando.bmp');
    btnEditar.Font.Style := [fsBold];
    btnEditar.Font.Color := clBlue;
  end;
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
  checkEdit(Sender, qryCadProduto);
  pesqCatProdutoF.ShowModal;
end;

end.

