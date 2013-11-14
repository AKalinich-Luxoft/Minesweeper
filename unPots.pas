unit unPots;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, rxAnimate, rxGIFCtrl, jpeg;

type
  TfmPots = class(TForm)
    lbl1: TLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    ScrollBox1: TScrollBox;
    pnl3: TPanel;
    pnl4: TPanel;
    RxGIFAnimator4: TRxGIFAnimator;
    pnl5: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    pnl6: TPanel;
    pnl7: TPanel;
    rxgfnmtr1: TRxGIFAnimator;
    pnl8: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    pnl9: TPanel;
    pnl10: TPanel;
    rxgfnmtr2: TRxGIFAnimator;
    pnl11: TPanel;
    lbl6: TLabel;
    lbl7: TLabel;
    pnl12: TPanel;
    pnl13: TPanel;
    rxgfnmtr3: TRxGIFAnimator;
    pnl14: TPanel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    pnl15: TPanel;
    pnl16: TPanel;
    rxgfnmtr4: TRxGIFAnimator;
    pnl17: TPanel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    pnl18: TPanel;
    pnl19: TPanel;
    rxgfnmtr5: TRxGIFAnimator;
    pnl20: TPanel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    pnl21: TPanel;
    pnl22: TPanel;
    rxgfnmtr6: TRxGIFAnimator;
    pnl23: TPanel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    pnl24: TPanel;
    pnl25: TPanel;
    rxgfnmtr7: TRxGIFAnimator;
    pnl26: TPanel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    pnl27: TPanel;
    pnl28: TPanel;
    rxgfnmtr8: TRxGIFAnimator;
    pnl29: TPanel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    pnl30: TPanel;
    pnl31: TPanel;
    rxgfnmtr9: TRxGIFAnimator;
    pnl32: TPanel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    pnl33: TPanel;
    pnl34: TPanel;
    rxgfnmtr10: TRxGIFAnimator;
    pnl35: TPanel;
    lbl33: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    pnl36: TPanel;
    pnl37: TPanel;
    rxgfnmtr11: TRxGIFAnimator;
    pnl38: TPanel;
    lbl36: TLabel;
    lbl37: TLabel;
    lbl38: TLabel;
    img1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxGIFAnimator4Click(Sender: TObject);
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
  Warrior1_lvl1_cost : integer = 1000;  Warrior1_lvl1_pep : integer = 10;
  Warrior2_lvl1_cost : integer = 1200;  Warrior2_lvl1_pep : integer = 12;
  Warrior3_lvl1_cost : integer = 1400;  Warrior3_lvl1_pep : integer = 15;
  Warrior4_lvl1_cost : integer = 1500;  Warrior4_lvl1_pep : integer = 18;

  Warrior1_lvl2_cost : integer = 2000;  Warrior1_lvl2_pep : integer = 25;
  Warrior2_lvl2_cost : integer = 2200;  Warrior2_lvl2_pep : integer = 27;
  Warrior3_lvl2_cost : integer = 2400;  Warrior3_lvl2_pep : integer = 30;
  Warrior4_lvl2_cost : integer = 2600;  Warrior4_lvl2_pep : integer = 35;

  Warrior1_lvl3_cost : integer = 3000;  Warrior1_lvl3_pep : integer = 40;
  Warrior2_lvl3_cost : integer = 3300;  Warrior2_lvl3_pep : integer = 43;
  Warrior3_lvl3_cost : integer = 3500;  Warrior3_lvl3_pep : integer = 45;
  Warrior4_lvl3_cost : integer = 4000;  Warrior4_lvl3_pep : integer = 50;

var
  fmPots: TfmPots;
  cost : integer;
  TargetPots : TRxGIFAnimator;
  Warrior_cost :  array[1..12] of Integer;
  Warrior_pep  :  array[1..12] of Integer;

implementation

uses unMain;

{$R *.dfm}

procedure TfmPots.FormShow(Sender: TObject);
var tg :integer;
begin
    if fmMain.RxGIFAnimator1.Hint = 'X' then TargetPots := fmMain.RxGIFAnimator1;
    if fmMain.RxGIFAnimator2.Hint = 'X' then TargetPots := fmMain.RxGIFAnimator2;
    if fmMain.RxGIFAnimator3.Hint = 'X' then TargetPots := fmMain.RxGIFAnimator3;

    tg := TargetPots.Tag;

    if (tg = 0) then cost:=0 else cost := Warrior_cost[tg];

    lbl3.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[1]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[1]);
    lbl5.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[2]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[2]);
    lbl7.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[3]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[3]);
    lbl9.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[4]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[4]);

    lbl16.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[5]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[5]);
    lbl25.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[6]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[6]);
    lbl19.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[7]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[7]);
    lbl22.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[8]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[8]);

    lbl28.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[9]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[9]);
    lbl31.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[10]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[10]);
    lbl34.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[11]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[11]);
    lbl37.Caption:='ÑÒÎÈÌÎÑÒÜ: '+IntTOstr(Warrior_cost[12]-cost)+';  ÓĞÎÂÅÍÜ ÏÅÏßÊÈ: +'+inttostr(Warrior_pep[12]);

    if Scores >= (Warrior_cost[1]-cost) then lbl3.Color := clGreen else lbl3.Color := clRed;
    if Scores >= (Warrior_cost[2]-cost) then lbl5.Color := clGreen else lbl5.Color := clRed;
    if Scores >= (Warrior_cost[3]-cost) then lbl7.Color := clGreen else lbl7.Color := clRed;
    if Scores >= (Warrior_cost[4]-cost) then lbl9.Color := clGreen else lbl9.Color := clRed;

    if Scores >= (Warrior_cost[5]-cost) then lbl16.Color := clGreen else lbl16.Color := clRed;
    if Scores >= (Warrior_cost[6]-cost) then lbl25.Color := clGreen else lbl25.Color := clRed;
    if Scores >= (Warrior_cost[7]-cost) then lbl19.Color := clGreen else lbl19.Color := clRed;
    if Scores >= (Warrior_cost[8]-cost) then lbl22.Color := clGreen else lbl22.Color := clRed;

    if Scores >= (Warrior_cost[9]-cost) then lbl28.Color := clGreen else lbl28.Color := clRed;
    if Scores >= (Warrior_cost[10]-cost) then lbl31.Color := clGreen else lbl31.Color := clRed;
    if Scores >= (Warrior_cost[11]-cost) then lbl34.Color := clGreen else lbl34.Color := clRed;
    if Scores >= (Warrior_cost[12]-cost) then lbl37.Color := clGreen else lbl37.Color := clRed;

    pnl3.Visible := tg <= 4;
    pnl6.Visible := tg <= 4;
    pnl9.Visible := tg <= 4;
    pnl12.Visible := tg <= 4;

    pnl15.Visible := (tg >= 1) and (tg <= 8);
    pnl24.Visible := (tg >= 1) and (tg <= 8);
    pnl18.Visible := (tg >= 1) and (tg <= 8);
    pnl21.Visible := (tg >= 1) and (tg <= 8);

    pnl27.Visible := (tg >= 5) and (tg <= 12);
    pnl30.Visible := (tg >= 5) and (tg <= 12);
    pnl33.Visible := (tg >= 5) and (tg <= 12);
    pnl36.Visible := (tg >= 5) and (tg <= 12);

    pnl12.Align := alBottom;
    pnl15.Align := alBottom;
    pnl18.Align := alBottom;
    pnl21.Align := alBottom;
    pnl24.Align := alBottom;
    pnl27.Align := alBottom;
    pnl3.Align := alBottom;
    pnl30.Align := alBottom;
    pnl33.Align := alBottom;
    pnl36.Align := alBottom;
    pnl6.Align := alBottom;
    pnl9.Align := alBottom;

    pnl3.Align := alTop;
    pnl6.Align := alTop;
    pnl9.Align := alTop;
    pnl12.Align := alTop;
    pnl15.Align := alTop;
    pnl24.Align := alTop;
    pnl18.Align := alTop;
    pnl21.Align := alTop;
    pnl27.Align := alTop;
    pnl30.Align := alTop;
    pnl33.Align := alTop;
    pnl36.Align := alTop;

end;

procedure TfmPots.FormCreate(Sender: TObject);
begin
  Warrior_cost[1]:=Warrior1_lvl1_cost;  Warrior_pep[1] := Warrior1_lvl1_pep;
  Warrior_cost[2]:=Warrior2_lvl1_cost;  Warrior_pep[2] := Warrior2_lvl1_pep;
  Warrior_cost[3]:=Warrior3_lvl1_cost;  Warrior_pep[3] := Warrior3_lvl1_pep;
  Warrior_cost[4]:=Warrior4_lvl1_cost;  Warrior_pep[4] := Warrior4_lvl1_pep;

  Warrior_cost[5]:=Warrior1_lvl2_cost;  Warrior_pep[5] := Warrior1_lvl2_pep;
  Warrior_cost[6]:=Warrior2_lvl2_cost;  Warrior_pep[6] := Warrior2_lvl2_pep;
  Warrior_cost[7]:=Warrior3_lvl2_cost;  Warrior_pep[7] := Warrior3_lvl2_pep;
  Warrior_cost[8]:=Warrior4_lvl2_cost;  Warrior_pep[8] := Warrior4_lvl2_pep;

  Warrior_cost[9]:= Warrior1_lvl3_cost;  Warrior_pep[9] := Warrior1_lvl3_pep;
  Warrior_cost[10]:=Warrior2_lvl3_cost;  Warrior_pep[10] := Warrior2_lvl3_pep;
  Warrior_cost[11]:=Warrior3_lvl3_cost;  Warrior_pep[11] := Warrior3_lvl3_pep;
  Warrior_cost[12]:=Warrior4_lvl3_cost;  Warrior_pep[12] := Warrior4_lvl3_pep;

end;

procedure TfmPots.RxGIFAnimator4Click(Sender: TObject);
var tg : integer;
begin
  tg := (Sender as TRxGIFAnimator).Tag;
  if  Warrior_cost[tg] - cost = 0 then
      begin
      Application.MessageBox('İòîò âîåíı óæå íàíÿò!', 'ÓÏ×Ê', mb_ok+MB_ICONINFORMATION);
      exit;
      end;

  if  Warrior_cost[tg] - cost > Scores then
      begin
      Application.MessageBox('Ó âàñ íå õâàòàåò ÷î÷î÷êîâ! İòîò âîåíı íå áóäåò âàì ïîìîãàòü.', 'ÓÏ×Ê', mb_ok+MB_ICONINFORMATION);
      exit;
      end;

  if (Application.MessageBox('Âû ğèàëüíı õîòèòå íàíÿòü ıòîãî ñëàâíå âîåíı?', 'ÓÏ×Ê', MB_YESNO+MB_ICONQUESTION)=id_no) then Exit;

  Scores := Scores - ( Warrior_cost[tg] - cost );
  TargetPots.Image :=  (Sender as TRxGIFAnimator).Image;
  TargetPots.Tag := (Sender as TRxGIFAnimator).Tag;
  ModalResult := mrOk;

end;

procedure TfmPots.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + 30;
end;

procedure TfmPots.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position - 30;
end;

procedure TfmPots.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key=13) or (Key=27) then Close;
end;

end.
