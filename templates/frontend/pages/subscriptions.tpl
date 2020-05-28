{**
 * templates/frontend/pages/subscriptions.tpl
 *
 * Copyright (c) 2013-2017 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal Subscriptions.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="about.subscriptions"}

<main class="containe">
	<header class="row page-header justify-content-md-center">
		<div class="col-md-8">
			<h1>{translate key="about.subscriptions"}</h1>
		</div>
	</header>
	<div class="row justify-content-md-center">
    <div class="col-md-8 page-content">

      {include file="frontend/components/subscriptionContact.tpl"}

      <a name="subscriptionTypes"></a>
      {if !$individualSubscriptionTypes->wasEmpty()}
        <section>
          <h2>{translate key="about.subscriptions.individual"}</h2>
          <p>{translate key="subscriptions.individualDescription"}</p>
          <table class="table">
            <tr>
              <th>{translate key="about.subscriptionTypes.name"}</th>
              <th>{translate key="about.subscriptionTypes.format"}</th>
              <th>{translate key="about.subscriptionTypes.duration"}</th>
              <th>{translate key="about.subscriptionTypes.cost"}</th>
            </tr>
            {iterate from=individualSubscriptionTypes item=subscriptionType}
              <tr>
                <td>
                  <div>
                    {$subscriptionType->getLocalizedName()|escape}
                  </div>
                  <div>
                    {$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
                  </div>
                </td>
                <td>{translate key=$subscriptionType->getFormatString()}</td>
                <td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
                <td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
              </tr>
            {/iterate}
          </table>
        </section>
        {if $isUserLoggedIn}
          <p>
            <a class="btn" href="{url page="user" op="purchaseSubscription" path="individual"}">
              {translate key="user.subscriptions.purchaseNewSubscription"}
            </a>
          </p>
        {/if}
      {/if}

      {if !$institutionalSubscriptionTypes->wasEmpty()}
        <h2>{translate key="about.subscriptions.institutional"}</h2>
        <p>{translate key="subscriptions.institutionalDescription"}</p>
        <table class="table">
          <tr>
            <th>{translate key="about.subscriptionTypes.name"}</th>
            <th>{translate key="about.subscriptionTypes.format"}</th>
            <th>{translate key="about.subscriptionTypes.duration"}</th>
            <th>{translate key="about.subscriptionTypes.cost"}</th>
          </tr>
          {iterate from=institutionalSubscriptionTypes item=subscriptionType}
            <tr>
              <td>
                <div>
                  {$subscriptionType->getLocalizedName()|escape}
                </div>
                <div>
                  {$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
                </div>
              </td>
              <td>{translate key=$subscriptionType->getFormatString()}</td>
              <td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
              <td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
            </tr>
          {/iterate}
        </table>
        {if $isUserLoggedIn}
          <p>
            <a class="btn" href="{url page="user" op="purchaseSubscription" path="institutional"}">
              {translate key="user.subscriptions.purchaseNewSubscription"}
            </a>
          </p>
        {/if}
      {/if}
    </div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
