unit FormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, jpeg, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuAcoes: TMenuItem;
    mnuModelosXPecas: TMenuItem;
    ActionList1: TActionList;
    actModelosXPecas: TAction;
    actTesteCriptografia: TAction;
    mnuUtilitarios: TMenuItem;
    mnuTesteCriptografia: TMenuItem;
    actConfiguracoes: TAction;
    mnuConfiguracoes: TMenuItem;
    actCargaBematech: TAction;
    mnuCargaBematech: TMenuItem;
    Image1: TImage;
    menucorrigirespaco: TMenuItem;
    mnuRemoverDuplicados: TMenuItem;
    procedure actTesteCriptografiaExecute(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actModelosXPecasExecute(Sender: TObject);
    procedure actCargaBematechExecute(Sender: TObject);
    procedure menucorrigirespacoClick(Sender: TObject);
    procedure mnuRemoverDuplicadosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


uses FormCriptografia, FormConfiguracoes, FormModelosXPecas, Configuracoes,
  DataModule, CargaBematech, FormRemoveEspacoModelos;

{$R *.dfm}

procedure TfrmPrincipal.actCargaBematechExecute(Sender: TObject);
begin
  frmCargaBematech := TfrmCargaBematech.Create(Application);
  frmCargaBematech.Show;
end;

procedure TfrmPrincipal.actConfiguracoesExecute(Sender: TObject);
begin
  frmConfiguracoes := TfrmConfiguracoes.Create(Application);
  frmConfiguracoes.Show;
end;

procedure TfrmPrincipal.actModelosXPecasExecute(Sender: TObject);
begin
  frmModelosXPecas := TfrmModelosXPecas.Create(Application);
  frmModelosXPecas.Show;
end;

procedure TfrmPrincipal.actTesteCriptografiaExecute(Sender: TObject);
begin
  frmCriptografia := TfrmCriptografia.Create(Application);
  frmCriptografia.Show;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Configuracao := TConfiguracoes.Create;
  if Not Configuracao.CarregarConfiguracoes then
  begin
    MessageDlg ('Não foi possível carregar o arquivo de configuração.', mtError, [mbOk], 0);
    Application.Terminate;
  end;
end;

procedure TfrmPrincipal.menucorrigirespacoClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente remover os espaços em branco'+ #13 +' dos Modelos gravados na Base?',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    frmUtilRemoveEspacoBase:= TfrmUtilRemoveEspacoBase.Create(Application);
    frmUtilRemoveEspacoBase.processarRegistros;
  end;
end;

procedure TfrmPrincipal.mnuRemoverDuplicadosClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente remover os registros duplicados'+ #13 +' dos Modelos gravados na Base?',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    frmUtilRemoveEspacoBase:= TfrmUtilRemoveEspacoBase.Create(Application);
    frmUtilRemoveEspacoBase.removerRegistrosDuplicados;
  end;
end;

Initialization

DecimalSeparator := '.';

end.
