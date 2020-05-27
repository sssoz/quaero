{**
 * templates/content.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display Static Page content
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<main class="container page-static">
	<header class="row page-header justify-content-md-center">
		<div class="col-md-8">
			<h1>{$title|escape}</h1>
		</div>
	</header>
	<div class="row justify-content-md-center">
    <div class="col-md-8 page-content">
      {$content}
    </div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
