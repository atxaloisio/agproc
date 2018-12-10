object frmCargaBematech: TfrmCargaBematech
  Left = 0
  Top = 0
  Caption = 'Carga Bematech'
  ClientHeight = 417
  ClientWidth = 788
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
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 179
    Top = 6
    Width = 146
    Height = 13
    Caption = 'Problema no c'#243'digo de barras:'
  end
  object Label3: TLabel
    Left = 331
    Top = 6
    Width = 38
    Height = 13
    AutoSize = False
    Caption = '0'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 788
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnLerProdutos: TButton
      Left = 8
      Top = 10
      Width = 112
      Height = 25
      Hint = 'L'#234' cadastro de produtos do Abacos'
      Caption = 'Ler Produtos'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnLerProdutosClick
    end
    object btnAtualizarAccess: TButton
      Left = 126
      Top = 10
      Width = 112
      Height = 25
      Hint = 
        'Atualiza arquivo tempor'#225'rio do Access, para ser utilizado futura' +
        'mente na importa'#231#227'o do BemaLite'
      Caption = 'Atualizar Access'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAtualizarAccessClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 788
    Height = 351
    Align = alClient
    DataSource = dsDadosParaBematech
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawDataCell = DBGrid1DrawDataCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PRODUTO'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOM_PRODUTO'
        Width = 478
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_POLIPARTES'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIG_UNIDADE'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VAL_PRECO'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_BARRAS'
        Width = 127
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IND_ERRO'
        Width = 40
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 392
    Width = 788
    Height = 25
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      788
      25)
    object Label1: TLabel
      Left = 155
      Top = 6
      Width = 146
      Height = 13
      Caption = 'Problema no c'#243'digo de barras:'
    end
    object lblQtdlProblemaCodBarras: TLabel
      Left = 307
      Top = 6
      Width = 38
      Height = 13
      AutoSize = False
      Caption = '0'
    end
    object lblProgresso: TLabel
      Left = 387
      Top = 6
      Width = 103
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Carregando produtos'
      Visible = False
    end
    object Label4: TLabel
      Left = 8
      Top = 6
      Width = 78
      Height = 13
      Caption = 'Qtde. Produtos:'
    end
    object lblQtdProdutos: TLabel
      Left = 92
      Top = 6
      Width = 38
      Height = 13
      AutoSize = False
      Caption = '0'
    end
    object pbProgresso: TProgressBar
      Left = 496
      Top = 4
      Width = 281
      Height = 17
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      Visible = False
    end
  end
  object dsDadosParaBematech: TDataSource
    DataSet = DM.qryDadosParaBematech
    Left = 624
    Top = 56
  end
end
