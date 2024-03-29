{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 * @uses $heading string The HTML tag to use for each issue title.
 *}
{if $issue->getShowTitle() && $issue->getLocalizedTitle()}
	{assign var="showTitle" value=true}
{else}
	{assign var="showTitle" value=false}
{/if}


{capture assign="issueTitle"}
	{if $issue->getIssueSeries()}
		{$issue->getIssueSeries()|escape}
	{elseif $showTitle}
		{$issue->getLocalizedTitle()|escape}
	{else}
		{** probably can occur only in OJS versions prior to 3.1 *}
		{translate key="issue.issue"}
	{/if}
{/capture}

<article class="issue-summary">
  <a href="{url op="view" path=$issue->getBestIssueId()}" class="issue-summary-link">
    <{$heading} class="issue-summary-series">
      {$issueTitle|escape}
    </{$heading}>
    {if $showTitle || $issue->getDatePublished()}
      {if $issue->getDatePublished()}
        <p class="issue-summary-date">{$issue->getDatePublished()|date_format:$dateFormatLong}</p>
      {/if}
      {if $issue->getIssueSeries() && $showTitle}
        <p class="issue-summary-title">{$issue->getLocalizedTitle()|escape}</p>
      {/if}
    {/if}
  </a>
</article>
