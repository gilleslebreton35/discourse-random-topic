import { withPluginApi } from "discourse/lib/plugin-api";
import RandomGameLauncher from "../components/random-game-launcher";

export default {
  name: "init-random-button",
  initialize() {
    withPluginApi("1.34.0", (api) => {
      // Injection au-dessus de la liste des sujets (discovery)
      api.renderInOutlet("discovery-above-topic-list-titles", RandomGameLauncher);
    });
  },
};