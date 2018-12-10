object DM: TDM
  OldCreateOrder = False
  Left = 489
  Top = 188
  Height = 537
  Width = 619
  object dbExcel: TADOConnection
    ConnectionTimeout = 900
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object qryPlanilha: TADOQuery
    Connection = dbExcel
    Parameters = <>
    SQL.Strings = (
      'select * from "1$"')
    Left = 152
    Top = 16
  end
  object dbSQLServer: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI.1;Persist Security Info=False;User ID=sa;Initia' +
      'l Catalog=ABACOS;Data Source=192.168.130.10;'
    ConnectionTimeout = 900
    LoginPrompt = False
    Provider = 'SQLNCLI.1'
    Left = 32
    Top = 72
  end
  object qryBuscaCodigoDescritor: TADOQuery
    Connection = dbSQLServer
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'NOM_DESCRITOR'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 100
        Size = 100
        Value = Null
      end>
    SQL.Strings = (
      'SELECT DS1.DES1_COD AS '#39'COD_DESCRITOR'#39
      'FROM TCOM_DES1PR DS1 '
      'WHERE RTRIM(LTRIM(DS1.DES1_NME)) = :NOM_DESCRITOR')
    Left = 152
    Top = 72
  end
  object qryBuscaCodigoProduto: TADOQuery
    Connection = dbSQLServer
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'COD_EXT_PRODUTO'
        Attributes = [paNullable]
        DataType = ftString
        Precision = 15
        Size = 15
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PROD.PROS_COD AS '#39'COD_PRODUTO'#39
      'FROM TCOM_PROSER PROD'
      'WHERE LTRIM(RTRIM(PROD.PROS_EXT_COD)) = :COD_EXT_PRODUTO')
    Left = 152
    Top = 120
  end
  object qryBuscaProdutoDescritor: TADOQuery
    Connection = dbSQLServer
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'COD_DESCRITOR'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COD_PRODUTO'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'DP1.DES1_COD'
      'FROM'
      #9'TCOM_DEP1PR DP1'
      'WHERE'
      #9'DP1.DES1_COD = :COD_DESCRITOR'
      #9'AND DP1.PROS_COD = :COD_PRODUTO'
      '')
    Left = 152
    Top = 168
  end
  object spInsereNovoDescritor1: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DES1PR'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDES1_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES1_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@pDES1_CHR_SN_SELPDS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDESG_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES1_DAT_FIM'
        Attributes = [paNullable]
        DataType = ftDateTime
        Direction = pdInputOutput
        Value = Null
      end>
    Left = 312
    Top = 72
  end
  object qryInserirRelacaoDescritorProduto: TADOQuery
    Connection = dbSQLServer
    Parameters = <
      item
        Name = 'COD_PRODUTO'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COD_DESCRITOR'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO TCOM_DEP1PR (PROS_COD, DES1_COD)'
      ' VALUES (:COD_PRODUTO, :COD_DESCRITOR)')
    Left = 152
    Top = 216
  end
  object spInserirDEEPR1: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DEE1PR;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDEE1_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pPROS_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDEE1_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end>
    Left = 448
    Top = 72
  end
  object spInsereNovoDescritor2: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DES2PR;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDES2_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES2_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@pDES2_CHR_SN_SELPDS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDESG_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES2_DAT_FIM'
        Attributes = [paNullable]
        DataType = ftDateTime
        Direction = pdInputOutput
        Value = Null
      end>
    Left = 312
    Top = 120
  end
  object spInsereNovoDescritor3: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DES3PR;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDES3_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES3_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@pDES3_CHR_SN_SELPDS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDESG_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDES3_DAT_FIM'
        Attributes = [paNullable]
        DataType = ftDateTime
        Direction = pdInputOutput
        Value = Null
      end>
    Left = 312
    Top = 168
  end
  object spInserirDEEPR2: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DEE2PR;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDEE2_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pPROS_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDEE2_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end>
    Left = 448
    Top = 120
  end
  object spInserirDEEPR3: TADOStoredProc
    Connection = dbSQLServer
    ProcedureName = 'PCOM_C_DEE3PR;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@pACAO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@pDEE3_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@pPROS_COD'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@pDEE3_NME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end>
    Left = 448
    Top = 168
  end
  object dbAccess: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=L:\Projetos\Polipar' +
      'tes\Agilizacao de Processos\Src\Bin\Carga Bematech\CARGA.mdb;Per' +
      'sist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 320
  end
  object qryDadosParaBematech: TADOQuery
    Connection = dbSQLServer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'ID_PRODUTO,'
      #9'NOM_PRODUTO,'
      #9'COD_POLIPARTES,'
      #9'COD_UNIDADE,'
      #9'NOM_UNIDADE,'
      #9'SIG_UNIDADE,'
      #9'VAL_PRECO,'
      #9'CASE WHEN IND_ERRO = '#39'N'#39' THEN'
      
        #9#9'CASE WHEN LEN(COD_BARRAS) > 12 THEN SUBSTRING(COD_BARRAS,2,12)' +
        ' ELSE COD_BARRAS END'
      #9'ELSE'
      #9#9'COD_BARRAS'
      #9'END AS '#39'COD_BARRAS'#39','
      #9'IND_ERRO'
      'FROM'
      #9'('
      #9'SELECT'
      #9#9'PROD.PROS_COD AS '#39'ID_PRODUTO'#39','
      
        #9#9'UPPER(DBO.FN_REMOVE_CARACTERES_ESPECIAIS(PROD.PROS_NOM_RED)) A' +
        'S '#39'NOM_PRODUTO'#39','
      #9#9'PROD.PROS_EXT_COD AS '#39'COD_POLIPARTES'#39','
      #9#9'UNIDADE.UNIP_COD AS '#39'COD_UNIDADE'#39','
      #9#9'UNIDADE.UNIP_NOM AS '#39'NOM_UNIDADE'#39','
      #9#9'UNIDADE.UNIP_ABR AS '#39'SIG_UNIDADE'#39','
      #9#9'(SELECT TOP 1 PRECO.PROL_VAL_PRE'
      #9#9#9'  '#9#9#9#9'   FROM TCOM_PROLIS PRECO'
      #9#9#9#9#9#9#9'   WHERE PRECO.PROS_COD = PROD.PROS_COD'
      #9#9#9#9#9#9#9'   ORDER BY PRECO.PROL_DAT_ALT DESC, PRECO.PROL_DAT_CAD'
      #9#9#9#9#9#9#9'   ) AS VAL_PRECO,'
      #9#9'CASE WHEN ISNUMERIC(PROD.PROS_BAR) = 1 THEN'
      #9#9#9'CAST(CAST(LTRIM(RTRIM(PROD.PROS_BAR)) AS BIGINT) AS VARCHAR)'
      #9#9'ELSE'
      #9#9#9'PROD.PROS_BAR'
      #9#9'END AS '#39'COD_BARRAS'#39','
      #9#9'CASE WHEN ISNUMERIC(LTRIM(RTRIM(PROD.PROS_BAR))) = 1 THEN'
      #9#9#9#39'N'#39
      #9#9'ELSE'
      #9#9#9#39'S'#39
      #9#9'END AS '#39'IND_ERRO'#39
      #9'FROM'
      #9#9'TCOM_PROSER PROD'
      
        #9#9'INNER JOIN TCOM_UNIPRO UNIDADE ON UNIDADE.UNIP_COD = PROD.UNIP' +
        '_COD'
      #9'WHERE'
      #9#9'PROD.PROS_DAT_FIM IS NULL'
      '    --and  PROD.PROS_BAR like '#39'%896500807538%'#39
      #9') AS TB_AUX'
      'ORDER BY'
      '  NOM_PRODUTO')
    Left = 152
    Top = 264
    object qryDadosParaBematechID_PRODUTO: TIntegerField
      DisplayLabel = 'ID Produto'
      FieldName = 'ID_PRODUTO'
    end
    object qryDadosParaBematechNOM_PRODUTO: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NOM_PRODUTO'
      ReadOnly = True
      Size = 100
    end
    object qryDadosParaBematechCOD_POLIPARTES: TStringField
      DisplayLabel = 'C'#243'd. Polipartes'
      FieldName = 'COD_POLIPARTES'
      FixedChar = True
      Size = 15
    end
    object qryDadosParaBematechCOD_UNIDADE: TIntegerField
      FieldName = 'COD_UNIDADE'
      Visible = False
    end
    object qryDadosParaBematechNOM_UNIDADE: TStringField
      FieldName = 'NOM_UNIDADE'
      Visible = False
      FixedChar = True
      Size = 50
    end
    object qryDadosParaBematechSIG_UNIDADE: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'SIG_UNIDADE'
      FixedChar = True
      Size = 3
    end
    object qryDadosParaBematechVAL_PRECO: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'VAL_PRECO'
      ReadOnly = True
    end
    object qryDadosParaBematechCOD_BARRAS: TStringField
      DisplayLabel = 'C'#243'd.Barras'
      FieldName = 'COD_BARRAS'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object qryDadosParaBematechIND_ERRO: TStringField
      DisplayLabel = 'Erro ?'
      FieldName = 'IND_ERRO'
      ReadOnly = True
      Size = 1
    end
  end
  object qryApagarDadosBematechAccess: TADOQuery
    Connection = dbAccess
    Parameters = <>
    SQL.Strings = (
      'DELETE FROM TB_PRODUTO_ABACOS')
    Left = 152
    Top = 320
  end
  object qryInserirDadosBematechAccess: TADOQuery
    Connection = dbAccess
    Parameters = <>
    Left = 152
    Top = 368
  end
  object dbFirebird: TSQLConnection
    ConnectionName = 'FirebirdConnection'
    DriverName = 'UIB FireBird15'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpUIBfire15.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=UIB FireBird15'
      'BlobSize=-1'
      'CommitRetain=False'
      'Database=localhost:c:\Sys\Base\MILLENIUM'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=masterkey'
      'RoleName=RoleName'
      'ServerCharSet='
      'SQLDialect=3'
      'Interbase TransIsolation=ReadCommited'
      'User_Name=SYSDBA'
      'WaitOnLocks=True')
    VendorLib = 'fbclient.dll'
    Left = 304
    Top = 240
  end
end
