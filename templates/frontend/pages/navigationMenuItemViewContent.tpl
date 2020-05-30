{**
 * templates/frontend/pages/navigationMenuItemViewContent.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display NavigationMenuItem custom page content
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>{$title|escape}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        {$content}
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
