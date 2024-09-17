-- Biffa were unble to access the Big Reveal page because on page load there is a check of previous orders to see if they have already 
-- ordered a free celebration pack. During the construction of the domain order obejcts an exception is thrown when an order line with
-- quantity = 0 is encountered. This order is a zero price order that was created in order to allow Biffa to set-up as multi-lingual. 
-- Deleting the 0 quantity order line allows the page to load
DECLARE @OrderLineID INT = 
(
    SELECT ol.OrderLineID
    FROM Dat_Order o
        JOIN Dat_Company c on c.CompanyID = o.CompanyID
        JOIN Dat_Order_Lines ol on ol.OrderID = o.OrderID
    WHERE 
        c.[Name] = 'Biffa'
        AND o.OrderNumber = 'ORD-2024-98807' 
        AND ol.Qty = 0
)

DELETE olci
FROM Dat_Order_Lines_Catalogue_Items olci 
WHERE olci.OrderLineID = @OrderLineID

DELETE ol
FROM Dat_Order_Lines ol 
WHERE ol.OrderLineID = @OrderLineID