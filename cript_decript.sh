#!/bin/sh
cript_decript () {
# local CriptChars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"
 local CriptChars="200,201,202,203,204,205,206,207,210,211,212,213,214,215,216,217,220,221,222,223,224,225,226,227,230,231,232,233,234,235,236,237,240,241,242,243,244,245,246,247,250,251,252,253,254,255,256,257,260,261,262,263,264,265,266,267,300,301,302,303,304,305,306,307,310,311,312,313,314,315,316,317,320,321,322,323,324,325,326,327,330,331,332,333,334,335,336,337,340,341,342,343,344,345,346,347,350,351,352,353,354,355,356,357,360,361,362,363,364,365,366,367,600,601,602,603,604,605,606,607,610,611,612,613,614,615,616,617,620,621,622,623,624,625,626,627,630,631,632,633,634,635,636,637,640,641,642,643,644,645,646,647,650,651,652,653,654,655,656,657,660,661,662,663,664,665,666,667,700,701,702,703,704,705,706,707,710,711,712,713,714,715,716,717,720,721,722,723,724,725,726,727,730,731,732,733,734,735,736,737,740,741,742,743,744,745,746,747,750,751,752,753,754,755,756,757,760,761,762,763,764,765,766,767"
 local DecriptChars="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,А,Б,В,Г,Д,Е,Ё,Ж,З,И,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ъ,Ы,Ь,Э,Ю,Я,а,б,в,г,д,е,ё,ж,з,и,й,к,л,м,н,о,п,р,с,т,у,ф,х,ц,ч,ш,щ,ъ,ы,ь,э,ю,я"
 local AllCript=$(echo "$CriptChars"|awk -F "," '{print NF}')
 local AllDecript=$(echo "$DecriptChars"|awk -F "," '{print NF}')

 ElementsPosition () {
  printf "\nGenerating randomness factor..."
  local PositionOrder=""
  #/in
  for OriginalPosition in $(seq 1 $AllCript); do
   local AddElement="$OriginalPosition"
   if [ -n "$PositionOrder" ]; then
    local PositionOrder="$PositionOrder,$AddElement"
   else
    local PositionOrder="$AddElement"
   fi
   printf "."
  done

  SelectedPositions=$(echo "$PositionOrder"|tr ',' '\n'|shuf|head -n "$AllDecript"|tr '\n' ','|sed 's/,$//')
  printf "\nRandom factor with ${AllCript} characters ✓\n"
 }
 ElementsPosition

 printf "\nGenerating random encryption key..."
 local RandomChars=""
 for ReferencePosition in $(seq 1 $AllCript); do
  local OriginalPosition=$(echo "$SelectedPositions"|cut -d',' -f"$ReferencePosition")
  if [ -n "$RandomChars" ]; then
   local RandomChars=${RandomChars},$(printf "$CriptChars"|cut -d',' -f"$OriginalPosition")
  else
   local RandomChars=$(printf "$CriptChars"|cut -d',' -f"$OriginalPosition")
  fi
  printf "."
 done
 printf "\nKey generated ✓\n"
 unset SelectedPosition
 printf "Encrypting..."
 for ReferencePosition in $(seq 1 $AllDecript); do
  local OpenChars=$(echo "$DecriptChars"|awk -F',' '{print $'"$ReferencePosition"'}')
  local ClosedChars=$(echo "$RandomChars"|awk -F',' '{print $'"$ReferencePosition"'}')
  printf "$OpenChars:\\$ClosedChars\n"
  sed -i 's/'"$OpenChars"'/'"\o$ClosedChars"'/g' cript_file
  printf "."
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
