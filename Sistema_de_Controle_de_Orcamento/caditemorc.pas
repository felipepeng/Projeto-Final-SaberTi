unit cadItemOrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, pesqProduto, DB;

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
    lblItemId1: TLabel;
    lblQnt: TLabel;
    lblVlUnidade: TLabel;
    lblVlTotal: TLabel;
    btnPesqProduto: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesqProdutoClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
  //Cancel
  OrcamentoF.qryOrcItem.Cancel;
  Close;
end;

procedure TcadItemOrcF.btnInserirClick(Sender: TObject);
begin
  //Post
  if OrcamentoF.qryOrcItemqt_produto.AsFloat = 0 then
  begin
    ShowMessage('Quantidade deve ser Preenchida');
    edtQuantidade.SetFocus;
    Exit;
  end;

  OrcamentoF.qryOrcItem.Post;
  OrcamentoF.SomaItens();
  Close;
end;

procedure TcadItemOrcF.btnPesqProdutoClick(Sender: TObject);
begin
  pesqProdutoF.ShowModal;
end;

procedure TcadItemOrcF.edtQuantidadeExit(Sender: TObject);
begin
  OrcamentoF.qryOrcItemvl_total.AsFloat := OrcamentoF.qryOrcItemvl_unitario.AsFloat * OrcamentoF.qryOrcItemqt_produto.AsFloat;
end;

procedure TcadItemOrcF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  CloseAction:= caFree;
end;

end.

