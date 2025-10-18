unit XCadPai;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Buttons;

type

  { TXCadPaiF }

  TXCadPaiF = class(TForm)
    btnInserir: TBitBtn;
    btnFechar: TBitBtn;
    edtPesquisa: TEdit;
    lblPesquisar: TLabel;
    PageControl1: TPageControl;
    PanelCadastroBottom: TPanel;
    PanelConsultaCenter: TPanel;
    PanelConsultaBottom: TPanel;
    PanelConsultaTop: TPanel;
    btnPesquisa: TSpeedButton;
    tbConsulta: TTabSheet;
    tbCadastro: TTabSheet;
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

end.

