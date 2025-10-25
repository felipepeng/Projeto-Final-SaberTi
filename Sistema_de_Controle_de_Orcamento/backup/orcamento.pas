unit Orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBGrids, DBExtCtrls, EditBtn, ZDataset, ZAbstractRODataset,
  ZSqlUpdate, XCadPai, DB, pesqCliente, DataModule, cadItemOrc;

type

  { TOrcamentoF }

  TOrcamentoF = class(TXCadPaiF)
    btnAddItem: TBitBtn;
    btnExcluirItem: TBitBtn;
    btnPesqCliente: TSpeedButton;
    btnPesquisa: TSpeedButton;
    DateEditDataOrcamento: TDBDateEdit;
    DateEditDataValidade: TDBDateEdit;
    DBTextClienteNome: TDBText;
    dsOrcItem: TDataSource;
    DBGridOrcItem: TDBGrid;
    edtTotalOrcamento: TDBEdit;
    edtClienteId: TDBEdit;
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
    qryClienteclienteid: TZIntegerField;
    qryClientecpf_cnpj_cliente: TZRawStringField;
    qryClientenome_cliente: TStringField;
    qryClientetipo_cliente: TZRawStringField;
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
    qryProdutocategoriaprodutoid: TZIntegerField;
    qryProdutods_produto: TStringField;
    qryProdutodt_cadastro_produto: TZDateTimeField;
    qryProdutoobs_produto: TZRawStringField;
    qryProdutoprodutoid: TZIntegerField;
    qryProdutostatus_produto: TZRawStringField;
    qryProdutovl_venda_produto: TZBCDField;
    updtOrcamento: TZUpdateSQL;
    qryOrcItem: TZQuery;
    qryCliente: TZQuery;
    qryProduto: TZQuery;
    procedure btnAddItemClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesqClienteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure qryOrcamentoAfterInsert(DataSet: TDataSet);
    procedure qryOrcItemAfterInsert(DataSet: TDataSet);
  private

  public
    procedure AbreOrcItens(orcamentoid : Integer);
    procedure SomaItens();

  end;

var
  OrcamentoF: TOrcamentoF;

implementation

{$R *.lfm}

{ TOrcamentoF }

procedure TOrcamentoF.SomaItens();
var
  tam, i: Integer;
  count : Double;
begin
  //ShowMessage(IntToStr(OrcamentoF.qryOrcItem.RecordCount));
  //tam :=  OrcamentoF.qryOrcItem.RecordCount;
  count := 0;

  //for i := 0 to tam do
  //begin
  //  count := count +
  //end;

  if not qryOrcItem.IsEmpty then
  begin
    qryOrcItem.First;
    while not qryOrcItem.Eof do
    begin
      count := count + qryOrcItem.FieldByName('vl_total').AsFloat;
      qryOrcItem.Next;
    end;
  end;

  //ShowMessage('Total geral: ' + FloatToStr(count));
  qryOrcamentovl_total_orcamento.AsFloat := count;
end;

procedure TOrcamentoF.AbreOrcItens(orcamentoid : Integer);
begin
  if orcamentoid <> 0 then
  begin
      qryOrcItem.Close;
      qryOrcItem.SQL.Clear;
      qryOrcItem.SQL.Add(
                      'SELECT '+
                      'ORCAMENTOITEMID, '+
                      'ORCAMENTOID, '+
                      'PRODUTOID, '+
                      //'produtodesc, '+
                      'QT_PRODUTO, '+
                      'VL_UNITARIO, '+
                      'VL_TOTAL '+
                      'FROM ORCAMENTO_ITEM ' +
                      'WHERE ORCAMENTOID = '+ inttostr(orcamentoid) + ' ' +
                      'ORDER BY ORCAMENTOID');
       //ShowMessage(DataModule1.qryOrcamentoItem.SQL.Text);
       qryOrcItem.Open;
  end;
end;

procedure TOrcamentoF.FormShow(Sender: TObject);
begin
  inherited;
  //Abre Query
  qryOrcamento.Open;
  qryOrcItem.Open;
  qryProduto.Open;
end;

procedure TOrcamentoF.PageControl1Change(Sender: TObject);
begin
    AbreOrcItens(qryOrcamentoorcamentoid.AsInteger);
end;

procedure TOrcamentoF.qryOrcamentoAfterInsert(DataSet: TDataSet);
begin
  //Sequence
  qryOrcamento.FieldByName('orcamentoid').AsInteger := StrToInt(DataModule1.getSequence('orcamento_orcamentoid_seq'));
end;

procedure TOrcamentoF.qryOrcItemAfterInsert(DataSet: TDataSet);
begin
  qryOrcItem.FieldByName('orcamentoitemid').AsInteger := StrToInt(DataModule1.getSequence('orcamento_item_orcamentoitemid'));
end;

procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  //Fecha Query
  qryOrcamento.Close;
  qryOrcItem.Close;
  qryProduto.Close;
end;

procedure TOrcamentoF.FormCreate(Sender: TObject);
begin

end;

procedure TOrcamentoF.btnPesqClienteClick(Sender: TObject);
begin
  pesqClienteF.ShowModal;
end;

procedure TOrcamentoF.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  //Abre Orcamento Itens
  AbreOrcItens(qryOrcamentoorcamentoid.AsInteger);
end;

procedure TOrcamentoF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryOrcamento.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryOrcamento.SQL.Text:= ('select * from orcamento o' +
                              ' where o.orcamentoid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryOrcamento.SQL.Text:= ('select * from orcamento order by  orcamentoid;');
  end;

  //Reabre a Query
  qryOrcamento.Open;
end;

procedure TOrcamentoF.btnInserirClick(Sender: TObject);
begin
  //Insert
  qryOrcamento.Insert;
  //Abre Orcamento Itens
  AbreOrcItens(qryOrcamentoorcamentoid.AsInteger);
  inherited;
  //Datas
  qryOrcamento.FieldByName('dt_orcamento').AsDateTime := Date;
  qryOrcamento.FieldByName('dt_validade_orcamento').AsDateTime:= Date + 15;
end;

procedure TOrcamentoF.btnGravarClick(Sender: TObject);
begin
  //Gravar
  qryOrcamento.Post;
  qryOrcamento.Refresh;
  inherited;
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

procedure TOrcamentoF.btnExcluirItemClick(Sender: TObject);
begin
  if not (OrcamentoF.qryOrcItem.IsEmpty) then
  begin
    OrcamentoF.qryOrcItem.Delete;
  end;

  SomaItens();
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

procedure TOrcamentoF.btnAddItemClick(Sender: TObject);
begin
  //Cadastro Item
  qryOrcItem.Insert;
  qryOrcItemorcamentoid.AsInteger := qryOrcamentoorcamentoid.AsInteger;
  cadItemOrcF.ShowModal;
end;

end.

