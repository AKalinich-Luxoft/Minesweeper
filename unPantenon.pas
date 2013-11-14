unit unPantenon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, rxAnimate, rxGIFCtrl, StdCtrls;

type
  TfmPantenon = class(TForm)
    lbl1: TLabel;
    pnl1: TPanel;
    lbl14: TLabel;
    pnl2: TPanel;
    scrlbx1: TScrollBox;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl10: TLabel;
    img1: TImage;
    img2: TImage;
    pnl6: TPanel;
    pnl7: TPanel;
    img3: TImage;
    pnl8: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    pnl9: TPanel;
    pnl10: TPanel;
    img4: TImage;
    pnl11: TPanel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    pnl12: TPanel;
    pnl13: TPanel;
    img5: TImage;
    pnl14: TPanel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    pnl15: TPanel;
    pnl16: TPanel;
    img6: TImage;
    pnl17: TPanel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img2Click(Sender: TObject);
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

const
  Spell1_leonide_pep : Integer = 10; Spell1_leonide_cost : Integer = 1200;
  Spell2_onotole_pep : Integer = 30; Spell2_onotole_cost : Integer = 1500;
  Spell3_bless_pep : Integer = 70; Spell3_bless_cost : Integer = 1700;
  Spell4_ray_pep : Integer = 90; Spell4_ray_cost : Integer = 2000;
  Spell5_chack_pep : Integer = 150; Spell5_chack_cost : Integer = 3000;

var
  fmPantenon: TfmPantenon;
  Spell_pep, Spell_cost : array[1..5] of Integer;


implementation

uses unMain;

{$R *.dfm}

procedure TfmPantenon.FormShow(Sender: TObject);
begin
  lbl3.Caption := 'НЕОБХОДИМО ПЕПЯКИ: '+IntToStr(Spell1_leonide_pep)+';  СТОИМОСТЬ: '+IntToStr(Spell1_leonide_cost);
  lbl5.Caption := 'НЕОБХОДИМО ПЕПЯКИ: '+IntToStr(Spell2_onotole_pep)+';  СТОИМОСТЬ: '+IntToStr(Spell2_onotole_cost);
  lbl8.Caption := 'НЕОБХОДИМО ПЕПЯКИ: '+IntToStr(Spell3_bless_pep)+';  СТОИМОСТЬ: '+IntToStr(Spell3_bless_cost);
  lbl12.Caption := 'НЕОБХОДИМО ПЕПЯКИ: '+IntToStr(Spell4_ray_pep)+';  СТОИМОСТЬ: '+IntToStr(Spell4_ray_cost);
  lbl16.Caption := 'НЕОБХОДИМО ПЕПЯКИ: '+IntToStr(Spell5_chack_pep)+';  СТОИМОСТЬ: '+IntToStr(Spell5_chack_cost);

  if (Pepyaka >= Spell1_leonide_pep)  and (Scores >= Spell1_leonide_cost) then lbl3.Color:=clGreen else lbl3.Color:=clRed;
  if (Pepyaka >= Spell2_onotole_pep)  and (Scores >= Spell2_onotole_cost) then lbl5.Color:=clGreen else lbl5.Color:=clRed;
  if (Pepyaka >= Spell3_bless_pep)    and (Scores >= Spell3_bless_cost) then lbl8.Color:=clGreen else lbl8.Color:=clRed;
  if (Pepyaka >= Spell4_ray_pep)      and (Scores >= Spell4_ray_cost) then lbl12.Color:=clGreen else lbl12.Color:=clRed;
  if (Pepyaka >= Spell5_chack_pep)    and (Scores >= Spell5_chack_cost) then lbl16.Color:=clGreen else lbl16.Color:=clRed;

end;

procedure TfmPantenon.FormCreate(Sender: TObject);
begin
  Spell_pep[1] := Spell1_leonide_pep;   Spell_cost[1] := Spell1_leonide_cost;
  Spell_pep[2] := Spell2_onotole_pep;   Spell_cost[2] := Spell2_onotole_cost;
  Spell_pep[3] := Spell3_bless_pep;     Spell_cost[3] := Spell3_bless_cost;
  Spell_pep[4] := Spell4_ray_pep;       Spell_cost[4] := Spell4_ray_cost;
  Spell_pep[5] := Spell5_chack_pep;     Spell_cost[5] := Spell5_chack_cost;

  fmMain.imgSp1.Hint := fmPantenon.lbl10.Caption;
  fmMain.imgSp2.Hint := fmPantenon.lbl6.Caption;
  fmMain.imgSp3.Hint := fmPantenon.lbl9.Caption;
  fmMain.imgSp4.Hint := fmPantenon.lbl13.Caption;
  fmMain.imgSp5.Hint := fmPantenon.lbl17.Caption;

end;

procedure TfmPantenon.img2Click(Sender: TObject);
var tg : integer;
begin
    tg := (Sender as TImage).Tag;
    if (Spell_pep[tg] > Pepyaka) then
      begin
        Application.MessageBox('У вас недостаточно пепяки для такого мощнэ оружия!', 'УПЧК', mb_ok+MB_ICONINFORMATION);
        exit;
      end;

    if (Spell_cost[tg] > Scores) then
      begin
        Application.MessageBox('У вас недостаточно чочочков для этого оружия!', 'УПЧК', mb_ok+MB_ICONINFORMATION);
        exit;
      end;

    if Application.MessageBox('Приобрести это страшнэ для УГ оружие?', 'УПЧК', MB_YESNO+MB_ICONQUESTION)=id_no then Exit;

    Scores := Scores - Spell_cost[tg];
    if (tg=1) then Inc(Arsenal.Skill1_Leonide);
    if (tg=2) then Inc(Arsenal.Skill2_Onotole);
    if (tg=3) then Inc(Arsenal.Skill3_Bless);
    if (tg=4) then Inc(Arsenal.Skill4_Ray);
    if (tg=5) then Inc(Arsenal.Skill5_Chack);

    ModalResult := mrOk;
end;

procedure TfmPantenon.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
   scrlbx1.VertScrollBar.Position := scrlbx1.VertScrollBar.Position + 30;
end;

procedure TfmPantenon.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   scrlbx1.VertScrollBar.Position := scrlbx1.VertScrollBar.Position - 30;
end;

procedure TfmPantenon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key=13) or (Key=27) then Close;
end;

end.
