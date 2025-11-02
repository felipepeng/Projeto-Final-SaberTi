unit XCadPai;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Buttons, DBGrids, LCLType;

type

  { TXCadPaiF }

  TXCadPaiF = class(TForm)
    btnGravar: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnInserir: TBitBtn;
    btnFechar: TBitBtn;
    DBGrid1: TDBGrid;
    PageControl1: TPageControl;
    PanelCadastroCenter: TPanel;
    PanelCadastroBottom: TPanel;
    PanelConsultaCenter: TPanel;
    PanelConsultaBottom: TPanel;
    PanelConsultaTop: TPanel;
    tbConsulta: TTabSheet;
    tbCadastro: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  XCadPaiF: TXCadPaiF;

implementation

{$R *.lfm}

{ TXCadPaiF }



procedure TXCadPaiF.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage := tbConsulta;
end;

procedure TXCadPaiF.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TXCadPaiF.btnEditarClick(Sender: TObject);
begin

end;

procedure TXCadPaiF.btnCancelarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbConsulta;
end;

procedure TXCadPaiF.btnExcluirClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbConsulta;
end;

procedure TXCadPaiF.btnGravarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbConsulta;
end;

procedure TXCadPaiF.btnInserirClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
end;

procedure TXCadPaiF.DBGrid1DblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
end;

procedure TXCadPaiF.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
  begin
    PageControl1.ActivePage := tbCadastro;
  end;

  if Key = VK_ESCAPE then
  begin
    edtPesquisa.SetFocus;
  end;
end;

procedure TXCadPaiF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

