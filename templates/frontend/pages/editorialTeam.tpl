{**
 * templates/frontend/pages/editorialTeam.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="about.editorialTeam"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key="about.editorialTeam"}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        {$currentContext->getLocalizedSetting('editorialTeam')}
        <p>
          {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="about.editorialTeam"}
        </p>
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
