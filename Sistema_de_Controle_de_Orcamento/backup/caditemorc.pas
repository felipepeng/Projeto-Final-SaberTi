unit cadItemOrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, pesqProduto;

type

  { TcadItemOrcF }

  TcadItemOrcF = class(TForm)
    btnInserir: TBitBtn;
    btnCancelar: TBitBtn;
    edtVlTotal: TDBEdit;
    edtVlUnidade: TDBEdit;
    edtQuantidade: TDBEdit;
    edtProdutoDesc: TDBEdit;
    edtProdutoId: TDBEdit;
    edtItemId: TDBEdit;
    lblItemId: TLabel;
    lblItemId1: TLabel;
    lblQnt: TLabel;
    lblVlUnidade: TLabel;
    lblVlTotal: TLabel;
    btnPesqProduto: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesqProdutoClick(Sender: TObject);
    procedure edtQuantidadeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  cadItemOrcF: TcadItemOrcF;

implementation

{$R *.lfm}

uses
  Orcamento;

{ TcadItemOrcF }

procedure TcadItemOrcF.btnCancelarClick(Sender: TObject);
begin
  OrcamentoF.qryOrcItem.Cancel;
  OrcamentoF.qryProduto.Cancel;
  Close;
end;

procedure TcadItemOrcF.btnPesqProdutoClick(Sender: TObject);
begin
  //OrcamentoF.qryProduto.Insert;
  pesqProdutoF.ShowModal;
end;

procedure TcadItemOrcF.edtQuantidadeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  OrcamentoF.qryOrcItemvl_total.AsFloat := OrcamentoF.qryOrcItemvl_unitario.AsFloat * OrcamentoF.qryOrcItemqt_produto.AsFloat;
end;

procedure TcadItemOrcF.FormShow(Sender: TObject);
begin
  OrcamentoF.qryOrcItem.Insert;
end;


end.

