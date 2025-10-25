unit relClientes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_Class,
  LR_DBSet, ZDataset;

type

  { TrelClientesF }

  TrelClientesF = class(TForm)
    btnRelClientes: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryClientes: TZQuery;
    procedure btnRelClientesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  relClientesF: TrelClientesF;

implementation

{$R *.lfm}

{ TrelClientesF }

procedure TrelClientesF.FormShow(Sender: TObject);
begin
  qryClientes.Open;
end;

procedure TrelClientesF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  qryClientes.Close;
end;

procedure TrelClientesF.btnRelClientesClick(Sender: TObject);
begin
  frReport1.LoadFromFile('.\Relatorios\relClientes.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

end.

