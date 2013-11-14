unit unHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, rxAnimate, rxGIFCtrl, jpeg;

type
  TfmHelp = class(TForm)
    lbl1: TLabel;
    pnl1: TPanel;
    lbl2: TLabel;
    pnl2: TPanel;
    lbl3: TLabel;
    pnl3: TPanel;
    lbl4: TLabel;
    pnl4: TPanel;
    lbl5: TLabel;
    pnl5: TPanel;
    img3: TImage;
    pnl6: TPanel;
    img4: TImage;
    pnl7: TPanel;
    lbl6: TLabel;
    pnl8: TPanel;
    pnl9: TPanel;
    lbl7: TLabel;
    pnl10: TPanel;
    rxgfnmtr2: TRxGIFAnimator;
    pnl11: TPanel;
    pnl12: TPanel;
    lbl8: TLabel;
    pnl13: TPanel;
    img1: TImage;
    pnl14: TPanel;
    lbl9: TLabel;
    pnl15: TPanel;
    pnlSp2: TPanel;
    imgSp2: TImage;
    lblSp2: TLabel;
    lblR2: TLabel;
    pnl16: TPanel;
    lbl10: TLabel;
    pnl17: TPanel;
    pnl18: TPanel;
    img2: TImage;
    lbl11: TLabel;
    lbl12: TLabel;
    pnl19: TPanel;
    lbl13: TLabel;
    pnl20: TPanel;
    lbl14: TLabel;
    pnl21: TPanel;
    rxgfnmtr1: TRxGIFAnimator;
    pnl22: TPanel;
    rxgfnmtr3: TRxGIFAnimator;
    shp1: TShape;
    shp2: TShape;
    pnl23: TPanel;
    lbl15: TLabel;
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHelp: TfmHelp;

implementation

{$R *.dfm}

procedure TfmHelp.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    VertScrollBar.Position:=VertScrollBar.Position+30;
end;

procedure TfmHelp.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    VertScrollBar.Position:=VertScrollBar.Position-30;
end;

procedure TfmHelp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key=13) or (Key=27) then Close;
end;

end.
