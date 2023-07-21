unit U_Cad_Treinar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.Imaging.pngimage, Vcl.ExtCtrls,Data.Db, Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_treinador = class(TForm)
    PageControl1: TPageControl;
    Image1: TImage;
    tb_cad: TTabSheet;
    txt_datanasc: TDBEdit;
    txt_natu: TDBEdit;
    txt_nacio: TDBEdit;
    btn_consultar: TImage;
    txt_times: TDBComboBox;
    txt_sexo: TDBComboBox;
    txt_datacad: TDBEdit;
    btn_salvar: TImage;
    btn_inserir: TImage;
    txt_idade: TDBEdit;
    txt_nome: TDBEdit;
    txt_id: TDBEdit;
    btn_fechar: TImage;
    btn_cancelar: TImage;
    tb_consul: TTabSheet;
    Image2: TImage;
    DBGrid1: TDBGrid;
    rg_opcoes: TRadioGroup;
    Image6: TImage;
    btn_imprimir: TImage;
    txt_buscar: TEdit;
    lb_buscar: TLabel;
    Image8: TImage;
    btn_clear: TButton;
    Image4: TImage;
    Image5: TImage;
    lb_msg: TLabel;
    Image3: TImage;
    Image7: TImage;
    procedure btn_inserirClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure rg_opcoesClick(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure txt_buscarKeyPress(Sender: TObject; var Key: Char);
    procedure Image7Click(Sender: TObject);
    procedure btn_consultarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
   procedure configbotons;
   procedure QuantidadeRegistros;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_treinador: Tfrm_treinador;

implementation
{$R *.dfm}

uses U_Dm, U_Editar_Treinar;

procedure Tfrm_treinador.btn_cancelarClick(Sender: TObject);
begin
dm.tb_treinador.cancel;
configbotons;
end;

procedure Tfrm_treinador.btn_consultarClick(Sender: TObject);
begin
pagecontrol1.TabIndex:=1;
tb_consul.TabVisible:=true;
tb_cad.tabvisible:=false;
end;

procedure Tfrm_treinador.btn_editarClick(Sender: TObject);
begin
dm.tb_treinador.edit;
configbotons;
end;

procedure Tfrm_treinador.btn_excluirClick(Sender: TObject);
begin
case application.MessageBox('Deseja excluir treinador?','Excluir Treinador', mb_yesno+ mb_iconquestion) of
idyes:
begin
  dm.tb_treinador.delete;
  showmessage('Treinador excluido com sucesso!');
end;
end;
end;

procedure Tfrm_treinador.btn_fecharClick(Sender: TObject);
begin
if dm.tb_treinador.State in [dsinsert, dsedit] then
begin
  showmessage('Salve ou cancele antes de fechar');
  exit;
  end else
  begin
    close;
  end;
end;

procedure Tfrm_treinador.btn_inserirClick(Sender: TObject);
begin
dm.tb_treinador.active:=true;
dm.tb_treinador.insert;
configbotons;
dm.tb_treinadordata_cad.value:=date;
txt_nome.setfocus;
end;

procedure Tfrm_treinador.btn_salvarClick(Sender: TObject);
var
teamId:integer;
begin
if(txt_id.text ='') or (txt_nome.text='') or(txt_idade.text='') or(txt_sexo.text='') or (txt_datanasc.text='') or(txt_nacio.text='')or(txt_natu.text='')or(txt_datacad.text='')or(txt_times.text='')then
begin
  showmessage('Preencha todos os campo!');
  exit;
  end else
{TeamID := dm.tb_treinador.FieldByName('id_treinador').AsInteger;
  if TeamHasCoach(TeamID) then
  begin
    ShowMessage('O time já possui um treinador associado.');
    Exit;
  end else }
  dm.tb_treinador.post;
showmessage('Treinador salvo com sucesso!');
configbotons;
end;

procedure Tfrm_treinador.Button1Click(Sender: TObject);
begin
if txt_buscar.text=''then
begin
  showmessage('Digite algo para pesquisar');
  txt_buscar.setfocus;
  exit;
end;
with dm.sql_con_treinador do
begin
  close;
  sql.clear;
  sql.add('select * from treinadores');
  case rg_opcoes.ItemIndex of
  0:begin
    sql.add('where id_treinador = :codigo');
    parambyname('codigo').value:=txt_buscar.text;
  end;
  1:begin
    sql.add('where nome like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
   2:begin
    sql.add('where sexo like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
  3:begin
    sql.add('where times like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
  end;
  QuantidadeRegistros;
end;

end;

procedure Tfrm_treinador.configbotons;
begin
btn_inserir.visible:=dm.tb_treinador.State in [dsbrowse];
btn_salvar.visible:=dm.tb_treinador.State in [dsinsert, dsedit];
btn_cancelar.visible:=dm.tb_treinador.State in [dsinsert, dsedit];
end;

procedure Tfrm_treinador.Image3Click(Sender: TObject);
begin
if dm.tb_treinador.RecordCount > 0 then  begin
     dm.tb_treinador.Delete;
     dm.tb_treinador.EnableControls;
      dm.sql_con_treinador.Refresh;
end;
end;

procedure Tfrm_treinador.Image4Click(Sender: TObject);
begin
frm_editTreina.showmodal;
end;

procedure Tfrm_treinador.Image5Click(Sender: TObject);
begin
if txt_buscar.text=''then
begin
  showmessage('Digite algo para pesquisar');
  txt_buscar.setfocus;
  exit;
end;
with dm.sql_con_treinador do
begin
  close;
  sql.clear;
  sql.add('select * from treinadores');
  case rg_opcoes.ItemIndex of
  0:begin
    sql.add('where id_treinador = :codigo');
    parambyname('codigo').value:=txt_buscar.text;
  end;
  1:begin
    sql.add('where nome like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
   2:begin
    sql.add('where sexo like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
  3:begin
    sql.add('where times like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
  end;
  open;
  QuantidadeRegistros;
end;
end;


procedure Tfrm_treinador.Image7Click(Sender: TObject);
begin
pagecontrol1.TabIndex:=0;
tb_consul.TabVisible:=false;
tb_cad.visible:=true;



end;

procedure Tfrm_treinador.Image8Click(Sender: TObject);
begin
with dm.sql_con_treinador do
begin
  close;
  sql.clear;
  sql.add('select * from treinadores');
  open;
end;
end;

procedure Tfrm_treinador.QuantidadeRegistros;
begin
if dm.sql_con_treinador.recordcount = 0 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Nenhum dado encontrado';
  btn_imprimir.enabled:=false;
end;
if dm.sql_con_treinador.recordcount = 1 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Foi encontrado 1 registro';
  btn_imprimir.enabled:=true;
end;
if dm.sql_con_treinador.recordcount > 1 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Foram encontrados '+inttostr(dm.sql_con_treinador.recordcount)+' Cadastros';
  btn_imprimir.enabled:=true;
end;
end;

procedure Tfrm_treinador.rg_opcoesClick(Sender: TObject);
begin
case rg_opcoes.ItemIndex of
0:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o Número de registro do treinador';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
1:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o nome do treinador';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
2:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o gênero do treinador';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
3:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o time do treinador';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
end;

end;

procedure Tfrm_treinador.txt_buscarKeyPress(Sender: TObject; var Key: Char);
begin
case rg_opcoes.ItemIndex of
0:begin
  if(key in['0'..'9'] =false)and(word(key)<> VK_BACK)then
  begin
    showmessage('Digite apenas números');
    key:=#0;
  end;
end;
end;
end;

end.
