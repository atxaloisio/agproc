unit FormModelosXPecas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Hashes, ComCtrls, ExtCtrls, Grids, Constantes, DB,
  ADODB, SqlExpr, DBXpress;

type
  TfrmModelosXPecas = class(TForm)
    GroupBox1: TGroupBox;
    edtPastaOrigem: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPastaDestino: TEdit;
    clbArquivos: TCheckListBox;
    Label3: TLabel;
    btnLerArquivo: TButton;
    panProgresso: TPanel;
    pbProcessamento: TProgressBar;
    lblMsg: TLabel;
    pcPlanilhas: TPageControl;
    btnCancelar: TButton;
    btnProcessar: TButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    ckbPecasSemModelos: TCheckBox;
    ckbProcessesarSelecionado: TCheckBox;
    ckbProdutosNaoCadastrados: TCheckBox;
    ckbLimitarLista: TCheckBox;
    edtQtdLinhas: TEdit;
    GroupBox4: TGroupBox;
    label50: TLabel;
    lblPNC: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLerArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ckbLimitarListaClick(Sender: TObject);
    procedure edtQtdLinhasExit(Sender: TObject);
  private
    { Private declarations }
    listaGrades: TList;
    listaListas: TList;
    lista: TList;
    listaPlanihas: TStringList;
    listaModelos: TIntegerHash;
    cancelou: Boolean;
    linhaSelecionada: Longint;
    recarregarPlanilhas: Boolean;
    procedure ListarArquivos(Diretorio: string; Sub: Boolean);
    function TemAtributo(Attr, Val: Integer): Boolean;
    function PegarCodigoDescritor(nDesc: Integer; nomeDescritor: string; var codigoObtido: Integer): string;
    function PegarCodigoProduto(codExtProduto: string; var codigoObtido: Integer): string;
    function PegarProdutoAssociadoDescritor(codProduto, codDescritor: Integer): Integer;
    function InserirNovoDescritor(nDesc: Integer; nomeDescritor: string; var codigoNovoDescritor: Integer): Boolean;
    function InserirRelacaoProdutoDescritor(codigoProduto, codigoDescritor: Integer; modelos: string): Boolean;
    function AtualizaRelacaoProdutoDescritor(codigoModelo: Integer; modelos: string): Boolean;
    function InserirDEEPR(nDesc: Integer; codigoProduto: Integer; nomeDescritor: string): Boolean;
    procedure MoverPlanilhasProcessadas;
  public
    { Public declarations }
  end;

var
  frmModelosXPecas: TfrmModelosXPecas;

implementation

uses
  DataModule, Configuracoes, Peca, ADOInt, Modelo;

{$R *.dfm}

procedure TfrmModelosXPecas.btnCancelarClick(Sender: TObject);
begin
  cancelou := True;
end;

procedure TfrmModelosXPecas.btnCancelarMouseEnter(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TfrmModelosXPecas.btnCancelarMouseLeave(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
end;

procedure TfrmModelosXPecas.btnLerArquivoClick(Sender: TObject);
var
  peca: TProduto;
  codigo, descricao, modelos, nomeArquivo, legenda, sitDescXProduto: string;
  NodePeca: TTreeNode;
  t, linha, coluna, nPlan, a, nCampo, codDescritor, x, codigoProduto: Integer;
  Tab: TTabSheet;
  Grid: TStringGrid;
  tabelas: TStringList;
  ocorreuErro: Boolean;
  m1: TModelo;
  qtdArqChecado, q, nDescritor: Integer;
  nomeModeloAux: string;
  qtdPNC, qtdCPD, qtdDNC, qtdCDD, qtdDNP, qtdDEP, qtdDDP: Integer;
  log: TextFile;
  nomelog: string;
begin
  cancelou := False;

  nomelog := 'LOG_IMPORTACAO_' + StringReplace(DateTimeToStr(Now), '/', '_', [rfReplaceAll, rfIgnoreCase]);
  nomelog := StringReplace(nomelog, ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  nomelog := StringReplace(nomelog, ':', '', [rfReplaceAll, rfIgnoreCase]);

  if Configuracao.PastaLogs = '' then
    Configuracao.PastaLogs := ExtractFilePath(Application.ExeName);

  AssignFile(log, Configuracao.PastaLogs + nomelog);
  Rewrite(log);

  qtdPNC := 0;
  qtdCPD := 0;
  qtdDNC := 0;
  qtdCDD := 0;
  qtdDNP := 0;
  qtdDEP := 0;
  qtdDDP := 0;

  qtdArqChecado := 0;
  for q := 0 to clbArquivos.Count - 1 do
    if clbArquivos.Checked[q] then
      Inc(qtdArqChecado);

  if qtdArqChecado = 0 then
  begin
    MessageDlg('Selecione um arquivo para processar.', mtInformation, [mbOk], 0);
    Exit;
  end;

  if qtdArqChecado > 1 then
  begin
    MessageDlg('Nesta versão inicial, por questões de segurança, está desabilitado o processamento de múltiplos arquivos.', mtInformation, [mbOk], 0);
    Exit;
  end;

  clbArquivos.Enabled := False;

  try

    btnLerArquivo.Enabled := False;
    Screen.Cursor := crHourGlass;

    try
      ocorreuErro := False;
      cancelou := False;

      // Limpar ambiente

      panProgresso.Visible := True;
      lblMsg.Caption := 'Limpando ambiente . . . ';
      Application.ProcessMessages;

      pbProcessamento.Min := 0;
      pbProcessamento.Position := 0;
      pbProcessamento.Max := pcPlanilhas.PageCount + listaGrades.Count + listaListas.Count + 1;

      // Limpar paginas do page control

      while pcPlanilhas.PageCount > 0 do
      begin
        pcPlanilhas.Pages[0].Destroy;
        pbProcessamento.Position := pbProcessamento.Position + 1;
        Application.ProcessMessages;
      end;

      // Limpar grids

      while listaGrades.Count > 0 do
      begin
        listaGrades.Delete(0);
        pbProcessamento.Position := pbProcessamento.Position + 1;
        Application.ProcessMessages;
      end;

      // Limpar Listas

      while listaListas.Count > 0 do
      begin
        listaListas.Delete(0);
        pbProcessamento.Position := pbProcessamento.Position + 1;
        Application.ProcessMessages;
      end;

      listaPlanihas.Clear;
      pbProcessamento.Position := pbProcessamento.Position + 1;
      Application.ProcessMessages;

      for t := 0 to clbArquivos.Count - 1 do
      begin

        if not clbArquivos.Checked[t] then
          Continue;

        // Limpar descritores encontrados no processamento anterior, podem ser diferentes...

        lblMsg.Caption := 'Limpando lista de descritores para um novo processamento . . . ';
        Application.ProcessMessages;

        pbProcessamento.Max := listaModelos.ItemCount;
        pbProcessamento.Min := 0;
        pbProcessamento.Position := 0;
        listaModelos.Restart;
        while listaModelos.Next do
        begin
          listaModelos.Delete(listaModelos.CurrentKey);
          listaModelos.Restart;
          pbProcessamento.Position := pbProcessamento.Position + 1;
          Application.ProcessMessages;
        end;

        nomeArquivo := clbArquivos.Items.Strings[t];

        Tab := TTabSheet.Create(pcPlanilhas);
        Tab.Parent := pcPlanilhas;
        Tab.PageControl := pcPlanilhas;
        Tab.Caption := nomeArquivo;

        Grid := TStringGrid.Create(Tab);
        Grid.Parent := Tab;
        Grid.DefaultRowHeight := 15;
        Grid.Align := alClient;
        Grid.Font.Name := 'Arial';

        Grid.Options := [goColSizing, goFixedHorzLine, goHorzLine, goVertLine, goDrawFocusSelected];

        Grid.Visible := False;

        Grid.OnDrawCell := DrawCell;
        Grid.OnSelectCell := SelectCell;

        Grid.FixedRows := 1;
        Grid.FixedCols := 0;

        Grid.Ctl3D := False;

        Grid.ColCount := 3;
        Grid.RowCount := 1;

        Grid.ColWidths[0] := 100;
        Grid.Cells[0, 0] := 'Código';

        Grid.ColWidths[1] := 350;
        Grid.Cells[1, 0] := 'Descrição';

        Grid.ColWidths[2] := 450;
        Grid.Cells[2, 0] := 'Modelos';

        linha := 1;

        lista := TList.Create;

        with DM do
        begin

          if ConectarExcel(Configuracao.PastaOrigem, nomeArquivo, tabelas) then
          begin

            // Futuramente esta validação pode ser descartada, visto que o For abaixo tratará muitas planilhas num mesmo arquivo.

            if tabelas.Count > 1 then
            begin
              ocorreuErro := True;
              raise Exception.Create('O arquivo possui ' + IntToSTr(tabelas.Count) + ' planilhas. Primeiro corrija o arquivo.');
            end;

            lblMsg.Caption := 'Processando planilha(s):  ' + nomeArquivo;

            for nPlan := 0 to tabelas.Count - 1 do
            begin

              AbrirPlanilha(tabelas.Strings[nPlan]);

              pbProcessamento.Position := 0;
              pbProcessamento.Min := 0;
              pbProcessamento.Max := qryPlanilha.RecordCount;

              qryPlanilha.First;

              while not qryPlanilha.Eof do
              begin

                if (cancelou) then
                begin
                  Screen.Cursor := crDefault;
                  if (MessageDlg('Cancelar leitura de planilhas ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
                  begin
                    recarregarPlanilhas := True;
                    Exit;
                  end;
                end
                else
                begin
                  cancelou := False;
                  Screen.Cursor := crHourGlass;
                end;

                codigo := qryPlanilha.Fields.FieldByNumber(1).AsString;
                descricao := Trim(qryPlanilha.Fields.FieldByNumber(2).AsString);
                modelos := qryPlanilha.Fields.FieldByNumber(3).AsString;

                peca := TProduto.Create(codigo, descricao, modelos);

                peca.Situacao := PegarCodigoProduto(peca.CodigoExterno, codigoProduto);

                peca.Codigo := codigoProduto;

                peca.Descricao := descricao;

                peca.Modelos := modelos;

                peca.CodigoExterno := peca.Situacao + peca.CodigoExterno;

                if codigoProduto > 0 then
                  peca.CodigoModelo := PegarProdutoAssociadoDescritor(codigoProduto, 7);

                // Acumular totalizadores

                if peca.Situacao = produtoNaoCadastrado then
                begin
                  Inc(qtdPNC);
                  Writeln(log, 'Codigo: ' + peca.CodigoExterno + ' não cadastrado.');
                end
                else if peca.Situacao = cadastroProdutoDuplicado then
                begin
                  Inc(qtdCPD);
                  Writeln(log, 'Codigo: ' + peca.CodigoExterno + ' duplicado no sistema');
                end;

                if (peca.Situacao = produtoNaoCadastrado) and (not ckbProdutosNaoCadastrados.Checked) then
                  FreeAndNil(peca)
                else
                begin

                  (* Inicio de tratamento especial *)

                  // Tratar, pois existem dois lay-outs de planilha (um com 3 colunas, sendo os
                  // modelos separados pór barra "/" e outro com várias colunas, uma para cada modelo)

                  if qryPlanilha.Fields.Count > 3 then
                    for nCampo := 4 to qryPlanilha.Fields.Count - 1 do
                    begin
                      nomeModeloAux := Trim(qryPlanilha.Fields.FieldByNumber(nCampo).AsString);
                      peca.Modelos := peca.Modelos + ', ' + nomeModeloAux;
                    end;

                  (* Fim de tratamento especial *)

                  if (peca.Modelos <> '') or (not ckbPecasSemModelos.Checked) then
                  begin
                    Grid.Cells[0, linha] := peca.CodigoExterno;
                    Grid.Cells[1, linha] := peca.Descricao;
                    Grid.Cells[2, linha] := peca.Modelos;
                    Grid.RowCount := Grid.RowCount + 1;

                    Inc(linha);

                    lista.Add(peca);

                    if (ckbLimitarLista.Checked) and (lista.Count >= StrToInt(edtQtdLinhas.Text)) then
                      Break;
                  end
                  else
                    FreeAndNil(peca);

                end;

                Application.ProcessMessages;

                qryPlanilha.Next;

                pbProcessamento.Position := pbProcessamento.Position + 1;
              end;

            end;

          end;
        end;

        //clbArquivos.Checked[t] := False;

        listaGrades.Add(Grid);

        Grid.Visible := True;

        listaListas.Add(lista);

        listaPlanihas.Add(clbArquivos.Items.Strings[t]);
      end;

      recarregarPlanilhas := False;

      lblPNC.Caption := IntToStr(qtdPNC);
//      lblCPD.Caption := IntToStr(qtdCPD);
//      lblDNC.Caption := IntToStr(qtdDNC);
//      lblCDD.Caption := IntToStr(qtdCDD);
//      lblDNP.Caption := IntToStr(qtdDNP);
//      lblDEP.Caption := IntToStr(qtdDEP);
//      lblDDP.Caption := IntToStr(qtdDDP);

    except
      on e: Exception do
      begin
        ocorreuErro := True;
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    Flush(log);
    CloseFile(log);
    dm.qryPlanilha.Close;
    panProgresso.Visible := False;
    btnLerArquivo.Enabled := True;
    Screen.Cursor := crDefault;
    if cancelou then
    begin
      listaGrades.Add(Grid);
      listaListas.Add(lista);
      listaPlanihas.Add(clbArquivos.Items.Strings[t]);
      Grid.Visible := True;
      MessageDlg('Cancelado pelo usuário!', mtInformation, [mbOk], 0);
    end
    else if not ocorreuErro then
    begin
      DM.DesconectaExcel;
      MessageDlg('Concluído!', mtInformation, [mbOk], 0)
    end
    else
      MessageDlg('Concluído sem sucesso!', mtError, [mbOk], 0);
  end;
end;

procedure TfrmModelosXPecas.btnProcessarClick(Sender: TObject);
var
  nLista, nModelo, codigoNovo, nDescritor: integer;
  nProduto, nInicial, nFinal: Longint;
  listaAtual: TList;
  modelo: TModelo;
  produto: TProduto;
  ocorreuErro: Boolean;
  Trans : TTransactionDesc;
begin
  try
    try
      if MessageDlg('Iniciar o processamento da planilha ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        Exit;

       cancelou := False;

      if listaListas.Count = 0 then
      begin
        MessageDlg('A lista de processamento está vazia. Carregue um arquivo.', mtWarning, [mbOk], 0);
        Exit;
      end;

      if (ckbProcessesarSelecionado.Checked) and (linhaSelecionada <= 0) then
      begin
        MessageDlg('Caso escolha processar somente a linha selecionada, você deve clicar na linha desejada.', mtWarning, [mbOk], 0);
        Exit;
      end;

      //if recarregarPlanilhas then
      //begin
      //  MessageDlg('Um processamento foi concluído ou interrompido. Recarregue o arquivo excel para visualizar a nova situação.',
      //    mtWarning, [mbOk], 0);
      //  Exit;
      //end;

      recarregarPlanilhas := True;

      btnLerArquivo.Enabled := False;
      btnProcessar.Enabled := False;

      panProgresso.Visible := True;
      lblMsg.Caption := 'Processando . . . ';
      Application.ProcessMessages;

      ocorreuErro := False;

      nDescritor := 7; //codigo atual da especificacao modelo

      for nLista := 0 to listaListas.Count - 1 do
      begin

        listaAtual := TList(listaListas.Items[nLista]);

        if ckbProcessesarSelecionado.Checked then
        begin
          nInicial := linhaSelecionada - 1;
          nFinal := linhaSelecionada;
        end
        else
        begin
          nInicial := 0;
          nFinal := listaAtual.Count;
        end;

        pbProcessamento.Max := nFinal;
        pbProcessamento.Min := nInicial;
        pbProcessamento.Position := nInicial;
        lblMsg.Caption := 'Processando a planilha ' + listaPlanihas.Strings[nLista];

        for nProduto := nInicial to nFinal - 1 do
        begin

          if (cancelou) then
          begin
            Screen.Cursor := crDefault;
            if (MessageDlg('Cancelar o processamento das planilhas ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
            begin
              recarregarPlanilhas := True;
              Exit;
            end;
          end
          else
          begin
            cancelou := False;
            Screen.Cursor := crHourGlass;
          end;

          produto := TProduto(listaAtual.Items[nProduto]);
          // Se a situacao do produto está correta . . . processar . . .
          if produto.Situacao = correto then
          begin
            Trans.TransactionID := 1;
            Trans.IsolationLevel := xilREADCOMMITTED;
            if produto.CodigoModelo = 0 then
            begin
              //se não temos a associação espec_prod vamos inserir

              DM.dbFirebird.StartTransaction(Trans);
              if InserirRelacaoProdutoDescritor(produto.Codigo, 7, produto.Modelos) then
                produto.CodigoModelo := PegarProdutoAssociadoDescritor(produto.Codigo, 7);
              DM.dbFirebird.Commit(Trans);
            end
            else
            begin
              DM.dbFirebird.StartTransaction(Trans);
              AtualizaRelacaoProdutoDescritor(produto.CodigoModelo, produto.Modelos);
              DM.dbFirebird.Commit(Trans);
            end;
//            for nModelo := 0 to produto.Modelos.Count - 1 do
//            begin
//              modelo := TModelo(produto.Modelos.Items[nModelo]);
//
//              // Se a situacao do modelo for "DNC - Descritor não cadastrado", cadastrar um novo então . . .
//              if (modelo.Situacao = descritorNaoCadastrado) then
//              begin
//                codigoNovo := 0;
//                if InserirNovoDescritor(nDescritor, modelo.Nome, codigoNovo) then
//                begin
//                  modelo.Situacao := correto;
//                  modelo.Codigo := codigoNovo;
//                end;
//              end;
//
//              // Se a situacao do modelo for correta, inserir a associacao modelo x produto
//              if modelo.Situacao = correto then
//              begin
//                InserirRelacaoProdutoDescritor(nDescritor, produto.Codigo, modelo.Codigo);
//                InserirDEEPR(nDescritor, produto.Codigo, modelo.Nome);
//              end;
//
//            end;
          end;
          pbProcessamento.Position := pbProcessamento.Position + 1;
          Application.ProcessMessages;
        end;
      end;
    except
      on e: Exception do
      begin
        DM.dbFirebird.Rollback(Trans);
        ocorreuErro := True;
        raise Exception.Create('Erro ao processar planilhas: ' + e.Message);
      end;
    end;
  finally
    panProgresso.Visible := False;
    btnLerArquivo.Enabled := True;
    btnProcessar.Enabled := True;
    Screen.Cursor := crDefault;
    if cancelou then
      MessageDlg('Cancelado pelo usuário!', mtInformation, [mbOk], 0)
    else if not ocorreuErro then
      MessageDlg('Concluído!', mtInformation, [mbOk], 0)
    else
      MessageDlg('Concluído sem sucesso!', mtError, [mbOk], 0);
  end;
end;

procedure TfrmModelosXPecas.ckbLimitarListaClick(Sender: TObject);
begin
  edtQtdLinhas.Enabled := ckbLimitarLista.Checked;
end;

procedure TfrmModelosXPecas.DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
  begin
    if ((Pos(cadastroProdutoDuplicado, Cells[ACol, ARow]) > 0) or (Pos(cadastroDescritorDuplicado, Cells[ACol, ARow]) > 0) or (Pos(descritorDuplicadoParaProduto, Cells[ACol, ARow]) > 0)) then
      Canvas.Font.Color := clRed

    else if (Pos(produtoNaoCadastrado, Cells[ACol, ARow]) > 0) then
      Canvas.Font.Color := clMaroon

    else if ((Pos(descritorNaoCadastrado, Cells[ACol, ARow]) > 0) or (Pos(descritorNaoExisteParaProduto, Cells[ACol, ARow]) > 0)) then
      Canvas.Font.Color := clGreen

    else if (Pos(descritorJaExisteParaProduto, Cells[ACol, ARow]) > 0) then
      Canvas.Font.Color := clBlue;

    Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cells[ACol, ARow]);
    Canvas.FrameRect(Rect);
  end;
end;

procedure TfrmModelosXPecas.edtQtdLinhasExit(Sender: TObject);
begin
  if StrToIntDef(edtQtdLinhas.Text, 0) <= 0 then
  begin
    MessageDlg('Valor inválido!', mtWarning, [mbOk], 0);
    edtQtdLinhas.SetFocus;
  end;
end;

procedure TfrmModelosXPecas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  DM.DesconectarSQLServer;
  DM.DesconectarFirebird;
  Action := caFree;
end;

procedure TfrmModelosXPecas.FormCreate(Sender: TObject);
begin
//  dm.ConectarSQLServer(Configuracao.Servidor, Configuracao.banco, Configuracao.Usuario, Configuracao.Senha);
  DM.ConectarFirebird(Configuracao.Servidor, Configuracao.banco, Configuracao.Usuario, Configuracao.Senha);
  edtPastaOrigem.Text := Configuracao.PastaOrigem;
  edtPastaDestino.Text := Configuracao.PastaDestino;
  ListarArquivos(Configuracao.PastaOrigem, True);
  listaGrades := TList.Create;
  listaListas := TList.Create;
  listaPlanihas := TStringList.Create;
  listaModelos := TIntegerHash.Create;
end;

function TfrmModelosXPecas.InserirDEEPR(nDesc: Integer; codigoProduto: Integer; nomeDescritor: string): Boolean;
var
  novoCodigo: Integer;
  sp: TADOStoredProc;
  nd: string;
begin
  try
    try
      result := false;

      nd := IntToStr(nDesc);

      if nDesc = 1 then
        sp := dm.spInserirDEEPR1
      else if nDesc = 2 then
        sp := dm.spInserirDEEPR2
      else if nDesc = 3 then
        sp := dm.spInserirDEEPR3;

      sp.Parameters.ParamByName('@pACAO').Value := 'I';
      sp.Parameters.ParamByName('@pPROS_COD').Value := codigoProduto;
      sp.Parameters.ParamByName('@pDEE' + nd + '_NME').Value := nomeDescritor;
      sp.ExecProc;

      novoCodigo := sp.Parameters.ParamByName('@pDEE' + nd + '_COD').Value;

      result := novoCodigo > 0;
    except
      on e: Exception do
      begin
        result := false;
        raise Exception.Create('Erro ao inserir DEEPR para o produto ' + IntToStr(codigoProduto) + ' e descritor ' + nomeDescritor + ': ' + e.Message);
      end;
    end;
  finally
    sp.Close;
  end;
end;

function TfrmModelosXPecas.InserirNovoDescritor(nDesc: Integer; nomeDescritor: string; var codigoNovoDescritor: Integer): Boolean;
var
  sp: TADOStoredProc;
  nd: string;
begin
  try
    try
      result := false;

      nd := IntToStr(nDesc);

      if nDesc = 1 then
        sp := dm.spInsereNovoDescritor1
      else if nDesc = 2 then
        sp := dm.spInsereNovoDescritor2
      else if nDesc = 3 then
        sp := dm.spInsereNovoDescritor3;

      if listaModelos.Exists(nomeDescritor) then
        codigoNovoDescritor := listaModelos.Items[nomeDescritor]
      else
      begin
        sp.Parameters.ParamByName('@pACAO').Value := 'I';
        sp.Parameters.ParamByName('@pDES' + nd + '_NME').Value := nomeDescritor;
        sp.Parameters.ParamByName('@pDES' + nd + '_CHR_SN_SELPDS').Value := 'S';
        sp.Parameters.ParamByName('@pDESG_COD').Value := 1;
        sp.Parameters.ParamByName('@pDES' + nd + '_DAT_FIM').Value := null;
        sp.ExecProc;

        // Pegar o código do novo descritor
        codigoNovoDescritor := sp.Parameters.ParamByName('@pDES' + nd + '_COD').Value;

        if codigoNovoDescritor > 0 then
          listaModelos.Items[nomeDescritor] := codigoNovoDescritor;
      end;

      result := codigoNovoDescritor > 0;
    except
      on e: Exception do
      begin
        result := false;
        raise Exception.Create('Erro ao inserir o descritor ' + nomeDescritor + ': ' + e.Message);
      end;
    end;
  finally
    sp.Close;
  end;
end;

function TfrmModelosXPecas.InserirRelacaoProdutoDescritor(codigoProduto, codigoDescritor: Integer; modelos: string): Boolean;
begin
  try
    try
      result := false;

      //dm.qryInserirRelacaoDescritorProduto.Parameters.ParamByName('cod_produto').Value := codigoProduto;
      //dm.qryInserirRelacaoDescritorProduto.Parameters.ParamByName('cod_descritor').Value := codigoDescritor;

      // aqui

      dm.qryInserirRelacaoDescritorProduto.SQL.Clear;
      dm.qryInserirRelacaoDescritorProduto.SQL.ADD('INSERT INTO ESPEC_PRODUTOS (PRODUTO, ESPECIFICACAO, DESCRICAO)');
      dm.qryInserirRelacaoDescritorProduto.SQL.ADD('VALUES (' + IntToStr(codigoProduto) + ', ' + IntToStr(codigoDescritor) + ', ' + QuotedStr(modelos) + ')');
      // até aqui

      dm.qryInserirRelacaoDescritorProduto.ExecSQL;

      result := true;

    except
      on e: Exception do
      begin
        result := false;
        raise Exception.Create('Erro ao relacionar o produto ' + IntToStr(codigoProduto) + ' a especificação de modelo ' + ': ' + e.Message);
      end;
    end;
  finally
//    dm.qryInserirRelacaoDescritorProduto.Close;
    dm.qryInserirRelacaoDescritorProduto.Close;
  end;
end;

procedure TfrmModelosXPecas.ListarArquivos(Diretorio: string; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
  Ret := FindFirst(Diretorio + '\*.xls', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') and (F.Name <> '..') then
          if Sub = True then
          begin
            TempNome := Diretorio + '\' + F.Name;
            ListarArquivos(TempNome, True);
          end;
      end
      else
      begin
        clbArquivos.Items.Add(F.Name);
      end;
      Ret := FindNext(F);
    end;
  finally
    FindClose(F);
  end;
end;

function TfrmModelosXPecas.PegarCodigoDescritor(nDesc: Integer; nomeDescritor: string; var codigoObtido: Integer): string;
var
  nd: string;
begin
  try
    result := erroNaoConhecido;

    if listaModelos.Exists(nomeDescritor) then
      codigoObtido := listaModelos.Items[nomeDescritor]
    else
    begin

      // aqui
      nd := IntToStr(nDesc);
      dm.qryBuscaCodigoDescritor.SQL.Clear;
      dm.qryBuscaCodigoDescritor.SQL.Add('SELECT DS.DES' + nd + '_COD AS COD_DESCRITOR');
      dm.qryBuscaCodigoDescritor.SQL.Add('FROM TCOM_DES' + nd + 'PR DS');
      dm.qryBuscaCodigoDescritor.SQL.Add('WHERE RTRIM(LTRIM(DS.DES' + nd + '_NME)) = ' + #39 + nomeDescritor + #39);
      // até aqui

      //dm.qryBuscaCodigoDescritor.Parameters.ParamByName('nom_descritor').Value := nomeDescritor;

      dm.qryBuscaCodigoDescritor.Open;

      if dm.qryBuscaCodigoDescritor.IsEmpty then
        codigoObtido := 0
      else if dm.qryBuscaCodigoDescritor.RecordCount > 1 then
        codigoObtido := -1
      else
      begin
        codigoObtido := dm.qryBuscaCodigoDescritor.FieldByName('COD_DESCRITOR').AsInteger;
        listaModelos[nomeDescritor] := codigoObtido;
      end;
    end;

    // Validar retorno
    if codigoObtido = 0 then
      result := descritorNaoCadastrado
    else if codigoObtido = -1 then
      result := cadastroDescritorDuplicado
    else
      result := correto;

  finally
    dm.qryBuscaCodigoDescritor.Close;
  end;
end;

function TfrmModelosXPecas.PegarCodigoProduto(codExtProduto: string; var codigoObtido: Integer): string;
begin
  try
    result := erroNaoConhecido;

    // aqui
    dm.qryBuscaCodigoProduto.SQL.Clear;
    dm.qryBuscaCodigoProduto.SQL.Add('SELECT PRODUTO ');
    dm.qryBuscaCodigoProduto.SQL.Add('FROM PRODUTOS');
    dm.qryBuscaCodigoProduto.SQL.Add('WHERE LTRIM(RTRIM(COD_PRODUTO)) = ' + #39 + codExtProduto + #39);
    // até aqui

    //dm.qryBuscaCodigoProduto.Parameters.ParamByName('cod_ext_produto').Value := codExtProduto;
    dm.qryBuscaCodigoProduto.Open;

    if dm.qryBuscaCodigoProduto.IsEmpty then
      codigoObtido := 0
    else
      codigoObtido := dm.qryBuscaCodigoProduto.FieldByName('PRODUTO').AsInteger;

    // Validar retorno
    if codigoObtido = 0 then
      result := produtoNaoCadastrado
    else
      result := correto;

  finally
    dm.qryBuscaCodigoProduto.Close;
  end;
end;

function TfrmModelosXPecas.PegarProdutoAssociadoDescritor(codProduto, codDescritor: Integer): Integer;
begin
  try
    result := 0;

    // aqui
    dm.qryBuscaProdutoDescritor.SQL.Clear;
    dm.qryBuscaProdutoDescritor.SQL.Add('SELECT ESPEC_PRODUTO');
    dm.qryBuscaProdutoDescritor.SQL.Add('FROM ESPEC_PRODUTOS');
    dm.qryBuscaProdutoDescritor.SQL.Add('WHERE PRODUTO = ' + IntToStr(codProduto));
    dm.qryBuscaProdutoDescritor.SQL.Add('	AND ESPECIFICACAO = ' + IntToStr(codDescritor));
    // até aquui

    // dm.qryBuscaProdutoDescritor.Parameters.ParamByName('cod_produto').Value := codProduto;
    // dm.qryBuscaProdutoDescritor.Parameters.ParamByName('cod_descritor').Value := codDescritor;

    dm.qryBuscaProdutoDescritor.Open;

    if dm.qryBuscaProdutoDescritor.IsEmpty then
      result := 0
    else
      result := dm.qryBuscaProdutoDescritor.fieldbyname('ESPEC_PRODUTO').AsInteger;

  finally
    dm.qryBuscaProdutoDescritor.Close;
  end;
end;

function TfrmModelosXPecas.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

procedure TfrmModelosXPecas.SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  linhaSelecionada := ARow;
end;

function TfrmModelosXPecas.AtualizaRelacaoProdutoDescritor(codigoModelo: Integer; modelos: string): Boolean;
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

procedure TfrmModelosXPecas.MoverPlanilhasProcessadas;
var
  nomeArquivo : string;
  t : Integer;
begin
  DM.DesconectaExcel; // para garantir que a conexão foi encerrada
  for t := 0 to clbArquivos.Count - 1 do
  begin
    if not clbArquivos.Checked[t] then
      Continue;
    nomeArquivo := clbArquivos.Items.Strings[t];

    MoveFile(PChar(Configuracao.PastaOrigem + nomeArquivo), PChar(Configuracao.PastaDestino + nomeArquivo));
  end;
  clbArquivos.Clear;
  ListarArquivos(Configuracao.PastaOrigem, True);
end;

end.

