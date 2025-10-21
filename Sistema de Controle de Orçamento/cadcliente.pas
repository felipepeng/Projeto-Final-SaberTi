unit cadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB, DataModule;

type

  { TcadClienteF }

  TcadClienteF = class(TXCadPaiF)
    btnPesquisa: TSpeedButton;
    cbTipo: TDBComboBox;
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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryCadClienteAfterInsert(DataSet: TDataSet);
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
end;

procedure TcadClienteF.qryCadClienteAfterInsert(DataSet: TDataSet);
begin
  //Aplica Sequence
  qryCadCliente.FieldByName('clienteid').AsInteger := StrToInt(DataModule1.getSequence('cliente_clienteid'));
end;

procedure TcadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
  qryCadCliente.Close;
end;

procedure TcadClienteF.btnInserirClick(Sender: TObject);
begin
  inherited; //Vai para Cadastro
  //Insert
  qryCadCliente.Insert;
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

procedure TcadClienteF.btnGravarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta
  //Confirma o Insert
  qryCadCliente.Post;
end;

procedure TcadClienteF.btnEditarClick(Sender: TObject);
begin
  inherited; //Faz Nada
  //Edit
  qryCadCliente.Edit;
end;

procedure TcadClienteF.btnExcluirClick(Sender: TObject);
begin
  inherited; //Vai para Consulta
  //Exclui
  If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryCadCliente.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TcadClienteF.btnCancelarClick(Sender: TObject);
begin
  inherited; //Vai para Consulta

  //Checa se está durante o Insert
  if qryCadCliente.State = dsInsert then
    DataModule1.decreaseSequence('cliente_clienteid');

  qryCadCliente.Cancel;

end;

end.

