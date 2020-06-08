{**
  * templates/frontend/components/footer.tpl
  *
  * Copyright (c) 2014-2016 Simon Fraser University
  * Copyright (c) 2003-2016 John Willinsky
  * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
  *
  * @brief Common site frontend footer.
*}


<footer class="site-footer">
  <section class="container" aria-label="{translate|escape key="common.navigation.sidebar"}">
    <h2 class="sr-only">{translate key="admin.version.moreInfo"}</h2>
    <p>ISSN: 2369-8659</p>
    <ul class="unstyled-list">
      <li>
        <a href="https://twitter.com/PIE_Journal" target="_blank" rel="noopener">Twitter</a>
      </li>
      <li>
        <a href="https://www.facebook.com/philinquiry/" target="_blank" rel="noopener">Facebook</a>
      </li>
    </ul>
  </section>
  <section class="container">
    <h2 class="sr-only">{translate key="about.aboutSite"}</h2>
    <div class="row">
      <div class="col-6">
        {call_hook name="Templates::Common::Sidebar"}
      </div>
      <div class="col-6 text-right">
        <a href="{url page="about" op="aboutThisPublishingSystem"}" target="blank" rel="noopener">
          <img class="footer-brand-image" alt="{translate key='about.aboutThisPublishingSystem'}" src="{$baseUrl}/{$brandImage}">
        </a>
      </div>
    </div>
  </section>
</footer>


{* Load author biography modals if they exist *}
{if !empty($smarty.capture.authorBiographyModals|trim)}
{$smarty.capture.authorBiographyModals}
{/if}

{* Login modal *}
<section id="loginModal" class="modal fade" tabindex="0" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <header>
        <h2>{translate key="navigation.login"}</h2>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </header>
      {include file="frontend/components/loginForm.tpl" formType = "loginModal"}
    </div>
  </div>
</section>

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
