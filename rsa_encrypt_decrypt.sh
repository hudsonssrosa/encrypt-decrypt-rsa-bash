#!/bin/bash

# Cores
Cp="\033[0m" # cor padrao
Cr="\033[0;31m" # red
Cg="\033[0;32m" # green
Cy="\033[1;33m" # yellow
Cb="\033[1;37m" # blue

teclar_enter_continuar(){
        echo " "
        echo -e "${Cy} >>> Pressione a tecla 'ENTER' para continuar... ${Cp}"
        read tecla
        clear
}

listar_primos(){
echo "_____________________________________________________________"
echo "  Listando números primos a partir de um valor limite"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo -e "${Cp} >>> Para começar, indique um valor máximo para obter todos os primos que o antecedem: ${Cp}"
read numero_limite

escala_limite_primos=`seq $numero_limite | factor | awk -F \: '$1 == $2{ print $1}' | column -x`
echo " "
echo "$escala_limite_primos"
}

definir_valor_p(){
echo "_____________________________________________________________"
echo "  a- Solicitar um número primo inteiro ao usuário, número (p)"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo -e "${Cp} >>> Entre com um valor para o número P ${Cp}"
read num_p
echo " "
echo -e "${Cb}                      P = $num_p ${Cp}"
}

definir_valor_q(){
echo "_______________________________________________________________________________________"
echo "  b- Solicitar um número primo inteiro ao usuário, número (q) diferente e maior que (p)"
echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
echo -e "${Cp} >>> Entre com um valor para o número Q ${Cp}"
read num_q
echo " "
echo -e "${Cb}                      Q = $num_q ${Cp}"
sleep 1
}

# Definindo valores P e Q primos
clear
listar_primos
while [[ "x$numero_limite" == "x" || $numero_limite -le 0 ]] ; do
        clear
        listar_primos
done
definir_valor_p
definir_valor_q

clear
echo " Verificando se P e Q são realmente primos..."
echo " "

if [[ $num_p -ne 0 && $num_q -ne 0 ]] ; then
        if [ $num_p -gt 1 ] ; then
                
                Div=2
                resto=0

                while [ $Div -ne $num_p ] ; do
                        resto=$(expr $num_p % $Div)

                        if [ $resto -ne 0 ] ; then
                                Div=$(($Div+1))
                        else
                                echo -e "${Cr} O número P = $num_p não é primo! ${Cp}"
                                p_eh_primo=false
                                sleep 3
                                
                                clear
                                listar_primos
                                definir_valor_p                                      
                        fi                
                done

                if [ $Div -eq $num_p ] ; then
                        echo -e "${Cg} O número P = $num_p é primo! ${Cp}" 
                        p_eh_primo=true 
                        break
                fi        
        else
                echo -e "${Cr} ATENÇÃO: P não foi calculado. Deve ser maior que 1 ou não nulo! ${Cp}";  
                listar_primos
                definir_valor_p
        fi


        if [[ $num_q -gt 1 && $num_q != $num_p ]] ; then     
                
                Div=2
                resto=0

                while [ $Div -ne $num_q ] ; do
                        resto=$(expr $num_q % $Div)

                        if [ $resto -ne 0 ] ; then
                                Div=$(($Div+1))
                        else
                                echo -e "${Cr} O número Q = $num_q não é primo! ${Cp}"
                                q_eh_primo=false                        
                                sleep 1
                                
                                definir_valor_q                       
                        fi                
                done
                
                if [ $Div -eq $num_q ] ; then
                        echo -e "${Cg} O número Q = $num_q é primo! ${Cp}" 
                        q_eh_primo=true                                                               
                        break
                fi   
        else
                echo -e "${Cr} ATENÇÃO: Q não foi calculado. Deve ser diferente de P e maior que 1 ou não nulo! ${Cp}";
                listar_primos
                definir_valor_q
        fi
fi

if [[ $p_eh_primo == true && $q_eh_primo == true ]] ; then
        sao_primos=true                
else
        sao_primos=false                
fi

# ------------------- INICIANDO CALCULOS DO TRABALHO-------------------
if [ $sao_primos == true ] ; then

        echo "_____________________________________________________________________________________"
        echo "  c- Solicitar uma linha de texto ao usuário, a qual será criptografada e decriptada."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        echo -e "${Cp} >>> Antes de continuar, digite em uma linha apenas um texto qualquer para ser " 
        echo -e "${Cp}     criptado e decriptado posteriormente: ${Cp}"
        read mensagem
        echo -e "${Cg}     OK. Sua mensagem foi armazenada com sucesso! ${Cp}"
        
        echo " "
        echo " Número Z --> (p-1) x (q-1) será calculado"
        echo " Calculando..."
        sleep 2
        
        clear                
        echo "___________________________________________________________"
        echo "  d- Apresentar em tela os seguintes cálculos e resultados:"
        echo "             d1- Número n = p x q"
        echo "             d2- Número z = (p-1) x (q-1)"
        echo "             d3- Número (d) que seja primo de (z)"
        echo "             d4- Número (e) onde: (d x e) mod (z) = 1"
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
                 
#------ Calculando produto de P*Q para N
        num_n=$((num_p*num_q))

#------ Calculando Quociente de Euler - Z
        num_z=$(((num_p-1)*(num_q-1)))
        
#------ Calculando D pela Fatoração do número obtido em Z              
        num_fat_d=$num_z
        fat=()
        Div=2

        # Fatorando
        while [ $num_fat_d -ge $Div ] ; do
                let res=$num_fat_d%Div
                
                if [ $res -eq 0 ] ; then

                        fat=(${fat[@]} $Div)                                
                        let num_fat_d=$num_fat_d/Div

                else
                        let Div++
                fi
        done

        # Calculando MMC de Z
        tamVetFat=$(echo ${#fat[@]})
        quoc_d=$num_z              

        echo -e "${Cp}     Número Z obtido: $num_z ${Cp}"
        echo -e "${Cp}     MMC de $quoc_d ${Cp}"
        echo " "      
        
        for iter in $(seq $tamVetFat) ; do
                let iter--
                div_dec=`echo ${fat[iter]}`
                quoc_d=$((quoc_d/div_dec))

                if [ $iter -eq 0 ] ; then
                        echo -e "${Cg}                 -> D: ${Cp}$num_z ${Cg}| ${fat[0]} ${Cp}"
                fi
                        echo -e "${Cg}                 -> D: ${Cp}$quoc_d ${Cg}| ${fat[iter+1]} ${Cp}"                        
        done                                                   
        
        # Números primos de 2 até Z
        escala_primos=`seq $num_z | factor | awk -F \: '$1 == $2{ print $1}' | column -x`

        echo " "
        echo -e "${Cp} >>> Eleja um número primo D relativo à Z($num_z) que NÃO seja igual aos fatores (${fat[@]}): ${Cp}"                 
        echo -e " "
        echo -e "${Cp} Antes disso, deseja ver quais são os primos até $num_z ? (Sim = S | Não = N) ${Cp}"
        read opcao

        # Opção para listar Números primos com base em Z
        caractere_escolhido=`echo ${opcao^^}`

        if [ $caractere_escolhido == "S" ] ; then
                echo -e "${Cp} $escala_primos ${Cp}"        
        else
                break
        fi

        mostrar_resultados_p_q_n_z(){
        echo -e "${Cb} ----> Sendo P = $num_p e Q = $num_q : ${Cp}"
        echo -e "${Cb} ----> Valor de N, sendo $num_p x $num_q resulta em: N = $num_n ${Cp}"
        echo -e "${Cb} ----> Valor de Z, sendo ($num_p - 1) x ($num_q - 1) resulta em: Z = $num_z ${Cp}"
        }

#------ Validando o valor de D para a chave pública        
        inserir_valor_d_valido(){
                echo " "
                echo -e "${Cp} >>> Para a chave pública, defina um valor primo para D: ${Cp}"
                read num_d
                echo " "             
                echo " Verificando..."

                if [ $num_d -gt 1 ] ; then                             
                Div=2
                resto_d=0

                        while [ $Div -ne $num_d ] ; do
                                resto_d=$(expr $num_d % $Div)

                                if [ $resto_d -ne 0 ] ; then
                                        Div=$(($Div+1))
                                else
                                        echo -e "${Cr} O número D = $num_d não é primo! ${Cp}"
                                        d_eh_primo=false                        
                                        sleep 1
                                        clear
                                        inserir_valor_d_valido    
                                fi                
                        done
                        
                        if [ $Div -eq $num_d ] ; then
                                echo -e "${Cg} O número D = $num_d é primo! ${Cp}" 
                                d_eh_primo=true
                        fi   
                else
                        echo -e "${Cr} ATENÇÃO: D deve ser um número primo maior que 1 ou não nulo! ${Cp}";
                        clear
                        inserir_valor_d_valido 
                fi

                # Verificando se D é relativamente primo à Z              
                d_relativo=$((num_z%num_d))

                if [ $d_relativo -eq 0 ] ; then
                        echo -e "${Cr}    -> Número D($num_d) não é válido, pois não atende à condição '1 < d < n'. ${Cp}" 
                        echo -e "${Cr}    -> A chave pública Kd não foi descoberta! ${Cp}"
                        inserir_valor_d_valido
                else                        
                        echo -e "${Cg}    -> Número D($num_d) relativo atende à condição '1 < d < n'. ${Cp}"
                        echo -e "${Cb} ----> A chave pública Kd é: ($num_d, $num_n) ${Cp}"
                fi
        }

        # Perguntar por D
        inserir_valor_d_valido 
                
#------ Calculando o valor de E para chave privada
        inserir_valor_e_valido(){
                echo " "
                echo -e "${Cp} >>> Eleja um número primo E que, quando dividido por Z não possua resto igual a zero: ${Cp}"                 
                echo -e " "
                echo -e "${Cp}     Apresentando valores de E possíveis (pode ser que exista mais de um valor válido)... ${Cp}"       
                
                iter_e=$((iter+1))

                for iter_e in $(seq $num_z) ; do                        
                        div_e=$(($num_z%iter_e))
                        div_zero=$(($num_z/iter_e))
                        produto_d_iter_e=$((num_d*iter_e))
                        num_iter_e_valido=$((produto_d_iter_e%num_z))
                        
                        if [[ $num_iter_e_valido -eq 1 && $div_zero -ne 0 ]] ; then
                                echo -e "${Cg}          -> Resto ($div_e). Será possível utilizar o valor para ${Cb}E ---> $iter_e ${Cp}"
                        fi   

                        let iter_e++
                done  
                               
                echo " "
                echo -e "${Cp} >>> Com base no apresentado acima, defina o valor da chave privada E: ${Cp}"
                read num_e               
                
                if [ $num_e -eq $num_d ] ; then
                        echo -e "${Cr}    -> O valor de D não pode ser igual ao de E. escolha outro valor para estas chaves. ${Cp}"
                        sleep 2
                        clear
                        echo -e "${Cp} $escala_primos ${Cp}"
                        inserir_valor_d_valido
                        teclar_enter_continuar
                        inserir_valor_e_valido
                else

                        echo " "
                        echo " Verificando..."

                        produto_d_e=$((num_d*num_e))
                        num_e_valido=$((produto_d_e%num_z))

                        if [ $num_e_valido -ne 1 ] ; then                       
                                echo -e "${Cr}    -> Número E($num_e) não é válido, pois não atende à condição '(d x e) mod (z) = 1'. ${Cp}" 
                                echo -e "${Cr}    -> A chave privada Ke não foi descoberta! ${Cp}"
                                # Perguntar por E novamente caso seja inválido
                                inserir_valor_e_valido                        
                        else
                                mostrar_resultados_kd_ke                       
                        fi
                fi
        }

        mostrar_resultados_kd_ke(){
                clear
                echo -e "${Cy}:¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨:${Cp}"
                echo -e "${Cy}:   RESULTADOS - 1/4   :${Cp}"  
                echo -e "${Cy}:......................:${Cp}"
                echo " "
                mostrar_resultados_p_q_n_z
                echo -e "${Cg}    -> Número D($num_d) relativo atende à condição '1 < d < n'. ${Cp}"
                echo -e "${Cb} ----> A chave pública Kd é: ($num_d, $num_n) ${Cp}"                        
                echo " "
                echo "   Logo:"
                echo -e "${Cg}    -> Número E($num_e) atende à condição '(d x e) mod (z) = 1'. ${Cp}"
                echo -e "${Cb} ----> A chave privada Ke é: ($num_e, $num_n) ${Cp}"   
                echo " "
                echo -e "${Cb} ----> Mensagem a ser criptografada: \"$mensagem\" ${Cp}"   
        }

        teclar_enter_continuar
        # Perguntar por E                
        inserir_valor_e_valido
        teclar_enter_continuar

#------ Conversão das Chaves Privada e Pública (E e D)
        # echo "309 ^ 65537 % 391" | bc
        echo -e "${Cy}:¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨:${Cp}"
        echo -e "${Cy}:   RESULTADOS - 2/4   :${Cp}"  
        echo -e "${Cy}:......................:${Cp}"
        echo " "
        echo "__________________________________________________________________________________________"
        echo "  e- Apresentar os números da chave privada: (e,n) em decimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        conv_decimal_e=$(echo "ibase=2;$num_e" | bc)
        conv_decimal_n=$(echo "ibase=2;$num_n" | bc)
        echo -e "${Cb} ----> Chave privada Ke($num_e, $num_n) em decimal..............: ${Cg}ke($conv_decimal_e, $conv_decimal_n) ${Cp}"
        echo " "        
        echo "__________________________________________________________________________________________"
        echo "  f- Apresentar os números da chave privada: (e,n) em binário."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        conv_binario_e=$(echo "obase=2;$num_e" | bc)
        conv_binario_n=$(echo "obase=2;$num_n" | bc)
        echo -e "${Cb} ----> Chave privada Ke($num_e, $num_n) em binário.........: ${Cg}ke($conv_binario_e, $conv_binario_n) ${Cp}"
        echo " "        
        echo "__________________________________________________________________________________________"
        echo "  g- Apresentar os números da chave pública: (d,n) em decimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        conv_decimal_d=$(echo "ibase=2;$num_d" | bc)
        echo -e "${Cb} ----> Chave pública Kd($num_d, $num_n) em decimal.........: ${Cg}kd($conv_decimal_d, $conv_decimal_n) ${Cp}"
        echo " "               
        echo "__________________________________________________________________________________________"
        echo "  h- Apresentar os números da chave pública: (d,n) em binário."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        conv_binario_d=$(echo "obase=2;$num_d" | bc)
        echo -e "${Cb} ----> Chave pública Kd($num_d, $num_n) em binário.........: ${Cg}kd($conv_binario_d, $conv_binario_n) ${Cp}"
        echo " "
        teclar_enter_continuar


        echo -e "${Cy}:¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨:${Cp}"
        echo -e "${Cy}:   RESULTADOS - 3/4   :${Cp}"  
        echo -e "${Cy}:......................:${Cp}"
        echo " "            
        echo "__________________________________________________________________________________________"
        echo "  i- Apresentar a fórmula para criptografar: C = P^e (mod n) (colocar os números (e) e (n)."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        texto_C=$(((mensagem^num_e)%num_n)) 
        echo -e "---------------> $texto_C"

        echo -e "${Cb} ----> Criptografia através da fórmula....................: ${Cg}C = P^$num_e (mod $num_n) ${Cp}"
        #C=$(((P^num_e)%num_n))   
        echo " "        
        echo "__________________________________________________________________________________________"
        echo "  j - Apresentar a fórmula pra decriptar: P = C^d (mod n) (colocar os números (d) e (n)."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        echo -e "${Cb} ----> Decriptografia através da fórmula..................: ${Cg}P = C^$num_d (mod $num_n) ${Cp}"
        #P=$(((C^num_d)%num_n))
        echo " "        
#------ apresentação e conversão da mensagem digitada pelo usuário
        echo "__________________________________________________________________________________________"
        echo "  k - Apresentar o texto digitado pelo usuário e o seu tamanho."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        tamanho_msg=$(echo ${#mensagem})
        echo -e "${Cb} ----> O seguinte texto digitado pelo usuário possui ${Cg}$tamanho_msg${Cp} caracteres (incluindo espaços): ${Cp}"
        echo -e "${Cb} ----> ${Cg}\"$mensagem\" ${Cp}"
        echo " "        
        echo "Aguarde..." 
        echo " " 
        echo "__________________________________________________________________________________________"
        echo "  l – Apresentar o texto digitado original em decimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        
        vetMsg=()
        vetPx=()

        for i in $(seq $(echo $tamanho_msg)) ; do
                let i--
                
                ex=$(printf "%s" $(printf "${mensagem:$i:1}" | xxd -p -c1 -u))
                ex="0000"${ex}
                ex=${ex:${#ex}-4}
                vetPx=( ${vetPx[@]} "$ex" ) # inserido elementos de 'ex'
                _decNum=$(echo "ibase=16;${ex:2:2}" | bc)                
                vetMsg=(${vetMsg[@]} $(echo ${_decNum}))
        done

        totDec=() 
        tamVet=$(echo ${#vetMsg[@]})

        for j in $(seq $(echo $tamVet)) ; do
                let j--
                totDec=( ${totDec[@]} ${vetMsg[@]:$j:1}) 
        done        

        echo -e ""
        echo -e "${Cb} ----> Texto original em decimal....................: ${Cg}${totDec[@]} ${Cp}" 
        
        echo " "        
        echo "__________________________________________________________________________________________"
        echo "  m – Apresentar o texto digitado original em hexadecimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"
        echo -e "${Cb} ----> Texto original em hexadecimal................: ${Cg}${vetPx[@]} ${Cp}"
        echo " "     

        teclar_enter_continuar

        echo -e "${Cy}:¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨:${Cp}"
        echo -e "${Cy}:   RESULTADOS - 4/4   :${Cp}"  
        echo -e "${Cy}:......................:${Cp}"

        # Criptografando...

        totDecCript=()    
               
        for z in $(seq $(echo $tamVet)) ; do
                let z--                
              
                # Aplicando fórmula para letra_criptografada=$(((letra^num_e)%num_n)) 
                letra_criptografada=$(echo "(${vetMsg[@]:$z:1}^$num_e)%${num_n}" | bc) 
                echo -e "${Cb} ----> Caractere '${mensagem:$z:1}' criptografado na posição $z:.....: ${Cg}${letra_criptografada[@]} ${Cp}"
                totDecCript=( ${totDecCript[@]} $(echo ${letra_criptografada}))
        done

        VetEnc=()
        tamVetCript=$(echo ${#totDecCript[@]})

        for a in $(seq $(echo $tamVetCript)) ; do
                let a--

                msgHex=$(printf "%s" $(printf "${totDecCript[@]:$a:1}" | xxd -p -c1 -u))
                msgHex="0000"${msgHex}
                msgHex=${msgHex:${#msgHex}-4}

                #msgHex=$(printf "\\\x%s" $(echo "obase=16;${totDecCript[@]:$a:1}" | bc))                
                VetEnc=( ${VetEnc[@]} "$msgHex" )
        done

        textoB64=$(echo "${VetEnc[@]}" | base64)
            

        echo " "            
        echo "__________________________________________________________________________________________"
        echo "  n – Apresentar o texto criptografado em formato caractere puro."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
                # APRESENTAÇÃO DO TEXTO CRIPTOGRAFADO PURO NÃO IMPLEMENTADA
        echo " "
        echo "__________________________________________________________________________________________"
        echo "  o – Apresentar o texto criptografado em formato decimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        echo -e "${Cb} ----> Texto original criptografado em decimal.....: ${Cg}${totDecCript[@]} ${Cp}"

        echo " "
        echo "__________________________________________________________________________________________"
        echo "  p – Apresentar o texto criptografado em formato hexadecimal."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        echo -e "${Cb} ----> Texto criptografado em hexadecimal..........: ${Cg}${VetEnc[@]} ${Cp}"

        echo " "
        echo "__________________________________________________________________________________________"
        echo "  q – Apresentar o texto criptografado formatado em base 64 bits (base64)."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
        echo -e "${Cb} ----> Texto criptografado em base64...............: ${Cg}$textoB64 ${Cp}"

        echo " "
        echo "__________________________________________________________________________________________"
        echo "  r – Apresentar o texto original após a decriptação."
        echo "¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨"        
       
        # Decriptando...

        totDecDecript=()
        caract_puro=()
        
        for w in $(seq $(echo $tamVet)) ; do
                let w--                
                              
                # Aplicando fórmula para letra_decriptada=$(((letra^num_d)%num_n))
                letra_decriptada=$(echo "(${totDecCript[@]:$w:1}^$num_d)%${num_n}" | bc) 
                echo -e "${Cb} ----> Caractere na posição $w decriptado:.....: ${Cg}${letra_decriptada[@]} ${Cp}"
                totDecDecript=( ${totDecDecript[@]} $(echo ${letra_decriptada}))

                caract_puro=$(printf "\x$(printf "%x" $letra_decriptada)")
                echo -e "${Cb} ----> Caracter puro:.....: ${Cg}${caract_puro} ${Cp}"
        done

        echo " "
        echo -e "${Cb} ----> texto decriptado em decimal...............: ${Cg}${totDecDecript[@]} ${Cp}"
        
        # APRESENTAÇÃO DO TEXTO DECRIPTADO PURO NÃO FINALIZADA
        #texto_decriptado_puro=$(printf "\%o" ${totDecDecript[@]})
        #echo -e "${Cb} ----> texto decriptado em caracter puro...............: ${Cg}${texto_decriptado_puro} ${Cp}"
        


# ------------------- FINALIZANDO CALCULOS DO TRABALHO ----------------
else
        echo -e "${Cr} ATENÇÃO: P e Q devem ser números primos. ${Cp}";
fi
 
exit