---
sidebar_position: 4
---
# Clearing House functionality

An EV clearing house in the scope of this protocol facilitates the
mutual exchange of roaming authorisations, charge data & charge point
information between its partners. The formal act of clearing - as meant
here - is the assignment of charge detail records to the corresponding
EV Service Provider. The financial clearing has to be executed in a
subsequent process step and is out of scope of the interface addressed
by OCHP. However, the here defined data types are meant to be used as a
base to calculate the payment request.
Normally the following steps are followed, (*highlighted* steps are
in scope of OCHP):

* *An EVSP (Partner A) uploads authorisation data of its EV users to 
  the Clearing House (CH).*
* *The EVSE operators that have a roaming contract with (A), download 
  this authorisation data from the CH.*
* The EVSE operators enable these authorisations to be used on their 
  charge points.
* The EV users of partner (A) can now charge their electric vehicles 
  at all charge points of the EVSE operators named in step 2.
* *The EVSE operator uploads the charge data (using Charge Detail 
  Records) to the CH.*
* *This charge data is then routed by the CH towards partner (A) using 
  OCHP.*
* Partner (A) pays the roaming partner for the charging action done by 
  its customer.
* Partner (A) bills its customer.
