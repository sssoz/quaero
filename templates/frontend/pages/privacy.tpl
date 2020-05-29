{**
 * templates/frontend/pages/privacy.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the privacy policy.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="manager.setup.privacyStatement"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key="manager.setup.privacyStatement"}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        {$currentContext->getLocalizedSetting('privacyStatement')}
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
