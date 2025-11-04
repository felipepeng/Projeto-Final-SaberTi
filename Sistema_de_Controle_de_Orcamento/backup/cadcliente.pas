unit cadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB, DataModule, LCLType, cadProduto;

type

  { TcadClienteF }

  TcadClienteF = class(TXCadPaiF)
    cbTipo: TDBComboBox;
    CombFiltro: TComboBox;
    dsCadCliente: TDataSource;
    edtCPF_CNPJ: TDBEdit;
    edtNome: TDBEdit;
    edtId: TDBEdit;
    edtPesquisa: TEdit;
    lblTipo: TLabel;
    lblId: TLabel;
    lblNome: TLabel;
    lblCPF_CNPJ: TLabel;
    lblPesquisa: TLabel;
    qryCadCliente: TZQuery;
    qryCadClienteclienteid: TZIntegerField;
    qryCadClientecpf_cnpj_cliente: TZRawStringField;
    qryCadClientenome_cliente: TZRawStringField;
    qryCadClientetipo_cliente: TZRawStringField;
    updtCadCliente: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cbTipoClick(Sender: TObject);
    procedure cbTipoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CombFiltroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtCPF_CNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCPF_CNPJKeyPress(Sender: TObject; var Key: char);
    procedure edtNomeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryCadClienteAfterCancel(DataSet: TDataSet);
    procedure qryCadClienteAfterInsert(DataSet: TDataSet);
    procedure qryCadClienteBeforeCancel(DataSet: TDataSet);
    procedure qryCadClienteBeforePost(DataSet: TDataSet);
  private

  public

  end;

var
  cadClienteF: TcadClienteF;

implementation

{$R *.lfm}

{ TcadClienteF }

procedure TcadClienteF.FormShow(Sender: TObject);
begin
  inherited;
  qryCadCliente.Open;
  CombFiltro.SetFocus;

  //Inicia ComboBox
  CombFiltro.Items.Add('ID');
  CombFiltro.Items.Add('Tipo_Cliente');
  CombFiltro.Items.Add('CPF/CNPJ');
  CombFiltro.Items.Add('Nome');
  CombFiltro.ItemIndex := 0;  // seleciona o primeiro item;
end;

procedure TcadClienteF.qryCadClienteAfterCancel(DataSet: TDataSet);
begin
  btnEditar.Glyph.LoadFromFile('./icons/editar.BMP');
  btnEditar.Enabled := true;
  btnEditar.Font.Style := [];
  btnEditar.Font.Color := clBlack;

  PageControl1.ActivePage := tbConsulta;
end;

procedure TcadClienteF.qryCadClienteAfterInsert(DataSet: TDataSet);
begin
  //Aplica Sequence
  qryCadCliente.FieldByName('clienteid').AsInteger := StrToInt(DataModule1.getSequence('cliente_clienteid'));
end;

procedure TcadClienteF.qryCadClienteBeforeCancel(DataSet: TDataSet);
begin
  if (qryCadCliente.State<>dsBrowse) and (qryCadClientenome_cliente.AsString<>'') or (qryCadClientecpf_cnpj_cliente.AsString<>'') then
  begin
    If  MessageDlg('Atenção', 'Existem alterações não salvar, quer cancelar mesmo assim?', mtConfirmation,[mbyes,mbno],0) = mryes then
    begin
      //Checa se está durante o Insert
      if qryCadCliente.State = dsInsert then
        DataModule1.decreaseSequence('categoria_produto_categoriaprodutoid_seq');
    end
    else
    begin
      Abort;
      PageControl1.ActivePage := tbCadastro;
    end;
  end
  else
  begin
    //Checa se está durante o Insert
    if qryCadCliente.State = dsInsert then
      DataModule1.decreaseSequence('categoria_produto_categoriaprodutoid_seq');
  end;

end;

procedure TcadClienteF.qryCadClienteBeforePost(DataSet: TDataSet);
begin
  if PageControl1.ActivePage = tbConsulta then
  begin
    qryCadCliente.Cancel;
    DataModule1.decreaseSequence('cliente_clienteid');
  end;
end;

procedure TcadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  qryCadCliente.Close;
end;

procedure TcadClienteF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (PageControl1.ActivePage = tbCadastro) and (Key = VK_ESCAPE) then
    PageControl1.ActivePage := tbConsulta;
end;

procedure TcadClienteF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  //Insert
  qryCadCliente.Insert;

  edtNome.SetFocus;
  btnEditar.Enabled := false;
end;

procedure TcadClienteF.btnPesquisaClick(Sender: TObject);
begin
  //Fecha a Query
  qryCadCliente.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCadCliente.SQL.Text:= ('select * from cliente c' +
                              ' where c.clienteid =' + edtPesquisa.Text);
  end else
  begin
    qryCadCliente.SQL.Text:= ('select * from cliente c order by c.clienteid;');
  end;

  //Reabre a Query
  qryCadCliente.Open;
end;

procedure TcadClienteF.cbTipoClick(Sender: TObject);
begin
  cadProdutoF.checkEdit(Sender, qryCadCliente, btnEditar);
end;

procedure TcadClienteF.cbTipoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      btnGravar.SetFocus;
    end;
end;

procedure TcadClienteF.CombFiltroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RIGHT then
  begin
    edtPesquisa.SetFocus;
  end;
end;

procedure TcadClienteF.DBGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure TcadClienteF.edtCPF_CNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
    cadProdutoF.checkEdit(Sender, qryCadCliente, btnEditar);
end;

procedure TcadClienteF.edtCPF_CNPJKeyPress(Sender: TObject; var Key: char);
begin
  //Só permite números e backspace
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TcadClienteF.edtNomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
  cadProdutoF.checkEdit(Sender, qryCadCliente, btnEditar);
end;

procedure TcadClienteF.edtPesquisaChange(Sender: TObject);
var
  campo, filtro: string;
begin
  //filtagem da pesquisa
  if CombFiltro.ItemIndex = -1 then
    Exit;

  campo:= edtPesquisa.Text;
  //pega cada insert do EditConsulta

 case CombFiltro.ItemIndex of
    0: filtro := 'CLIENTEID::text';
    1: filtro := 'TIPO_CLIENTE';
    2: filtro := 'CPF_CNPJ_CLIENTE';
    3: filtro := 'NOME_CLIENTE';
  else
    filtro := '';
  end;
  //Busca pelo index do Combobox qual coluna da tabela quero buscar
  // enquanto estiver ativo busca no mesmo
  // obs data não funciona ainda

  if filtro = '' then
    Exit;
  //garante que não busca nada se não tiver o filtro

  qryCadCliente.Close;
  qryCadCliente.SQL.Clear;

  if campo = '' then
  begin
    qryCadCliente.SQL.Add('SELECT * FROM CLIENTE ORDER BY CLIENTEID');
  end else begin
    qryCadCliente.SQL.Add('SELECT * FROM CLIENTE WHERE ' + filtro + ' ILIKE :campo');
    qryCadCliente.ParamByName('campo').AsString := campo + '%';
  end;
  //se campo estiver vazio mostra tudo
  //concatena cada insert de campo com a query
  qryCadCliente.Open;

end;

procedure TcadClienteF.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    DBGrid1.SetFocus;
  end;

  if Key = VK_LEFT then
  begin
    CombFiltro.SetFocus;
  end;
end;

procedure TcadClienteF.btnGravarClick(Sender: TObject);
begin

  if qryCadClientenome_cliente.AsString = '' then
  begin
    ShowMessage('Nome Completo deve ser Preenchido');
    edtNome.SetFocus;
    Abort;
  end;

  if qryCadClientecpf_cnpj_cliente.AsString = '' then
  begin
    ShowMessage('CPF/CNPJ deve ser Preenchido');
    edtCPF_CNPJ.SetFocus;
    Abort;
  end;

  if qryCadClientetipo_cliente.AsString = '' then
  begin
    ShowMessage('Tipo deve ser Preenchido');
    cbTipo.SetFocus;
    Abort;
  end;


  if qryCadCliente.State <> dsBrowse then
  begin
    //Gravar
    qryCadCliente.Post;
    qryCadCliente.Refresh;
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

procedure TcadClienteF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz Nada

  if (qryCadCliente.State <> dsInsert) then
  begin
    //Edit
    qryCadCliente.Edit;
    btnEditar.Glyph.LoadFromFile('./icons/editando.bmp');
    btnEditar.Font.Style := [fsBold];
    btnEditar.Font.Color := clBlue;
  end;
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);
begin
  //Exclui
  If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryCadCliente.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TcadClienteF.btnCancelarClick(Sender: TObject);
begin
  //inherited; //Vai para Consulta

  qryCadCliente.Cancel;

end;

end.

