unit unHall;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons, rxAnimate, rxGIFCtrl, IniFiles;

type
  TfmHall = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    rg1: TRadioGroup;
    pnl1: TPanel;
    btn1: TBitBtn;
    rxgfnmtr1: TRxGIFAnimator;
    rxgfnmtr2: TRxGIFAnimator;
    shp1: TShape;
    shp2: TShape;
    pnl2: TPanel;
    L1: TLabel;
    grp1: TGroupBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    L2: TLabel;
    L3: TLabel;
    L4: TLabel;
    L5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ReadStatsFile(IsImproved : boolean; Typ : Integer);
    procedure rg1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHall: TfmHall;

implementation

uses unMain;

{$R *.dfm}

procedure TfmHall.FormShow(Sender: TObject);
var i:integer;
begin
  if lbl2.Font.Color<>clred then
  begin
    rg1.ItemIndex:=0;
    rb1.Checked:=true;
    rg1Click(Sender);
  end else
          rg1Click(Sender);
end;

procedure TfmHall.ReadStatsFile(IsImproved : boolean; Typ : Integer);
var sec, s, s1 : string; cnt, i, j:integer;
    tmp : string;
    Results : array of string;
    Place : integer;
    L : TLabel;

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

    function DecodeName(str : string):String;
    var ind : Integer;
    begin
      //
      try
        Result := '';
        ind := AnsiPos('|', str);
        str := TRIM(Copy(str, 1, ind-1));

      except
        str := '';
      end;

      Result := str;
    end;

begin
  //
  cnt := 5;
  SetLength(Results, cnt);       //0..5
  fmMain.OpenResultsFile;

  if IsImproved then sec := 'IMPROVED' else sec := 'CLASSIC';

  for i:=1 to cnt do
  begin
        s:=InIF.ReadString( sec, 'Result_'+inttostr(i)+inttostr(typ), '');
        s:=DecodeString(s);
        if (s='') then
            Results[i-1]:='' else
            Results[i-1]:=s;
  end;

    for i:=1 to cnt do
      for j:=1 to cnt-1 do
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
        if i=1 then L:=L1;
        if i=2 then L:=L2;
        if i=3 then L:=L3;
        if i=4 then L:=L4;
        if i=5 then L:=L5;

        L.Caption:=IntToStr(i)+'. ---';
        if (IsImproved) and ( DecodeLvl(Results[i-1])>0 ) and ( DecodeTime(Results[i-1])>0 ) then
        begin
          s:=IntToStr(i)+'. '+DecodeName(Results[i-1])+#13+#10;
          s:=s+'Уровне: '+inttostr( DecodeLvl(Results[i-1]) )+';  Чочочки: '+inttostr( DecodeScore(Results[i-1]) )+';';
          L.Caption:=s;
        end;

        if (not IsImproved) and ( DecodeTime(Results[i-1])<>99999 ) then
        begin
          s:=IntToStr(i)+'. '+DecodeName(Results[i-1])+#13+#10;
          s:=s+'Времячке: '+inttostr( DecodeTime(Results[i-1]) )+';';
          L.Caption:=s;
        end;
    end;

    InIF.Free;
end;


procedure TfmHall.rg1Click(Sender: TObject);
var f, f1 : Boolean;
begin
  if lbl2.Font.Color = clred then
    begin
    L1.Font.Color := clBlack;
    L2.Font.Color := clBlack;
    L3.Font.Color := clBlack;
    L4.Font.Color := clBlack;
    L5.Font.Color := clBlack;

    f1 := rb2.Checked;
    f := lbl2.Tag = 1;
    if (f = f1) and ( rg1.ItemIndex = strtoint(lbl2.Hint) ) then
        begin
        if VictoryPlace = 1 then L1.Font.Color := clRed;
        if VictoryPlace = 2 then L2.Font.Color := clRed;
        if VictoryPlace = 3 then L3.Font.Color := clRed;
        if VictoryPlace = 4 then L4.Font.Color := clRed;
        if VictoryPlace = 5 then L5.Font.Color := clRed;
        end;

    end;

    ReadStatsFile(rb2.Checked, rg1.ItemIndex+1 );
end;

procedure TfmHall.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  L1.Font.Color := clBlack;
  L2.Font.Color := clBlack;
  L3.Font.Color := clBlack;
  L4.Font.Color := clBlack;
  L5.Font.Color := clBlack;
  lbl2.Font.Color := clBlack;
  lbl2.Hint := '0';
  lbl2.Tag := 0;
end;

procedure TfmHall.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key=13) or (Key=27) then Close;
end;

end.
