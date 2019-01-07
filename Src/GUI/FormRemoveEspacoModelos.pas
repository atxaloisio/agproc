unit FormRemoveEspacoModelos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, DB, ADODB, SqlExpr, DBXpress, ExtCtrls;

type
  TfrmUtilRemoveEspacoBase = class(TForm)
    btnCancelar: TButton;
    progresso: TGauge;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    cancelou: Boolean;
    function getContagemModelos: Integer;
    function AtualizaModelos(codigoModelo: Integer; modelos: string): Boolean;
  public
    { Public declarations }
    procedure processarRegistros;
    procedure removerRegistrosDuplicados;
  end;

var
  frmUtilRemoveEspacoBase: TfrmUtilRemoveEspacoBase;

implementation

uses
  DataModule, Configuracoes, Peca, ADOInt, Modelo;

{$R *.dfm}

function TfrmUtilRemoveEspacoBase.AtualizaModelos(codigoModelo: Integer;
  modelos: string): Boolean;
begin
  try
    try
      result := false;
      // aqui
      dm.qryInserirRelacaoDescritorProduto.SQL.Clear;
      dm.qryInserirRelacaoDescritorProduto.SQL.ADD('UPDATE ESPEC_PRODUTOS SET DESCRICAO = ' + QuotedStr(modelos));
      dm.qryInserirRelacaoDescritorProduto.SQL.ADD(' WHERE ESPEC_PRODUTO = ' + IntToStr(codigoModelo));
      // até aqui

      dm.qryInserirRelacaoDescritorProduto.ExecSQL;

      result := true;

    except
      on e: Exception do
      begin
        result := false;
        raise Exception.Create('Erro ao atualizar a relação do produto a especificação de modelo ' + ': ' + e.Message);
      end;
    end;
  finally
//    dm.qryInserirRelacaoDescritorProduto.Close;
    dm.qryInserirRelacaoDescritorProduto.Close;
  end;
end;

procedure TfrmUtilRemoveEspacoBase.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
end;

function TfrmUtilRemoveEspacoBase.getContagemModelos: Integer;
var
  retorno: Integer;
begin
  retorno := 0;
  try
    DM.qryModeloContagem.Close;
    DM.qryModeloContagem.SQL.Clear;
    DM.qryModeloContagem.SQL.Text := 'SELECT COUNT(ESPEC_PRODUTO) AS CONTAGEM FROM ESPEC_PRODUTOS WHERE ESPECIFICACAO = 7 AND DESCRICAO IS NOT NULL';
    DM.qryModeloContagem.Open;

    if DM.qryModeloContagem.IsEmpty then
      retorno := 0
    else
      retorno := DM.qryModeloContagem.fieldbyname('CONTAGEM').AsInteger;

    Result := retorno;
  finally
    DM.qryModeloContagem.Close;
  end;

end;

procedure TfrmUtilRemoveEspacoBase.btnCancelarClick(Sender: TObject);
begin
  cancelou := True;
end;

procedure TfrmUtilRemoveEspacoBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.DesconectarFirebird;
  Action := caFree;
end;

procedure TfrmUtilRemoveEspacoBase.FormCreate(Sender: TObject);
begin
  DM.ConectarFirebird(Configuracao.Servidor, Configuracao.banco, Configuracao.Usuario, Configuracao.Senha);
end;

procedure TfrmUtilRemoveEspacoBase.processarRegistros;
var
  nrRegs: Integer;
  index: Integer;
  listaModelos: TStringList;
  Trans: TTransactionDesc;
begin
  Self.Show;
  try
    try
      Timer1.Enabled := False;
      nrRegs := getContagemModelos;
      progresso.MaxValue := nrRegs;
      progresso.MinValue := 0;
      index := 0;
      Screen.Cursor := crHourGlass;

      DM.qryObterTodosModelosDB.Close;
      DM.qryObterTodosModelosDB.SQL.Clear;
      DM.qryObterTodosModelosDB.SQL.Text := 'SELECT ESPEC_PRODUTO, DESCRICAO FROM ESPEC_PRODUTOS WHERE ESPECIFICACAO = 7 AND DESCRICAO IS NOT NULL';
      DM.qryObterTodosModelosDB.Open;
      DM.qryObterTodosModelosDB.First;

      while not DM.qryObterTodosModelosDB.Eof do
      begin
        if (cancelou) then
        begin
          Screen.Cursor := crDefault;
          if (MessageDlg('Cancelar o processamento dos modelos?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          begin
            Exit;
          end;
        end
        else
        begin
          cancelou := False;
          Screen.Cursor := crHourGlass;
        end;
        inc(index);
        Trans.TransactionID := 1;
        Trans.IsolationLevel := xilREADCOMMITTED;
        progresso.Progress := index;
        listaModelos := TStringList.Create;
        listaModelos.CommaText := trim(DM.qryObterTodosModelosDB.fieldbyname('DESCRICAO').AsString);
        listaModelos.Delimiter := ',';
        Application.ProcessMessages;
        DM.dbFirebird.StartTransaction(Trans);
        AtualizaModelos(DM.qryObterTodosModelosDB.fieldbyname('ESPEC_PRODUTO').AsInteger, listaModelos.CommaText);
        DM.dbFirebird.Commit(Trans);
        FreeAndNil(listaModelos);
        DM.qryObterTodosModelosDB.Next;
        Application.ProcessMessages;
      end;

      ShowMessage('Registros atualizados com sucesso!');

      Close;

    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao atualizar a relação do produto a especificação de modelo ' + ': ' + e.Message);
      end;
    end;
  finally
    DM.qryObterTodosModelosDB.Close;
    Screen.Cursor := crDefault;
  end;

end;

procedure TfrmUtilRemoveEspacoBase.Timer1Timer(Sender: TObject);
begin
  processarRegistros;
end;

procedure TfrmUtilRemoveEspacoBase.removerRegistrosDuplicados;
var
  nrRegs: Integer;
  index, interador: Integer;
  listaModelos, listaGrava: TStringList;
  Trans: TTransactionDesc;
begin
  Self.Show;
  try
    try
      Timer1.Enabled := False;
      nrRegs := getContagemModelos;
      progresso.MaxValue := nrRegs;
      progresso.MinValue := 0;
      index := 0;
      Screen.Cursor := crHourGlass;

      DM.qryObterTodosModelosDB.Close;
      DM.qryObterTodosModelosDB.SQL.Clear;
      DM.qryObterTodosModelosDB.SQL.Text := 'SELECT ESPEC_PRODUTO, DESCRICAO FROM ESPEC_PRODUTOS WHERE ESPECIFICACAO = 7 AND DESCRICAO IS NOT NULL';
      DM.qryObterTodosModelosDB.Open;
      DM.qryObterTodosModelosDB.First;

      while not DM.qryObterTodosModelosDB.Eof do
      begin
        if (cancelou) then
        begin
          Screen.Cursor := crDefault;
          if (MessageDlg('Cancelar o processamento dos modelos?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          begin
            Exit;
          end;
        end
        else
        begin
          cancelou := False;
          Screen.Cursor := crHourGlass;
        end;
        inc(index);
        Trans.TransactionID := 1;
        Trans.IsolationLevel := xilREADCOMMITTED;
        progresso.Progress := index;

        listaModelos := TStringList.Create;
        listaModelos.CommaText := trim(DM.qryObterTodosModelosDB.fieldbyname('DESCRICAO').AsString);
        listaModelos.Delimiter := ',';

        listaGrava := TStringList.Create;

        for interador := 0 to pred(listaModelos.Count) do
        begin
          if listaGrava.IndexOf(listaModelos.Strings[interador]) = -1 then
            listaGrava.Add(listaModelos.Strings[interador]);
        end;

        Application.ProcessMessages;
        if listaGrava.Count > 0 then
        begin
          DM.dbFirebird.StartTransaction(Trans);
          AtualizaModelos(DM.qryObterTodosModelosDB.fieldbyname('ESPEC_PRODUTO').AsInteger, listaGrava.CommaText);
          DM.dbFirebird.Commit(Trans);
        end;

        FreeAndNil(listaModelos);
        FreeAndNil(listaGrava);
        DM.qryObterTodosModelosDB.Next;
        Application.ProcessMessages;
      end;

      ShowMessage('Registros atualizados com sucesso!');

      Close;

    except
      on e: Exception do
      begin
        raise Exception.Create('Erro ao atualizar a relação do produto a especificação de modelo ' + ': ' + e.Message);
      end;
    end;
  finally
    DM.qryObterTodosModelosDB.Close;
    Screen.Cursor := crDefault;
  end;

end;

end.

