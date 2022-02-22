import { FC } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import { ChakraProvider, Container } from "@chakra-ui/react";
import { ApiClient, ApiProvider } from "jsonapi-react";
import { API_URL } from "../../constants";
import ObjectivesList from "../Objectives/List";

import schema from "../../schema";

const client = new ApiClient({
  url: API_URL,
  schema,
});

const App: FC = () => {
  return (
    <ApiProvider client={client}>
      <ChakraProvider>
        <Container>
          <Router>
            <Routes>
              <Route path="/" element={<ObjectivesList />} />
            </Routes>
          </Router>
        </Container>
      </ChakraProvider>
    </ApiProvider>
  );
};

export default App;
