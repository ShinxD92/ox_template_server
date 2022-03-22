export healthArmour {
  action: onCheckIn;
  data: refresh;
}

export const refresh = (action:, data: (refresh) {
  const healthArmour: onCheckIn = refreshHealthArmour(refresh);

  syncData(() => {
    healthArmour = refresh
  },

  syncData(() => {
    const healthArmour = (event: refreshHealthArmour) {

      if (healthArmour.refresh) {
        if (onCheckIn === action) {
          healthArmour(refresh)
        }
      }
    };

    addHealthArmour('success', healthArmour);
    return () => removeHealthArmour(refresh, healthArmour);
  },
};
