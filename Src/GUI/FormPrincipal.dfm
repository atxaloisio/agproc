object frmPrincipal: TfrmPrincipal
  Left = 382
  Top = 99
  Width = 773
  Height = 589
  Caption = 'Agiliza'#231#227'o de Processos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object mnuAcoes: TMenuItem
      Caption = '&A'#231#245'es'
      object mnuModelosXPecas: TMenuItem
        Action = actModelosXPecas
        Caption = 'Especifica'#231#245'es - Associa'#231#227'o de &Modelos x Pe'#231'as'
      end
      object mnuCargaBematech: TMenuItem
        Action = actCargaBematech
        Visible = False
      end
    end
    object mnuUtilitarios: TMenuItem
      Caption = '&Utilit'#225'rios'
      object mnuConfiguracoes: TMenuItem
        Action = actConfiguracoes
      end
      object mnuTesteCriptografia: TMenuItem
        Action = actTesteCriptografia
      end
    end
  end
  object ActionList1: TActionList
    Left = 48
    Top = 8
    object actModelosXPecas: TAction
      Category = 'Acoes'
      Caption = 'Descritores - Associa'#231#227'o de &Modelos x Pe'#231'as'
      OnExecute = actModelosXPecasExecute
    end
    object actTesteCriptografia: TAction
      Category = 'Utilitarios'
      Caption = '&Teste de Criptografia'
      OnExecute = actTesteCriptografiaExecute
    end
    object actConfiguracoes: TAction
      Category = 'Utilitarios'
      Caption = '&Configuracoes'
      OnExecute = actConfiguracoesExecute
    end
    object actCargaBematech: TAction
      Category = 'Acoes'
      Caption = 'Carga Bematech'
      OnExecute = actCargaBematechExecute
    end
  end
end
