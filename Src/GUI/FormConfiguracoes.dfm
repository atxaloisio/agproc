object frmConfiguracoes: TfrmConfiguracoes
  Left = 320
  Top = 116
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 355
  ClientWidth = 487
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 487
    Height = 136
    Align = alTop
    Caption = 'Descritors Predefinidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 16
      Width = 141
      Height = 13
      Caption = 'Pasta de origem das Planilhas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 62
      Width = 207
      Height = 13
      Caption = 'Pasta de destino das Planilhas processadas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtPastaOrigem: TEdit
      Left = 9
      Top = 35
      Width = 418
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtPastaDestino: TEdit
      Left = 9
      Top = 81
      Width = 418
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object chkMoverArquivos: TCheckBox
      Left = 9
      Top = 108
      Width = 200
      Height = 17
      Caption = 'Mover Planilhas ap'#243's processamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnSelPastaOrigem: TBitBtn
      Left = 433
      Top = 34
      Width = 29
      Height = 24
      TabOrder = 3
      OnClick = btnSelPastaOrigemClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FFFFFF009E9C
        63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CF
        CE63CFCE63CFCE000000FFFFFF009E9CCEFFFF9CCFFF9CFFFF9CCFFF9CFFFF9C
        CFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CCFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFF
        FF9CFFFF63CFCE000000FFFFFF009E9C63CFCE63CFCE63CFCE63CFCE63CFCE63
        CFCE63CFCE009E9C009E9C009E9C009E9C009E9C009E9CFFFFFFFFFFFFFFFFFF
        009E9CF7F7F7CEFFFFCEFFFF9CFFFF9CFFFF009E9C000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF009E9C009E9C009E9C009E9C00
        9E9C000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Margin = 3
      Spacing = 0
    end
    object btnSelPastaDestino: TBitBtn
      Left = 432
      Top = 78
      Width = 29
      Height = 24
      TabOrder = 4
      OnClick = btnSelPastaDestinoClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FFFFFF009E9C
        63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CF
        CE63CFCE63CFCE000000FFFFFF009E9CCEFFFF9CCFFF9CFFFF9CCFFF9CFFFF9C
        CFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CCFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFF
        FF9CFFFF63CFCE000000FFFFFF009E9C63CFCE63CFCE63CFCE63CFCE63CFCE63
        CFCE63CFCE009E9C009E9C009E9C009E9C009E9C009E9CFFFFFFFFFFFFFFFFFF
        009E9CF7F7F7CEFFFFCEFFFF9CFFFF9CFFFF009E9C000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF009E9C009E9C009E9C009E9C00
        9E9C000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Margin = 3
      Spacing = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 203
    Width = 487
    Height = 112
    Align = alTop
    Caption = 'Conex'#227'o com Banco de Dados Millennium Business (Firebird)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 9
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Servidor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 62
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 239
      Top = 62
      Width = 30
      Height = 13
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 239
      Top = 16
      Width = 155
      Height = 13
      Caption = 'Caminho para o Banco de Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtServidor: TEdit
      Left = 9
      Top = 35
      Width = 224
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtUsuario: TEdit
      Left = 9
      Top = 81
      Width = 224
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtSenha: TMaskEdit
      Left = 239
      Top = 81
      Width = 222
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '#'
      TabOrder = 2
    end
    object edtBanco: TEdit
      Left = 239
      Top = 35
      Width = 224
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object btnCancelar: TButton
    Left = 375
    Top = 321
    Width = 88
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnSalvar: TButton
    Left = 281
    Top = 321
    Width = 88
    Height = 25
    Caption = '&Salvar'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 136
    Width = 487
    Height = 67
    Align = alTop
    Caption = 'Logs de importa'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label7: TLabel
      Left = 9
      Top = 16
      Width = 176
      Height = 13
      Caption = 'Pasta destino de Logs de importa'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtDestinoLogsImportacao: TEdit
      Left = 9
      Top = 35
      Width = 418
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnSelArquivoAccess: TBitBtn
      Left = 433
      Top = 34
      Width = 29
      Height = 24
      TabOrder = 1
      OnClick = btnSelArquivoAccessClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FFFFFF009E9C
        63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CFCE63CF
        CE63CFCE63CFCE000000FFFFFF009E9CCEFFFF9CCFFF9CFFFF9CCFFF9CFFFF9C
        CFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CCFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCF
        FF9CFFFF63CFCE000000FFFFFF009E9CCEFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
        FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF63CFCE000000FFFFFF009E9C
        CEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFFFFCEFF
        FF9CFFFF63CFCE000000FFFFFF009E9C63CFCE63CFCE63CFCE63CFCE63CFCE63
        CFCE63CFCE009E9C009E9C009E9C009E9C009E9C009E9CFFFFFFFFFFFFFFFFFF
        009E9CF7F7F7CEFFFFCEFFFF9CFFFF9CFFFF009E9C000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF009E9C009E9C009E9C009E9C00
        9E9C000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Margin = 3
      Spacing = 0
    end
  end
  object Button1: TButton
    Left = 4
    Top = 321
    Width = 219
    Height = 25
    Caption = 'Corrigir espa'#231'os em branco dos modelos'
    TabOrder = 5
  end
end
