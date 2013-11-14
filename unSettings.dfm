object fmSettings: TfmSettings
  Left = 581
  Top = 202
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1077#1095#1082#1077
  ClientHeight = 320
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 435
    Height = 193
    Align = alTop
    Caption = '   '#1059#1088#1086#1074#1085#1077' '
    TabOrder = 0
    object lbl1: TLabel
      Left = 232
      Top = 88
      Width = 66
      Height = 15
      Caption = #1057#1090#1088#1086#1095#1086#1095#1077#1082': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 232
      Top = 120
      Width = 61
      Height = 15
      Caption = #1057#1090#1086#1083#1073#1080#1082#1077': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 232
      Top = 152
      Width = 59
      Height = 15
      Caption = #1050#1086#1083'-'#1074#1086' '#1059#1043':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object rb1: TRadioButton
      Left = 24
      Top = 32
      Width = 153
      Height = 41
      Caption = #1057#1083#1072#1073#1072#1095#1086#1095#1082#1077'                 (9'#1093'9 '#1082#1083#1077#1090#1086#1095#1082#1077' '#1080' 10 '#1059#1043')'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      WordWrap = True
      OnKeyDown = FormKeyDown
    end
    object rb2: TRadioButton
      Left = 24
      Top = 88
      Width = 169
      Height = 41
      Caption = #1057#1077#1088#1077#1076#1085#1103#1095#1086#1095#1082#1077'                 (16'#1093'16 '#1082#1083#1077#1090#1086#1095#1082#1077' '#1080' 40 '#1059#1043')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      WordWrap = True
      OnKeyDown = FormKeyDown
    end
    object rb3: TRadioButton
      Left = 24
      Top = 144
      Width = 169
      Height = 41
      Caption = #1042#1086#1077#1085#1101'                          (16'#1093'30 '#1082#1083#1077#1090#1086#1095#1082#1077' '#1080' 99 '#1059#1043')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      WordWrap = True
      OnKeyDown = FormKeyDown
    end
    object rb4: TRadioButton
      Left = 232
      Top = 32
      Width = 161
      Height = 41
      Caption = #1057#1080#1082#1088#1077#1090#1085#1080' '#1091#1088#1086#1074#1085#1077'              ( ? '#1093' ? '#1082#1083#1077#1090#1086#1095#1082#1077' '#1080' ? '#1059#1043')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      WordWrap = True
      OnClick = rb4Click
      OnKeyDown = FormKeyDown
    end
    object edt1: TEdit
      Left = 303
      Top = 86
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 4
      Text = '9'
      OnKeyDown = FormKeyDown
    end
    object ud1: TUpDown
      Left = 368
      Top = 86
      Width = 16
      Height = 21
      Associate = edt1
      Enabled = False
      Min = 9
      Max = 50
      Position = 9
      TabOrder = 5
    end
    object edt2: TEdit
      Left = 304
      Top = 118
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 6
      Text = '9'
      OnKeyDown = FormKeyDown
    end
    object ud2: TUpDown
      Left = 369
      Top = 118
      Width = 16
      Height = 21
      Associate = edt2
      Enabled = False
      Min = 9
      Position = 9
      TabOrder = 7
    end
    object edt3: TEdit
      Left = 304
      Top = 150
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 8
      Text = '10'
      OnKeyDown = FormKeyDown
    end
    object ud3: TUpDown
      Left = 369
      Top = 150
      Width = 16
      Height = 21
      Associate = edt3
      Enabled = False
      Min = 10
      Max = 1000
      Position = 10
      TabOrder = 9
    end
  end
  object btn1: TBitBtn
    Left = 95
    Top = 273
    Width = 105
    Height = 32
    Cursor = crHandPoint
    Caption = #1054#1050#1069
    TabOrder = 1
    OnClick = btn1Click
    OnKeyDown = FormKeyDown
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btn2: TBitBtn
    Left = 223
    Top = 273
    Width = 105
    Height = 32
    Cursor = crHandPoint
    Caption = #1050#1072#1085#1094#1101#1083
    ModalResult = 2
    TabOrder = 2
    OnKeyDown = FormKeyDown
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000000000002400
      CE00AEAAB600CEC6D6002400C6002400D6002C00DE006D55CE00E6E2E6002400
      B6001C00A5005D5585005D557500E6E2F6002400AE00AEAAAE00241C3C001C1C
      1C002C1C5D000C0034005555550014005D001C009D0004001C003C383C009D8D
      D60014007D003C1CC6000C0044004C38A5001C008D0014006D008571CE005D55
      6D00B6AAF600341C8500241C5500B6AADE002C1C75001C1C24001C0085007D71
      9D00B6AAEE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000121C270000000000000008211000000004061303
      00000000000326042400000020050E11080000000F28010B000000000007061A
      1400000216040C0000000000000007061514020A040C00000000000000000007
      05150E040C00000000000000000000001D060110000000000000000000000002
      0901051F18080000000000000000020A010B25011E1103000000000000020E01
      0B00000D1B09170F00000000020A0512000000000D0704130300000309062308
      00000000000019290000002205160F0000000000000000000000000D2A030000
      0000000000000000000000000000000000000000000000000000}
  end
  object grp2: TGroupBox
    Left = 0
    Top = 193
    Width = 435
    Height = 64
    Align = alTop
    Caption = #1056#1077#1078#1080#1084' '#1080#1075#1088#1099
    TabOrder = 3
    object rb5: TRadioButton
      Left = 56
      Top = 23
      Width = 73
      Height = 26
      Caption = #1050#1083#1072#1089#1089#1080#1082#1101
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      WordWrap = True
      OnKeyDown = FormKeyDown
    end
    object rb6: TRadioButton
      Left = 240
      Top = 23
      Width = 113
      Height = 26
      Caption = #1048#1084#1087#1088#1091#1074#1101#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      WordWrap = True
      OnKeyDown = FormKeyDown
    end
  end
end
