unit pesqCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, DBGrids, ZDataset, ZAbstractRODataset;

type

  { TpesqClienteF }

  TpesqClienteF = class(TForm)
    btnPesquisa: TSpeedButton;
    dsPesqCliente: TDataSource;
    DBGrid1: TDBGrid;
    edtPesquisa: TEdit;
    lblPesquisa: TLabel;
    Panel1: TPanel;
    qryPesqCliente: TZQuery;
    qryPesqClienteclienteid: TZIntegerField;
    qryPesqClientecpf_cnpj_cliente: TZRawStringField;
    qryPesqClientenome_cliente: TZRawStringField;
    qryPesqClientetipo_cliente: TZRawStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  pesqClienteF: TpesqClienteF;

implementation

{$R *.lfm}

uses
  Orcamento;

{ TpesqClienteF }

procedure TpesqClienteF.FormShow(Sender: TObject);
begin
  qryPesqCliente.Open;
end;

procedure TpesqClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  qryPesqCliente.Close;
end;

procedure TpesqClienteF.edtPesquisaChange(Sender: TObject);
begin
  //Fecha a Query
  qryPesqCliente.Close;

  //Edita o comando SQL
  if edtPesquisa.Text <> '' then
  begin
    qryPesqCliente.SQL.Text:= ('select * from cliente c' +
                              ' where c.clienteid::text LIKE ''' + edtPesquisa.Text + '%'';');
  end else
  begin
    qryPesqCliente.SQL.Text:= ('select * from cliente order by  clienteid;');
  end;

  //Reabre a Query
  qryPesqCliente.Open;
end;

procedure TpesqClienteF.DBGrid1DblClick(Sender: TObject);
begin
  //Pega o Id Cliente
  OrcamentoF.qryOrcamentoclienteid.AsInteger := qryPesqClienteclienteid.AsInteger;

  Close;
end;

end.

