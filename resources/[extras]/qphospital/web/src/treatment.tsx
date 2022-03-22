const Treatment = useTreatment();
  const navigate = useNavigate();

  const checkIn = (
    index: number
  ) => {
    navigate('/treatment');
    Treatment.value[index] = index;
    props.NPC(Treatment.value[index]);
    fetchNui('qphospital:signIn', index);
  };

  const inProgress = (index: number) => {
    navigate('/health');
    Treatment.value[index] = index;
    props.NPC(Treatment.value[index]);
    fetchNui('qphospital:signIn', index);
  };

  useNuiEvent('sendTreatment', (data: NPC[]) => {
    Treatment.setValue(health);
  });

export default Treatment;
