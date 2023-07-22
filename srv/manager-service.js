const cds = require('@sap/cds')
const { Banks, Customers, Accounts, Transactions } = cds.entities

module.exports = cds.service.impl((srv)=> {
    srv.before('CREATE', 'Transections', _transection)
    //srv.before('UPDATE', 'Transections' , _beforeTransectionUpdate)
    srv.after('CREATE',  'Banks', _afterCreationBank)
})

async function _transection(req) {
    const data = req.data
    console.log(req.user)
    return cds.transaction(req).run(()=> { 
        if(data.hasOwnProperty("type")) {
            if(data.type === 'Deposit') {
                UPDATE(Accounts).set('balance +=', data.amount).where('accountid =', data.accounts_accountid)
            } else {
                UPDATE(Accounts).set('balance -=', data.amount).where('accountid =', data.accounts_accountid).and(
                    'balance >=', data.amount
                )
            }
        }
    }).then((affectedrows) => {
        if(affectedrows == 0) {
            req.error(409, `insufficient balance in the #${data.accounts_accountid}`)
        }
    })
}

async function _afterCreationBank(bankdetails, req) {
  //  console.log(`Bank ${bankdetails.bankID} is Created`)
    for(let i in bankdetails.customers) {
    //    console.log(`Customer ${bankdetails.customers[i].custID} is Created`)
      
      
        for(let j in bankdetails.customers[i].accounts) {
      //      console.log(`Account ${bankdetails.customers[i].accounts[j].accountid} is Created`)
            for(let k in bankdetails.customers[i].accounts[j].transections) {
        //        console.log(`Transecction ${bankdetails.customers[i].accounts[j].transections[k].ID} is Created`)
            }
        }
    }
}