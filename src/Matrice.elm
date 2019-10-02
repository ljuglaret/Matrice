module Matrice exposing (Matrice , somme, transposee,produit)

{-| 

# Definition
@docs Matrice

# Fonctions
@docs somme, transposee, produit

-}

{-|-}
type Matrice a =  Matrice (List (List a))

{-|-}
matriceRect : Matrice number -> Bool
matriceRect (Matrice a) =  List.all (\x-> x)
                    (List.filterMap (
                        \l -> List.head a |> Maybe.andThen (\tetej -> Just (List.length tetej == List.length l))) a)
{-|-}
matriceTaillesColonnes: Matrice number -> List Int 
matriceTaillesColonnes (Matrice a) = List.map (\elt -> List.length elt) a

{-|-}
tailleMatriceRect : Matrice number -> Maybe (Int,Int) 
tailleMatriceRect (Matrice a) = 
    if (matriceRect (Matrice a) )
    then Just (List.length a,   (List.foldr(+) 0 (matriceTaillesColonnes (Matrice a )))  // (List.length a))
    else Nothing

{-|-}
tailleMatriceRectTranspo : Matrice number -> Maybe(Int,Int) 
tailleMatriceRectTranspo m = 
    case (tailleMatriceRect m) of 
        Just x -> Just (Tuple.second x, Tuple.first x)
        Nothing -> Nothing

{-|-}
matriceRectMemeTailles : Matrice number -> Matrice number -> Bool
matriceRectMemeTailles (Matrice a) (Matrice b) =
    if (matriceRect (Matrice a)) &&(matriceRect (Matrice b)) && ((List.length a ) == (List.length b ))
    then List.all(\x -> x) (List.map2 (==) (matriceTaillesColonnes (Matrice a)) (matriceTaillesColonnes (Matrice b)))
    else False 
    

{-|-}
add2listes  : List ( List number) -> List ( List number) -> List ( List number) 
add2listes listeVal1 listeVal2 =
    List.map2  (\l1 l2 -> (List.map2 (+) l1 l2))
        listeVal1 listeVal2 


{-|Somme sur deux matrices de mêmes dimensions -}
somme :  Matrice number -> Matrice number -> Maybe (Matrice number)
somme  (Matrice m1) (Matrice m2) = 
    if (  matriceRectMemeTailles (Matrice m1) (Matrice m2))
    then  Just (Matrice (add2listes m1 m2))    
    else Nothing



{-|-}
transposee : Matrice number -> Maybe (Matrice number)
transposee (Matrice a) =
    if (matriceRect (Matrice a ))
    then
        let 
            aux acc l = 
                if (List.take 1 l== [[]])  
                then Just (Matrice acc)
                else aux  (acc++[(List.concatMap (\elt -> List.take 1 elt ) l)])
                            (List.map (\elt1 -> List.drop 1 elt1 ) l)
        in aux [] a  
    else Nothing

{-|-}
produitScalaire : List number -> List number -> number
produitScalaire a b = List.sum (List.map2(*) a b )

{-|-}
produit  : Matrice number ->  Matrice number  -> Maybe (Matrice number) 
produit l1 l2 = 
    let 
       
        l2t = transposee l2 
    in
        case ((tailleMatriceRect l1), (tailleMatriceRect l2))of 
            (Just taille1, Just taille2) -> 
                if (Tuple.second taille1 == Tuple.first taille2 )
                then
                    case (l1,l2t) of
                        (Matrice ml1, Just (Matrice ml2t)) -> 
                            Just (Matrice (
                                    List.map(\elt1 ->
                                        (List.map(\elt2 -> 
                                            produitScalaire elt1 elt2) ml2t))ml1)
                                )
                        
                        _ -> Nothing
                else  Nothing
            _ -> Nothing
      
