unit cadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB, DataModule;

type

  { TcadUsuarioF }

  TcadUsuarioF = class(TXCadPaiF)
    btnPesquisa: TSpeedButton;
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
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryCadUsuarioAfterInsert(DataSet: TDataSet);
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
end;

procedure TcadUsuarioF.qryCadUsuarioAfterInsert(DataSet: TDataSet);
begin
  //Aplica Sequence
  qryCadUsuario.FieldByName('id').AsInteger := StrToInt(DataModule1.getSequence('usuarios_id_seq'));
end;

procedure TcadUsuarioF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  //Fecha a Query
  qryCadUsuario.Close;
end;

procedure TcadUsuarioF.btnInserirClick(Sender: TObject);
begin
  inherited;
  //Insert
  qryCadUsuario.Insert;

  edtUsuario.SetFocus;
end;

procedure TcadUsuarioF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryCadUsuario.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryCadUsuario.SQL.Text:= ('select * from usuarios u' +
                              ' where u.id::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryCadUsuario.SQL.Text:= ('select * from usuarios;');
  end;

  //Reabre a Query
  qryCadUsuario.Open;
end;

procedure TcadUsuarioF.btnGravarClick(Sender: TObject);
begin
  inherited;
  //Gravar
  qryCadUsuario.Post;
end;

procedure TcadUsuarioF.btnEditarClick(Sender: TObject);
begin
  inherited;
  //Edit
  qryCadUsuario.Edit;
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
  inherited;

  //Checa se está durante o Insert
  if qryCadUsuario.State = dsInsert then
    DataModule1.decreaseSequence('usuarios_id_seq');

  //Cancelar
  qryCadUsuario.Cancel;
end;

end.

