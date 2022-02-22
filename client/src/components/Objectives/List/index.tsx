import {
  ChangeEvent,
  FocusEvent,
  FC,
  useState,
  MouseEventHandler,
  useMemo,
} from "react";
import { useQuery, useMutation, useClient } from "jsonapi-react";
import {
  Box,
  Text,
  Heading,
  Flex,
  Input,
  Button,
  Alert,
} from "@chakra-ui/react";
import { FaTrash, FaPlus } from "react-icons/fa";

type INewObjective = {
  title: string;
  weight: number;
};

type IObjective = INewObjective & {
  id: string;
};

const ListObjectives: FC = () => {
  const client = useClient();
  const [addingNew, setAddingNew] = useState<boolean>(false);
  const [newObjective, setNewObjective] = useState<INewObjective>({
    title: null,
    weight: 0,
  });

  const { data, isLoading } = useQuery("objectives");

  const [addObjective, {}] = useMutation("objectives");

  const handleAddNewClick = () => {
    setAddingNew(true);
  };

  const handleNewObjectiveFieldChange =
    (field: string) => (event: ChangeEvent<HTMLInputElement>) => {
      setNewObjective({
        ...newObjective,
        [field]: event.target.value,
      });
    };

  const handleWeightInputBlur = (_: FocusEvent<HTMLInputElement>) => {
    addObjective(newObjective).then(() => {
      setAddingNew(false);
    });
  };

  const handleExistingObjectiveUpdate =
    (objective: IObjective, field: string) =>
    (event: FocusEvent<HTMLInputElement>) => {
      client.mutate(["objectives", objective.id], {
        [field]: event.target.value,
      });
    };

  const handleDeleteObjective =
    (objective: IObjective): MouseEventHandler<HTMLButtonElement> =>
    (_) => {
      client.delete(["objectives", objective.id]);
    };

  const sumOfWeights = useMemo(() => {
    if (!data) {
      return 0;
    }

    return data.reduce((sum, objective) => sum + objective.weight, 0);
  }, [data]);

  return (
    <Box>
      <Flex mt="20" mb="10" align="center" justifyContent="space-between">
        <Heading>Objectives</Heading>
        <Box>
          <Button rightIcon={<FaPlus />} onClick={handleAddNewClick}>
            Add Objective
          </Button>
        </Box>
      </Flex>
      {isLoading ? (
        <Text>loading...</Text>
      ) : (
        data
          .sort((objective) => objective.id)
          .map((objective) => (
            <Box
              border="1px"
              padding="5"
              mb="5"
              rounded="md"
              key={objective.id}
              borderColor="gray.200"
            >
              <Flex justifyContent="space-between" width="100%">
                <Input
                  variant="unstyled"
                  defaultValue={objective.title}
                  type="text"
                  onBlur={handleExistingObjectiveUpdate(objective, "title")}
                />
                <Flex justifyContent="flex-end">
                  <Input
                    variant="unstyled"
                    defaultValue={objective.weight}
                    type="number"
                    onBlur={handleExistingObjectiveUpdate(objective, "weight")}
                  />
                  <Button
                    rightIcon={<FaTrash />}
                    colorScheme="red"
                    paddingX="8"
                    onClick={handleDeleteObjective(objective)}
                  >
                    Delete
                  </Button>
                </Flex>
              </Flex>
            </Box>
          ))
      )}
      {addingNew && (
        <Box
          border="1px"
          padding="5"
          mb="5"
          rounded="md"
          borderColor="gray.200"
        >
          <Flex justifyContent="space-between" width="100%">
            <Input
              variant="unstyled"
              value={newObjective.title}
              onChange={handleNewObjectiveFieldChange("title")}
              type="text"
            />
            <Flex justifyContent="flex-end">
              <Input
                variant="unstyled"
                value={newObjective.weight}
                onChange={handleNewObjectiveFieldChange("weight")}
                onBlur={handleWeightInputBlur}
                type="number"
              />
              <Button
                rightIcon={<FaTrash />}
                colorScheme="red"
                disabled
                paddingX="8"
              >
                Delete
              </Button>
            </Flex>
          </Flex>
        </Box>
      )}

      <Alert colorScheme={sumOfWeights === 100 ? "green" : "red"} rounded="md">
        <Text>
          Total weight: {sumOfWeights} / 100
          <br />
          {sumOfWeights > 100 && (
            <Text color="red.500">
              You have exceeded the 100% weight limit.
            </Text>
          )}
          {sumOfWeights < 100 && (
            <Text color="red.500">
              You have not reached the 100% weight limit.
            </Text>
          )}
        </Text>
      </Alert>
    </Box>
  );
};

export default ListObjectives;
