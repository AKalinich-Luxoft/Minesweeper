unit unChack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, ExtCtrls, jpeg;

type
  TfmChack = class(TForm)
    img1: TImage;
    pnl1: TPanel;
    lbl1: TLabel;
    g1: TGauge;
    tmr1: TTimer;
    img2: TImage;
    tmr2: TTimer;
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
  private
    { Private declarations }
    Cur_row : integer;
  public
    { Public declarations }
  end;

var
  fmChack: TfmChack;


implementation

uses unMain;

{$R *.dfm}

procedure TfmChack.FormShow(Sender: TObject);
begin
  img2.Visible:=true;
  g1.Progress := 0;
  Cur_row := 0;
  tmr1.Enabled:=True;
  //fmChack.Position := poScreenCenter;
end;

procedure TfmChack.tmr1Timer(Sender: TObject);
var i,j : integer;  f : real;
begin
  //
  if Cur_row>Desk_Width-1 then begin
                               tmr1.Enabled:=false;
                               tmr2.Enabled:=true;
                               exit;
                               end;

  j:=Cur_row;
  for i:=0 to Desk_Height-1 do
      begin
      if (Desk_buttons[i, j].Tag=10) then begin
                            if (Desk_buttons[i, j].Glyph.Empty) then UGCount:=UGCount-1;
                            Desk_buttons[i, j].Glyph := fmMain.btnFlag.Glyph;
                            (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;
                            Continue;
                            end;

       (Desk_buttons[i,j].Parent as TPanel).Color:=StandartCol;
       Desk_buttons[i, j].Down := true;
       fmMain.WhatInCell(Desk_buttons[i, j], false);
      end;
  inc(Cur_row);
  f := ((Cur_row*1.0) / (Desk_Width*1.0))*100;
  g1.Progress := Round(f);
  if g1.Progress>50 then img2.Visible:=false;
end;

procedure TfmChack.tmr2Timer(Sender: TObject);
begin
    tmr2.Enabled:=false;
    fmChack.ModalResult:=mrOk;
end;

end.
