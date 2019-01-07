object frmUtilRemoveEspacoBase: TfrmUtilRemoveEspacoBase
  Left = 275
  Top = 430
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Remover Espa'#231'os em Branco dos Modelos do Banco de Dados'
  ClientHeight = 111
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object progresso: TGauge
    Left = 0
    Top = 28
    Width = 499
    Height = 33
    ForeColor = clNavy
    Progress = 0
  end
  object Label1: TLabel
    Left = 5
    Top = 9
    Width = 490
    Height = 13
    Caption = 
      'Removendo espa'#231'os em branco dos modelos registrados  no banco de' +
      ' dados. Aguarde.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnCancelar: TButton
    Left = 224
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = btnCancelarClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 64
    Top = 72
  end
end
