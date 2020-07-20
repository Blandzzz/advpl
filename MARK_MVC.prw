#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch'

User Function  MARK_MVC()

    Private oMark

    oMark := FWMarkBrowse():New()

    oMark:SetAlias('ZZB')

    oMark:SetDescription('Seleção de albuns')

    oMark:SetFieldMark('ZZB_OK')

    oMark:AddLegend("ZZB->ZZB_TIPO == '1'", "GREEN", "CD") //Verde 
    oMark:AddLegend("ZZB->ZZB_TIPO == '2'", "BLUE", "DVD") //Azul 

Return Nil

//----------------------------------------------

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'visualizar'    ACTION 'VIEWDEF.MARK_MVC'      OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'       ACTION 'VIEWDEF.MVC001'        OPERATION 3 ACCESS 1    
    Add OPTION aRotina TITLE 'Processar'     ACTION "U_PROCS()"               OPERATION 6 ACCESS 0

Return aRotina
//---------------------------------
Static Function ModelDef()

Return FWLoadModel('MVC001')
//----------------------------------------------
Static Function ViewDef()

Return FWLoadView('MVC001')
//----------------------------------------------
User Function PROCS()
    Local aArea := GetArea()
    Local cMarca := oMark:Mark()
    Local nCt := 0

        ZZB->(DBGoTo())
            While !ZZB->(EOF())
                
                If oMark:IsMark(cMarca)
                    nCt ++
                EndIf
                    ZZB->(DBSkip())
                End

        MsgInfo("Foram marcados" + AllTrim(Str(nCt)) + "</b>registros.")
        RestArea(aArea)

Return Nil
            
