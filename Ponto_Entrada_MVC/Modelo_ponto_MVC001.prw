#include "protheus.ch"
#include "parmtype.ch"
 
User Function ITEM()
    Local aParam := PARAMIXB
    Local xRet := .T.
    Local oObj := ""
    Local cIdPonto := ""
    Local cIdModel := ""
    Local lIsGrid := .F.
    Local nLinha := 0
    Local nQtdLinhas := 0
    Local cMsg := ""
 
    If aParam <> NIL
        oObj := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
        lIsGrid := (Len(aParam) > 3)
 
        If cIdPonto == "MODELPOS"
            cMsg := "Chamada na validação total do modelo." + CRLF
            cMsg += "ID " + cIdModel + CRLF
 
            xRet := ApMsgYesNo(cMsg + "Continua?")
 
        ElseIf cIdPonto == "FORMPOS"
            cMsg := "Chamada na validação total do formulário." + CRLF
            cMsg += "ID " + cIdModel + CRLF
 
            If lIsGrid
                cMsg += "É um FORMGRID com " + Alltrim(Str(nQtdLinhas)) + " linha(s)." + CRLF
                cMsg += "Posicionado na linha " + Alltrim(Str(nLinha)) + CRLF
            Else
                cMsg += "É um FORMFIELD" + CRLF
            EndIf
 
            xRet := ApMsgYesNo(cMsg + "Continua?")
 
        ElseIf cIdPonto == "FORMLINEPRE"
            If aParam[5] == "DELETE"
                cMsg := "Chamada na pré validação da linha do formulário. " + CRLF
                cMsg += "Onde esta se tentando deletar a linha" + CRLF
                cMsg += "ID " + cIdModel + CRLF
                cMsg += "É um FORMGRID com " + Alltrim(Str(nQtdLinhas)) + " linha(s)." + CRLF
                cMsg += "Posicionado na linha " + Alltrim(Str(nLinha)) + CRLF
                xRet := ApMsgYesNo(cMsg + " Continua?")
            EndIf
 
        ElseIf cIdPonto == "FORMLINEPOS"
            cMsg := "Chamada na validação da linha do formulário." + CRLF
            cMsg += "ID " + cIdModel + CRLF
            cMsg += "É um FORMGRID com " + Alltrim(Str(nQtdLinhas)) + " linha(s)." + CRLF
            cMsg += "Posicionado na linha " + Alltrim(Str(nLinha)) + CRLF
            xRet := ApMsgYesNo(cMsg + " Continua?")
 
        ElseIf cIdPonto == "MODELCOMMITTTS"
            ApMsgInfo("Chamada após a gravação total do modelo e dentro da transação.")
 
        ElseIf cIdPonto == "MODELCOMMITNTTS"
            ApMsgInfo("Chamada após a gravação total do modelo e fora da transação.")
 
        ElseIf cIdPonto == "FORMCOMMITTTSPRE"
            ApMsgInfo("Chamada após a gravação da tabela do formulário.")
 
        ElseIf cIdPonto == "FORMCOMMITTTSPOS"
            ApMsgInfo("Chamada após a gravação da tabela do formulário.")
 
        ElseIf cIdPonto == "MODELCANCEL"
            cMsg := "Deseja realmente sair?"
            xRet := ApMsgYesNo(cMsg)
 
        ElseIf cIdPonto == "BUTTONBAR"
            xRet := {{"Salvar", "SALVAR", {||u_TSMT010()}}}
        EndIf
    EndIf
Return xRet
 
User Function TSMT010()
    Alert("Buttonbar")
Return NIL