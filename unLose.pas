unit unLose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, rxAnimate, rxGIFCtrl, Buttons, jpeg;

type
  TfmLose = class(TForm)
    lbl1: TLabel;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    lbl2: TLabel;
    pnl2: TPanel;
    btn1: TBitBtn;
    rxgfnmtr1: TRxGIFAnimator;
    shp1: TShape;
    grp1: TGroupBox;
    mmo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLose: TfmLose;

implementation

uses unMain;

{$R *.dfm}

procedure TfmLose.FormShow(Sender: TObject);
var x:integer;
begin
   Randomize();
   x:=Random(3);

   if x=0 then img1.Picture:=img2.Picture;
   if x=1 then img1.Picture:=img3.Picture;
   if x=2 then img1.Picture:=img4.Picture;

   if (GameType=1) and (Stage<6) then img1.Picture:=img2.Picture;

end;

end.
