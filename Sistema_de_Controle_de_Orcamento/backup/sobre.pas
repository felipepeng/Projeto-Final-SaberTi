unit Sobre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLType;

type

  { TSobreF }

  TSobreF = class(TForm)
    GroupBoxEmpresa: TGroupBox;
    GroupBoxSistema: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    lblDataDesenvolv: TLabel;
    lblDataDesenvolv1: TLabel;
    lblDesenvolvidoPor: TLabel;
    lblDev: TLabel;
    lblLinguagem: TLabel;
    lblBD: TLabel;
    lblSistema: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  SobreF: TSobreF;

implementation

{$R *.lfm}

{ TSobreF }



procedure TSobreF.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

end.

