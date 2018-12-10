unit Configuracoes;

interface

  uses
    IniFiles, SysUtils, Funcoes, Forms;

  type
    TConfiguracoes = Class(TObject)
      Private
        // Descritores Predefinidos - Planilhas
        fPastaOrigem: String;
        fPastaDestino: String;
        fMoverArquivos: Boolean;
        // Banco de dados
        fServidor: String;
        fBanco: String;
        fUsuario: String;
        fSenha: String;
        // Carga Bematech
        fArquivoAccess: String;
      Public
        Property PastaOrigem : String read fPastaOrigem write fPastaOrigem;
        Property PastaDestino: String read fPastaDestino write fPastaDestino;
        Property MoverArquivos: Boolean read fMoverArquivos write fMoverArquivos;
        Property Servidor: String read fServidor write fServidor;
        Property Banco: String read fBanco write fBanco;
        Property Usuario: String read fUsuario write fUsuario;
        property Senha: String read fSenha write fSenha;
        property ArquivoAccess: String read fArquivoAccess write fArquivoAccess;

        Function CarregarConfiguracoes: Boolean;
        Function SalvarConfiguracoes: Boolean;
    End;

  var
    Configuracao: TConfiguracoes;

implementation

{ TConfiguracoes }

function TConfiguracoes.CarregarConfiguracoes: Boolean;
var ini: TIniFile;
begin
  try
    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\ap.ini');

      Self.fPastaOrigem := ini.ReadString('planilhas','pasta_origem','');
      Self.fPastaDestino := ini.ReadString('planilhas','pasta_destino','');
      Self.fMoverArquivos := ini.ReadString('planilhas','mover_apos_processar','') = 'S';

      Self.fServidor := ini.ReadString('banco','servidor','');
      Self.fBanco := Cripto(ini.ReadString('banco','banco',''),'N');
      Self.fUsuario := Cripto(ini.ReadString('banco','usuario',''),'N');
      Self.fSenha := Cripto(ini.ReadString('banco','senha',''),'N');

      Self.fArquivoAccess := ini.ReadString('carga_bematech','arquivo_access','');

      result := True;
    finally
      FreeAndNil(ini);
    end;
  Except
    result := False;
  end;
end;

function TConfiguracoes.SalvarConfiguracoes: Boolean;
var ini: TIniFile;
    barra: String;
begin
  try
    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\ap.ini');

      if Copy(Self.PastaOrigem, Length(Self.PastaOrigem), 1) <> '\' then
        barra := '\'
      else
        barra := '';

      ini.WriteString('planilhas', 'pasta_origem', Self.fPastaOrigem + barra);
      ini.WriteString('planilhas', 'pasta_destino', Self.fPastaDestino + barra);

      if fMoverArquivos then
        ini.WriteString('planilhas','mover_apos_processar', 'S')
      else
        ini.WriteString('planilhas','mover_apos_processar', 'N');

      ini.WriteString('banco','servidor', Self.fServidor);
      ini.WriteString('banco','banco', Cripto(Self.fBanco,'S'));
      ini.WriteString('banco','usuario', Cripto(Self.fUsuario,'S'));
      ini.WriteString('banco','senha', Cripto(Self.fSenha,'S'));

      ini.WriteString('carga_bematech', 'arquivo_access', Self.fArquivoAccess);

      result := True;
    finally
      FreeAndNil(ini);
    end;
  Except
    result := False;
  end;
end;

end.
