unit panel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, allegro, poczatek;

var
   tlo,menu_t,wy,wyborpzm,pp1,pp2,pp3,nowa_gra,wznow : ^AL_BITMAP;
   font_pcx : AL_FONTptr;
   zycie,pkt,pzm,nr_menu:integer;



procedure init_panel();
procedure wys_panel();
procedure init_menu();
procedure wys_menu();
procedure klik_myszka();

implementation

procedure init_menu();
begin
  pzm:=1;
  nr_menu:=1;
  zycie:=3;
  pkt:=0;
  menu_t := NIL;
  menu_t := al_load_bmp( 'menu_tlo.bmp', @al_default_palette);
  if( menu_t = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  wy:= al_load_bmp( 'menu_wyjscie.bmp', @al_default_palette);
  if( wy = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  wyborpzm:= al_load_bmp( 'menu_wyborpzm.bmp', @al_default_palette);
  if( wyborpzm = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  pp1:= al_load_bmp( 'menu_pzm1.bmp', @al_default_palette);
  if( pp1 = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  pp2:= al_load_bmp( 'menu_pzm2.bmp', @al_default_palette);
  if( pp2 = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  pp3:= al_load_bmp( 'menu_pzm3.bmp', @al_default_palette);
  if( pp3 = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  nowa_gra:= al_load_bmp( 'menu_nowa.bmp', @al_default_palette);
  if( nowa_gra = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  wznow:= al_load_bmp( 'menu_wznow.bmp', @al_default_palette);
  if( wznow = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
end;

procedure wys_menu();
begin
  al_blit(menu_t, bufor, 0, 0, 0, 0, menu_t^.w, menu_t^.h);
  case nr_menu of
    1: begin
         al_blit(nowa_gra, bufor, 0, 0, 200, 150, nowa_gra^.w, nowa_gra^.h);
         al_blit(wyborpzm, bufor, 0, 0, 200, 300, wyborpzm^.w, wyborpzm^.h);
         al_blit(wy, bufor, 0, 0, 200, 450, wy^.w, wy^.h);
       end;
    2: begin
         al_blit(pp1, bufor, 0, 0, 200, 150, pp1^.w, pp1^.h);
         al_blit(pp2, bufor, 0, 0, 200, 260, pp2^.w, pp2^.h);
         al_blit(pp3, bufor, 0, 0, 200, 370, pp3^.w, pp3^.h);
         al_blit(wy, bufor, 0, 0, 200, 480, wy^.w, wy^.h);
       end;
    3: begin
         al_blit(wznow, bufor, 0, 0, 200, 250, wznow^.w, wznow^.h);
         al_blit(wy, bufor, 0, 0, 200, 450, wy^.w, wy^.h);
       end;
  end;
end;

procedure klik_myszka();
begin
  case nr_menu of
    1: if (al_mouse_b=1) then
       begin
         if (al_mouse_x>200) AND (al_mouse_x<800) then
         begin
           if (al_mouse_y>150) AND (al_mouse_y<250) then nr_menu:=4;
           if (al_mouse_y>300) AND (al_mouse_y<400) then nr_menu:=2;
           if (al_mouse_y>450) AND (al_mouse_y<550) then nr_menu:=0;
         end;
         al_mouse_b:=0;
       end;
    2: if (al_mouse_b=1) then
       begin
         if (al_mouse_x>200) AND (al_mouse_x<800) then
         begin
           if (al_mouse_y>150) AND (al_mouse_y<250) then begin nr_menu:=4; pzm:=1; end;
           if (al_mouse_y>260) AND (al_mouse_y<360) then begin nr_menu:=4; pzm:=2; end;
           if (al_mouse_y>370) AND (al_mouse_y<470) then begin nr_menu:=0; pzm:=3; end;
           if (al_mouse_y>480) AND (al_mouse_y<580) then nr_menu:=0;
         end;
         al_mouse_b:=0;
       end;
    3: if (al_mouse_b=1) then
       begin
         if (al_mouse_x>200) AND (al_mouse_x<800) then
         begin
           if (al_mouse_y>250) AND (al_mouse_y<350) then nr_menu:=4;
           if (al_mouse_y>450) AND (al_mouse_y<550) then nr_menu:=0;
         end;
         al_mouse_b:=0;
       end;
  end;
end;

procedure init_panel();
begin
  zycie:=3;
  pkt:=0;
  pzm:=1;
  font_pcx := al_load_font('My_Font.pcx',@al_default_palette, NIL);
  //writeln(font_pcx=NIL);
  tlo := NIL;
  tlo := al_load_bmp( 'tlo_panel.bmp', @al_default_palette);
  if( tlo = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka Tlo_Panel !' );
    al_exit();
    exit();
  end;
end;
procedure wys_panel();
begin
  al_blit (tlo, bufor, 0, 0, 800, 0, tlo^.w, tlo^.h);
  al_textout_ex( bufor, font_pcx, IntToStr(zycie), 920, 252, al_makecol( 0, 0, 0 ), - 1 );
  al_textout_ex( bufor, font_pcx, IntToStr(pkt), 820, 80, al_makecol( 0, 0, 0 ), - 1 );
  al_textout_ex( bufor, font_pcx, IntToStr(pzm), 950, 460, al_makecol( 0, 0, 0 ), - 1 );
  if (zycie=0) then
  begin
    al_destroy_bitmap(tlo);
    //al_destroy_font(font_pcx);
  end;
end;

end.

