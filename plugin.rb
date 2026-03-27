# name: discourse-random-topic
# about: Un bouton "À quoi on joue ce soir" utilisant GJS et l'API de recherche.
# version: 0.3
# authors: VotreNom
# url: https://github.com/votre-repo/discourse-random-topic

enabled_site_setting :random_topic_enabled

# On peut aussi ajouter du CSS global ici si on ne veut pas tout mettre dans le GJS
register_asset "stylesheets/random-topic.scss"