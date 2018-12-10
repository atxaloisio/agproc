object frmModelosXPecas: TfrmModelosXPecas
  Left = 246
  Top = 85
  Width = 781
  Height = 562
  Caption = 'Associa'#231#227'o de Modelos x Pe'#231'as'
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
  DesignSize = (
    765
    523)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 765
    Height = 233
    Align = alTop
    Caption = 'ARQUIVOS A SEREM PROCESSADOS'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      765
      233)
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 79
      Height = 13
      Caption = 'Pasta de Origem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 62
      Width = 81
      Height = 13
      Caption = 'Pasta de Destino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 103
      Width = 98
      Height = 13
      Caption = 'Arquivos Dispon'#237'veis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtPastaOrigem: TEdit
      Left = 10
      Top = 39
      Width = 745
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtPastaDestino: TEdit
      Left = 10
      Top = 77
      Width = 745
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object clbArquivos: TCheckListBox
      Left = 10
      Top = 122
      Width = 572
      Height = 101
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
    end
    object rbtDestino: TRadioGroup
      Left = 588
      Top = 116
      Width = 167
      Height = 107
      Anchors = [akTop, akRight]
      Caption = 'DESTINO'
      Items.Strings = (
        'Descritor Predefinido 1'
        'Descritor Predefinido 2'
        'Descritor Predefinido 3')
      TabOrder = 3
    end
  end
  object btnLerArquivo: TButton
    Left = 8
    Top = 490
    Width = 88
    Height = 25
    Hint = 'Carrega as planilhas Excel'
    Anchors = [akLeft, akBottom]
    Caption = '&Ler Arquivos'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnLerArquivoClick
  end
  object pcPlanilhas: TPageControl
    Left = 0
    Top = 233
    Width = 765
    Height = 135
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
  end
  object panProgresso: TPanel
    Left = 78
    Top = 254
    Width = 614
    Height = 102
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clMoneyGreen
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    Visible = False
    DesignSize = (
      612
      100)
    object lblMsg: TLabel
      Left = 8
      Top = 5
      Width = 100
      Height = 13
      Caption = 'Processando Planilha'
    end
    object pbProcessamento: TProgressBar
      Left = 8
      Top = 24
      Width = 590
      Height = 36
      Anchors = [akLeft, akTop, akRight]
      Smooth = True
      Step = 5
      TabOrder = 0
    end
    object btnCancelar: TButton
      Left = 511
      Top = 63
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object btnProcessar: TButton
    Left = 102
    Top = 489
    Width = 88
    Height = 25
    Hint = 'Atualiza banco de dados do '#193'bacos, a partir da planilha'
    Anchors = [akLeft, akBottom]
    Caption = '&Processar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnProcessarClick
  end
  object GroupBox3: TGroupBox
    Left = 303
    Top = 374
    Width = 298
    Height = 106
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'LEGENDA'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      298
      106)
    object Label4: TLabel
      Left = 8
      Top = 26
      Width = 245
      Height = 15
      Anchors = [akLeft]
      Caption = 'CPD - Cadastro de produto duplicado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 8
      Top = 38
      Width = 210
      Height = 15
      Anchors = [akLeft]
      Caption = 'DNC - Descritor n'#227'o cadastrado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 8
      Top = 62
      Width = 280
      Height = 15
      Anchors = [akLeft]
      Caption = 'DNP - Descritor n'#227'o associado ao produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 8
      Top = 14
      Width = 196
      Height = 15
      Anchors = [akLeft]
      Caption = 'PNC - Produto n'#227'o cadastrado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 8
      Top = 50
      Width = 259
      Height = 15
      Anchors = [akLeft]
      Caption = 'CDD - Cadastro de descritor duplicado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 8
      Top = 86
      Width = 280
      Height = 15
      Anchors = [akLeft]
      Caption = 'DDP - Descritor duplicado para o produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 8
      Top = 74
      Width = 280
      Height = 15
      Anchors = [akLeft]
      Caption = 'DEP - Descritor j'#225' existe para o produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 374
    Width = 289
    Height = 106
    Anchors = [akLeft, akBottom]
    Caption = 'OP'#199#213'ES'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    DesignSize = (
      289
      106)
    object ckbPecasSemModelos: TCheckBox
      Left = 9
      Top = 17
      Width = 180
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'N'#227'o mostrar pe'#231'as sem modelos'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object ckbProcessesarSelecionado: TCheckBox
      Left = 9
      Top = 59
      Width = 208
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Processar somente a linha selecionada'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
    object ckbProdutosNaoCadastrados: TCheckBox
      Left = 9
      Top = 38
      Width = 192
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Carregar produtos n'#227'o cadastrados'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object ckbLimitarLista: TCheckBox
      Left = 9
      Top = 81
      Width = 225
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Limitar quantidade de produtos na lista a:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ckbLimitarListaClick
    end
    object edtQtdLinhas: TEdit
      Left = 229
      Top = 76
      Width = 52
      Height = 22
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = edtQtdLinhasExit
    end
  end
  object GroupBox4: TGroupBox
    Left = 607
    Top = 374
    Width = 150
    Height = 106
    Anchors = [akRight, akBottom]
    Caption = 'Ocorr'#234'ncias'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    DesignSize = (
      150
      106)
    object Label11: TLabel
      Left = 7
      Top = 26
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'CPD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 7
      Top = 38
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'DNC'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label13: TLabel
      Left = 7
      Top = 62
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'DNP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object label50: TLabel
      Left = 7
      Top = 14
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'PNC'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label15: TLabel
      Left = 7
      Top = 50
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'CDD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label16: TLabel
      Left = 7
      Top = 86
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'DDP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label17: TLabel
      Left = 7
      Top = 74
      Width = 21
      Height = 15
      Anchors = [akLeft]
      Caption = 'DEP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblCPD: TLabel
      Left = 50
      Top = 26
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDNC: TLabel
      Left = 50
      Top = 38
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDNP: TLabel
      Left = 50
      Top = 62
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblPNC: TLabel
      Left = 50
      Top = 14
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblCDD: TLabel
      Left = 50
      Top = 50
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDDP: TLabel
      Left = 50
      Top = 86
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDEP: TLabel
      Left = 50
      Top = 74
      Width = 91
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
end
