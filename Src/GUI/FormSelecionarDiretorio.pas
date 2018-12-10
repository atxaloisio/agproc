unit FormSelecionarDiretorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TfrmSelecionarDiretorio = class(TForm)
    dlbDiretorio: TDirectoryListBox;
    dcbDrive: TDriveComboBox;
    Label1: TLabel;
    Label2: TLabel;
    btnCancelar: TButton;
    btnOk: TButton;
    procedure dcbDriveChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    fDirSelecionado: String;
    cancelou: Boolean;
  public
    { Public declarations }
    Property Diretorio: String read fDirSelecionado write fDirSelecionado;
    Function Selecionar: Boolean;
  end;

var
  frmSelecionarDiretorio: TfrmSelecionarDiretorio;

implementation

{$R *.dfm}

procedure TfrmSelecionarDiretorio.btnCancelarClick(Sender: TObject);
begin
  cancelou := True;
  Close;
end;

procedure TfrmSelecionarDiretorio.btnOkClick(Sender: TObject);
begin
  cancelou := False;
  Close;
end;

procedure TfrmSelecionarDiretorio.dcbDriveChange(Sender: TObject);
begin
  dlbDiretorio.Drive := dcbDrive.Drive;
end;

function TfrmSelecionarDiretorio.Selecionar: Boolean;
begin
  frmSelecionarDiretorio.ShowModal;
  if Not cancelou then
  begin
    Result := True;
    Diretorio := dlbDiretorio.Directory;
  end
  else
  begin
    Result := False;
    Diretorio := '';
  end;
end;

end.
