#! /bin/bash

#set -xv

#Le "#set -xv" je le mets toujours, ça me sert à debuguer le script en enlevant le dièse (#). 

clear

#si le nombre d'arguments depasse 1 on quitte le programme avec code 1

if [[ $# -ne 1 ]]
   then 
   echo "Nombre d'argument incorrectes. "
   echo "Utilisation : $0 comme fichier."
   exit 1
fi


#On a cree des fonction pour les different tache a executer

creation ()

{
echo "Lancement de la creation..." && echo -e "\n"
if test -e "$1" 
   then 
   if test -f "$1"
      then 
   echo "Le fichier $1 existe."
   elif test -d "$1"
      then 
      echo "$1 est un repertoire et ne peut pas etre cree."
   fi 
else   
   touch "$1"
   find . -iname  "$1" -exec ls -lh "{}" \;
   echo "Le fichier $1 a ete bien cree. Comme vous le voyez en-dessus"
fi 

#On cree un sous menu qui demandera a l'utilisateur s'il veut quitter le programme ou revenir au menu  principal

while :
do
read -p "Voulez-vous retourner au menu principal? [Oo/Nn]: " touche
 case $touche in
[Oo])    echo -e "Retour au menu  principal !!!\n"
break
;;
[Nn])    echo  "Programme achevé..."
exit 1
;;
*) echo "Mauvaise reponse..."
continue
;;
 esac
done
}

edition ()

{
echo "Lancement de l'edition..." && echo -e "\n"
if test -f "$1"
   then

#une pause

   echo -e "Vous pouvez editer le fichier et quitter.\n "
   echo "Appuyer la touche <Entree> pour continuer..."
   read entre
   case $entre in 
   *) 
   ;;
   esac

#un sous menu qui donne la possibiliter a l'utulisateur de choisir son editeur

     echo "Vous etes libre d'utiliser l'editeur que vous vous sentiez a l'aise"
     echo -e " <v> pour (vi);\n <V> pour (Vim);\n <E/e> pou emacs;\n <N/n> pour (nano)"
     while :
     do 
     read -p "Votre editeur: " editeur && echo -e "\n"
     case ${editeur} in 
     v) 
      vi "$1"
      break
      ;;
     V)  
      vim "$1"
      break
      ;;
    [Ee])
        emacs "$1"
        break
      ;; 
     n)
        nano "$1"
        break
      ;;
     *) echo "Mauvaise choix"
        continue
      ;;
      esac
      done 
   echo "Vous aves edite votre fichier avec $editeur"
else
       if test -d "$1"
          then 
          echo "$1 est un repertoire et ne peut pas etre editer"
       else
          echo "Fichier $1 inexistant"
       fi
fi

#On cree un sous menu qui demandera a l'utilisateur s'il veut quitter le programme ou revenir au principal

while :
   do
read -p "Voulez-vous retourner au menu principal? [Oo/Nn]: " touche
 case $touche in
[Oo])    echo -e "Retour au menu  principal !!!\n"
break
;;
[Nn])    echo  "Programme achevé..."
exit 1
;;
*) echo "Mauvaise reponse..."
continue
;;
 esac
done

}

affichage ()

{
echo "Lancement de l'affichage..." && echo -e "\n"
if test -f "$1"
   then 

#Un sous menu qui permettera a l'utiliateur d choisir son mode d'affichage
 
 echo  "Vous etes libre d'afficher votre ficher avec la commande  que vous voulez:  "
 echo -e " <m> pour (more) qui affiche page par page;\n <l> pour (less) qui affiche page par page comme more mais beaucoup plus puissant et rapige;\n <c> pour (cat) qui affiche tout le contenu du fichier;\n <h> pour (head) qui affiche les 10 premiere lignes;\n <t> pour (tail) qui affiche les 10 dernier lignes."
     while :
     do
     read -p "Votre mode d'affichage svp: " affichage && echo -e "\n" 
     case ${affichage} in
     m)
      more "$1"
      break
      ;;
     l)
      less "$1"
      break
      ;;
    c)
        cat "$1"
        break
      ;;
     h)
        head "$1"
        break
      ;;
     t)
       tail "$1"
       break
       ;;
     *) echo "Mauvaise choix"
        continue
      ;;
      esac
      done
     echo "Vous avez afficher votre fichier avec $affichage"

else 
   if test -d "$1"
      then 
      echo "$1 est un repertoire et ne peut etre visualise"
   else 
      echo "Fichier $1 inexistant "
   fi
fi  

#On cree un sous menu qui demandera a l'utilisateur s'il veut quitter le programme ou revenir au principal

while :
do
read -p "Voulez-vous retourner au menu principal? [Oo/Nn]: " touche
 case $touche in
[Oo])    echo -e "Retour  au menu  principal !!!\n"
break
;;
[Nn])    echo  "Programme achevé..."
exit 1
;;
*) echo "Mauvaise reponse..."
continue
;;
 esac
done
}

suppresion ()

{
echo "Lacement de la suppresion..." && echo -e "\n"
if test -f "$1"
   then 
   rm -r "$1"
   echo "Le fichier $1 a ete bien supprime"
else 
   if test  -d "$1"
      then 
      echo "$1 est un repertoire et ne peut etre supprime"
   else 
      echo "Fichier $1 inexistant "
   fi

fi

#On cree un sous menu qui demandera a l'utilisateur s'il veut quitter le programme ou revenir au principal

while :
do
read -p "Voulez-vous retourner au menu principal? [Oo/Nn]: " touche
 case $touche in
[Oo])    echo -e "Retour au menu  principal !!!\n"
break
;;
[Nn])    echo  "Programme achevé..."
exit 1
;;
*) echo "Mauvaise reponse..."
continue
;;
 esac
done
}

#Un boucle qui permettra a l'utilisateur de retourner au menu principal

while :
do 

#Affichage du menu

#une couleur de retour a la normal du text
neutre="\033[0m"
echo -e "$neutre"

   echo -e "B I E N V E N U    D A N S    L E    M E N U    D E    S Y S T E M E    D E    G E S T I O N    D E    F I C H I E R.\n "

echo -e "\n"
echo -e "\033[1m    ***************** MENU *****************\n"
echo "    1- Creer un fichier                     "
echo "    2- Editer un fichier                    "
echo "    3- Afficher le contenu d'un fichier     "
echo "    4- Supprimer in fichier                 "
echo "    5- Quiter                               " 
echo -e "    ========================================\033[0m\n"
echo -e "Faites votre choix en fonction de vos besoins"
read -p "Enrez votre choix: " choix 
echo -e "\n"

#si le choix saisi est different de 1, 2, 3 et 4
if [[ "$choix" != [1-5] ]]
       then 
       echo -e "Choix incorrecte.\n"

#On donne la possibiliter a l'utilisateur de  quitter ou continuer le programme en ressayant
 
echo "Votre choix est incorrecte, vous avez la possibiliter de quitter ou continue le programme en resseyant."
 echo -e "Appuyez sur la touche <o> comme (Oui) pour continuer ou la touche <n> comme (Non) pour quitter le programme.\n"
while :
do 
read -p "Voulez-vous coninuer ? [Oo/Nn]: " touche
 case $touche in
[Oo])    echo "Reprise du programme..."
break
;;
[Nn])    echo  "Programme achevé..."
exit 1
;;
*) echo "Mauvaise reponse..."
continue
;;
 esac
done
fi

#en fonction du choix, on execute les differentes taches

case "$choix" in

#On fait appel aux fonctions cree

#Le passage de texte en couleur,souligne et en gras  dans le shell est déclenché par la séquence :\033[XXm (\033[X;XXm) 
 
1) echo -e "\033[1;4;31mLa creation d'un fichier.\033[0;31m"
   echo -e "\n"
creation $1
;;
2) echo -e "\033[1;4;34mL'edition d'un fichier.\033[0;34m"
   echo -e "\n"
edition $1
;;
3) echo -e "\033[1;4;33mL'affichage du contenu d'un fichier.\033[0;33m"
   echo -e "\n"
affichage $1
;;
4) echo -e "\033[1;4;32mLa suppression d'un fichier.\033[0;32m"
   echo -e "\n"
suppresion $1
;;
5) echo "Vous avez quitter le menu"
   echo "A bientot"
#Tout c'est bien deroule on quitte le programme avec le code 0
   exit 0
esac

#Pause

echo "Appuyer la touche <Entree> pour continuer..."
   read entre
   case $entre in
   *) clear
   ;;
   esac
done
