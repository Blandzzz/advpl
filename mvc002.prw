#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch'

/*/{Portheus.doc} MVC002
//TODO Tela de cdastr em MVC com duas entidades
@author Rafael Blandino
@version 1.0
@type function
/*/

user function MVC002()
    Local aArea := GetArea()
    Local oBrowse := FwMBrowse() :new()

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

    Local aRotina := FWMVCMenu("MVC002")

Return aRotina

Static Function ModelDef()

    Local oModel:= MPFormModel() :New ("XMVC002",,,,)
    Local oStPai:= FWFormStruct(1,"ZZB")
    Local oStFilho := FWFormStruct(1,"ZZA")
    //Local aZZARel := {}

    oModel:AddFields("ZZBMASTER",,oStPai)
    oModel:AddGrid("ZZADETAIL",'ZZBMASTER' ,oStFilho,,,,,)

    oModel:SetRelation('ZZADETAIL',{{'ZZA_FILIAL', 'xFilial(ZZA)'},{'ZZA_CODALB','ZZB_COD'}},ZZA->(IndexKey(1)))

        oModel:SetPrimaryKey({"ZZA_FILIAL",""})

    oModel:SetDescription("Modelo2")
    oModel:GetModel('ZZBMASTER'):SetDescription('Modelo Albuns')
    oModel:GetModel('ZZADETAIL'):SetDescription('Modelo Musicas')

Return oModel

Static Function ViewDef()
    Local oView := Nil
    Local oModel := FWLoadModel("MVC002")
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

    oView:EnableTitleView("VIEW_ZZB", 'Cabeçalho')     //Adicionando titulo ao formulário
    oView:EnableTitleView("VIEW_ZZA", 'Grid')     //Adicionando titulo ao formulário

Return oView