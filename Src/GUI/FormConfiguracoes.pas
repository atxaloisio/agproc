unit FormConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TfrmConfiguracoes = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtPastaOrigem: TEdit;
    Label2: TLabel;
    edtPastaDestino: TEdit;
    chkMoverArquivos: TCheckBox;
    btnSelPastaOrigem: TBitBtn;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtServidor: TEdit;
    edtUsuario: TEdit;
    Label5: TLabel;
    btnSelPastaDestino: TBitBtn;
    btnCancelar: TButton;
    btnSalvar: TButton;
    edtSenha: TMaskEdit;
    Label6: TLabel;
    edtBanco: TEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    edtDestinoLogsImportacao: TEdit;
    btnSelArquivoAccess: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSelPastaOrigemClick(Sender: TObject);
    procedure btnSelPastaDestinoClick(Sender: TObject);
    procedure btnSelArquivoAccessClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses FormCriptografia, Configuracoes, FormSelecionarDiretorio;

{$R *.dfm}

procedure TfrmConfiguracoes.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracoes.btnSalvarClick(Sender: TObject);
begin
  Configuracao.PastaOrigem := edtPastaOrigem.Text;
  Configuracao.PastaDestino := edtPastaDestino.Text;
  Configuracao.PastaLogs := edtDestinoLogsImportacao.Text;
  Configuracao.MoverArquivos := chkMoverArquivos.Checked;
  Configuracao.Servidor := edtServidor.Text;
  Configuracao.Usuario := edtUsuario.Text;
  Configuracao.Senha := edtSenha.Text;
  Configuracao.Banco := edtBanco.Text;
//  Configuracao.ArquivoAccess := edtArquivoAccess.Text;

  if Not Configuracao.SalvarConfiguracoes then
    MessageDlg ('Erro na gravação do arquivo de configuração.', mtError, [mbOk], 0);

  Close;
end;

procedure TfrmConfiguracoes.btnSelPastaDestinoClick(Sender: TObject);
begin
  try
    frmSelecionarDiretorio := TfrmSelecionarDiretorio.Create(Application);
    if frmSelecionarDiretorio.Selecionar then
      edtPastaDestino.Text :=  frmSelecionarDiretorio.Diretorio;
  finally
    FreeAndNil(frmSelecionarDiretorio);
  end;
end;

procedure TfrmConfiguracoes.btnSelPastaOrigemClick(Sender: TObject);
begin
  try
    frmSelecionarDiretorio := TfrmSelecionarDiretorio.Create(Application);
    if frmSelecionarDiretorio.Selecionar then
      edtPastaOrigem.Text :=  frmSelecionarDiretorio.Diretorio;
  finally
    FreeAndNil(frmSelecionarDiretorio);
  end;
//  if dlgSelArquivoAccess.Execute then
//    edtArquivoAccess.Text := dlgSelArquivoAccess.FileName;
end;

procedure TfrmConfiguracoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  edtPastaOrigem.Text := Configuracao.PastaOrigem;
  edtPastaDestino.Text := Configuracao.PastaDestino;
  edtDestinoLogsImportacao.Text := Configuracao.PastaLogs;
  chkMoverArquivos.Checked := Configuracao.MoverArquivos;
  edtServidor.Text := Configuracao.Servidor;
  edtUsuario.Text := Configuracao.Usuario;
  edtSenha.Text := Configuracao.Senha;
  edtBanco.Text := Configuracao.Banco;
//  edtArquivoAccess.Text := Configuracao.ArquivoAccess;
end;

procedure TfrmConfiguracoes.btnSelArquivoAccessClick(Sender: TObject);
begin
  try
    frmSelecionarDiretorio := TfrmSelecionarDiretorio.Create(Application);
    if frmSelecionarDiretorio.Selecionar then
      edtDestinoLogsImportacao.Text :=  frmSelecionarDiretorio.Diretorio;
  finally
    FreeAndNil(frmSelecionarDiretorio);
  end;
end;

end.
