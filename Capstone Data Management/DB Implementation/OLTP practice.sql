select cd.AccountId,BranchCode, balance openingBalance,sum(balance - TransactionAmount) closingBalance
from customer_data cd,
    transaction_data td
where cd.AccountId = td.AccountId
group by cd.AccountId;

select cd.customerid,		
         sum(case when td.transactiontype = 'Deposit' then 1 else 0 end) Deposit_Count,
        sum(case when td.transactiontype = 'Withdrawal' then 1 else 0 end) Withdrawal_Count
from customer_data cd,
     transaction_data td
where cd.AccountId = td.AccountId
group by cd.customerid;