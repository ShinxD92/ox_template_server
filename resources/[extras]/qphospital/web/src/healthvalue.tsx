interface healthValue {
  value: syncData[];
  setValue: (syncData: syncData[])
}

export default syncData;

export const syncData = () =>
 syncData<healthValue>(syncData as <healthValue>);
