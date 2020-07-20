#include 'protheus.ch'
#include 'parmtype.ch'

/*/(Protheus.doc) DBST001
// TODO Exemplo de uso de DBStruct ()
@author Rafael Blandino
@version 1
@type function
/*/

user function DBST001()
    Local nHandle := TCLink("MSSQL/DSN1","127.0.0.1",7890)
    Local cTable  := "ZZB990"
    Local cRDD := "TOPCONN"
    Local aStruZZB := ZZB->(DbStruct())

    DBUseArea(.T., cRDD, cTable, (cTable), .F., .T.)
        MemoWrite("C:\temp\ESTRUTURA.txt", VarInfo("aStruZZB", aStruZZB, ,.F.))

    DBCloseArea()

    TCUnlink(nHandle)
Return