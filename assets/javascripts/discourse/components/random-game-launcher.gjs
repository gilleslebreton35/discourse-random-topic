import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { ajax } from "discourse/lib/ajax";

export default class RandomGameLauncher extends Component {
  @service siteSettings;
  @service router;
  @tracked loading = false;

  @action
  async pickRandomTopic() {
    this.loading = true;
    const categoryId = this.siteSettings.random_game_category_id;

    try {
      // Recherche sur toute la catégorie avec tri aléatoire côté serveur
      const result = await ajax("/search/query", {
        data: {
          q: `#${categoryId} order:random status:open`,
          page: 1
        }
      });

      const topics = result.topics;

      if (topics && topics.length > 0) {
        const randomTopic = topics[0];
        // Transition vers le sujet trouvé
        this.router.transitionTo("topic.fromParams", {
          id: randomTopic.id,
          slug: randomTopic.slug
        });
      } else {
        const { popupMessages } = await import("discourse/lib/notification");
        popupMessages.alert("Aucun jeu trouvé dans cette catégorie !");
      }
    } catch (error) {
      console.error("Erreur random-topic:", error);
    } finally {
      this.loading = false;
    }
  }

  <template>
    {{#if this.siteSettings.random_topic_enabled}}
      <div class="random-game-container">
        <DButton
          @action={{this.pickRandomTopic}}
          @icon="dice"
          @label="À quoi on joue ce soir ?"
          @isLoading={{this.loading}}
          class="btn-primary random-game-btn"
        />
      </div>

      <style pre-scss>
        .random-game-container {
          display: flex;
          justify-content: center;
          padding: 1.5em;
          margin: 1em 0;
          background: var(--secondary-low);
          border: 2px dashed var(--primary-low-medium);
          border-radius: 12px;
        }

        .random-game-btn {
          font-weight: bold;
          .d-icon {
            margin-right: 8px;
          }
          &:hover .d-icon {
            animation: fa-spin 0.5s infinite linear;
          }
        }
      </style>
    {{/if}}
  </template>
}