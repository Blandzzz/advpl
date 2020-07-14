#include 'protheua.ch'
#include 'parmtype.ch'
#include 'FwMvcDef,ch'

user /*/{Protheus.doc} MVC001 ()
    (long_description)
    @type  Function
    @author Rafael Blandino
    @since 10/07/2020
    @version version
    @param param, param_type, param_descr
    @return return, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
 Function MVC001 ()
    local oBrowse := FwMBrowser() : new()

    oBrowse:SetAlias ("ZZB")
    oBrowse:SetDescription ("Albuns")

    //Legendas.
    oBrowse:AddLegend ("ZZB->ZZB_TIPO == '1'","GREEN", "CD")   //VERDE
    oBrowse:AddLegend ("ZZB->ZZB_TIPO == '2'","BLUE", "DVD")   //AZUL

    oBrowse: Activate ()

Return

//Contrução da MenuDef
/*/{Protheus.doc} MenuDef()
    (long_description)
    @type  Static Function
    @author Rafael Blandino
    @since 10/07/2020
    @version version
    @param param, param_type, param_descr
    @return return, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
 Static Function MenuDef()
    Local aRotina := {}

        Add OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MVC001' OPERATION 2 ACCESS 0
        Add OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.MVC001' OPERATION 3 ACCESS 1
        Add OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.MVC001' OPERATION 4 ACCESS 2
        Add OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.MVC001' OPERATION 5 ACCESS 2

/*
MenuDef Operation
1 - Pesquisar
2 - Visualizar
3 - Incluir
4 - Alterar
5 - Excluir
6 - Chamada de Função pre definida pelo Dev
7 - Copiar
*/

Return aRotina

// Criando a ModelDef
/*/{Protheus.doc} ModelDef()
    (long_description)
    @type  Static Function
    @author Rafael Blandino
    @since 10/07/2020
    @version 1.0
    @param param, param_type, param_descr
    @return return, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
 Static Function ModelDef()
    local oModel := Nil
    local oStzzb := FWFormStruct(1,"ZZB")

    //Instanciando modelo de  Dados.
    oModel:= MPFormModel() :New ("ZMODELLM", , , ,)
    //Atribuindo formulario para o modelo de Dados.
    oModel:AddFields("FORMZZB",,oStzzb)
    //Chave Primaria da Rotina
    oModel:SetPrimaryKey ({'ZZB_FILIAL','ZZB_COD'})

    
Return
