unit cadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB, DataModule, LCLType, cadProduto;

type

  { TcadUsuarioF }

  TcadUsuarioF = class(TXCadPaiF)
    CombFiltro: TComboBox;
    dsCadUsuario: TDataSource;
    edtSenha: TDBEdit;
    edtNomeComp: TDBEdit;
    edtId: TDBEdit;
    edtUsuario: TDBEdit;
    edtPesquisa: TEdit;
    lblId: TLabel;
    lblSenha: TLabel;
    lblUsuario: TLabel;
    lblPesquisa: TLabel;
    lblNomeComp: TLabel;
    qryCadUsuario: TZQuery;
    qryCadUsuarioid: TZIntegerField;
    qryCadUsuarionome_completo: TZRawStringField;
    qryCadUsuariosenha: TZRawStringField;
    qryCadUsuariousuario: TZRawStringField;
    updtCadUsuario: TZUpdateSQL;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure CombFiltroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtNomeCompKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure qryCadUsuarioAfterCancel(DataSet: TDataSet);
    procedure qryCadUsuarioAfterInsert(DataSet: TDataSet);
    procedure qryCadUsuarioBeforeCancel(DataSet: TDataSet);
    procedure qryCadUsuarioBeforePost(DataSet: TDataSet);
  private

  public

  end;

var
  cadUsuarioF: TcadUsuarioF;

implementation

{$R *.lfm}

{ TcadUsuarioF }

procedure TcadUsuarioF.FormShow(Sender: TObject);
begin
  inherited;
  //Abre a Query
  qryCadUsuario.Open;

  CombFiltro.SetFocus;

  //Inicia ComboBox
  CombFiltro.Items.Add('ID');
  CombFiltro.Items.Add('Usuário');
  CombFiltro.Items.Add('Nome');
  CombFiltro.Items.Add('Senha');
  CombFiltro.ItemIndex := 0;  // seleciona o primeiro item;
end;

procedure TcadUsuarioF.qryCadUsuarioAfterCancel(DataSet: TDataSet);
begin
  btnEditar.Glyph.LoadFromFile('./icons/editar.BMP');
  btnEditar.Enabled := true;
  btnEditar.Font.Style := [];
  btnEditar.Font.Color := clBlack;

  PageControl1.ActivePage := tbConsulta;
end;

procedure TcadUsuarioF.qryCadUsuarioAfterInsert(DataSet: TDataSet);
begin
  //Aplica Sequence
  qryCadUsuario.FieldByName('id').AsInteger := StrToInt(DataModule1.getSequence('usuarios_id_seq'));
end;

procedure TcadUsuarioF.qryCadUsuarioBeforeCancel(DataSet: TDataSet);
begin
  if (qryCadUsuario.State<>dsBrowse) and (qryCadUsuariousuario.AsString<>'') or (qryCadUsuarionome_completo.AsString<>'') or (qryCadUsuariosenha.AsString<>'') then
  begin
    If  MessageDlg('Atenção', 'Existem alterações não salvar, quer cancelar mesmo assim?', mtConfirmation,[mbyes,mbno],0) = mryes then
    begin

    end
    else
    begin
      Abort;
      PageControl1.ActivePage := tbCadastro;
    end;
  end;

  //Checa se está durante o Insert
  if qryCadUsuario.State = dsInsert then
    DataModule1.decreaseSequence('usuarios_id_seq');

end;

procedure TcadUsuarioF.qryCadUsuarioBeforePost(DataSet: TDataSet);
begin
  if PageControl1.ActivePage = tbConsulta then
  begin
    qryCadUsuario.Cancel;
    //DataModule1.decreaseSequence('usuarios_id_seq');
  end;
end;

procedure TcadUsuarioF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  //Fecha a Query
  qryCadUsuario.Close;
end;

procedure TcadUsuarioF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (PageControl1.ActivePage = tbCadastro) and (Key = VK_ESCAPE) then
    PageControl1.ActivePage := tbConsulta;
end;

procedure TcadUsuarioF.btnInserirClick(Sender: TObject);
begin
  inherited;
  //Insert
  qryCadUsuario.Insert;

  edtUsuario.SetFocus;
  btnEditar.Enabled := false;
end;

procedure TcadUsuarioF.CombFiltroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RIGHT then
  begin
    edtPesquisa.SetFocus;
  end;
end;

procedure TcadUsuarioF.DBGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure TcadUsuarioF.edtNomeCompKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
    cadProdutoF.checkEdit(Sender, qryCadUsuario, btnEditar);
end;

procedure TcadUsuarioF.edtPesquisaChange(Sender: TObject);
var
  campo, filtro: string;
begin
  //filtagem da pesquisa
  if CombFiltro.ItemIndex = -1 then
    Exit;

  campo:= edtPesquisa.Text;
  //pega cada insert do EditConsulta

 case CombFiltro.ItemIndex of
    0: filtro := 'id::text';
    1: filtro := 'usuario';
    2: filtro := 'nome_completo';
    3: filtro := 'senha';
  else
    filtro := '';
  end;
  //Busca pelo index do Combobox qual coluna da tabela quero buscar
  // enquanto estiver ativo busca no mesmo
  // obs data não funciona ainda

  if filtro = '' then
    Exit;
  //garante que não busca nada se não tiver o filtro

  qryCadUsuario.Close;
  qryCadUsuario.SQL.Clear;

  if campo = '' then
  begin
    qryCadUsuario.SQL.Add('SELECT * FROM usuarios ORDER BY id');
  end else begin
    qryCadUsuario.SQL.Add('SELECT * FROM usuarios WHERE ' + filtro + ' ILIKE :campo');
    qryCadUsuario.ParamByName('campo').AsString := campo + '%';
  end;
  //se campo estiver vazio mostra tudo
  //concatena cada insert de campo com a query
  qryCadUsuario.Open;




  ////Fecha a Query
  //qryCadUsuario.Close;
  //
  ////Edita o comando SQL
  //if edtPesquisa.Text <> '' then
  //begin
  //  qryCadUsuario.SQL.Text:= ('select * from usuarios u' +
  //                            ' where u.id::text LIKE ''' + edtPesquisa.Text + '%'';');
  //end else
  //begin
  //  qryCadUsuario.SQL.Text:= ('select * from usuarios;');
  //end;
  //
  ////Reabre a Query
  //qryCadUsuario.Open;
end;

procedure TcadUsuarioF.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
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

procedure TcadUsuarioF.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
    cadProdutoF.checkEdit(Sender, qryCadUsuario, btnEditar);

  if Key = VK_RETURN then
  begin
    btnGravar.SetFocus;
  end;
end;

procedure TcadUsuarioF.edtUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_TAB then
    cadProdutoF.checkEdit(Sender, qryCadUsuario, btnEditar);
end;

procedure TcadUsuarioF.btnGravarClick(Sender: TObject);
begin

  if qryCadUsuariousuario.AsString = '' then
  begin
    ShowMessage('Usuário deve ser Preenchido');
    edtUsuario.SetFocus;
    Abort;
  end;

  if qryCadUsuarionome_completo.AsString = '' then
  begin
    ShowMessage('Nome Completo deve ser Preenchido');
    edtNomeComp.SetFocus;
    Abort;
  end;

  if qryCadUsuariosenha.AsString = '' then
  begin
    ShowMessage('Senha deve ser Preenchida');
    edtSenha.SetFocus;
    Abort;
  end;


  if qryCadUsuario.State <> dsBrowse then
  begin
    //Gravar
    qryCadUsuario.Post;
    qryCadUsuario.Refresh;
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

procedure TcadUsuarioF.btnEditarClick(Sender: TObject);
begin
  inherited;

  if (qryCadUsuario.State <> dsInsert) then
  begin
    //Edit
    qryCadUsuario.Edit;
    btnEditar.Glyph.LoadFromFile('./icons/editando.bmp');
    btnEditar.Font.Style := [fsBold];
    btnEditar.Font.Color := clBlue;
  end;
end;

procedure TcadUsuarioF.btnExcluirClick(Sender: TObject);
begin
  //Excluir
  If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryCadUsuario.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TcadUsuarioF.btnCancelarClick(Sender: TObject);
begin
  if qryCadUsuario.State = dsBrowse then
    inherited;

  //Cancelar
  qryCadUsuario.Cancel;
end;

end.

