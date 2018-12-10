object frmSelecionarDiretorio: TfrmSelecionarDiretorio
  Left = 773
  Top = 211
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Selecionar Pasta'
  ClientHeight = 286
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 39
    Height = 13
    Caption = 'Unidade'
  end
  object Label2: TLabel
    Left = 8
    Top = 49
    Width = 41
    Height = 13
    Caption = 'Diret'#243'rio'
  end
  object dlbDiretorio: TDirectoryListBox
    Left = 8
    Top = 65
    Width = 233
    Height = 185
    ItemHeight = 16
    TabOrder = 0
  end
  object dcbDrive: TDriveComboBox
    Left = 8
    Top = 24
    Width = 233
    Height = 19
    TabOrder = 1
    OnChange = dcbDriveChange
  end
  object btnCancelar: TButton
    Left = 59
    Top = 256
    Width = 88
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnOk: TButton
    Left = 153
    Top = 256
    Width = 88
    Height = 25
    Caption = '&Ok'
    TabOrder = 3
    OnClick = btnOkClick
  end
end
