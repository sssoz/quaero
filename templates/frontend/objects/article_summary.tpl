{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}
{assign var=articlePath value=$article->getBestId()}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<article class="article-summary">

	{if $showAuthor && $article->getPages()}
		<header class="row">
			<div class="col">
				<p class="metadata">{$article->getAuthorString()|escape}</p>
			</div>
			<div class="col-3 col-md-2 col-lg-2">
				<p class="metadata text-right">
					{$article->getPages()|escape}
				</p>
			</div>
		</header>
	{elseif $showAuthor}
		<header class="metadata">{$article->getAuthorString()|escape}</header>
	{elseif $article->getPages()}
		<header class="metadata">
			{$article->getPages()|escape}
		</header>
	{/if}

	<h3 class="article-summary-title">
		<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$article->getLocalizedFullTitle()|escape}
		</a>
	</h3>

	{if $showDatePublished && $article->getDatePublished()}
		<time class="metadata">
			{$article->getDatePublished()|date_format:$dateFormatLong}
		</time>
	{/if}

	{* Get DOI from DOIPubIdPlugin object *}
	{if $requestedPage === 'issue'}
		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{if $pubIdPlugin->getPubIdType() != 'doi'}
				{continue}
			{/if}
			{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
			{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				<p class="metadata">
					<a href="{$doiUrl}">{$doiUr}</a>
				</p>
			{/if}
		{/foreach}
	{* Get DOI from PublishedArticle object ($pubIdPlugin isn't assigned to indexJournal template) *}
	{elseif $requestedOp === "index" && $article->getStoredPubId('doi')}
		{assign var="doiUrl" value=$article->getStoredPubId('doi')|substr_replace:'https://doi.org/':0:0|escape}
		{if $doiUrl}
			<p class="metadata">
				<a href="{$doiUrl}">{$doiUrl}</a>
			</p>
		{/if}
	{/if}

	{if !$hideGalleys && $article->getGalleys()}
		<footer>
			{foreach from=$article->getGalleys() item=galley}
				{if $primaryGenreIds}
					{assign var="file" value=$galley->getFile()}
					{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
						{continue}
					{/if}
				{/if}
				{assign var="hasArticleAccess" value=$hasAccess}
				{if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $article->getCurrentPublication()->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
					{assign var="hasArticleAccess" value=1}
				{/if}
				{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess}
			{/foreach}
		</footer>
	{/if}

	{call_hook name="Templates::Issue::Issue::Article"}
</article>
