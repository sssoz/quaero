{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a landing page for a single issue. It will show the table of contents
 *  (toc) or a cover image, with a click through to the toc.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue, consisting of one or
 *       more of the volume, number, year and title, depending on settings
 * @uses $issueGalleys array Galleys for the entire issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">

    	{* Display a message if no current issue exists *}
    	{if !$issue}
    		<header class="page-header page-issue-header">
    			{include file="frontend/components/notification.tpl" messageKey="current.noCurrentIssueDesc"}
    		</header>

    	{* Display an issue with the Table of Contents *}
    	{else}
    		<header class="page-header page-issue-header">

    		{* Indicate if this is only a preview *}
    		{if !$issue->getPublished()}
    			{include file="frontend/components/notification.tpl" messageKey="editor.issues.preview"}
    		{/if}

    			<h1 class="page-issue-title">{$issue->getIssueSeries()|escape}</h1>

    			<time datetime="{$issue->getDatePublished()}">
    				{translate key="plugins.themes.healthSciencesPIE.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
    			</time>

    			{* PUb IDs (eg - DOI) *}
    			{foreach from=$pubIdPlugins item=pubIdPlugin}
    				{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
    				{if $pubId}
    					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
    					{if $doiUrl}
    						{capture assign="pubId"}
    							<a href="{$doiUrl}">
    								{$doiUrl}
    							</a>
    						{/capture}
    					{/if}
    					<div class="page-issue-doi">
    						{if $pubIdPlugin->getPubIdType() == 'doi'}
    							{$pubId}
    						{else}
    							{translate key="plugins.themes.healthSciencesPIE.issuePubId" pubIdType=$pubIdPlugin->getPubIdDisplayType()|escape pubId=$pubId}
    						{/if}
    					</div>
    				{/if}
    			{/foreach}
    		</header>

        <!-- Issue theme/title, description, galleys -->
        {if $issueGalleys || $issue->hasDescription() || $issue->getLocalizedTitle()}
          {if $issue->hasDescription() || $issue->getLocalizedTitle()}
            <h2>
              {if $issue->getLocalizedTitle()}
                {$issue->getLocalizedTitle()}
              {else}
                {translate key="plugins.themes.healthSciencesPIE.issueDescription"}
              {/if}
            </h2>
            {$issue->getLocalizedDescription()|strip_unsafe_html}
          {/if}
          {if $issueGalleys}
            <h3>
              {translate key="issue.fullIssue"}
            </h3>
            {foreach from=$issueGalleys item=galley}
              {include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
            {/foreach}
          {/if}
        {/if}
        {if $issue->getLocalizedCoverImageUrl()}
        <img class="page-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
        {/if}

        <!-- TOC -->
    		{if !$issue->getLocalizedDescription() || !$issue->getLocalizedCoverImageUrl()}<div class="issue-wrapper">{/if}
    			{include file="frontend/objects/issue_toc.tpl" sectionHeading="h2"}
    		{if !$issue->getLocalizedDescription() || !$issue->getLocalizedCoverImageUrl()}</div>{/if}
    	{/if}
    </div>

  </div><!-- .row -->
</main>

{include file="frontend/components/footer.tpl"}
