unit bonusy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, allegro, paletka,kulka, poziomy,poczatek,panel;


type bonuslist = ^bonus_obj;
bonus_obj = record
	bonus_x:integer;     // pozycja x
	bonus_y:integer;     // pozycja y
        bonus_w:integer;     // szerokosc
        bonus_h:integer;     // wysokosc
        bonus_next:bonuslist;
	bonus_bm:^AL_BITMAP; // bitmapa
        bonus_i:integer;
        bonus_j:integer;
end;

var
  bonus1:bonuslist;
  bonus2:bonuslist;

procedure powieksz_paletka();
procedure zmniejsz_paletka();
procedure szybsza_paletka();
procedure wolniejsza_paletka();
procedure szybsza_kulka();
procedure wolniejsza_kulka();
procedure multi_kulka();
function odwrotne_sterowanie():boolean;
procedure life_plus();
function zderzenie_bonus_paletka(zderzajacy:bonuslist):boolean;
procedure init_bonusy1();
procedure wys_bonusy1();
procedure wstaw1(i:integer;j:integer);
procedure usun1(usuwany:bonuslist);
procedure init_bonusy2();
procedure wys_bonusy2();
procedure wstaw2(i:integer);
procedure usun2(usuwany:bonuslist);
procedure wys_paletke();
procedure init_bonusy();
procedure wys_bonusy();


implementation



procedure wstaw1(i:integer;j:integer);
var tmp:bonuslist;
begin
  new(tmp);
  tmp^.bonus_bm := NIL;
  case tablica_pzm1[i][j].klocek_bonus of
    1: tmp^.bonus_bm := al_load_bmp( 'kulka_vplus.bmp', @al_default_palette);
    2: tmp^.bonus_bm := al_load_bmp( 'kulka_vminus.bmp', @al_default_palette);
    3: tmp^.bonus_bm := al_load_bmp( 'paletka_plus.bmp', @al_default_palette);
    4: tmp^.bonus_bm := al_load_bmp( 'paletka_minus.bmp', @al_default_palette);
    5: tmp^.bonus_bm := al_load_bmp( 'paletka_vplus.bmp', @al_default_palette);
    6: tmp^.bonus_bm := al_load_bmp( 'paletka_vminus.bmp', @al_default_palette);
    7: tmp^.bonus_bm := al_load_bmp( 'paletka_zmiana_kierunku.bmp', @al_default_palette);
    8: tmp^.bonus_bm := al_load_bmp( 'dodatkowe_zycie.bmp', @al_default_palette);
  end;
  if( tmp^.bonus_bm = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka 2!' );
    al_exit();
    exit();
  end;
  tmp^.bonus_w:=tmp^.bonus_bm^.w;
  tmp^.bonus_h:=tmp^.bonus_bm^.h;
  tmp^.bonus_x:=tablica_pzm1[i][j].klocek_x+40;
  tmp^.bonus_y:=tablica_pzm1[i][j].klocek_y;
  tmp^.bonus_i:=i;
  tmp^.bonus_j:=j;

  tmp^.bonus_next := bonus1;
  bonus1 := tmp;

  tmp:=NIL;
  dispose(tmp);
end;


procedure wstaw2(i:integer);
var tmp:bonuslist;
begin
  new(tmp);
  tmp^.bonus_bm := NIL;
  case tablica_pzm2[i].klocek_bonus of
    1: tmp^.bonus_bm := al_load_bmp( 'kulka_vplus.bmp', @al_default_palette);
    2: tmp^.bonus_bm := al_load_bmp( 'kulka_vminus.bmp', @al_default_palette);
    3: tmp^.bonus_bm := al_load_bmp( 'paletka_plus.bmp', @al_default_palette);
    4: tmp^.bonus_bm := al_load_bmp( 'paletka_minus.bmp', @al_default_palette);
    5: tmp^.bonus_bm := al_load_bmp( 'paletka_vplus.bmp', @al_default_palette);
    6: tmp^.bonus_bm := al_load_bmp( 'paletka_vminus.bmp', @al_default_palette);
    7: tmp^.bonus_bm := al_load_bmp( 'paletka_zmiana_kierunku.bmp', @al_default_palette);
    8: tmp^.bonus_bm := al_load_bmp( 'dodatkowe_zycie.bmp', @al_default_palette);
  end;
  if( tmp^.bonus_bm = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka 1!' );
    al_exit();
    exit();
  end;
  tmp^.bonus_w:=tmp^.bonus_bm^.w;
  tmp^.bonus_h:=tmp^.bonus_bm^.h;
  tmp^.bonus_x:=tablica_pzm2[i].klocek_x+40;
  tmp^.bonus_y:=tablica_pzm2[i].klocek_y;
  tmp^.bonus_i:=i;

  tmp^.bonus_next := bonus2;
  bonus2 := tmp;

  tmp:=NIL;
  dispose(tmp);
end;

procedure usun1(usuwany:bonuslist);
var tmp,tmp2:bonuslist;
begin
  new(tmp);
  new(tmp2);
  tmp:=bonus1;
  if (tmp = usuwany) then
  begin
    bonus1 := bonus1^.bonus_next;
    tmp2:=usuwany;
  end
  else
  begin
   tmp2:=usuwany;
   while (tmp^.bonus_next <> tmp2) do tmp:=tmp^.bonus_next;
   tmp^.bonus_next:=tmp2^.bonus_next;
  end;
  al_destroy_bitmap( tmp2^.bonus_bm );
  tmp:=NIL;
  dispose(tmp);
  dispose(tmp2);

end;

procedure usun2(usuwany:bonuslist);
var tmp,tmp2:bonuslist;
begin
  new(tmp);
  new(tmp2);
  tmp:=bonus2;
  if (tmp = usuwany) then
  begin
    bonus2 := bonus2^.bonus_next;
    tmp2:=usuwany;
  end
  else
  begin
   tmp2:=usuwany;
   while (tmp^.bonus_next <> tmp2) do tmp:=tmp^.bonus_next;
   tmp^.bonus_next:=tmp2^.bonus_next;
  end;
  al_destroy_bitmap( tmp2^.bonus_bm );
  tmp:=NIL;
  dispose(tmp);
  dispose(tmp2);

end;

procedure init_bonusy1();
var i,j:integer;
begin
  bonus1 := NIL;


  for i:=1 to wiersz1 do
  begin
    for j:=1 to kolumna1 do
    begin
     if (tablica_pzm1[i][j].klocek_bonus <> 0) then wstaw1(i,j);
    end;
  end;
end;

procedure init_bonusy2();
var i:integer;
begin
  bonus2 := NIL;
  for i:=1 to kolumna2 do
  begin
    if (tablica_pzm2[i].klocek_bonus <> 0) then wstaw2(i);
  end;
end;

procedure powieksz_paletka();
begin
  if(paletka1.paletka_w<200) then paletka1.paletka_w:=paletka1.paletka_w+50;
end;

procedure zmniejsz_paletka();
begin
  if(paletka1.paletka_w>50) then paletka1.paletka_w:=paletka1.paletka_w-50;
end;

procedure szybsza_paletka();
begin
  if(Vp<10) then Vp:=Vp+2;
end;

procedure wolniejsza_paletka();
begin
  if(Vp>2) then Vp:=Vp-2;
end;

procedure szybsza_kulka();
begin
  if(Vk<10) then Vk:=Vk+2;
end;

procedure wolniejsza_kulka();
begin
  if(Vk>2) then Vk:=Vk-2;
end;

procedure multi_kulka();
begin

end;

function odwrotne_sterowanie():boolean;
begin
 if(sterowanie) then odwrotne_sterowanie := true
 else odwrotne_sterowanie := false
end;
procedure wys_paletke();
begin
 if(odwrotne_sterowanie())then
 begin
   if( al_key[ AL_KEY_RIGHT ] ) AND (paletka1.paletka_x > 0) then begin if(paletka1.paletka_x-Vp<0) then paletka1.paletka_x:=0 else paletka1.paletka_x := paletka1.paletka_x-Vp; end;
   if( al_key[ AL_KEY_LEFT ] ) AND (paletka1.paletka_x+paletka1.paletka_w < 800) then begin if(paletka1.paletka_x+paletka1.paletka_w+Vp>800) then paletka1.paletka_x:=800-paletka1.paletka_w else paletka1.paletka_x := paletka1.paletka_x+Vp; end;
 end
 else
 begin
   if( al_key[ AL_KEY_LEFT ] ) AND (paletka1.paletka_x > 0) then begin if(paletka1.paletka_x-Vp<1) then paletka1.paletka_x:=1 else paletka1.paletka_x := paletka1.paletka_x-Vp; end;
   if( al_key[ AL_KEY_RIGHT ] ) AND (paletka1.paletka_x+paletka1.paletka_w < 800) then begin if(paletka1.paletka_x+paletka1.paletka_w+Vp>799) then paletka1.paletka_x:=799-paletka1.paletka_w else paletka1.paletka_x := paletka1.paletka_x+Vp; end;
 end;
 al_blit(paletka1.paletka_bm, bufor, 0, 0, paletka1.paletka_x, paletka1.paletka_y, paletka1.paletka_w , paletka1.paletka_h);
end;

procedure life_plus();
begin
 zycie:=zycie+1;
end;

function zderzenie_bonus_paletka(zderzajacy:bonuslist):boolean;
begin
  if (zderzajacy^.bonus_y+zderzajacy^.bonus_h >= wysokosc-paletka1.paletka_h) AND (zderzajacy^.bonus_x+zderzajacy^.bonus_w  >= paletka1.paletka_x) AND (zderzajacy^.bonus_x+zderzajacy^.bonus_w div 2 <= paletka1.paletka_x+paletka1.paletka_w) then
    zderzenie_bonus_paletka := true
  else zderzenie_bonus_paletka := false;
end;



procedure wys_bonusy1();
var tmp:bonuslist; i,j:integer;
begin
  new(tmp);
  for i:=1 to wiersz1 do
  begin
    for j:=1 to kolumna1 do
    begin
     tmp:=bonus1;
     if(tablica_pzm1[i][j].klocek_n=0) AND (tablica_pzm1[i][j].klocek_bonus<>0) then
     begin
       while (tmp<>NIL) AND ((tmp^.bonus_i<>i) OR (tmp^.bonus_j<>j)) do
       begin
        tmp:=tmp^.bonus_next;
       end;
       if(tmp <> NIL) then
       begin
         al_blit(tmp^.bonus_bm, bufor, 0, 0, tmp^.bonus_x, tmp^.bonus_y, tmp^.bonus_w , tmp^.bonus_h);
         tmp^.bonus_y:=tmp^.bonus_y+1;
         if(tmp^.bonus_y>600) or (zderzenie_bonus_paletka(tmp)) then
         begin
           if (zderzenie_bonus_paletka(tmp)) then begin
             case tablica_pzm1[i][j].klocek_bonus of
                1: szybsza_kulka();
                2: wolniejsza_kulka();
                3: powieksz_paletka();
                4: zmniejsz_paletka();
                5: szybsza_paletka();
                6: wolniejsza_paletka();
                7: begin if(sterowanie) then else sterowanie:=true; odwrotne_sterowanie(); end;
                8: life_plus();
             end;
           end;
           usun1(tmp);
         end;
       end;
     end;
     tmp:=NIL;
    end;
  end;
  dispose(tmp);
end;



procedure wys_bonusy2();
var tmp:bonuslist; i:integer;
begin
  new(tmp);

    for i:=1 to kolumna2 do
    begin
     tmp:=bonus2;
     if(tablica_pzm2[i].klocek_n=0) AND (tablica_pzm2[i].klocek_bonus<>0) then
     begin
       while (tmp<>NIL) AND (tmp^.bonus_i<>i) do
       begin
        tmp:=tmp^.bonus_next;
       end;
       if(tmp <> NIL) then
       begin
         al_blit(tmp^.bonus_bm, bufor, 0, 0, tmp^.bonus_x, tmp^.bonus_y, tmp^.bonus_w , tmp^.bonus_h);
         tmp^.bonus_y:=tmp^.bonus_y+1;
         if(tmp^.bonus_y>600) or (zderzenie_bonus_paletka(tmp)) then
         begin
           if (zderzenie_bonus_paletka(tmp)) then begin
             case tablica_pzm2[i].klocek_bonus of
                1: szybsza_kulka();
                2: wolniejsza_kulka();
                3: powieksz_paletka();
                4: zmniejsz_paletka();
                5: szybsza_paletka();
                6: wolniejsza_paletka();
                7: begin if(sterowanie) then else sterowanie:=true; odwrotne_sterowanie(); end;
                8: life_plus();
             end;
           end;
           usun2(tmp);
         end;
       end;
     end;
     tmp:=NIL;
    end;

  dispose(tmp);

end;


procedure init_bonusy();
begin
  case pzm of
    1: init_bonusy1();
    2: init_bonusy2();
  end;
end;

procedure wys_bonusy();
begin
  case pzm of
    1: wys_bonusy1();
    2: wys_bonusy2();
  end;
end;

end.

