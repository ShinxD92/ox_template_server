var qphospital = action("syncData");
   qphospital.onCheckIn = ( users, treatment, health, armour ) => {
    console.log( users, treatment, health, armour );
  if( treatment == "success" ) {
    qphospital.action( "syncData" );
  }
}
qphospital.Init( process.onCheckIn.success );
