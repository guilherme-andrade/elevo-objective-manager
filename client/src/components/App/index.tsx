import { FC } from "react";
import { ChakraProvider } from "@chakra-ui/react";

const App: FC = () => {
  return (
    <ChakraProvider>
      <div className="App">{process.env.API_URL}</div>
    </ChakraProvider>
  );
};

export default App;
