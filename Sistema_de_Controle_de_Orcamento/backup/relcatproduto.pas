unit relCatProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, LR_DBSet,
  LR_Class, ZDataset, LCLType;

type

  { TrelCatProdutoF }

  TrelCatProdutoF = class(TForm)
    btnRelClientes: TBitBtn;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qryCatProduto: TZQuery;
    procedure btnRelClientesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  relCatProdutoF: TrelCatProdutoF;

implementation

{$R *.lfm}

{ TrelCatProdutoF }


procedure TrelCatProdutoF.btnRelClientesClick(Sender: TObject);
begin
  frReport1.LoadFromFile('.\Relatorios\relCatProduto.lrf');
  frReport1.PrepareReport;
  frReport1.ShowReport;
end;

procedure TrelCatProdutoF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

end.

