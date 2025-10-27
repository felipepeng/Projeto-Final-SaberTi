unit relOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, ZDataset;

type

  { TrelOrcamentoF }

  TrelOrcamentoF = class(TForm)
    btnRelOrcamento: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryOrcamento: TZQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relOrcamentoF: TrelOrcamentoF;

implementation

{$R *.lfm}

{ TrelOrcamentoF }

procedure TrelOrcamentoF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  qryOrcamento.Close;
  CloseAction := caFree;
end;

procedure TrelOrcamentoF.FormShow(Sender: TObject);
begin
  qryOrcamento.Open;
end;

end.

