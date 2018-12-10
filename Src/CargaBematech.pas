unit CargaBematech;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, ExtCtrls, ComCtrls;

type
  TfrmCargaBematech = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    dsDadosParaBematech: TDataSource;
    btnLerProdutos: TButton;
    Label1: TLabel;
    lblQtdlProblemaCodBarras: TLabel;
    btnAtualizarAccess: TButton;
    pbProgresso: TProgressBar;
    lblProgresso: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblQtdProdutos: TLabel;
    procedure btnLerProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizarAccessClick(Sender: TObject);
    procedure DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCargaBematech: TfrmCargaBematech;

implementation

uses DataModule, Configuracoes;

{$R *.dfm}

procedure TfrmCargaBematech.btnAtualizarAccessClick(Sender: TObject);
begin
  DecimalSeparator := '.';

  if DM.qryDadosParaBematech.IsEmpty then
  begin
    ShowMessage('Não existem produtos carregados. Primeiro execute o botão "Ler Produtos".');
    Exit;
  end
  else
  begin

    if MessageDlg ('Todos os produtos da base temporária do Access serão apagados e uma nova carga será realizada. Continuar ?',
      mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

    if MessageDlg ('Existem produtos com problemas, que não serão carregados. Continuar mesmo assim ?',
      mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

    try
      if DM.ApagarDadosBematechAccess = True then
      begin
        Screen.Cursor := crHourGlass;
        lblProgresso.Visible := True;
        lblProgresso.Refresh;
        pbProgresso.Visible := True;
        pbProgresso.Min := 0;
        pbProgresso.Max := dm.qryDadosParaBematech.RecordCount;
        pbProgresso.Position := 0;
        dm.qryDadosParaBematech.DisableControls;
        DM.qryDadosParaBematech.First;
        While Not DM.qryDadosParaBematech.Eof do
        begin
          if DM.qryDadosParaBematech.FieldByName('ind_erro').AsString  = 'N' then
            DM.InserirDadosBematechAccess(dm.qryDadosParaBematech.FieldByName('cod_barras').AsString,
                                          dm.qryDadosParaBematech.FieldByName('nom_produto').AsString,
                                          dm.qryDadosParaBematech.FieldByName('val_preco').AsFloat);
          DM.qryDadosParaBematech.Next;
          pbProgresso.Position := pbProgresso.Position + 1;
          pbProgresso.Refresh;
        end;
      end;
      Screen.Cursor := crDefault;
      ShowMessage ('Carga concluída com sucesso!');
    finally
      dm.qryDadosParaBematech.EnableControls;
      lblProgresso.Visible := False;
      pbProgresso.Visible := False;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmCargaBematech.btnLerProdutosClick(Sender: TObject);
var qtdErros: Integer;
begin
  try
    Screen.Cursor := crHourGlass;
    dm.qryDadosParaBematech.DisableControls;
    lblQtdlProblemaCodBarras.Caption := '0';
    DM.qryDadosParaBematech.Open;
    DM.qryDadosParaBematech.First;
    qtdErros := 0;
    While Not DM.qryDadosParaBematech.Eof do
    begin
      if DM.qryDadosParaBematech.FieldByName('ind_erro').AsString  = 'S' then
        Inc(qtdErros);
      DM.qryDadosParaBematech.Next;
    end;
    lblQtdlProblemaCodBarras.Caption := IntToStr(qtdErros);
    lblQtdProdutos.Caption := IntToStr(DM.qryDadosParaBematech.RecordCount);
  finally
    dm.qryDadosParaBematech.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmCargaBematech.DBGrid1DrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  {if (UpperCase(Field.Name) = 'IND_ERRO') and (Field.Value = 'S') then
  begin
    Canvas.Brush.Color := clRed;
    Canvas.Pen.Color := clWhite;
    Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Field.Name );
    Canvas.FrameRect(Rect);
  end;}
end;

procedure TfrmCargaBematech.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.DesconectarAccess;
  DM.DesconectarSQLServer;
  Action := caFree;
end;

procedure TfrmCargaBematech.FormCreate(Sender: TObject);
begin
  DM.ConectarAccess(Configuracao.ArquivoAccess);
  DM.ConectarSQLServer(Configuracao.Servidor, Configuracao.banco, Configuracao.Usuario, Configuracao.Senha);
end;

end.
