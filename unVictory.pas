unit unVictory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, rxAnimate, rxGIFCtrl, Buttons;

type
  TfmVicrory = class(TForm)
    lbl1: TLabel;
    img1: TImage;
    lbl2: TLabel;
    RxGIFAnimator1: TRxGIFAnimator;
    shp1: TShape;
    pnl1: TPanel;
    grp1: TGroupBox;
    pnl2: TPanel;
    mmo1: TMemo;
    btn1: TBitBtn;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmVicrory: TfmVicrory;

implementation

uses unAnimate, unChack;

{$R *.dfm}

procedure TfmVicrory.FormShow(Sender: TObject);
var x:integer;
begin
   Randomize();
   x:=Random(3);
   RxGIFAnimator1.Image := ANM.RxGIFAnimator14.Image;

   if x=0 then
              begin
              img1.Picture:=img2.Picture;
              lbl2.Caption:='×ÀÊİ ÎÄÎÁĞßİ!1';
              end;
   if x=1 then
              begin
              img1.Picture:=img3.Picture;
              lbl2.Caption:='ÎÍÎÒÎËÅ ÒÅØÈÒÜÑß!!!11';
              end;
   if x=2 then
              begin
              img1.Picture:=img4.Picture;
              lbl2.Caption:='ËÅÎÍÈÄİ ËÈÊÓİ!!1';
              end;
   if fmChack.g1.Progress>50 then
              begin
              img1.Picture:=img5.Picture;
              lbl2.Caption:='×ÀÊİ ĞÀÇÓÏËÎÒÍßİ!!1';
              end;

end;

end.
