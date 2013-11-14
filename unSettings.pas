unit unSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TfmSettings = class(TForm)
    grp1: TGroupBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    lbl1: TLabel;
    edt1: TEdit;
    ud1: TUpDown;
    lbl2: TLabel;
    edt2: TEdit;
    ud2: TUpDown;
    lbl3: TLabel;
    edt3: TEdit;
    ud3: TUpDown;
    btn1: TBitBtn;
    btn2: TBitBtn;
    grp2: TGroupBox;
    rb5: TRadioButton;
    rb6: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure rb4Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSettings: TfmSettings;

implementation

uses unMain;

{$R *.dfm}

procedure TfmSettings.FormShow(Sender: TObject);
var mc:Integer;
begin
  rb4.Checked:=true;
  if GameType=0 then mc:=MinesCount else mc:=PrimaryMinesCount;
  if (Desk_Width=9) and (Desk_Height=9) and (mc=10) then rb1.Checked:=true;
  if (Desk_Width=16) and (Desk_Height=16) and (mc=40) then rb2.Checked:=true;
  if (Desk_Width=30) and (Desk_Height=16) and (mc=99) then rb3.Checked:=true;
  rb4Click(Sender);
end;

procedure TfmSettings.rb4Click(Sender: TObject);
begin
  edt1.Enabled:= rb4.Checked; ud1.Enabled:= rb4.Checked;
  edt2.Enabled:= rb4.Checked; ud2.Enabled:= rb4.Checked;
  edt3.Enabled:= rb4.Checked; ud3.Enabled:= rb4.Checked;
end;

procedure TfmSettings.btn1Click(Sender: TObject);
begin
  if rb1.Checked then
    begin
      Desk_Width:=9;
      Desk_Height:=9;
      MinesCount:=10;
      Level:=1;
    end;

  if rb2.Checked then
    begin
      Desk_Width:=16;
      Desk_Height:=16;
      MinesCount:=40;
      Level:=2;
    end;

  if rb3.Checked then
    begin
      Desk_Width:=30;
      Desk_Height:=16;
      MinesCount:=99;
      Level:=3;
    end;

  if rb4.Checked then
    begin
      Desk_Width:=ud2.Position;
      Desk_Height:=ud1.Position;
      MinesCount:=ud3.Position;
      Level:=4;
    end;

  if rb5.Checked then
    begin
      GameType:=0;
    end;

  if rb6.Checked then
    begin
      GameType:=1;
      Stage:=1;
      Scores:=0;
    end;

  ModalResult:=mrOk;
end;

procedure TfmSettings.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) or (Key=27) then ModalResult:=mrCancel;
end;

end.
