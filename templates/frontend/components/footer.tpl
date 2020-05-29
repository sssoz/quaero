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
	<div class="container site-footer-sidebar" role="complementary"
	     aria-label="{translate|escape key="common.navigation.sidebar"}">
		<div class="row">
			{call_hook name="Templates::Common::Sidebar"}
		</div>
	</div>
	<div class="container">
    <div class="text-right">
      <a href="{url page="about" op="aboutThisPublishingSystem"}">
        <img class="footer-brand-image" alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/{$brandImage}">
      </a>
    </div>
	</div>
</footer><!-- pkp_structure_footer_wrapper -->


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
