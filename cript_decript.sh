#!/bin/sh
cript_decript () {
 local CD_CRIPT="Ä,Å,Ç,É,Ñ,Ö,Ü,á,à,â,ä,ã,å,ç,é,è,ê,ë,í,ì,î,ï,ñ,ó,ò,ô,ö,õ,ú,ù,û,ü,†,°,¢,£,§,•,¶,ß,®,©,™,´,¨,≠,Æ,Ø,∞,±,≤,≥,¥,µ,∂,∑,¿,¡,¬,√,ƒ,≈,∆,«,»,…, ,À,Ã,Õ,Œ,œ,–,—,“,”,‘,’,÷,◊,ÿ,Ÿ,⁄,€,‹,›,ﬁ,ﬂ,‡,·,‚,„,‰,Â,Ê,Á,Ë,È,Í,Î,Ï,Ì,Ó,Ô,,Ò,Ú,Û,Ù,ı,ˆ,˜,Ä,Å,Ç,É,Ñ,Ö,Ü,á,à,â,ä,ã,å,ç,é,è,ê,ë,í,ì,î,ï,ñ,ó,ò,ô,ö,õ,ú,ù,û,ü,†,°,¢,£,§,•,¶,ß,®,©,™,´,¨,≠,Æ,Ø,∞,±,≤,≥,¥,µ,∂,∑,¿,¡,¬,√,ƒ,≈,∆,«,»,…, ,À,Ã,Õ,Œ,œ,–,—,“,”,‘,’,÷,◊,ÿ,Ÿ,⁄,€,‹,›,ﬁ,ﬂ,‡,·,‚,„,‰,Â,Ê,Á,Ë,È,Í,Î,Ï,Ì,Ó,Ô,,Ò,Ú,Û,Ù,ı,ˆ,˜"
 local CD_DECRIPT="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9, ,–ê,–ë,–í,–ì,–î,–ï,–Å,–ñ,–ó,–ò,–ô,–ö,–õ,–ú,–ù,–û,–ü,–†,–°,–¢,–£,–§,–•,–¶,–ß,–®,–©,–™,–´,–¨,–≠,–Æ,–Ø,–∞,–±,–≤,–≥,–¥,–µ,—ë,–∂,–∑,–∏,–π,–∫,–ª,–º,–Ω,–æ,–ø,—Ä,—Å,—Ç,—É,—Ñ,—Ö,—Ü,—á,—à,—â,—ä,—ã,—å,—ç,—é,—è"
 local C_COUNT=$(echo "$CD_CRIPT"|awk -F "," '{print NF}')
 local D_COUNT=$(echo "$CD_DECRIPT"|awk -F "," '{print NF}')

 cd_count () {
  #position
  CD_ORDER=""
  for cd_i in $(seq 1 $C_COUNT); do
   CD_ADD="$cd_i"
   if [ -n "$CD_ORDER" ]; then
    CD_ORDER="$CD_ORDER,$CD_ADD"
   else
    CD_ORDER="$CD_ADD"
   fi
  done

#  echo "$CD_ORDER"

  local C_KEY=$(echo "$CD_ORDER"|tr ',' '\n'|shuf|head -n "$D_COUNT"|tr '\n' ','|sed 's/,$//')
  echo $C_KEY
  echo ""
  C_LKEY=$(echo "$C_KEY"|awk -F "," '{print NF}')
 }
 cd_count

 # Atribuir os valores separados por v√≠rgula em $C_COUNT a vari√°veis separadas
# set -- $(echo "$C_COUNT" | tr ',' ' ')

 # Criar uma vari√°vel vazia para armazenar a quarta vari√°vel com a substitui√ß√£o dos elementos
 CD_FINAL=""

 # Iterar sobre as vari√°veis atribu√≠das pelo comando "set" e adicionar os elementos correspondentes de $CD_CRIPT √† vari√°vel CD_FINAL
 for i in $(seq 1 $C_LKEY); do
  # Adicionar o elemento √† vari√°vel CD_FINAL
  if [ -n "$CD_FINAL" ]; then
   CD_FINAL=${CD_FINAL}$(echo "$CD_CRIPT"|cut -d',' -f"$i")
  else
   CD_FINAL=$(echo "$CD_CRIPT"|cut -d',' -f"$i")
  fi
 done

 echo "$CD_FINAL"

}
cript_decript

#echo "$DECRIPT"|sed 's/,//g'
#echo "$DECRIPT"|awk -F "," '{print $1}'
#echo "$DECRIPT"|awk -F "," '{print $129}'
#echo "$DECRIPT" | fold -w2 | shuf
#echo ""

#C_VALUE=""
#for ((cd_i=1; cd_i<=$C_DCOUNT; cd_i++))
#do
# C_DADD=$(echo "$C_DDECRIPT" | awk -v cdi="$cd_i" -F "," '{print $cdi}')
# C_DORDER="${C_DORDER}${C_DADD}"
#done
#echo "$C_DORDER"
