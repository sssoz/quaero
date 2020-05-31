{**
 * templates/frontend/pages/error.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Generic error page.
 * Displays a simple error message and (optionally) a return link.
 *}
{include file="frontend/components/header.tpl"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col col-lg-9 page">
      <header class="page-header justify-content-md-center">
        {if $pageTitle}
  				<h1>
  					{translate key=$pageTitle}
  				</h1>
  			{/if}
    	</header>

      <div class="page-content justify-content-md-center">
        <p>{translate key=$errorMsg params=$errorParams}</p>

        {if $backLink}
  				<p>
  					<a href="{$backLink}">{translate key=$backLinkLabel}</a>
  				</p>
  			{/if}
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
