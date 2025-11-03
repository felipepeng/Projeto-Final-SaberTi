unit relOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, ZDataset, LCLType;

type

  { TrelOrcamentoF }

  TrelOrcamentoF = class(TForm)
    btnRelOrcamento: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryOrcamento: TZQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TrelOrcamentoF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

procedure TrelOrcamentoF.FormShow(Sender: TObject);
begin
  qryOrcamento.Open;
end;

end.

