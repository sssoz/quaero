{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view an article with all of it's details.
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $journal Journal The journal currently being viewed.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}

<main class="container article-details">

  <div class="row justify-content-center">

    <article class="col-11 col-lg-9 page">
      {include file="frontend/objects/article_details.tpl"}
    </article>

  </div>

</main>

{include file="frontend/components/footer.tpl"}
