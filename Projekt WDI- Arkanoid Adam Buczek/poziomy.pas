unit poziomy;

{$mode objfpc}{$H+}

interface




uses
  Classes, SysUtils, allegro, poczatek,paletka,kulka,crt,panel;

const wiersz1 = 8;
const kolumna1 = 8;
const kolumna2 = 65;



type
klocek_obj = record
       klocek_x:integer;     // pozycja x
       klocek_y:integer;     // pozycja y
       klocek_w:integer;     // szerokosc
       klocek_h:integer;     // wysokosc
       klocek_n:integer;     // ilosc uderzen do zniszczenia
       klocek_bm:^AL_BITMAP;
       klocek_bonus:integer;  // czy klocek zwiera bonus
       klocek_pkt:integer;

end;

var
  tablica_pzm1 : Array[1..wiersz1, 1..kolumna1] of klocek_obj;
  tablica_pzm2 : Array[1..kolumna2] of klocek_obj;

procedure init_pzm1();
procedure wys_pzm1();
function zderzenie_klocek_pzm1(i:integer;j:integer):boolean;
procedure odbice_klocek_pzm1(var z_x:integer; var z_y:integer;i:integer;j:integer);
procedure init_pzm2();
procedure wys_pzm2();
function zderzenie_klocek_pzm2(i:integer):boolean;
procedure odbice_klocek_pzm2(var z_x:integer; var z_y:integer;i:integer);
{procedure init_pzm3();
procedure wys_pzm3();
function zderzenie_klocek_pzm3(i:integer;j:integer):boolean;
procedure odbice_klocek_pzm3(var z_x:integer; var z_y:integer;i:integer;j:integer);}
function spr_wygranej():boolean;
procedure wys_pzm();
procedure init_pzm();

implementation


procedure init_pzm1();
var i,j,x,y:integer;
begin
  x := 0;
  y := 0;
  randomize;
  for i:=1 to wiersz1 do
  begin
    for j:=1 to kolumna1 do
    begin
      tablica_pzm1[i][j].klocek_bm := NIL;

      if (i=1)or (i=2) then begin tablica_pzm1[i][j].klocek_bm := al_load_bmp( 'zielony_klocek.bmp', @al_default_palette);  tablica_pzm1[i][j].klocek_n:=1; end;
      if (i=3)or (i=4) then begin tablica_pzm1[i][j].klocek_bm := al_load_bmp( 'zolty_klocek.bmp', @al_default_palette);  tablica_pzm1[i][j].klocek_n:=2; end;
      if (i=5)or (i=6) then begin tablica_pzm1[i][j].klocek_bm := al_load_bmp( 'pomaranczowy_klocek.bmp', @al_default_palette);  tablica_pzm1[i][j].klocek_n:=3; end;
      if (i=7)or (i=8) then begin tablica_pzm1[i][j].klocek_bm := al_load_bmp( 'czerwony_klocek.bmp', @al_default_palette);  tablica_pzm1[i][j].klocek_n:=4; end;
      tablica_pzm1[i][j].klocek_pkt:=tablica_pzm1[i][j].klocek_n*10;
      if( tablica_pzm1[i][j].klocek_bm = NIL ) then
      begin
        al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
        al_message( 'nie mogę załadować obrazka !' );
        al_exit();
        exit();
      end;
      tablica_pzm1[i][j].klocek_x := x;
      tablica_pzm1[i][j].klocek_y := y;
      x := x + 100;
      tablica_pzm1[i][j].klocek_w := tablica_pzm1[i][j].klocek_bm^.w;
      tablica_pzm1[i][j].klocek_h := tablica_pzm1[i][j].klocek_bm^.h;
      if(random(8)=0)then tablica_pzm1[i][j].klocek_bonus := random(8)+1
      else tablica_pzm1[i][j].klocek_bonus := 0;
    end;
    y:= y + 20;
    x := 0;
  end;
end;

function zderzenie_klocek_pzm1(i:integer;j:integer):boolean;
begin
      if(kulka1.kulka_y+kulka1.kulka_h >= tablica_pzm1[i][j].klocek_y) AND (kulka1.kulka_y <= tablica_pzm1[i][j].klocek_y+tablica_pzm1[i][j].klocek_h)  AND (kulka1.kulka_x+kulka1.kulka_w >= tablica_pzm1[i][j].klocek_x) AND (kulka1.kulka_x <= tablica_pzm1[i][j].klocek_x+tablica_pzm1[i][j].klocek_w) then
      begin
        zderzenie_klocek_pzm1 := true;
      end
      else zderzenie_klocek_pzm1 := false;
end;

procedure odbice_klocek_pzm1(var z_x:integer; var z_y:integer;i:integer;j:integer);
begin
  if ((kulka1.kulka_x+kulka1.kulka_w >= tablica_pzm1[i][j].klocek_x) AND (kulka1.kulka_x < tablica_pzm1[i][j].klocek_x)) OR ((kulka1.kulka_x+kulka1.kulka_w > tablica_pzm1[i][j].klocek_x+tablica_pzm1[i][j].klocek_w) AND(kulka1.kulka_x <= tablica_pzm1[i][j].klocek_x+tablica_pzm1[i][j].klocek_w)) then
    z_x:=-z_x;
  if ((kulka1.kulka_y <= tablica_pzm1[i][j].klocek_y+tablica_pzm1[i][j].klocek_h) AND (kulka1.kulka_y+kulka1.kulka_h > tablica_pzm1[i][j].klocek_y+tablica_pzm1[i][j].klocek_h))  OR ((kulka1.kulka_y+kulka1.kulka_h >= tablica_pzm1[i][j].klocek_y) AND (kulka1.kulka_y < tablica_pzm1[i][j].klocek_y)) then
    z_y:=-z_y;

end;

procedure wys_pzm1();
var i,j:integer;
begin

  for i:=1 to wiersz1 do
  begin
    for j:=1 to kolumna1 do
    begin
      if(tablica_pzm1[i][j].klocek_n <> 0) then
        begin
          al_blit(tablica_pzm1[i][j].klocek_bm, bufor, 0, 0, tablica_pzm1[i][j].klocek_x,tablica_pzm1[i][j].klocek_y, tablica_pzm1[i][j].klocek_w, tablica_pzm1[i][j].klocek_h);
          if(zderzenie_klocek_pzm1(i,j)) then
          begin
            odbice_klocek_pzm1(z_x,z_y,i,j);
            kulka1.kulka_x := kulka1.kulka_x + z_x;
            kulka1.kulka_y := kulka1.kulka_y - z_y;
            if(tablica_pzm1[i][j].klocek_n > 0) then tablica_pzm1[i][j].klocek_n := tablica_pzm1[i][j].klocek_n-1;
            if(tablica_pzm1[i][j].klocek_n = 0) then begin pkt:=pkt+tablica_pzm1[i][j].klocek_pkt; al_destroy_bitmap( tablica_pzm1[i][j].klocek_bm ); end;
          end;
        end;
    end;
  end;
end;




function zderzenie_klocek_pzm2(i:integer):boolean;
begin
      if(kulka1.kulka_y+kulka1.kulka_h >= tablica_pzm2[i].klocek_y) AND (kulka1.kulka_y <= tablica_pzm2[i].klocek_y+tablica_pzm2[i].klocek_h)  AND (kulka1.kulka_x+kulka1.kulka_w >= tablica_pzm2[i].klocek_x) AND (kulka1.kulka_x <= tablica_pzm2[i].klocek_x+tablica_pzm2[i].klocek_w) then
      begin
        zderzenie_klocek_pzm2 := true;
      end
      else zderzenie_klocek_pzm2 := false;
end;

procedure odbice_klocek_pzm2(var z_x:integer; var z_y:integer;i:integer);
begin
  if (i=1) AND ((kulka1.kulka_y+kulka1.kulka_h >= tablica_pzm2[i].klocek_y) AND (kulka1.kulka_y < tablica_pzm2[i].klocek_y)) then tablica_pzm2[i].klocek_n:=0;
  if ((kulka1.kulka_x+kulka1.kulka_w >= tablica_pzm2[i].klocek_x) AND (kulka1.kulka_x < tablica_pzm2[i].klocek_x)) OR ((kulka1.kulka_x+kulka1.kulka_w > tablica_pzm2[i].klocek_x+tablica_pzm2[i].klocek_w) AND(kulka1.kulka_x <= tablica_pzm2[i].klocek_x+tablica_pzm2[i].klocek_w)) then
    z_x:=-z_x;
  if ((kulka1.kulka_y <= tablica_pzm2[i].klocek_y+tablica_pzm2[i].klocek_h) AND (kulka1.kulka_y+kulka1.kulka_h > tablica_pzm2[i].klocek_y+tablica_pzm2[i].klocek_h))  OR ((kulka1.kulka_y+kulka1.kulka_h >= tablica_pzm2[i].klocek_y) AND (kulka1.kulka_y < tablica_pzm2[i].klocek_y)) then
    z_y:=-z_y;

end;



procedure init_pzm2();
var i,x,y:integer;
begin
  x := 0;
  y := 0;
  randomize;
  tablica_pzm2[1].klocek_bm := NIL;
  tablica_pzm2[1].klocek_bm := al_load_bmp( 'zielonoszary_klocek.bmp', @al_default_palette);
  tablica_pzm2[1].klocek_n:=-1;
  tablica_pzm2[1].klocek_pkt:=100;
  tablica_pzm2[1].klocek_x := 400-tablica_pzm2[1].klocek_bm^.w div 2;
  tablica_pzm2[1].klocek_y := 300-tablica_pzm2[1].klocek_bm^.h div 2;
  tablica_pzm2[1].klocek_w := tablica_pzm2[1].klocek_bm^.w;
  tablica_pzm2[1].klocek_h := tablica_pzm2[1].klocek_bm^.h;
  tablica_pzm2[1].klocek_bonus := random(9)+1;


    for i:=2 to kolumna2 do
    begin
      tablica_pzm2[i].klocek_bm := NIL;
      if (i<10) or (i mod 8 = 2) or (i mod 8 = 1) or (i>57) then begin tablica_pzm2[i].klocek_bm := al_load_bmp( 'szary_klocek.bmp', @al_default_palette);  tablica_pzm2[i].klocek_n:=-1; end
      else begin tablica_pzm2[i].klocek_bm := al_load_bmp( 'zolty_klocek.bmp', @al_default_palette);  tablica_pzm2[i].klocek_n:=2 end;

      tablica_pzm2[i].klocek_pkt:=tablica_pzm2[i].klocek_n*10;
      if( tablica_pzm2[i].klocek_bm = NIL ) then
      begin
        al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
        al_message( 'nie mogę załadować obrazka !' );
        al_exit();
        exit();
      end;
      tablica_pzm2[i].klocek_x := x;
      tablica_pzm2[i].klocek_y := y;
      x := x + 100;
      tablica_pzm2[i].klocek_w := tablica_pzm2[i].klocek_bm^.w;
      tablica_pzm2[i].klocek_h := tablica_pzm2[i].klocek_bm^.h;
      if(random(8)=0)then tablica_pzm2[i].klocek_bonus := random(8)+1
      else tablica_pzm2[i].klocek_bonus := 0;
      if (x=800) then begin x:=0; y:=y+20; end;
    end;

end;


procedure wys_pzm2();
var i:integer;
begin
    for i:=1 to kolumna2 do
    begin
      if(tablica_pzm2[i].klocek_n <> 0) then
        begin
          al_blit(tablica_pzm2[i].klocek_bm, bufor, 0, 0, tablica_pzm2[i].klocek_x,tablica_pzm2[i].klocek_y, tablica_pzm2[i].klocek_w, tablica_pzm2[i].klocek_h);
          if(zderzenie_klocek_pzm2(i)) then
          begin
            odbice_klocek_pzm2(z_x,z_y,i);
            kulka1.kulka_x := kulka1.kulka_x + z_x;
            kulka1.kulka_y := kulka1.kulka_y - z_y;
            if(tablica_pzm2[i].klocek_n > 0) then tablica_pzm2[i].klocek_n := tablica_pzm2[i].klocek_n-1;
            if(tablica_pzm2[i].klocek_n = 0) then begin pkt:=pkt+tablica_pzm2[i].klocek_pkt; al_destroy_bitmap( tablica_pzm2[i].klocek_bm ); end;
          end;
        end;
    end;
    if(tablica_pzm2[1].klocek_n = 0) then
    begin
      for i:=2 to kolumna2 do
      begin
        if (i<10) or (i mod 8 = 2) or (i mod 8 = 1) or (i>57) then
        begin
          tablica_pzm2[i].klocek_n:=0;
          al_destroy_bitmap( tablica_pzm2[i].klocek_bm );
        end;
        end;
    end;

end;

procedure init_pzm();
begin
  case pzm of
    1: init_pzm1();
    2: init_pzm2();
  end;
end;

procedure wys_pzm();
begin
  case pzm of
    1: wys_pzm1();
    2: wys_pzm2();
  end;
end;

function spr_wygranej():boolean;
var i,j:integer;
begin
  spr_wygranej:=true;
  case pzm of
    1: begin
         for i:=1 to wiersz1 do
         begin
           for j:=1 to kolumna1 do
           begin
             if(tablica_pzm1[i][j].klocek_n>0) then
             begin
               spr_wygranej:= false;
               exit();
             end;
           end;
         end;
         pzm:=pzm+1;
       end;
    2: begin
         for i:=1 to kolumna2 do
           begin
             if(tablica_pzm2[i].klocek_n>0) then
             begin
               spr_wygranej:= false;
               exit();
             end;
           end;
           pzm:=pzm+1;
         end;
  end;
end;

end.

