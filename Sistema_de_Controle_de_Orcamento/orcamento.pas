unit Orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBGrids, DBExtCtrls, EditBtn, ZDataset, ZAbstractRODataset,
  ZSqlUpdate, XCadPai, DB, pesqCliente, DataModule;

type

  { TOrcamentoF }

  TOrcamentoF = class(TXCadPaiF)
    btnAddItem: TBitBtn;
    btnExcluirItem: TBitBtn;
    btnPesqCliente: TSpeedButton;
    btnPesquisa: TSpeedButton;
    dsOrcItem: TDataSource;
    DBGridOrcItem: TDBGrid;
    edtTotalOrcamento: TDBEdit;
    edtDataValidade: TDBEdit;
    edtCliente: TDBEdit;
    edtDataOrcamento: TDBEdit;
    edtId: TDBEdit;
    dsOrcamento: TDataSource;
    edtPesquisa: TEdit;
    lblDataOrcamento: TLabel;
    lblDataValidade: TLabel;
    lblTotalOrcamento: TLabel;
    lblId: TLabel;
    lblCliente: TLabel;
    lblPesquisa: TLabel;
    PanelCadastroTop: TPanel;
    qryOrcamento: TZQuery;
    qryOrcamentoclienteid: TZIntegerField;
    qryOrcamentodt_orcamento: TZDateTimeField;
    qryOrcamentodt_validade_orcamento: TZDateTimeField;
    qryOrcamentoorcamentoid: TZIntegerField;
    qryOrcamentovl_total_orcamento: TZBCDField;
    qryOrcItemorcamentoid: TZIntegerField;
    qryOrcItemorcamentoitemid: TZIntegerField;
    qryOrcItemprodutoid: TZIntegerField;
    qryOrcItemqt_produto: TZBCDField;
    qryOrcItemvl_total: TZBCDField;
    qryOrcItemvl_unitario: TZBCDField;
    updtOrcamento: TZUpdateSQL;
    qryOrcItem: TZQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesqClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
  private

  public

  end;

var
  OrcamentoF: TOrcamentoF;

implementation

{$R *.lfm}

{ TOrcamentoF }

procedure TOrcamentoF.FormShow(Sender: TObject);
begin
  inherited;
  //Abre Query
  qryOrcamento.Open;
  qryOrcItem.Open;
end;

procedure TOrcamentoF.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  //Sequence
  qryOrcamento.FieldByName('orcamentoid').AsInteger := StrToInt(DataModule1.getSequence('orcamento_orcamentoid_seq'));
end;

procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  //Fecha Query
  qryOrcamento.Close;
  qryOrcItem.Close;
end;

procedure TOrcamentoF.btnPesqClienteClick(Sender: TObject);
begin
  pesqClienteF.ShowModal;
end;

procedure TOrcamentoF.btnInserirClick(Sender: TObject);
begin
  inherited;
  //Insert
  qryOrcamento.Insert;
end;

procedure TOrcamentoF.btnGravarClick(Sender: TObject);
begin
  //Gravar
  inherited;
  qryOrcamento.Post;
end;

procedure TOrcamentoF.btnEditarClick(Sender: TObject);
begin
  inherited;
  //Edit
  qryOrcamento.Edit;
end;

procedure TOrcamentoF.btnExcluirClick(Sender: TObject);
begin
  //Exclui
  If  MessageDlg('Atenção', 'Você tem certeza que deseja excluir o registro?', mtConfirmation,[mbyes,mbno],0) = mryes then
  begin
    qryOrcamento.Delete;
    inherited; //Vai para Consulta
  end;
end;

procedure TOrcamentoF.btnCancelarClick(Sender: TObject);
begin
  inherited;

  //Decrementa a Sequence
  if qryOrcamento.State = dsInsert then
    DataModule1.decreaseSequence('orcamento_orcamentoid_seq');

  //Cancel
  qryOrcamento.Cancel;
end;

end.

