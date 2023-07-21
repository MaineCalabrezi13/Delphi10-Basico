unit U_Editar_Jogar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  Tfrm_editarJogar = class(TForm)
    txt_id: TDBEdit;
    txt_nome: TDBEdit;
    txt_idade: TDBEdit;
    txt_altura: TDBEdit;
    txt_peso: TDBEdit;
    txt_camisa: TDBEdit;
    txt_nacio: TDBEdit;
    txt_natu: TDBEdit;
    txt_datanasc: TDBEdit;
    txt_apelido: TDBEdit;
    txt_datacad: TDBEdit;
    txt_sexo: TDBComboBox;
    txt_posicao: TDBComboBox;
    txt_times: TDBComboBox;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_editarJogar: Tfrm_editarJogar;

implementation

{$R *.dfm}

uses U_Dm, U_Cad_Jogar;

procedure Tfrm_editarJogar.FormShow(Sender: TObject);
begin
 txt_id.text := dm.ds_jogador.DataSet.FieldByName('id_jogador').AsString;
 txt_nome.text := dm.ds_jogador.DataSet.FieldByName('nome').AsString;
 txt_apelido.text := dm.ds_jogador.DataSet.FieldByName('apelido').AsString;
 txt_idade.text := dm.ds_jogador.DataSet.FieldByName('idade').AsString;
 txt_altura.text := dm.ds_jogador.DataSet.FieldByName('altura').AsString;
 txt_peso.text := dm.ds_jogador.DataSet.FieldByName('peso').AsString;
 txt_datanasc.text := dm.ds_jogador.DataSet.FieldByName('data_nasc').AsString;
 txt_datacad.text := dm.ds_jogador.DataSet.FieldByName('data_cad').AsString;
 txt_sexo.text := dm.ds_jogador.DataSet.FieldByName('sexo').AsString;
 txt_posicao.text := dm.ds_jogador.DataSet.FieldByName('posição').AsString;
 txt_camisa.text := dm.ds_jogador.DataSet.FieldByName('camiseta').AsString;
 txt_times.text := dm.ds_jogador.DataSet.FieldByName('Times').AsString;


end;

procedure Tfrm_editarJogar.Image1Click(Sender: TObject);
begin
 dm.ds_jogador.DataSet.Edit;
  dm.ds_jogador.DataSet.Post;
  dm.ds_jogador.DataSet.Refresh;
  showmessage('Jogador editado com sucesso');
  Close;
end;

end.
