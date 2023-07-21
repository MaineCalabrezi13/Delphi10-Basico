unit U_Editar_Treinar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  Tfrm_editTreina = class(TForm)
    txt_datanasc: TDBEdit;
    txt_natu: TDBEdit;
    txt_nacio: TDBEdit;
    txt_times: TDBComboBox;
    txt_sexo: TDBComboBox;
    txt_datacad: TDBEdit;
    txt_idade: TDBEdit;
    Image1: TImage;
    txt_id: TDBEdit;
    txt_nome: TDBEdit;
    Image2: TImage;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_editTreina: Tfrm_editTreina;

implementation

{$R *.dfm}

uses U_Dm, U_Cad_Treinar;

procedure Tfrm_editTreina.FormShow(Sender: TObject);
begin
txt_id.text := dm.ds_treinador.DataSet.FieldByName('id_treinador').AsString;
end;

procedure Tfrm_editTreina.Image2Click(Sender: TObject);
begin
 dm.ds_treinador.DataSet.Edit;
  dm.ds_treinador.DataSet.Post;
  dm.ds_treinador.DataSet.Refresh;
  showmessage('Treinador editado com sucesso');
  Close;
end;

end.
