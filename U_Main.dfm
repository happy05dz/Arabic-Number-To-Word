object Main_Form: TMain_Form
  Left = 0
  Top = 0
  Caption = 'Arabic Number To Word'
  ClientHeight = 279
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Converters_Button: TButton
    Left = 391
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Converter'
    TabOrder = 0
    OnClick = Converters_ButtonClick
  end
  object Words_memo: TMemo
    Left = 8
    Top = 112
    Width = 458
    Height = 153
    Alignment = taRightJustify
    TabOrder = 1
  end
  object Numbers_edit: TEdit
    Left = 8
    Top = 32
    Width = 458
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
  end
  object Copy_Button: TButton
    Left = 296
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Copy'
    TabOrder = 3
  end
end
