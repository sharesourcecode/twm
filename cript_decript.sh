#!/bin/bash
cript_decript () {
 local CriptChars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"
 local DecriptChars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"
 local AllCript=$(echo "$CriptChars"|awk -F "," '{print NF}')
 local AllDecript=$(echo "$DecriptChars"|awk -F "," '{print NF}')

 ElementsPosition () {
  printf "\nGenerating randomness factor...\n"
  local PositionOrder=""
  #/in
  for OriginalPosition in $(seq 1 $AllCript); do
   local AddElement="$OriginalPosition"
   if [ -n "$PositionOrder" ]; then
    local PositionOrder="$PositionOrder,$AddElement"
   else
    local PositionOrder="$AddElement"
   fi
  done

  SelectedPositions=$(echo "$PositionOrder"|tr ',' '\n'|shuf|head -n "$AllDecript"|tr '\n' ','|sed 's/,$//')
  printf "\nRandom factor with ${AllCript} characters ✓\n"
 }
 ElementsPosition

 printf "\nGenerating random encryption key...\n"
 local RandomChars=""
 for ReferencePosition in $(seq 1 $AllCript); do
  local OriginalPosition=$(echo "$SelectedPositions"|cut -d',' -f"$ReferencePosition")
  if [ -n "$RandomChars" ]; then
   local RandomChars=${RandomChars},$(printf "$CriptChars"|cut -d',' -f"$OriginalPosition")
  else
   local RandomChars=$(printf "$CriptChars"|cut -d',' -f"$OriginalPosition")
  fi
 done
 printf "\nKey generated ✓\n"
 unset SelectedPosition

 for ReferencePosition in $(seq 1 $AllDecript); do
  local OpenChars=$(echo "$DecriptChars"|awk -F',' '{print $'"$ReferencePosition"'}')
  local ClosedChars=$(echo "$RandomChars"|awk -F',' '{print $'"$ReferencePosition"'}')
  printf "$OpenChars:$ClosedChars\n"
  sed -i "s/$OpenChars/$ClosedChars/g" cript_file
 done
 unset CriptChars DecriptChars RandomChars ReferencePosition

# echo "$DecriptChars"|awk -F "," '{print NF}'
# echo ""
# echo "$RandomChars"|awk -F "," '{print NF}'
 echo "$RandomChars"
}
cript_decript

#echo "$DECRIPT"|sed 's/,//g'
#echo "$DECRIPT"|awk -F "," '{print $1}'
#echo "$DECRIPT"|awk -F "," '{print $129}'
#echo "$DECRIPT" | fold -w2 | shuf
#echo ""

#C_VALUE=""
#for ((OriginalPosition=1; OriginalPosition<=$C_DCOUNT; OriginalPosition++))
#do
# C_DADD=$(echo "$C_DDECRIPT" | awk -v cdi="$OriginalPosition" -F "," '{print $cdi}')
# C_DORDER="${C_DORDER}${C_DADD}"
#done
#echo "$C_DORDER"
