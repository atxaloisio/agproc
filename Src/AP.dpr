program AP;

{%File 'ap-modelo.ini'}

uses
  Forms,
  FormPrincipal in 'GUI\FormPrincipal.pas' {frmPrincipal},
  FormModelosXPecas in 'GUI\FormModelosXPecas.pas' {frmModelosXPecas},
  FormCriptografia in 'GUI\FormCriptografia.pas' {frmCriptografia},
  FormConfiguracoes in 'GUI\FormConfiguracoes.pas' {frmConfiguracoes},
  Configuracoes in 'Configuracoes.pas',
  FormSelecionarDiretorio in 'GUI\FormSelecionarDiretorio.pas' {frmSelecionarDiretorio},
  DataModule in 'DM\DataModule.pas' {DM: TDataModule},
  Peca in 'Peca.pas',
  PecaFachada in 'PecaFachada.pas',
  Modelo in 'Modelo.pas',
  Constantes in 'Constantes.pas',
  CargaBematech in 'CargaBematech.pas' {frmCargaBematech},
  Funcoes in 'Funcoes.pas',
  Hashes in 'Hashes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
