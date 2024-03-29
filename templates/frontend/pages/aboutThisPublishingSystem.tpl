{**
 * templates/frontend/pages/aboutThisPublishingSystem.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view details about the OJS software.
 *
 * @uses $currentJournal Journal The journal currently being viewed
 * @uses $appVersion string Current version of OJS
 * @uses $pubProcessFile string Path to image of OJS publishing process
 *}
{include file="frontend/components/header.tpl" pageTitle="about.aboutThisPublishingSystem"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key="about.aboutThisPublishingSystem"}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        <p>
          {if $currentJournal}
            {translate key="about.aboutOJSJournal" ojsVersion=$appVersion}
          {else}
            {translate key="about.aboutOJSSite" ojsVersion=$appVersion}
          {/if}
        </p>
        <img src="{$baseUrl}/{$pubProcessFile}" alt="{translate key="about.aboutThisPublishingSystem.altText"}">
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
