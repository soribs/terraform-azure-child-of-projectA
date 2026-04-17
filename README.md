# terraform-azure-child-of-projectA

> **Module Child Terraform** — Partie du **ProjectA**  
> Crée un **Groupe de Ressources Azure** avec un balisage standardisé et une région par défaut.

---

## Vue d'ensemble

Ce module enfant crée un [Groupe de Ressources Azure](https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/management/manage-resource-groups-portal) et applique un ensemble de tags communs (`environment`, `project`, `location`) sur toutes les ressources. Il est conçu pour être appelé depuis un module parent ou racine dans le cadre de ProjectA.

---

## Utilisation

```
module "resource_group" {
  source = "git::https://github.com/soribs/terraform-azure-child-of-projectA.git///?ref=dev"

  resource_group_name = "rg-projectA-dev"
  location_name       = "Spain Central"
  project_name        = "projectA"
}
```

---

## Prérequis

| Nom       | Version   |
|-----------|-----------|
| terraform | >= 1.1.0  |
| azurerm   | = 4.67.0  |

### Configuration du provider

Ce module ne configure **pas** le provider `azurerm`. Le module parent (ou racine) est responsable de son initialisation :

```hcl
provider "azurerm" {
  features {}
}
```

---

## Variables d'entrée

| Nom                   | Description                                                                                              | Type     | Défaut           | Obligatoire |
|-----------------------|----------------------------------------------------------------------------------------------------------|----------|------------------|-------------|
| `resource_group_name` | Le nom du Groupe de Ressources Azure. Toute modification force la recréation de la ressource.            | `string` | n/a              | ✅ Oui      |
| `location_name`       | La région Azure où le Groupe de Ressources sera créé. Toute modification force la recréation.            | `string` | `"Spain Central"`| ❌ Non      |
| `project_name`        | Le nom du projet, utilisé comme tag sur le Groupe de Ressources.                                         | `string` | n/a              | ✅ Oui      |

---

## Sorties

| Nom                       | Description                                                   |
|---------------------------|---------------------------------------------------------------|
| `resource_group_name`     | Le nom du Groupe de Ressources créé.                          |
| `resource_group_id`       | L'identifiant Azure complet du Groupe de Ressources.          |
| `resource_group_location` | La région Azure dans laquelle le Groupe de Ressources existe. |

---

## Tags appliqués

Toutes les ressources créées par ce module partagent les tags suivants :

| Clé           | Valeur                        |
|---------------|-------------------------------|
| `environment` | `dev`                         |
| `project`     | *(valeur de `project_name`)*  |
| `location`    | `Madrid`                      |

---

## Ressources créées

| Ressource                       | Référence                              |
|---------------------------------|----------------------------------------|
| `azurerm_resource_group.this`   | Définie par `var.resource_group_name`  |

---

## Remarques

- Le tag `environment` est actuellement codé en dur à `"dev"`. Il est recommandé de le paramétrer si le module doit supporter plusieurs environnements (dev, staging, prod).
- Le tag `location` dans `common_tags` est codé en dur à `"Madrid"` et est indépendant de `var.location_name` (la vraie région Azure utilisée pour le déploiement). Ces deux valeurs peuvent être alignées ou rester séparées selon la stratégie de balisage choisie.

---

## Liens utiles

- 🔗 [Module parent — ProjectA](#) (https://github.com/soribs/terraform-azure-projectA)
- 📄 [Documentation Azure — Groupes de Ressources](https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/management/overview)