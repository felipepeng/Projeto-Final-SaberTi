unit Orcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, ZDataset, ZAbstractRODataset, ZSqlUpdate, XCadPai, DB;

type

  { TOrcamentoF }

  TOrcamentoF = class(TXCadPaiF)
    btnPesquisa: TSpeedButton;
    dsOrcamento: TDataSource;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    PanelCadastroTop: TPanel;
    qryOrcamento: TZQuery;
    qryOrcamentoclienteid: TZIntegerField;
    qryOrcamentodt_orcamento: TZDateTimeField;
    qryOrcamentodt_validade_orcamento: TZDateTimeField;
    qryOrcamentoorcamentoid: TZIntegerField;
    qryOrcamentovl_total_orcamento: TZBCDField;
    updtOrcamento: TZUpdateSQL;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
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
end;

procedure TOrcamentoF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  //Fecha Query
  qryOrcamento.Close;
end;

end.

