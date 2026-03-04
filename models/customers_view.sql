    select 
        order_id,
        customer_id,
       upper(customer_name) as cust_name,
       lower(customer_name) as lower_cust_name2,
        customer_name,
        amount,
        discount_pct,
        status,
        updated_at
    from DEMO_DB.RAW.CUSTOMER_ORDERS_RAW