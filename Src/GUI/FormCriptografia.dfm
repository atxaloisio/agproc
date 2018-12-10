object frmCriptografia: TfrmCriptografia
  Left = 331
  Top = 248
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Utilit'#225'rio de Criptografia / Descriptografia'
  ClientHeight = 150
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 482
    Height = 57
    Align = alTop
    Caption = 'Texto N'#227'o Criptografado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object edtDescriptografada: TEdit
      Left = 8
      Top = 22
      Width = 469
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 57
    Width = 482
    Height = 56
    Align = alTop
    Caption = 'Texto Criptografado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object edtCriptografada: TEdit
      Left = 7
      Top = 24
      Width = 469
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object btnDescriptografar: TButton
    Left = 102
    Top = 119
    Width = 88
    Height = 25
    Caption = 'Descriptografar'
    TabOrder = 2
    OnClick = btnDescriptografarClick
  end
  object btnCriptografar: TButton
    Left = 8
    Top = 119
    Width = 88
    Height = 25
    Caption = '&Criptografar'
    TabOrder = 3
    OnClick = btnCriptografarClick
  end
  object btnFechar: TButton
    Left = 386
    Top = 119
    Width = 88
    Height = 25
    Caption = '&Fechar'
    TabOrder = 4
    OnClick = btnFecharClick
  end
end
