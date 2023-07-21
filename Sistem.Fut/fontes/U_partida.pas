unit U_partida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask,data.Db, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_partida = class(TForm)
    PageControl1: TPageControl;
    partida: TTabSheet;
    consulta: TTabSheet;
    txt_camp: TDBComboBox;
    txt_timecasa: TDBComboBox;
    txt_timefora: TDBComboBox;
    txt_id: TDBEdit;
    txt_data: TDBEdit;
    btn_inserir: TImage;
    btn_salvar: TImage;
    btn_consultar: TImage;
    btn_cancelar: TImage;
    btn_fechar: TImage;
    rg_opcoes: TRadioGroup;
    lb_buscar: TLabel;
    txt_buscar: TEdit;
    Image7: TImage;
    Image6: TImage;
    DBGrid1: TDBGrid;
    Image4: TImage;
    Image5: TImage;
    btn_imprimir: TImage;
    Image8: TImage;
    lb_msg: TLabel;
    procedure btn_inserirClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_consultarClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure rg_opcoesClick(Sender: TObject);
    procedure txt_buscarKeyPress(Sender: TObject; var Key: Char);
    procedure Image5Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private
  procedure ConfigBotons;
  procedure QuantidadeRegistros ;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_partida: Tfrm_partida;

implementation

{$R *.dfm}

uses U_Dm;

procedure Tfrm_partida.btn_cancelarClick(Sender: TObject);
begin
dm.tb_partida.cancel;
configbotons;
end;

procedure Tfrm_partida.btn_consultarClick(Sender: TObject);
begin
pagecontrol1.TabIndex:=1;
consulta.TabVisible:=true;
partida.tabvisible:=false;
end;

procedure Tfrm_partida.btn_fecharClick(Sender: TObject);
begin
if dm.tb_partida.State in [dsinsert, dsedit] then
begin
  showmessage('Salve ou cancele antes de fechar');
  exit;
  end else
  begin
    close;
  end;
end;

procedure Tfrm_partida.btn_inserirClick(Sender: TObject);
begin
dm.tb_partida.active:=true;
dm.tb_partida.insert;
configbotons;
txt_camp.setfocus;
end;

procedure Tfrm_partida.btn_salvarClick(Sender: TObject);
begin
if txt_id.text ='' then
begin
  showmessage('Preencha todos os campo!');
  exit;
  end else
dm.tb_partida.post;
showmessage('Partida salva com sucesso!');
configbotons;
end;


procedure Tfrm_partida.ConfigBotons;
begin
btn_inserir.visible:=dm.tb_partida.State in [dsbrowse];
btn_salvar.visible:=dm.tb_partida.State in [dsinsert, dsedit];
btn_cancelar.visible:=dm.tb_partida.State in [dsinsert, dsedit];
end;

procedure Tfrm_partida.Image4Click(Sender: TObject);
begin
pagecontrol1.TabIndex:=0;
consulta.TabVisible:=false;
partida.tabvisible:=true;
end;

procedure Tfrm_partida.Image5Click(Sender: TObject);
begin
if txt_buscar.text=''then
begin
  showmessage('Digite algo para pesquisar');
  txt_buscar.setfocus;
  exit;
end;
with dm.sql_con_partida do
begin
  close;
  sql.clear;
  sql.add('select * from partida');
  case rg_opcoes.ItemIndex of
  0:begin
    sql.add('where id_partida = :codigo');
    parambyname('codigo').value:=txt_buscar.text;
  end;
  1:begin
    sql.add('where nome_camp like :codigo');
     parambyname('codigo').value:='%'+ txt_buscar.text+'%';
  end;
  end;
  open;
  QuantidadeRegistros;
end;

end;

procedure Tfrm_partida.Image6Click(Sender: TObject);
begin
if dm.tb_partida.RecordCount > 0 then  begin
     dm.tb_partida.Delete;
     dm.tb_partida.EnableControls;
      dm.sql_con_partida.Refresh;
      end;
end;

procedure Tfrm_partida.Image8Click(Sender: TObject);
begin
with dm.sql_con_partida do
begin
  close;
  sql.clear;
  sql.add('select * from partida');
  open;
end;
end;

procedure Tfrm_partida.QuantidadeRegistros;
begin
if dm.sql_con_partida.recordcount = 0 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Nenhum dado encontrado';
  btn_imprimir.enabled:=false;
end;
if dm.sql_con_partida.recordcount = 1 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Foi encontrado 1 registro';
  btn_imprimir.enabled:=true;
end;
if dm.sql_con_partida.recordcount > 1 then
begin
  lb_msg.visible:=true;
  lb_msg.caption:='';
  lb_msg.caption:='Foram encontrados '+inttostr(dm.sql_con_partida.recordcount)+' cadastros';
  btn_imprimir.enabled:=true;
end;
end;

procedure Tfrm_partida.rg_opcoesClick(Sender: TObject);
begin
case rg_opcoes.ItemIndex of
0:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o Número da partida';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
1:begin
txt_buscar.visible:=true;
lb_buscar.caption:='Digite o nome do campeonato';
lb_buscar.visible:=true;
txt_buscar.clear;
image5.visible:=true;
txt_buscar.Setfocus;
end;
end;
end;

procedure Tfrm_partida.txt_buscarKeyPress(Sender: TObject; var Key: Char);
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
