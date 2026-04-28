import {
  Button,
  Flex,
  Heading,
  Provider,
  defaultTheme,
} from "@adobe/react-spectrum";

export default function App() {
  return (
    <Provider theme={defaultTheme}>
      <Flex direction="column" gap="size-200" margin="size-400">
        <Heading level={1}>Meeting Booking</Heading>
        <Button variant="accent" onPress={() => {}}>
          Spectrum works
        </Button>
      </Flex>
    </Provider>
  );
}
