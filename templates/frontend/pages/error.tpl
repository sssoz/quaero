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

<main class="container page-error">
	<header class="row page-header justify-content-md-center">
		<div class="col-md-8">
			{if $pageTitle}
				<h1>
					{translate key=$pageTitle}
				</h1>
			{/if}
		</div>
	</header>
	<div class="row justify-content-md-center">
		<div class="col-md-8">
			<div class="description">
				{translate key=$errorMsg params=$errorParams}
			</div>
			{if $backLink}
				<div class="cmp_back_link">
					<a href="{$backLink}">{translate key=$backLinkLabel}</a>
				</div>
			{/if}
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
