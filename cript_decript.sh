#!/bin/sh
cript_decript () {
 local CD_CRIPT="€,,‚,ƒ,„,…,†,‡,ˆ,‰,Š,‹,Œ,,Ž,,,‘,’,“,”,•,–,—,˜,™,š,›,œ,,ž,Ÿ, ,¡,¢,£,¤,¥,¦,§,¨,©,ª,«,¬,­,®,¯,°,±,²,³,´,µ,¶,·,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,€,,‚,ƒ,„,…,†,‡,ˆ,‰,Š,‹,Œ,,Ž,,,‘,’,“,”,•,–,—,˜,™,š,›,œ,,ž,Ÿ, ,¡,¢,£,¤,¥,¦,§,¨,©,ª,«,¬,­,®,¯,°,±,²,³,´,µ,¶,·,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷"
 local CD_DECRIPT="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9, ,Ð,Ð‘,Ð’,Ð“,Ð”,Ð•,Ð,Ð–,Ð—,Ð˜,Ð™,Ðš,Ð›,Ðœ,Ð,Ðž,ÐŸ,Ð ,Ð¡,Ð¢,Ð£,Ð¤,Ð¥,Ð¦,Ð§,Ð¨,Ð©,Ðª,Ð«,Ð¬,Ð­,Ð®,Ð¯,Ð°,Ð±,Ð²,Ð³,Ð´,Ðµ,Ñ‘,Ð¶,Ð·,Ð¸,Ð¹,Ðº,Ð»,Ð¼,Ð½,Ð¾,Ð¿,Ñ€,Ñ,Ñ‚,Ñƒ,Ñ„,Ñ…,Ñ†,Ñ‡,Ñˆ,Ñ‰,ÑŠ,Ñ‹,ÑŒ,Ñ,ÑŽ,Ñ"
 local C_COUNT=$(echo "$CD_CRIPT"|awk -F "," '{print NF}')
 local D_COUNT=$(echo "$CD_DECRIPT"|awk -F "," '{print NF}')

 cd_count () {
  printf "\nGenerating randomness factor...\n"
  local CD_ORDER=""
  #/in
  for cd_i in $(seq 1 $CD_COUNT); do
   local CD_ADD="$cd_i"
   if [ -n "$CD_ORDER" ]; then
    local CD_ORDER="$CD_ORDER,$CD_ADD"
   else
    local CD_ORDER="$CD_ADD"
   fi
  done

  CD_KEY=$(echo "$CD_ORDER"|tr ',' '\n'|shuf|head -n "$D_COUNT"|tr '\n' ','|sed 's/,$//')
  C_TOTAL=$(echo "$CD_CRIPT"|awk -F "," '{print NF}')
  printf "\nRandom factor with ${C_TOTAL} characters âœ“\n"
 }
 cd_count

 printf "\nGenerating random encryption key...\n"
 local CD_SECRET=""

 for i in $(seq 1 $C_TOTAL); do
  local CD_I=$(echo "$CD_KEY"|cut -d',' -f"$i")
  if [ -n "$CD_SECRET" ]; then
   local CD_SECRET=${CD_SECRET},$(echo "$CD_CRIPT"|cut -d',' -f"$CD_I")
  else
   local CD_SECRET=$(echo "$CD_CRIPT"|cut -d',' -f"$CD_I")
  fi
 done
 printf "\nKey generated âœ“\n"
# echo "$CD_DECRIPT"|awk -F "," '{print NF}'
# echo ""
# echo "$CD_SECRET"|awk -F "," '{print NF}'
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
