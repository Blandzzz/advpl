#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch'

/*/{Protheus.doc} MVC003
//TODO Exemplo de validações em MVC
@author Rafael Blandino
@version 1.0
@type function
/*/

user function MVC003()
    Local aArea := GetArea()
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias("ZZB")
     oBrowse:SetAlias ("ZZB")
    oBrowse:SetDescription ("Albuns")

    //definindo as legendas
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '1'", "GREEN", "CD") //Verde
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '2'", "BLUE","DVD") //Azul
    //Ativa o Browse
    oBrowse:Activate()
    RestArea(aArea)

Return Nil

Static Function MenuDef

    Local aRotina := FWMVCMenu("MVC003")

Return aRotina

Static Function ModelDef()

    Local oModel:= MPFormModel() :New ("XMVC003",{|oModel|MdlPreVld(oModel)},{|oModel|MdlPosVld(oModel)},,)
    Local oStPai:= FWFormStruct(1,"ZZB")
    Local oStFilho := FWFormStruct(1,"ZZA")
    //Local aZZARel := {}

    oModel:AddFields("ZZBMASTER",,oStPai)
    oModel:AddGrid("ZZADETAIL",'ZZBMASTER' ,oStFilho,,,,,)

    //Validação na abertura do modelo
    oModel:SetVldActivate({|oModel| MdlActiveVld(oModel)})

    oModel:SetRelation('ZZADETAIL',{{'ZZA_FILIAL', 'xFilial(ZZA)'},{'ZZA_CODALB','ZZB_COD'}},ZZA->(IndexKey(1)))

    //Validação para nao repetir dados
    oModel:GetModel('ZZADETAIL'):SetUniqueLine({"ZZA_FILIAL","ZZA_NOME"})

        oModel:SetPrimaryKey({"ZZA_FILIAL",""})

    oModel:SetDescription("Modelo 3")
    oModel:GetModel('ZZBMASTER'):SetDescription('Modelo Albuns')
    oModel:GetModel('ZZADETAIL'):SetDescription('Modelo Musicas')

Return oModel

Static Function ViewDef()
    Local oView := Nil
    Local oModel := FWLoadModel("MVC003")
    Local oStPai := FWFormStruct (2,"ZZB")
    Local oStFilho := FWFormStruct (2,"ZZA")

    oView := FWFromView():New()     //construindo o modelo de dados
    oView:SetModel(oModel)          //Passando o modelo de dados informado

    oView:AddFields('VIEW_ZZB', oStPai, 'ZZBMASTER')
    oView:AddGrid('VIEW_ZZA', oStFilho, 'ZZADETAIL')

    oView:CreateHorizontalBox('CABEC', 40)
    oView:CreateHorizontalBox('GRID', 60)

    oView:SetOwnerView('VIEW_ZZB', 'CABEC')
    oView:SetOwnerView('VIEW_ZZA', 'GRID')

    oView:AddIncrementField('VIEW_ZZA', 'ZZA_NUM') //Incremento automatico por linha no campo numerico

    oView:EnableTitleView("VIEW_ZZB", 'Cabeçalho')     //Adicionando titulo ao formulário
    oView:EnableTitleView("VIEW_ZZA", 'Grid')     //Adicionando titulo ao formulário

Return oView

Static Function MdlActiveVld(oModel)
    Local lValid := .T.

    If (dDataBase != Date())

        HELP(' ',1,"MdlActiveVld",,"Data do sistema diferente da data atual",2,0,,,,,,"Logar no sistema com a Data atual")

        lValid := .F.

    EndIf    

Return (lValid)

//Pre validação do  modelo de dados

Static Function MdlPreVld(oModel)
    Local lValid := .T.

    MsgAlert ("Pré Validação", "MDLPREVLD")


Return (lValid)

//Pos validação do modelo de Dados

Static Function MdlPosVld(oModel)
    Local lValid := .T.

    If MsgYesNo("Deseja realmente continuar? ")
        MsgInfo("Validado pelo Usuario")

        Else
            lValid := .F.
  
    EndIf

Return (lValid)
