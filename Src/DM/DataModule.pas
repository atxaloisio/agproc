unit DataModule;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs, DBXpress, SqlExpr, FMTBcd;

type
  TDM = class(TDataModule)
    dbExcel: TADOConnection;
    qryPlanilha: TADOQuery;
    dbSQLServer: TADOConnection;
    qryBuscaCodigoDescritor_: TADOQuery;
    qryBuscaCodigoProduto_: TADOQuery;
    qryBuscaProdutoDescritor_: TADOQuery;
    spInsereNovoDescritor1: TADOStoredProc;
    qryInserirRelacaoDescritorProduto_: TADOQuery;
    spInserirDEEPR1: TADOStoredProc;
    spInsereNovoDescritor2: TADOStoredProc;
    spInsereNovoDescritor3: TADOStoredProc;
    spInserirDEEPR2: TADOStoredProc;
    spInserirDEEPR3: TADOStoredProc;
    dbAccess: TADOConnection;
    qryDadosParaBematech: TADOQuery;
    qryDadosParaBematechID_PRODUTO: TIntegerField;
    qryDadosParaBematechNOM_PRODUTO: TStringField;
    qryDadosParaBematechCOD_POLIPARTES: TStringField;
    qryDadosParaBematechCOD_UNIDADE: TIntegerField;
    qryDadosParaBematechNOM_UNIDADE: TStringField;
    qryDadosParaBematechSIG_UNIDADE: TStringField;
    qryDadosParaBematechVAL_PRECO: TFloatField;
    qryDadosParaBematechCOD_BARRAS: TStringField;
    qryDadosParaBematechIND_ERRO: TStringField;
    qryApagarDadosBematechAccess: TADOQuery;
    qryInserirDadosBematechAccess: TADOQuery;
    dbFirebird: TSQLConnection;
    qryBuscaCodigoDescritor: TSQLQuery;
    qryBuscaCodigoProduto: TSQLQuery;
    qryBuscaProdutoDescritor: TSQLQuery;
    qryInserirRelacaoDescritorProduto: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    Function ConectarExcel (diretorio, arquivo: String; var tabelas: TStringList): Boolean;
    Function DesconectaExcel: Boolean;
    Function AbrirPlanilha (nomePlanilha: String): Boolean;
    Function FecharPlanilha: Boolean;
    Function ConectarSQLServer (host, banco, usuario, senha: String): Boolean;
    Function ConectarFirebird (host, banco, usuario, senha: String): Boolean;
    Procedure DesconectarSQLServer;
    Procedure DesconectarFirebird;
    Function ConectarAccess (banco: String): Boolean;
    Procedure DesconectarAccess;
    Function ApagarDadosBematechAccess: Boolean;
    Function InserirDadosBematechAccess (codBarras, nomProduto: String; valPreco: Currency): Boolean;
  end;

var
  DM: TDM;

Const

//  fConnectionStringExcel : String = 'Provider=MSDASQL;' +
//                                    'Persist Security Info=False;' +
//                                    'Extended Properties="DBQ=%planilha%;' +
//                                    'DefaultDir=%diretorio%;' +
//                                    'Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};' +
//                                    'DriverId=1046;' +
//                                    'FIL=excel 12.0;' +
//                                    'MaxBufferSize=2048;' +
//                                    'MaxScanRows=8;' +
//                                    'PageTimeout=5;' +
//                                    'ReadOnly=1;' +
//                                    'SafeTransactions=0;' +
//                                    'Threads=3;' +
//                                    'UID=admin;' +
//                                    'UserCommitSync=Yes;"';

  fConnectionStringExcel : String = 'Provider=Microsoft.ACE.OLEDB.12.0;' +
                                    'Data Source=%planilha%;' +
                                    'Extended Properties="Excel 12.0 Xml;' +
                                    'HDR=YES;' +
                                    'ReadOnly=1;' +
                                    'SafeTransactions=0;' +
                                    'Threads=3;' +
                                    'UID=admin;' +
                                    'UserCommitSync=Yes;"';
                                    

  fConnectionStringSQLServer : String = 'Description=SQLServer;' +
                                        'DRIVER=SQL Server Native Client 10.0;' +
                                        'SERVER=%host%;' +
                                        'UID=%usuario%;' +
                                        'PWD=%senha%;' +
                                        'DATABASE=%banco%;' +
                                        'PROVIDER=SQLNCLI10;';

  fConnectionStringAccess : String = 'Provider=Microsoft.Jet.OLEDB.4.0;' +
                                     'Data Source=%banco%;' +
                                     'Persist Security Info=False';

  implementation

uses Configuracoes;

{$R *.dfm}

Function TDM.ApagarDadosBematechAccess: Boolean;
begin
  result := false;
  try
    qryApagarDadosBematechAccess.ExecSQL;
    result := true;
  except
    On e:Exception
      do e.Create('Erro ao apagar dados da tabela temporária do access: ' + e.Message);
  end;
end;

function TDM.ConectarAccess (banco: String): Boolean;
var connAux: String;
begin
  try
    dbAccess.Connected := False;
    connAux := fConnectionStringAccess;
    connAux := StringReplace(connAux, '%banco%', banco, [rfReplaceAll, rfIgnoreCase]);
    dbAccess.ConnectionString := connAux;
    dbAccess.Connected := True;
    result := True;
  except
    On e : Exception do
    begin
      Raise Exception.Create('Erro na conexão com o Access: ' + e.Message);
      dbSQLServer.Connected := False;
      result := False;
    end;
  end;
end;

function TDM.ConectarExcel(diretorio, arquivo: String;
  var tabelas: TStringList): Boolean;
var connAux, aux, adicionadas: String;
    i: Integer;
    tabelasAux: TStringList;
begin
  try
    dbExcel.Connected := False;
    connAux := fConnectionStringExcel;
    connAux := StringReplace(connAux, '%planilha%', diretorio + arquivo, [rfReplaceAll, rfIgnoreCase]);
//    connAux := StringReplace(connAux, '%diretorio%', diretorio, [rfReplaceAll, rfIgnoreCase]);
    dbExcel.ConnectionString := connAux;
    dbExcel.Connected := True;

    // Pegar a lita de planilhas existentes no Excel
    adicionadas := '';
    tabelasAux := TStringList.Create;
    tabelas := TStringList.Create;
    dbExcel.GetTableNames(tabelasAux, False);
    for i := 0 to tabelasAux.Count - 1 do
    begin
      aux := StringReplace(tabelasAux.Strings[0],#39,'"',[rfReplaceAll, rfIgnoreCase]);
      if Pos(aux, adicionadas) = 0 then
      begin
        tabelas.Add (aux);
        adicionadas := adicionadas + '##' + aux;
      end;
    end;
    tabelasAux.Clear;
    tabelasAux.Free;

    result := True;
  except
    On e : Exception do
    begin
      Raise Exception.Create('Erro na carga do arquivo ' + arquivo + ': ' + e.Message);
      dbExcel.Connected := False;
      result := False;
    end;
  end;
end;

function TDM.ConectarSQLServer(host, banco, usuario, senha: String): Boolean;
var connAux: String;
begin
  try
    ShowMessage(dbFirebird.Params.CommaText);
    dbFirebird.Params.SaveToFile('c:\projetos\luciano\parametros.txt');
    dbSQLServer.Connected := False;
    connAux := fConnectionStringSQLServer;
    connAux := StringReplace(connAux, '%host%', host, [rfReplaceAll, rfIgnoreCase]);
    connAux := StringReplace(connAux, '%banco%', banco, [rfReplaceAll, rfIgnoreCase]);
    connAux := StringReplace(connAux, '%usuario%', usuario, [rfReplaceAll, rfIgnoreCase]);
    connAux := StringReplace(connAux, '%senha%', senha, [rfReplaceAll, rfIgnoreCase]);
    dbSQLServer.ConnectionString := connAux;
//    dbSQLServer.Connected := True;
    result := True;
  except
    On e : Exception do
    begin
      Raise Exception.Create('Erro na conexão com o Firebird: ' + e.Message);
      dbSQLServer.Connected := False;
      result := False;
    end;
  end;
end;

function TDM.DesconectaExcel: Boolean;
begin
  try
    dbExcel.Connected := False;
    result := True;
  except
    on e : Exception do
    begin
      Raise Exception.Create('Erro na abertura do arquivo excel : ' + e.Message);
      result := False;
    end;
  end;
end;

procedure TDM.DesconectarAccess;
begin
  dbAccess.Close;
end;

procedure TDM.DesconectarSQLServer;
begin
  dbSQLServer.Close;
end;

function TDM.FecharPlanilha: Boolean;
begin
  try
    qryPlanilha.Close;
    result := True;
  except
    on e : Exception do
    begin
      Raise Exception.Create('Erro ao fechar planilha: ' + e.Message);
      result := False;
    end;
  end;
end;

function TDM.InserirDadosBematechAccess(codBarras, nomProduto: String; valPreco: Currency): Boolean;
begin
  result := False;
  try
    dm.qryInserirDadosBematechAccess.SQL.Clear;
    dm.qryInserirDadosBematechAccess.SQL.Add ('INSERT INTO TB_PRODUTO_ABACOS (COD_BARRAS, NOM_PRODUTO, VAL_PRECO) VALUES (');
    dm.qryInserirDadosBematechAccess.SQL.Add ('''' + codBarras + ''',' + '''' + nomProduto + ''',' + FloatToStr(valPreco) + ')');
    dm.qryInserirDadosBematechAccess.ExecSQL;
    result := True;
  except
    on e:Exception do
      e.Create('Erro ao inserir produto no Access: ' + #13#13 + ' - Cód. Barras: ' + codBarras + #13 + ' - Nome do Produto: ' + nomProduto +
        #13 + '- Preço: ' + FloatToStr(valPreco) + #13#13 + 'Erro: ' + e.Message);
  end;
end;

function TDM.AbrirPlanilha(nomePlanilha: String): Boolean;
begin
  try
    qryPlanilha.Close;
    qryPlanilha.SQL.Clear;
    qryPlanilha.SQL.Add('Select * From ' + nomePlanilha);
    qryPlanilha.Open;
    result := True;
  except
    result := False;
  end;
end;

function TDM.ConectarFirebird(host, banco, usuario,
  senha: String): Boolean;
var connAux: TStrings;
begin
  try
    connAux := dbFirebird.Params;
//    ShowMessage(IntToStr(connAux.IndexOfName('Database')));
//    ShowMessage(connAux.ValueFromIndex[connAux.IndexOfName('Database')]);

    connAux.Values['Database'] := host + '/3050:' + banco;
    connAux.Values['User_Name'] := usuario;
    connAux.Values['Password'] := senha;

    dbFirebird.Open;
    if (dbFirebird.Connected) then
    begin
//      ShowMessage('Firebird conectado!');
      Result := True;
    end
    else
    begin
//      ShowMessage('Firebird não conectado!');
      Result := False;
    end;

//    dbFirebird.Params.SaveToFile('c:\projetos\luciano\parametros.txt');
//    dbSQLServer.Connected := False;
//    connAux := fConnectionStringSQLServer;
//    connAux := StringReplace(connAux, '%host%', host, [rfReplaceAll, rfIgnoreCase]);
//    connAux := StringReplace(connAux, '%banco%', banco, [rfReplaceAll, rfIgnoreCase]);
//    connAux := StringReplace(connAux, '%usuario%', usuario, [rfReplaceAll, rfIgnoreCase]);
//    connAux := StringReplace(connAux, '%senha%', senha, [rfReplaceAll, rfIgnoreCase]);
//    dbSQLServer.ConnectionString := connAux;
//    dbSQLServer.Connected := True;
//    result := True;
  except
    On e : Exception do
    begin
      Raise Exception.Create('Erro na conexão com o Firebird: ' + e.Message);
      dbFirebird.Connected := False;
      result := False;
    end;
  end;
end;

procedure TDM.DesconectarFirebird;
begin
  Self.dbFirebird.Close;
end;

end.
