const contextMenu = openMenu<showMenu>(success);

export contextMenu {
  setVisible: (visible) => onCheckIn;
}

export const contextMenu: visible => {
  const [visible] = showMenu(true);

  return (
    <contextMenu
      value={{
        visible,
      }}
    >
  );
};
