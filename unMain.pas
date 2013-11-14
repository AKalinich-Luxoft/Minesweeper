unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, Buttons, ImgList, ComCtrls,
  rxAnimate, rxGIFCtrl, IniFiles, jpeg;

type
  TArsenal = record
    Skill1_Leonide : Integer;
    Skill2_Onotole : Integer;
    Skill3_Bless : Integer;
    Skill4_Ray : Integer;
    Skill5_Chack : Integer;
  end;

type
  TfmMain = class(TForm)
    pnl1: TPanel;
    lbl1: TLabel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    mm1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    btnFlag: TSpeedButton;
    btnMine: TSpeedButton;
    btnErr: TSpeedButton;
    tmr1: TTimer;
    img1: TImage;
    lbl2: TLabel;
    lblUG: TLabel;
    img2: TImage;
    lbl3: TLabel;
    lblTime: TLabel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    img3: TImage;
    lbl5: TLabel;
    lblScore: TLabel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    RxGIFAnimator1: TRxGIFAnimator;
    RxGIFAnimator2: TRxGIFAnimator;
    RxGIFAnimator3: TRxGIFAnimator;
    pnl13: TPanel;
    img4: TImage;
    lbl4: TLabel;
    lblPepyaka: TLabel;
    pnl14: TPanel;
    tmr2: TTimer;
    Spells_Pan: TPanel;
    pnlSp1: TPanel;
    imgSp1: TImage;
    lblSp1: TLabel;
    pnlSp2: TPanel;
    imgSp2: TImage;
    lblSp2: TLabel;
    pnlSp3: TPanel;
    imgSp3: TImage;
    lblSp3: TLabel;
    pnlSp4: TPanel;
    imgSp4: TImage;
    lblSp4: TLabel;
    pnlSp5: TPanel;
    imgSp5: TImage;
    lblSp5: TLabel;
    btnPantenon: TSpeedButton;
    lblR1: TLabel;
    lblR2: TLabel;
    lblR3: TLabel;
    lblR4: TLabel;
    tmr3: TTimer;
    tmr4: TTimer;
    N10: TMenuItem;
    procedure N9Click(Sender: TObject);
    procedure CreateDesk(Wdth:Integer; Hgth:Integer);
    procedure GenerateDesk(Wdth:Integer; Hgth:Integer; MC : Integer);
    procedure ChainClear(Wdth:Integer; Hgth:Integer);
    procedure CellClear(X:integer; Y:integer);
    procedure WhatInCell(Btn : TSpeedButton; IsChain : Boolean);
    procedure PlaceFlag(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure DeskBtnClick(Sender : TObject);
    procedure DeskBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure IsVictory();
    procedure VictoryMsg();
    procedure LoseMsg();
    procedure N5Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function RecalMines(MineCountt :Integer; Stage : Integer):integer;
    procedure RxGIFAnimator1Click(Sender: TObject);
    procedure PepyakaRecount();
    procedure tmr2Timer(Sender: TObject);
    procedure btnPantenonClick(Sender: TObject);
    procedure RecalcSpells();
    procedure imgSp1Click(Sender: TObject);

    procedure Spell1_Leonide();
    procedure Spell1_Leonide_action(x,y: integer);
    procedure Spell1_Leonide_cancel();

    procedure Spell2_Onotole();

    procedure Spell3_Bless();

    procedure Spell4_Ray();
    procedure Spell4_Ray_action(x, y : integer);
    procedure Spell4_Ray_cancel();

    procedure Spell5_Chack();

    procedure OpenResultsFile();
    procedure RecalcStatsFile(IsImproved : boolean);

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmr3Timer(Sender: TObject);
    procedure tmr4Timer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

const
  OneCellBonus : integer = 5;
  ChainCellBonus : integer = 7;
  MineCellBonus : Integer = 7;
  OneSavedCellBonus : Integer = 50;
  TimeBonus : integer = 2;
  NullZoneBonus : Integer = 10;
  StandartCol : TColor = $00FFDDD7;
  FlagedCol : TColor = clLime;
  MarkedCol : TColor = clAqua;

var
  Desk_Width, Desk_Height, MinesCount, PrimaryMinesCount : Integer;
  fmMain: TfmMain;
  Desk_mines : array of array of integer;
  Desk_buttons : array of array of TSpeedButton;
  Desk_pans : array of array of TPanel;
  FirstClick, Loose : Boolean;
  Level, Stage, GameType : Integer;
  UGCount, Scores, time, Pepyaka: Integer;
  Arsenal : TArsenal;
  Leonide_Mode : Boolean;
  Ray_Mode : Boolean;
  Bless_blocks : Integer;
  Ray_col, VictoryPlace : Integer;
  InIF : TIniFile;

implementation

uses unSettings, unAnimate, unVictory, unLose, unPots, unPantenon, Math,
  unChack, unHall, unAbout, unHelp;

{$R *.dfm}

function ifCellExist(iHeigth : integer; iWidth : integer):Boolean;
begin
  //
  Result:=false;
  if (iHeigth < 0) or (iWidth<0) then exit;
  if (iWidth > Desk_Width-1) then Exit;
  if (iHeigth > Desk_Height-1) then exit;

  Result := true;
end;

procedure TfmMain.OpenResultsFile();
var F : Textfile; s:string;
begin
  //
  s := ExtractFilePath(ParamStr(0))+'Stats.ini';
  try
   AssignFile(F, s);
   ReSet(F);
  except
    Rewrite(F);
  end;
  CloseFile(F);

  InIF := TIniFile.Create(s);

end;

procedure TfmMain.RecalcStatsFile(IsImproved : boolean);
var sec, s, s1 : string; cnt, i, j, typ:integer;
    tmp : string;
    Results : array of string;
    Place : integer;

    function DecodeString(str : string):string;
    var x1, x2:integer; str1 : string;
    begin
      //
      Result:='';
      while Trim(str)<>'' do
      begin
        str1 := TRIM(Copy(str, 1, 3));
        str  := Trim(Copy(str, 4, MaxInt));

        try
          x1 := StrToInt(str1);
        except
          x1 := 698;
        end;

        x2 := x1 xor 666;
        Result := Result + Chr(x2);
      end;

    end;

    function EncodeString(str:string):string; overload;
    var x1, x2:integer;
    begin
      Result:='';
      for x1:=1 to Length(str) do
        begin
        x2 :=  Ord(str[x1]);
        x2 :=  x2 xor 666;
        Result:=Result + IntToStr(x2);
        end;
    end;

    function EncodeString(DT : TDate; VoenName : string; tm : Integer):string; overload;
    var str:string;
    begin
      Result:='';
      str := Trim(Copy(VoenName,1,35))+'|'+IntToStr(tm)+'|'+DateToStr(DT);
      Result := EncodeString(str);
    end;

    function EncodeString(DT : TDate; VoenName : string; lvl : Integer; scrs : Integer):string; overload;
    var str:string;
    begin
      Result:='';
      str := Trim(Copy(VoenName,1,35))+'|'+IntToStr(lvl)+'|'+IntToStr(scrs)+'|'+DateToStr(DT);
      Result := EncodeString(str);
    end;

    function DecodeTime(str : string):integer;
    var tm, ind : Integer;
    begin
    //
    try
      Result := 0;
      ind := AnsiPos('|', str);
      str := TRIM(Copy(str, ind+1, MaxInt));

      ind := AnsiPos('|', str);
      str := TRIM(Copy(str, 1, ind-1));
      tm := StrToInt(str);
    except
      tm := 99999;
    end;

    if tm = 0 then tm := 99999;
    Result := tm;
    end;

    function DecodeLvl(str : string):Integer;
    var tm, ind : Integer;
    begin
      //
      try
        Result := 0;
        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, ind+1, MaxInt));

        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, 1, ind-1));
        tm := StrToInt(str);
      except
        tm := 0;
      end;

      Result := tm;
    end;

    function DecodeScore(str : string):Integer;
    var tm, ind : Integer;
    begin
      //
      try
        Result := 0;
        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, ind+1, MaxInt));

        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, ind+1, MaxInt));

        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, 1, ind-1));
        tm := StrToInt(str);
      except
        tm := 0;
      end;

      Result := tm;
    end;

begin
  //
  typ := 0;
  if fmSettings.rb1.Checked then typ := 1;
  if fmSettings.rb2.Checked then typ := 2;
  if fmSettings.rb3.Checked then typ := 3;

  if typ = 0 then exit;
  cnt := 5;
  Place := cnt+1;
  SetLength(Results, cnt+1);       //0..5

  if IsImproved then sec := 'IMPROVED' else sec := 'CLASSIC';
  OpenResultsFile;
  //InIF.ReadSection(sec, SL);

  for i:=1 to cnt do
  begin
        s:=InIF.ReadString( sec, 'Result_'+inttostr(i)+inttostr(typ), '');
        s:=DecodeString(s);
        if (s='') then
            Results[i-1]:='' else
            Results[i-1]:=s;
  end;

  if IsImproved=false then s := EncodeString(Now, 'Неизвестнэ военэ', StrToInt(lblTime.Caption) )
  else s := EncodeString(Now, 'Неизвестнэ военэ', Stage, Scores );

  if IsImproved then Results[cnt]:=DecodeString(s);
  if not IsImproved then Results[cnt]:=DecodeString(s);

    for i:=1 to cnt+1 do
      for j:=1 to cnt do
        begin
        if (IsImproved=false) then
          if (DecodeTime(Results[j-1]) > DecodeTime(Results[j])) then
                begin
                tmp:=Results[j-1];
                Results[j-1]:=Results[j];
                Results[j]:=tmp;
                end;

        if (IsImproved) then
          if ( DecodeLvl(Results[j-1]) < DecodeLvl(Results[j])) then
                begin
                tmp:=Results[j-1];
                Results[j-1]:=Results[j];
                Results[j]:=tmp;
                end;

        if (IsImproved) then
          if (DecodeScore(Results[j-1]) < DecodeScore(Results[j])) and (DecodeLvl(Results[j-1]) = DecodeLvl(Results[j])) then
                begin
                tmp:=Results[j-1];
                Results[j-1]:=Results[j];
                Results[j]:=tmp;
                end;

        end;

    for i:=1 to cnt do
    begin
        if IsImproved then
        begin
              InIF.Writestring(sec, 'Result_'+IntToStr(i)+IntToStr(typ), EncodeString( Results[i-1] ) );
              if (DecodeLvl(Results[i-1]) = Stage) and (DecodeScore(Results[i-1]) = Scores) then Place := i;
        end else
        begin
              InIF.Writestring(sec, 'Result_'+IntToStr(i)+IntToStr(typ), EncodeString( Results[i-1] ) );
              if (DecodeTime(Results[i-1]) = StrToInt(lblTime.Caption)) then Place := i;
        end;
    end;

    if Place<=5 then
    begin
      s := InputBox('УПЧК', 'Вы заняли '+inttostr(Place)+' место!'+#13+#10+'Слава новому военэ! Введите свое имя:', '');
      if (Trim(s)='') then s := 'Неизвестнэ военэ';
      if IsImproved=false then s := EncodeString(Now, s, StrToInt(lblTime.Caption) );
      if IsImproved then s:= EncodeString(Now, s, Stage, Scores );

      InIF.WriteString(sec, 'Result_'+IntToStr(Place)+IntToStr(typ), s );
      InIF.Free;

      if Place=1 then fmHall.L1.Font.Color := clRed;
      if Place=2 then fmHall.L2.Font.Color := clRed;
      if Place=3 then fmHall.L3.Font.Color := clRed;
      if Place=4 then fmHall.L4.Font.Color := clRed;
      if Place=5 then fmHall.L5.Font.Color := clRed;
      fmHall.lbl2.Font.Color := clRed;

      fmHall.rg1.ItemIndex := typ-1;
      if IsImproved then fmHall.rb2.Checked := True else fmHall.rb1.Checked := true;

      fmHall.lbl2.Hint := IntToStr(typ-1);
      if IsImproved then fmHall.lbl2.tag := 1 else fmHall.lbl2.Tag := 0;
      VictoryPlace := Place;

      fmHall.ShowModal;

    end else  InIF.Free;

end;

procedure TfmMain.Spell1_Leonide();
var rank : Integer; Spell_area : Integer;
begin
  //
  rank:=1;
  if lblR1.Caption = 'I' then rank := 1;
  if lblR1.Caption = 'II' then rank := 2;
  if lblR1.Caption = 'III' then rank := 3;

  Spell_area := 2;
  if rank=1 then Spell_area := 2;
  if rank=2 then Spell_area := 3;
  if rank=3 then Spell_area := 4;

  pnlSp1.Color := clYellow;
  Application.MessageBox('Укажите Леонидэ областе, которую он должен разуплотнить и щелкните по ней левой кнопкой мышке.'+#13+#10+
                          'Если хотите отменить отаке - нажмите Esc.', 'УПЧК', mb_ok+MB_ICONINFORMATION);

  Leonide_Mode := true;
end;

procedure TfmMain.Spell1_Leonide_action(x,y: integer);
var i,j : integer;
begin
  //
   for i:=0 to Desk_Height-1 do
          for j:=0 to Desk_Width-1 do
            if (Desk_buttons[i,j].Parent as TPanel).Color = MarkedCol then
                begin
                if (Desk_buttons[i, j].Tag=10) then begin
                            if (Desk_buttons[i, j].Glyph.Empty) then UGCount:=UGCount-1;
                            Desk_buttons[i, j].Glyph := btnFlag.Glyph;
                            (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;
                            Continue;
                            end;

                (Desk_buttons[i,j].Parent as TPanel).Color:=StandartCol;
                Desk_buttons[i, j].Down := true;
                WhatInCell(Desk_buttons[i, j], false);
                end;

 ChainClear(Desk_Width, Desk_Height);
 lblUG.Caption := IntToStr(UGCount);
 Leonide_Mode := false;
 Arsenal.Skill1_Leonide := Arsenal.Skill1_Leonide - 1;
 pnlSp1.Color := clMoneyGreen;
 RecalcSpells;
 IsVictory;

end;

procedure TfmMain.Spell1_Leonide_cancel();
var i, j: Integer;
begin
  //
  Leonide_Mode := false;
  pnlSp1.Color := clMoneyGreen;
       for i:=0 to Desk_Height-1 do
          for j:=0 to Desk_Width-1 do
            if (Desk_buttons[i,j].Parent as TPanel).Color = MarkedCol then
                if Desk_buttons[i,j].Glyph.Empty then (Desk_buttons[i,j].Parent as TPanel).Color := StandartCol
                else (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;
end;

procedure TfmMain.Spell2_Onotole();
var i, j, x, cnt, rank, total : Integer;
begin
  //
  pnlSp2.Color := clYellow;
  if Application.MessageBox('Использовать ясновидящий взор Онотоле прямо сейчас?', 'УПЧК', MB_YESNO+MB_ICONQUESTION)=id_no then
      begin
        pnlSp2.Color :=  clMoneyGreen;
        exit;
      end;

  rank:=1;
  if lblR2.Caption = 'I' then rank := 1;
  if lblR2.Caption = 'II' then rank := 2;
  if lblR2.Caption = 'III' then rank := 3;

  {
    1 rank = 10%
    2 rank = 15%
    3 rank = 20%
  }
  if (rank=1) then cnt := Round((MinesCount * 0.10));
  if (rank=2) then cnt := Round((MinesCount * 0.15));
  if (rank=3) then cnt := Round((MinesCount * 0.20));
  if cnt=0 then cnt:=1;

  x:=0;
  total:=0;

  for i:=0 to Desk_Height-1 do
    for j:=0 to Desk_Width-1 do
      if (Desk_buttons[i,j].Glyph.Empty) and (Desk_buttons[i,j].Tag=10) then Inc(total);

  Randomize;
  while (x<>cnt) and (total>0) do
  begin
    i := random(Desk_Height);
    j := Random(Desk_Width);

    if (Desk_buttons[i, j].Tag = 10) and (Desk_buttons[i, j].Glyph.Empty) then
        begin
        Desk_buttons[i, j].Glyph := btnFlag.Glyph;
        total:=total-1;
        UGCount := UGCount - 1;
        inc(x);
        (Desk_buttons[i,j].Parent as TPanel).Color := clYellow;
        end;
  end;

  while UGCount<0 do
  begin
    i := random(Desk_Height);
    j := Random(Desk_Width);

    if (Desk_buttons[i, j].Tag <> 10) and (Desk_buttons[i, j].Glyph.Empty=false) then
        begin
        Desk_buttons[i, j].Glyph := nil;
        UGCount := UGCount + 1;
        (Desk_buttons[i,j].Parent as TPanel).Color := clred;
        end;
  end;

  Application.MessageBox(PChar('Онотоле обнаружил и попячил '+inttostr(x)+' УГ.'), 'УПЧК', MB_OK+MB_ICONINFORMATION );

  for i:=0 to Desk_Height-1 do
          for j:=0 to Desk_Width-1 do
          begin
            if (Desk_buttons[i,j].Parent as TPanel).Color = clYellow then
                 (Desk_buttons[i,j].Parent as TPanel).Color:=FlagedCol;
            if (Desk_buttons[i,j].Parent as TPanel).Color = clRed then
                 begin
                 (Desk_buttons[i,j].Parent as TPanel).Color:=StandartCol;
                 Desk_buttons[i,j].Down := true;
                 WhatInCell(Desk_buttons[i,j], false);
                 end;
          end;

  ChainClear(Desk_Width, Desk_Height);
  lblUG.Caption := IntToStr(UGCount);
  Arsenal.Skill2_Onotole := Arsenal.Skill2_Onotole - 1;
  pnlSp2.Color := clMoneyGreen;
  RecalcSpells;
  IsVictory;

end;

procedure TfmMain.Spell3_Bless();
var i, j : integer;
begin
  //
  Bless_blocks:=Bless_blocks-1;
  if (Bless_blocks=0) then
          begin
          Arsenal.Skill3_Bless:=Arsenal.Skill3_Bless - 1;
          Bless_blocks:=-1;
          end;

  for i:=0 to Desk_Height-1 do
    for j:=0 to Desk_Width-1 do
            if (Desk_buttons[i,j].Parent as TPanel).Color = clRed then
                  begin
                  (Desk_buttons[i,j].Parent as TPanel).Color:=FlagedCol;
                  Desk_buttons[i,j].Glyph := btnFlag.Glyph;
                  UGCount := UGCount - 1;
                  end;

  ChainClear(Desk_Width, Desk_Height);
  pnlSp3.Color := clMoneyGreen;
  RecalcSpells;
  lblUG.Caption := IntToStr(UGCount);
  RecalcSpells;
  Loose := false;
  IsVictory;

end;

procedure TfmMain.Spell4_Ray();
var rank : Integer; Spell_area : Integer;
begin
  //
  rank:=1;
  if lblR4.Caption = 'I' then rank := 1;
  if lblR4.Caption = 'II' then rank := 2;
  if lblR4.Caption = 'III' then rank := 3;

  Spell_area := 1;
  if rank=1 then Spell_area := 1;
  if rank=2 then Spell_area := 2;
  if rank=3 then Spell_area := 3;

  pnlSp4.Color := clYellow;
  Application.MessageBox('Укажите ряд клеточке, подлежащих разуплотнению и щелкните по левой кнопкой мышке.'+#13+#10+
                          'Если хотите отменить разуплотнение - нажмите Esc.', 'УПЧК', mb_ok+MB_ICONINFORMATION);

  Ray_Mode := true;

end;

procedure TfmMain.Spell4_Ray_action(x, y : integer);
begin
  //
  Ray_col := 0;
  Loose := true;
  tmr4.Enabled:=true;
  while tmr4.Enabled do
     begin
      Application.ProcessMessages;
     end;
  Loose:=False;

  ChainClear(Desk_Width, Desk_Height);
  pnlSp4.Color := clMoneyGreen;
  Arsenal.Skill4_Ray := Arsenal.Skill4_Ray - 1;
  RecalcSpells;
  lblUG.Caption := IntToStr(UGCount);
  Ray_Mode:=false;
  fmMain.Repaint;
  IsVictory;

end;

procedure TfmMain.Spell4_Ray_cancel();
var i, j : integer;
begin
  //
  Ray_Mode := false;
  pnlSp4.Color := clMoneyGreen;
       for i:=0 to Desk_Height-1 do
          for j:=0 to Desk_Width-1 do
            if (Desk_buttons[i,j].Parent as TPanel).Color = MarkedCol then
                if Desk_buttons[i,j].Glyph.Empty then (Desk_buttons[i,j].Parent as TPanel).Color := StandartCol
                else (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;
end;

function TfmMain.RecalMines(MineCountt :Integer; Stage : Integer):integer;
var cnt, lim : Integer; f, step : Real;
begin
     if Stage=1 then
                begin
                PrimaryMinesCount:=MineCountt;
                f := Round(MineCountt * 0.5);  //
                if (f=0) then f:=1;
                Result := Round(f);
                exit;
                end;

     f := PrimaryMinesCount * 0.5;  //
     step := round(PrimaryMinesCount / 9.0);
     lim := (Desk_Width * Desk_Height) div 2;

     if (step=0) then step:=1;

     cnt := round(((Stage-1) * step ) + f);
     if lim<cnt then Result:=lim else Result := cnt;

end;

procedure TfmMain.Spell5_Chack;
begin
  //
  pnlSp5.Color := clYellow;
  if Application.MessageBox('Вы действительно хотите призвать на помощь самого Чакэ и оставить все веселье ему?'+#13+#10+
                          'Желательно укрыться подальше, поскольку разнесется к чертям все поле.','УПЧК', MB_YESNO+MB_ICONQUESTION) = ID_NO then begin pnlSp5.Color := clMoneyGreen; Exit; end;


  fmChack.ShowModal;
  lblUG.Caption := IntToStr(UGCount);
  fmMain.Repaint;
  Sleep(1000);
  pnlSp5.Color := clMoneyGreen;
  Arsenal.Skill5_Chack := Arsenal.Skill5_Chack - 1;
  RecalcSpells;

  IsVictory;

end;

procedure TfmMain.RecalcSpells();
var cnt, centr, rank : integer;
begin
  //
  cnt :=0;
  if Arsenal.Skill1_Leonide>0 then begin Inc(cnt); lblSp1.Caption := 'x'+ IntToStr(Arsenal.Skill1_Leonide); end;
  if Arsenal.Skill2_Onotole>0 then begin Inc(cnt); lblSp2.Caption := 'x'+IntToStr(Arsenal.Skill2_Onotole); end;
  if Arsenal.Skill3_Bless>0 then begin   Inc(cnt); lblSp3.Caption := 'x'+IntToStr(Arsenal.Skill3_Bless);   end;
  if Arsenal.Skill4_Ray>0 then begin     Inc(cnt); lblSp4.Caption := 'x'+IntToStr(Arsenal.Skill4_Ray);     end;
  if Arsenal.Skill5_Chack>0 then begin   Inc(cnt); lblSp5.Caption := 'x'+IntToStr(Arsenal.Skill5_Chack);   end;

  pnlSp1.Visible := Arsenal.Skill1_Leonide > 0;
  pnlSp2.Visible := Arsenal.Skill2_Onotole > 0;
  pnlSp3.Visible := Arsenal.Skill3_Bless > 0 ;
  pnlSp4.Visible := Arsenal.Skill4_Ray > 0;
  pnlSp5.Visible := Arsenal.Skill5_Chack > 0;

  cnt := (pnlSp1.Width + 6) * cnt;
  centr := (Spells_Pan.Width div 2) - (cnt div 2);

  cnt := 0;
  if pnlSp1.Visible then begin pnlSp1.Left := centr + ((pnlSp1.Width + 6) * cnt ); Inc(cnt); end;
  if pnlSp2.Visible then begin pnlSp2.Left := centr + ((pnlSp1.Width + 6) * cnt ); Inc(cnt); end;
  if pnlSp3.Visible then begin pnlSp3.Left := centr + ((pnlSp1.Width + 6) * cnt ); Inc(cnt); end;
  if pnlSp4.Visible then begin pnlSp4.Left := centr + ((pnlSp1.Width + 6) * cnt ); Inc(cnt); end;
  if pnlSp5.Visible then begin pnlSp5.Left := centr + ((pnlSp1.Width + 6) * cnt ); Inc(cnt); end;

  if pnlSp1.Visible then
    begin
    if (Pepyaka<=40) then lblR1.Caption := 'I';
    if (Pepyaka >= 41) and (Pepyaka<=70) then lblR1.Caption := 'II';
    if (Pepyaka >= 71) and (Pepyaka<=150) then lblR1.Caption := 'III';
    end;

  if pnlSp2.Visible then
    begin
    if (Pepyaka<=70) then lblR2.Caption := 'I';
    if (Pepyaka >= 71) and (Pepyaka<=110) then lblR2.Caption := 'II';
    if (Pepyaka >= 111) and (Pepyaka<=150) then lblR2.Caption := 'III';
    end;

  if pnlSp3.Visible then
    begin
    if (Pepyaka<=90) then lblR3.Caption := 'I';
    if (Pepyaka >= 91) and (Pepyaka<=110) then lblR3.Caption := 'II';
    if (Pepyaka >= 111) and (Pepyaka<=150) then lblR3.Caption := 'III';

    if lblR3.Caption='I' then rank := 1;
    if lblR3.Caption='II' then rank := 2;
    if lblR3.Caption='III' then rank := 3;

    if Bless_blocks=-1 then Bless_blocks := rank;
    lblSp3.Caption:=lblSp3.Caption+'('+IntToStr(Bless_blocks)+')';
    end;

  if pnlSp4.Visible then
    begin
    if (Pepyaka<=100) then lblR4.Caption := 'I';
    if (Pepyaka >= 101) and (Pepyaka<=130) then lblR4.Caption := 'II';
    if (Pepyaka >= 131) and (Pepyaka<=150) then lblR4.Caption := 'III';
    end;

end;

procedure TfmMain.PepyakaRecount();
var x:integer;
begin
  //
  Pepyaka := 0;
  x:=RxGIFAnimator1.Tag;
  if (x>0) then Pepyaka := Pepyaka + Warrior_pep[x];
  x:=RxGIFAnimator2.Tag;
  if (x>0) then Pepyaka := Pepyaka + Warrior_pep[x];
  x:=RxGIFAnimator3.Tag;
  if (x>0) then Pepyaka := Pepyaka + Warrior_pep[x];
  lblPepyaka.Caption:=inttostr(Pepyaka);
end;

//сообщение о проиграше
procedure TfmMain.LoseMsg();
begin
   //
   tmr1.Enabled:=false;

  if (GameType=1) then
    begin
    {
    Набрано чочочков: 5000
    Недопячено УГ: 23 x 7 = ...
    Времячке затраченэ: 120 * 2 = -240
    Итого чочочков: 5260
    }
    Spell1_Leonide_cancel;

    fmLose.mmo1.Clear;
    fmLose.mmo1.Lines.Add('Набрано чочочков: '+inttostr(Scores));
    fmLose.mmo1.Lines.Add('Недопячено УГ: '+lblUG.Caption+' x '+inttostr(MineCellBonus)+' = '+IntToStr( -StrToInt(lblUG.Caption)*MineCellBonus) );
    Scores := Scores - StrToInt(lblUG.Caption)*MineCellBonus;

    fmLose.mmo1.Lines.Add('Времячке затраченэ: '+inttostr(time)+'c. x '+inttostr(TimeBonus)+' = '+inttostr(-TimeBonus*time) );
    time:=-TimeBonus*time;
    Scores:=Scores + time;
    fmLose.mmo1.Lines.Add('Итого чочочков: '+inttostr(Scores));
    fmLose.Position:=poScreenCenter;
    fmLose.ShowModal;

    lblScore.Caption:=inttostr(Scores);
    Loose:=True;
    RecalcStatsFile(true);
    end;

   if (GameType=0) then
    begin
    {
    Недопячено УГ: 10 x 7 = -70
    Времячке затраченэ: 120 * 2 = -240
    Набрано чочочков: 1015
    }
    fmLose.mmo1.Clear;
    fmLose.mmo1.Lines.Add('Недопячено УГ: '+lblUG.Caption+' x '+inttostr(MineCellBonus)+' = '+IntToStr( -StrToInt(lblUG.Caption)*MineCellBonus) );
    Scores := Scores - StrToInt(lblUG.Caption)*MineCellBonus;
    fmLose.mmo1.Lines.Add('Времячке затраченэ: '+inttostr(time)+'c. x '+inttostr(TimeBonus)+' = '+inttostr(-TimeBonus*time) );
    time:=-TimeBonus*time;
    Scores:=Scores + time;
    fmLose.mmo1.Lines.Add('Набрано чочочков: '+inttostr(Scores));
    fmLose.Position:=poScreenCenter;
    fmLose.ShowModal;

    lblScore.Caption:=inttostr(Scores);
    Loose:=true;
    end;

end;

procedure TfmMain.VictoryMsg();
var i, j, cnt:integer;
begin
  //
  UGCount:=0;
  lblUG.Caption:='0';
  lblScore.Caption:=IntToStr(Scores);
  lblTime.Caption:=IntTostr(time);
  tmr1.Enabled:=false;

  if (GameType=1) then
    begin
    cnt:=0;
    for i:=0 to Desk_Height-1 do
        for j:=0 to Desk_Width-1 do
           if (Desk_buttons[i,j].Down=False) and (Desk_buttons[i,j].Glyph.Empty) then cnt:=cnt+1;

    {
    Набрано чочочков: 5000
    Нетронутэ ячейке: 10 х 50 = 500
    Времячке затраченэ: 120 * 2 = -240
    Итого чочочков: 5260
    }
    fmVicrory.mmo1.Clear;
    fmVicrory.mmo1.Lines.Add('Набрано чочочков: '+inttostr(Scores));
    fmVicrory.mmo1.Lines.Add('Нетронутэ ячейке: '+inttostr(cnt)+' x '+inttostr(OneSavedCellBonus)+' = '+Inttostr(cnt*OneSavedCellBonus) );
    cnt:=cnt * OneSavedCellBonus;
    fmVicrory.mmo1.Lines.Add('Времячке затраченэ: '+inttostr(time)+'c. x '+inttostr(TimeBonus)+' = '+inttostr(-TimeBonus*time) );
    time:=-TimeBonus*time;
    Scores:=Scores + cnt + time;
    fmVicrory.mmo1.Lines.Add('Итого чочочков: '+inttostr(Scores));
    fmVicrory.Position:=poScreenCenter;
    fmVicrory.ShowModal;
    tmr2.Enabled:=true;

    lblScore.Caption:=inttostr(Scores);
    Stage:=Stage+1;
    MinesCount := RecalMines(MinesCount, Stage);
    Loose:=True;
    //N2Click(btnFlag);
    end;

   if (GameType=0) then
    begin
    {
    Попячено УГ: 10
    Времячке затраченэ: 120
    Набрано чочочков: 1015
    }
    fmVicrory.mmo1.Clear;
    fmVicrory.mmo1.Lines.Add('Попячено УГ: '+inttostr(MinesCount));
    fmVicrory.mmo1.Lines.Add('Времячке затраченэ: '+inttostr(time)+'c. x '+inttostr(TimeBonus)+' = '+inttostr(-TimeBonus*time) );
    time:=-TimeBonus*time;
    Scores:=Scores + time;
    fmVicrory.mmo1.Lines.Add('Набрано чочочков: '+inttostr(Scores));
    fmVicrory.Position:=poScreenCenter;
    fmVicrory.ShowModal;

    lblScore.Caption:=inttostr(Scores);
    Loose:=true;
    end;

end;

//Проверка на победу
procedure TfmMain.IsVictory();
var i, j, cnt, cnt1 :integer;
begin
  if Loose then exit;
  //подсчитываем оставшиеся клетки
  cnt:=0;
  for i:=0 to Desk_Height-1 do
    for j:=0 to Desk_Width-1 do
      if Desk_buttons[i, j].Down=False then cnt:=cnt+1;

  if (cnt=MinesCount) then
      begin
      for i:=0 to Desk_Height-1 do
         for j:=0 to Desk_Width-1 do
            if Desk_buttons[i, j].Tag=10 then
               begin
               Desk_buttons[i, j].Glyph:=btnFlag.Glyph;
               (Desk_buttons[i, j].Parent as TPanel).Color := FlagedCol;
               end;

      //ShowMessage('Victory!');
      VictoryMsg;
      if GameType=0 then RecalcStatsFile(false);

      //Loose:=True;
      //tmr1.Enabled:=false;
      end else
      if (Loose=false) and (GameType=1) then
      begin
      cnt:=0; cnt1:=0;
      for i:=0 to Desk_Height-1 do
        for j:=0 to Desk_Width-1 do
          begin
          if not Desk_buttons[i, j].Glyph.Empty then cnt:=cnt+1;
          if (not Desk_buttons[i, j].Glyph.Empty) and (Desk_buttons[i, j].Tag=10) then cnt1:=cnt1+1;
          end;

      if (cnt=cnt1) and (cnt=MinesCount) then
        begin
        //ShowMessage('Victory');
        VictoryMsg;
        //Loose:=True;
        //tmr1.Enabled:=false;
        end;

      end;

end;

//проверка содержимого
procedure TfmMain.WhatInCell(Btn : TSpeedButton; IsChain : Boolean);
var i,j:integer;
begin
if (Loose) and (not Ray_Mode) then exit;
//fmMain.Refresh;
if Btn.Glyph.Empty=False then
    begin
    Btn.Down:=False;
    Exit;
    end;

if Btn.Down=false then
    begin
    Btn.Down:=True;
    exit;
    end;

  if FirstClick then
  repeat
      GenerateDesk(Desk_Width,Desk_Height,MinesCount);
      FirstClick:=false;
  until Btn.Tag=0;

  //проверяем что в ячйеке
  case Btn.Tag of
  10 :
      begin
      //Btn.Caption := 'M';
      Btn.Down:=false;
      Btn.Glyph:=btnMine.Glyph;
      Loose:=True;
      if Arsenal.Skill3_Bless=0 then
       begin
          for i:=0 to Desk_Height-1 do
             for j:=0 to Desk_Width-1 do
                begin
                if (Desk_buttons[i, j].Tag<>10) and (Desk_buttons[i, j].Glyph.Empty=false) then begin Desk_buttons[i, j].Glyph:=btnErr.Glyph; UGCount:=UGCount+1;  end;
                if (Desk_buttons[i, j].Tag=10) and (Desk_buttons[i, j].Glyph.Empty) then Desk_buttons[i, j].Glyph:=btnMine.Glyph;
                end;

          lblUG.Caption:=IntToStr(UGCount);
          (Btn.Parent as TPanel).Color := clred;
          //ShowMessage('Йобани стыд!!!');
          LoseMsg;
          //tmr1.Enabled:=false;
          exit;
       end else
          begin
          (Btn.Parent as TPanel).Color := clred;
          tmr3.Enabled:=true;
          pnlSp3.Color:=clYellow;
          Exit;
          end;

      end;
  1..8 :
      begin
      if (Btn.Caption='') and (fmChack.Visible=false) then
        if (IsChain) then Scores:=Scores+OneCellBonus else Scores:=Scores+ChainCellBonus;

      Btn.Caption := IntToStr( Btn.Tag  );
      if Btn.Tag = 1 then Btn.Font.Color := clBlue;
      if Btn.Tag = 2 then Btn.Font.Color := clGreen;
      if Btn.Tag = 3 then Btn.Font.Color := clRed;
      if Btn.Tag = 4 then Btn.Font.Color := clNavy;
      if Btn.Tag = 5 then Btn.Font.Color := clMaroon;
      if Btn.Tag = 6 then Btn.Font.Color := clTeal;
      if Btn.Tag = 7 then Btn.Font.Color := clOlive;
      if Btn.Tag = 8 then Btn.Font.Color := clPurple;

      end;
  0:
      begin
      if IsChain then ChainClear(Desk_Width, Desk_Height);
      //if (IsChain) and (Btn.Caption<>'') then Scores:=Scores+NullZoneBonus;
      end;
  end;

  if (fmChack.Visible=false) then IsVictory;

end;

//очистка ячейки
procedure TfmMain.CellClear(X:integer; Y:integer);
var i,j, wdth, hgth :integer;  Btn : TSpeedButton;
begin
  i:=X; j:=Y; wdth:=Desk_Width; hgth:=Desk_Height;
  //очищаем границы ячейки
      if (i>0) then
              begin
               Btn := Desk_buttons[i-1,j];
               if not Loose then Btn.Down:=true;
               if not Loose then WhatInCell(Btn, false);
              end;
      if (i>0) and (j>0) then
              begin
              Btn := Desk_buttons[i-1,j-1];
              if not Loose then Btn.Down:=true;
              if not Loose then WhatInCell(Btn, false);
              end;
      if (i>0) and (j<Wdth-1) then
              begin
              Btn := Desk_buttons[i-1,j+1];
              if not Loose then Btn.Down:=true;
              if not Loose then WhatInCell(Btn, false);
              end;

      if (j>0) then
             begin
             Btn := Desk_buttons[i,j-1];
             if not Loose then Btn.Down:=true;
             if not Loose then WhatInCell(Btn, false);
             end;
      if (j<Wdth-1) then
            begin
            Btn := Desk_buttons[i,j+1];
            if not Loose then Btn.Down:=true;
            if not Loose then WhatInCell(Btn, false);
            end;

      if (i<Hgth-1) then
            begin
            Btn := Desk_buttons[i+1,j];
            if not Loose then Btn.Down:=true;
            if not Loose then WhatInCell(Btn, false);
            end;
      if (i<Hgth-1) and (j>0) then
            begin
            Btn := Desk_buttons[i+1,j-1];
            if not Loose then Btn.Down:=true;
            if not Loose then WhatInCell(Btn, false);
            end;
      if (i<Hgth-1) and (j<Wdth-1) then
            begin
            Btn := Desk_buttons[i+1,j+1];
            if not Loose then Btn.Down:=true;
            if not Loose then WhatInCell(Btn, false);
            end;

end;

//цепная очистка
procedure TfmMain.ChainClear(Wdth:Integer; Hgth:Integer);
var SL:TStringList;
    s : string;
    i, j, x, y:integer;
begin
  //
  SL:=TStringList.Create();

  repeat
  SL.Clear;

  //запоминаем все индексы свобоных открытых ячеек
  for i:=0 to Hgth-1 do
    for j:=0 to Wdth-1 do
      if  (Desk_buttons[i,j].Tag=0) and (Desk_buttons[i,j].Caption<>' ') and (Desk_buttons[i,j].Down=true) then
        SL.Add( inttostr(i)+' '+inttostr(j) );

   if SL.Count>0 then Scores:=Scores+NullZoneBonus;
   for i:=0 to SL.Count-1 do
   begin
       s:=SL.Strings[i];
       x := StrToInt(Trim (Copy(s, 1, AnsiPos(' ',s) ) ) );
       y := StrToInt(Trim (Copy(s, AnsiPos(' ',s), MaxInt ) ) );
       Desk_buttons[x,y].Caption:=' ';
       CellClear(x, y);
   end;

   until SL.Count=0;

   SL.Free;

end;


//нажатие на ячейку
procedure TfmMain.DeskBtnClick(Sender : TObject);
begin
if Loose then
            begin
            (Sender as TSpeedButton).Down:=not (Sender as TSpeedButton).Down;
            Exit;
            end;

 if FirstClick then tmr1.Enabled:=true;

 if (Sender as TSpeedButton).Glyph.Empty then
      begin      
      WhatInCell( (Sender as TSpeedButton), true );
      IsVictory;
      end
 else
      begin
      (Sender as TSpeedButton).Down:=false;
      end;
lblScore.Caption:=IntToStr(Scores);
end;

//наведение на область
procedure TfmMain.DeskBtnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var i,j, x1, y1, rank, spell_area : integer;   btn : TSpeedButton;
begin
  //
  if (Leonide_Mode) then
  begin
  btn := (Sender as TSpeedButton);
  for i:=0 to Desk_Height-1 do
    for j:=0 to Desk_Width-1 do
      if (Desk_buttons[i,j].Parent as TPanel).Color = MarkedCol then
          if Desk_buttons[i,j].Glyph.Empty then (Desk_buttons[i,j].Parent as TPanel).Color := StandartCol
          else (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;

  rank:=1;
  if lblR1.Caption = 'I' then rank := 1;
  if lblR1.Caption = 'II' then rank := 2;
  if lblR1.Caption = 'III' then rank := 3;

  Spell_area := 2;
  if rank=1 then Spell_area := 2;
  if rank=2 then Spell_area := 3;
  if rank=3 then Spell_area := 4;

  i := (btn.GroupIndex-1) div Desk_Width;
  j := (btn.GroupIndex-1) - (i * Desk_Width);

  for x1:=i to i+spell_area-1 do
    for y1:=j to j+spell_area-1 do
      if ifCellExist(x1, y1) then
             if (Desk_buttons[x1, y1].Down=False) then
              (Desk_buttons[x1, y1].Parent as TPanel).Color := MarkedCol;

  end;

  if (Ray_Mode) and (not Loose) then
  begin
  btn := (Sender as TSpeedButton);
  for i:=0 to Desk_Height-1 do
    for j:=0 to Desk_Width-1 do
      if (Desk_buttons[i,j].Parent as TPanel).Color = MarkedCol then
          if Desk_buttons[i,j].Glyph.Empty then (Desk_buttons[i,j].Parent as TPanel).Color := StandartCol
          else (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;

  rank:=1;
  if lblR4.Caption = 'I' then rank := 1;
  if lblR4.Caption = 'II' then rank := 2;
  if lblR4.Caption = 'III' then rank := 3;

  Spell_area := 1;
  if rank=1 then Spell_area := 1;
  if rank=2 then Spell_area := 2;
  if rank=3 then Spell_area := 3;

  i := (btn.GroupIndex-1) div Desk_Width;
  j := (btn.GroupIndex-1) - (i * Desk_Width);

  for x1:=i to i+spell_area-1 do
    for y1:=0 to Desk_Width-1 do
      if ifCellExist(x1, y1) then
             if (Desk_buttons[x1, y1].Down=False) then
              (Desk_buttons[x1, y1].Parent as TPanel).Color := MarkedCol;

  end;

end;

//установка/снятие флажка
procedure TfmMain.PlaceFlag(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var btn : TSpeedButton; mines, i, j:integer;
begin

if Loose then
            begin
            (Sender as TSpeedButton).Down:=(Sender as TSpeedButton).Down;
            Exit;
            end;
btn := (Sender as TSpeedButton);

if Leonide_Mode then
    begin
    i := (btn.GroupIndex-1) div Desk_Width;
    j := (btn.GroupIndex-1) - (i * Desk_Width);
    Spell1_Leonide_action(i, j);
    exit;
    end;

if Ray_Mode then
    begin
    i := (btn.GroupIndex-1) div Desk_Width;
    j := (btn.GroupIndex-1) - (i * Desk_Width);
    Spell4_Ray_action(i, j);
    exit;
    end;

 if (ssleft in Shift) and (ssright in Shift) and (btn.Glyph.Empty) then    //если зажато две кнопки мыши
  begin
   //считаем количество окружающих мин
   i := (btn.GroupIndex-1) div Desk_Width;
   j := (btn.GroupIndex-1) - (i * Desk_Width);
   mines:=0;
   if (i>0) then if (Desk_buttons[i-1,j].Glyph.Empty=false) then mines:=mines+1;
   if (i>0) and (j>0) then if (Desk_buttons[i-1,j-1].Glyph.Empty=false) then mines:=mines+1;
   if (i>0) and (j<Desk_Width-1) then if (Desk_buttons[i-1,j+1].Glyph.Empty=false)  then mines:=mines+1;

   if (j>0) then if (Desk_buttons[i,j-1].Glyph.Empty=false) then mines:=mines+1;
   if (j<Desk_Width-1) then if (Desk_buttons[i,j+1].Glyph.Empty=false) then mines:=mines+1;

   if (i<Desk_Height-1) then if (Desk_buttons[i+1,j].Glyph.Empty=false) then mines:=mines+1;
   if (i<Desk_Height-1) and (j>0) then if (Desk_buttons[i+1,j-1].Glyph.Empty=false) then mines:=mines+1;
   if (i<Desk_Height-1) and (j<Desk_Width-1) then if (Desk_buttons[i+1,j+1].Glyph.Empty=false) then mines:=mines+1;

   if (mines = btn.Tag) and (btn.Tag>0) and (btn.Tag<9) and (btn.Glyph.Empty) then
      begin
//      if btn.Down=false then begin btn.Down:=true; exit; end;
      CellClear(i, j);         //очищаем ячейку если все мины помечены
      ChainClear(Desk_Width, Desk_Height);
      end;

    Exit;
  end;

if (Button = mbRight) then
begin

if Btn.Down=true then
    begin
    Btn.Down:=true;
    exit;
    end;

  if (Btn.Glyph.Empty) then
      begin
      if (UGCount<=0) and (GameType=1) then exit;
      Btn.Glyph := BtnFlag.Glyph;
      UGCount:=UGCount-1;
      (btn.Parent as TPanel).Color:=FlagedCol;
      end else
        if not (ssleft in Shift) then
          begin
          Btn.Glyph:=nil;
          UGCount:=UGCount+1;
          (btn.Parent as TPanel).Color:=StandartCol;
          end;
  lblUG.Caption:=IntToStr(UGCount);
  IsVictory;
end;

end;

procedure TfmMain.GenerateDesk(Wdth:Integer; Hgth:Integer; MC : Integer);
var i, j, x, y, mines:integer;
begin
  // 10 = mine
  //очищаем массив
  for i:=0 to Hgth-1 do
    for j:=0 to Wdth-1 do
        Desk_buttons[i,j].Tag:=0;

  //расставляем мины
  Randomize;
  for i:=1 to MC do
  begin
    //ищем свободную ячейку
    repeat
      x:=Random(Hgth);
      y:=Random(Wdth);
    until Desk_buttons[x, y].Tag<>10;

    Desk_buttons[x, y].Tag:=10;
  end;

  //пересчитываем кол-во мин в клетках
  for i:=0 to Hgth-1 do
    for j:=0 to Wdth-1 do
    if Desk_buttons[i,j].Tag<>10 then
      begin
      mines:=0;
      if (i>0) then if Desk_buttons[i-1,j].Tag=10 then mines:=mines+1;
      if (i>0) and (j>0) then if Desk_buttons[i-1,j-1].Tag=10 then mines:=mines+1;
      if (i>0) and (j<Wdth-1) then if Desk_buttons[i-1,j+1].Tag=10 then mines:=mines+1;

      if (j>0) then if Desk_buttons[i,j-1].Tag=10 then mines:=mines+1;
      if (j<Wdth-1) then if Desk_buttons[i,j+1].Tag=10 then mines:=mines+1;

      if (i<Hgth-1) then if Desk_buttons[i+1,j].Tag=10 then mines:=mines+1;
      if (i<Hgth-1) and (j>0) then if Desk_buttons[i+1,j-1].Tag=10 then mines:=mines+1;
      if (i<Hgth-1) and (j<Wdth-1) then if Desk_buttons[i+1,j+1].Tag=10 then mines:=mines+1;

      Desk_buttons[i,j].Tag:=mines;
      end;
end;

procedure TfmMain.CreateDesk(Wdth:Integer; Hgth:Integer);
var i, j, j1, h1, h2 :integer;
    btnWidth, btnHeight : integer;
    Arr : array of TSpeedButton;
    Arr_pan : array of TPanel;
begin
  btnWidth := 30;
  btnHeight := 30;
  Self.Hide;

  //Очищаем массив
  j:=0;
  j1 :=0;
  for i := 0 to Self.ComponentCount - 1 do begin
    if (Self.Components[i] is TSpeedButton) then
    if ((Self.Components[i] as TSpeedButton).Tag>=0) and ((Self.Components[i] as TSpeedButton).Tag<=10)
      then
      begin
      if j = Length(Arr) then SetLength(Arr, j + 1);
      Arr[j]:=(Self.Components[i] as TSpeedButton);
      Inc(j);
      end;

    if not (Self.Components[i] is TPanel) then Continue;
    if ((Self.Components[i] as TPanel).Tag=-1) then
      begin
      if j1 = Length(Arr_pan) then SetLength(Arr_pan, j1 + 1);
      Arr_pan[j1]:=(Self.Components[i] as TPanel);
      Inc(j1);
      end;
  end;

  if j < Length(Arr) then SetLength(Arr, j);
  if j1 < Length(Arr_pan) then SetLength(Arr_pan, j1);

  for i:=0 to j-1 do
  begin
    Arr[i].Free;
  end;

  for i:=0 to j1-1 do
  begin
    Arr_pan[i].Free;
  end;

  Arr_pan := nil;
  Arr:= nil;
  Desk_mines := nil;
  Desk_buttons := nil;
  Desk_pans := nil;
  SetLength(Desk_mines,Hgth,Wdth);
  SetLength(Desk_buttons,Hgth,Wdth);
  SetLength(Desk_pans,Hgth,Wdth);

  for i:=0 to Hgth-1 do
    for j:=0 to Wdth-1 do
       begin
       Desk_pans[i, j] := TPanel.Create(fmMain);
       Desk_pans[i, j].Parent := pnl5;
       Desk_pans[i, j].Width := btnWidth;
       Desk_pans[i, j].Height:= btnHeight;
       Desk_pans[i, j].Top:= 6 + (i * btnHeight);
       Desk_pans[i, j].Left:= 6 + (j * btnWidth);
       Desk_pans[i, j].Color := StandartCol;
       Desk_pans[i, j].Tag:=-1;

       Desk_mines[i, j]:=-1;
       Desk_buttons[i, j] := TSpeedButton.Create(fmMain);
       Desk_buttons[i, j].Parent := Desk_pans[i, j];
       Desk_buttons[i, j].Width := btnWidth;
       Desk_buttons[i, j].Height:= btnHeight;
       Desk_buttons[i, j].Top:=0;   //6 + (i * btnHeight);
       Desk_buttons[i, j].Left:=0;  //6 + (j * btnWidth);
       Desk_buttons[i, j].Font.Style := Desk_buttons[i, j].Font.Style + [fsBold];
       Desk_buttons[i, j].Font.Size := 15;
       Desk_buttons[i, j].Font.Name := 'MS Sans Serif';
       //Desk_buttons[i, j].Caption := IntToStr(i+j);
       Desk_buttons[i, j].AllowAllUp:=true;
       Desk_buttons[i, j].GroupIndex:=(Wdth*i)+j+1;     //((i+1)*1000)+j;
       Desk_buttons[i, j].OnClick:=DeskBtnClick;
       Desk_buttons[i, j].OnMouseMove:=DeskBtnMouseMove;
       Desk_buttons[i, j].OnMouseDown:=PlaceFlag;
       //Desk_buttons[i, j].OnMouseUp:=PlaceFlag;
       Desk_buttons[i, j].Tag:=-1;
       Desk_buttons[i, j].Flat:=True;

       end;

  h1 := (pnl2.Width + pnl3.Width)+(Wdth*btnWidth)+18;
  h2 := pnl7.Width + pnl8.Width + pnl9.Width;
  if pnl13.Visible then h2:= h2 + pnl13.Width + 20;
  if h1 > h2 then fmMain.Width := h1 else
      begin
      fmMain.Width := h2;
      h2 := (h2 - h1) div 2;

      for i:=0 to Hgth-1 do
        for j:=0 to Wdth-1 do
           Desk_pans[i, j].Left := Desk_pans[i, j].Left + h2;

      end;

  //fmMain.Width:= (pnl2.Width + pnl3.Width)+(Wdth*btnWidth)+18;
  //fmMain.Height:=

  h1 := (pnl1.Height + pnl4.Height)+(Hgth*btnHeight)+17+43;
  h2 := (pnl1.Height + pnl4.Height)+(pnl10.Height+pnl11.Height+pnl12.Height)+9+43;
  if h1 > h2 then fmMain.Height := h1 else
      begin
      fmMain.Height := h2;
      h2 := (h2 - h1) div 2;

      for i:=0 to Hgth-1 do
        for j:=0 to Wdth-1 do
           Desk_pans[i, j].Top := Desk_pans[i, j].Top + h2;

      end;

  Self.Show;
 // Self.Position:=poScreenCenter;
end;

procedure TfmMain.N9Click(Sender: TObject);
begin
  fmMain.Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  FirstClick:=True;
  Loose:=False;

  Desk_Width:=9;
  Desk_Height:=9;
  MinesCount:=10;
  Level := 1;
  Stage := 0;
  GameType := 0;
  N2Click(Sender);

  Arsenal.Skill1_Leonide:=0;
  Arsenal.Skill2_Onotole:=0;
  Arsenal.Skill3_Bless:=0;
  Arsenal.Skill4_Ray:=0;
  Arsenal.Skill5_Chack:=0;

  Leonide_Mode := false;
  Bless_blocks := -1;
  
end;

procedure TfmMain.N2Click(Sender: TObject);
begin
  VictoryPlace := 0;
  if GameType=0 then
     begin
     Scores:=0;
     lbl1.Caption:='РИАЛЬНЭ ВЗДРЪЖНЭ САПЕРЧИКЭ!!!!111';
     end;

  if GameType=1 then
      begin
      if (Sender <> btnFlag) then
         begin
         Stage:=1;
         Scores:=0;
         RxGIFAnimator1.Image.Clear;
         RxGIFAnimator2.Image.Clear;
         RxGIFAnimator3.Image.Clear;
         RxGIFAnimator1.Tag:=0;
         RxGIFAnimator2.Tag:=0;
         RxGIFAnimator3.Tag:=0;
         pnl10.Caption:='ПОТС';
         pnl11.Caption:=pnl10.Caption;
         pnl12.Caption:=pnl10.Caption;
         MinesCount:=PrimaryMinesCount;
         Bless_blocks := -1;
         Spell1_Leonide_cancel;
         Spell4_Ray_cancel;

         Arsenal.Skill1_Leonide:=0;
         Arsenal.Skill2_Onotole:=0;
         Arsenal.Skill3_Bless:=0;
         Arsenal.Skill4_Ray:=0;
         Arsenal.Skill5_Chack:=0;

         PepyakaRecount;
         RecalcSpells;

         //Pepyaka:=150;
         end;
      if Stage=1 then MinesCount:=RecalMines(MinesCount, Stage);
      lbl1.Caption:='УРОВНЕ '+inttostr(Stage);

      end;

  pnl13.Visible := GameType = 1;
  pnl14.Visible := GameType = 1;
  Spells_Pan.Visible := GameType = 1;
  btnPantenon.Visible := GameType =1;
  if GameType=0 then pnl8.Align :=alClient else begin pnl8.Align :=alLeft; pnl8.Width :=190; end;
  FirstClick:=True;
  Loose:=False;
  tmr1.Enabled:=false;
  UGCount:=MinesCount;
  time:=0;

  lblUG.Caption:=IntToStr(MinesCount);
  lblTime.Caption:=IntToStr(time);
  lblScore.Caption:=IntToStr(Scores);


  CreateDesk(Desk_Width, Desk_Height);
  GenerateDesk(Desk_Width, Desk_Height, MinesCount);

  //RxGIFAnimator1.Animate:=True;
end;


procedure TfmMain.N5Click(Sender: TObject);
begin
    fmSettings.ShowModal;
    if fmSettings.ModalResult=mrOk then
      begin
      N2Click(btnFlag);
      pnl10.Visible:=GameType=1;
      pnl11.Visible:=GameType=1;
      pnl12.Visible:=GameType=1;
      pnl11.Top := (pnl2.Height div 2) - (pnl11.Height div 2);
      btnPantenon.Top := (pnl3.Height div 2) - (btnPantenon.Height div 2);
      pnl10.Caption:='ПОТС';
      pnl11.Caption:=pnl10.Caption;
      pnl12.Caption:=pnl10.Caption;
      RxGIFAnimator1.Image.Clear;
      RxGIFAnimator2.Image.Clear;
      RxGIFAnimator3.Image.Clear;
      RxGIFAnimator1.Tag:=0;
      RxGIFAnimator2.Tag:=0;
      RxGIFAnimator3.Tag:=0;
      pnl13.Visible := GameType = 1;
      pnl14.Visible := GameType = 1;
      Spells_Pan.Visible := GameType = 1;
      btnPantenon.Visible := GameType =1;
      fmMain.Position := poScreenCenter;
      Bless_blocks := -1;

      Arsenal.Skill1_Leonide:=0;
      Arsenal.Skill2_Onotole:=0;
      Arsenal.Skill3_Bless:=0;
      Arsenal.Skill4_Ray:=0;
      Arsenal.Skill5_Chack:=0;

      PepyakaRecount;
      RecalcSpells;
      end;
end;

procedure TfmMain.tmr1Timer(Sender: TObject);
begin
  if not Loose then
    begin
    time:=time+1;
    lblTime.Caption:=IntToStr(time);
    end;

end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmr1.Enabled:=False;
end;

procedure TfmMain.RxGIFAnimator1Click(Sender: TObject);
var f : Boolean;
begin
    if Loose then exit;
    (Sender as TRxGIFAnimator).Hint := 'X';
    fmPots.ScrollBox1.VertScrollBar.Position:=0;
    f:=tmr1.Enabled;
    tmr1.Enabled:=False;
    fmPots.ShowModal;
    tmr1.Enabled:=f;
    (Sender as TRxGIFAnimator).Hint := '';
    (Sender as TRxGIFAnimator).Animate := true;
    if (Sender as TRxGIFAnimator).Tag >0 then ((Sender as TRxGIFAnimator).Parent as TPanel).Caption := '';

    lblScore.Caption := inttostr(Scores);
    PepyakaRecount;
    RecalcSpells;
end;

procedure TfmMain.tmr2Timer(Sender: TObject);
begin
    tmr2.Enabled:=false;
    N2Click(btnFlag);
end;

procedure TfmMain.btnPantenonClick(Sender: TObject);
var f:Boolean;
begin
    if Loose then exit;
    fmPantenon.scrlbx1.VertScrollBar.Position:=0;
    f:=tmr1.Enabled;
    tmr1.Enabled:=False;
    fmPantenon.ShowModal;
    tmr1.Enabled:=f;

    RecalcSpells();
    lblScore.Caption := inttostr(Scores);
end;

procedure TfmMain.imgSp1Click(Sender: TObject);
var tg : integer;
begin
  //
  if Loose then exit;
  if FirstClick then
      begin
      Application.MessageBox('Нельзя использовать сикретни оружие не разведав минимума местности!', 'УПЧК', mb_ok+MB_ICONINFORMATION);
      exit;
      end;
  tg := (Sender as TImage).Tag;

  if pnlSp1.Color = clYellow then exit;
  if pnlSp2.Color = clYellow then exit;
  if pnlSp3.Color = clYellow then exit;
  if pnlSp4.Color = clYellow then exit;
  if pnlSp5.Color = clYellow then exit;

  if tg = 1 then Spell1_Leonide;
  if tg = 2 then Spell2_Onotole;
  if tg = 3 then Application.MessageBox(PCHAR('Следующие '+inttostr(Bless_blocks)+' отаке УГ будут блокироване благословением.'), 'УПЧК', MB_OK+MB_ICONINFORMATION );
  if tg = 4 then Spell4_Ray;
  if tg = 5 then Spell5_Chack;

end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i, j : integer;
begin
      if ((Key = 13) or (Key = 27)) then
      begin
       if Leonide_Mode then Spell1_Leonide_cancel;
       if Ray_Mode then Spell4_Ray_cancel;
      end;
end;

procedure TfmMain.tmr3Timer(Sender: TObject);
begin
    tmr3.Enabled:=False;
    Spell3_Bless();
end;

procedure TfmMain.tmr4Timer(Sender: TObject);
var i,j:integer;
begin
  if Ray_col>Desk_Width-1 then begin tmr4.Enabled:=false; exit;  end;

  j:=Ray_col;
  for i:=0 to Desk_Height-1 do
    if (Desk_buttons[i, j].Parent as TPanel).Color = MarkedCol then
      begin
      if (Desk_buttons[i, j].Tag=10) then begin
                            if (Desk_buttons[i, j].Glyph.Empty) then UGCount:=UGCount-1;
                            Desk_buttons[i, j].Glyph := btnFlag.Glyph;
                            (Desk_buttons[i,j].Parent as TPanel).Color := FlagedCol;
                            Continue;
                            end;

       //if ifCellExist(i, j+1) then
        //if ((Desk_buttons[i,j+1].Parent as TPanel).Color = MarkedCol) and (Desk_buttons[i,j+1].Tag<>10 ) then
       //     (Desk_buttons[i,j+1].Parent as TPanel).Color:=clGreen;
       (Desk_buttons[i,j].Parent as TPanel).Color:=StandartCol;
       Desk_buttons[i, j].Down := true;
       WhatInCell(Desk_buttons[i, j], false);
      end;
  inc(Ray_col);

end;

procedure TfmMain.N3Click(Sender: TObject);
begin
    fmHall.ShowModal;
end;

procedure TfmMain.N7Click(Sender: TObject);
begin
    AboutBox.ShowModal;
end;

procedure TfmMain.N10Click(Sender: TObject);
begin
    fmHelp.VertScrollBar.Position:=0;
    fmHelp.ShowModal;
end;

end.
