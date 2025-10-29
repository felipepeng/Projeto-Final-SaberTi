unit cadItemOrc;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, pesqProduto, DB, DataModule;

type

  { TcadItemOrcF }

  TcadItemOrcF = class(TForm)
    btnInserir: TBitBtn;
    btnCancelar: TBitBtn;
    btnPesqProd: TBitBtn;
    edtVlTotal: TDBEdit;
    edtVlUnidade: TDBEdit;
    edtQuantidade: TDBEdit;
    edtProdutoDesc: TDBEdit;
    edtProdutoId: TDBEdit;
    lblItemId1: TLabel;
    lblQnt: TLabel;
    lblVlUnidade: TLabel;
    lblVlTotal: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
  //Cancel
  OrcamentoF.qryOrcItem.Cancel;

  //Decrementa a Sequence
  DataModule1.decreaseSequence('orcamento_item_orcamentoitemid');

  Close;
end;

procedure TcadItemOrcF.btnInserirClick(Sender: TObject);
begin

  if OrcamentoF.qryOrcItemprodutoid.AsString = '' then
  begin
    ShowMessage('Um produto deve ser escolhido.');
    btnPesqProdClick(Sender);
    Abort;
  end;

  if OrcamentoF.qryOrcItemqt_produto.AsFloat = 0 then
  begin
    ShowMessage('Quantidade deve ser Preenchida.');
    edtQuantidade.SetFocus;
    Abort;
  end;

  //Post
  OrcamentoF.qryOrcItem.Post;
  OrcamentoF.SomaItens();
  Close;
end;

procedure TcadItemOrcF.btnPesqProdClick(Sender: TObject);
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

procedure TcadItemOrcF.FormShow(Sender: TObject);
begin
  btnPesqProd.SetFocus;
end;

end.

