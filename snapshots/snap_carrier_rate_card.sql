{% snapshot snap_carrier_rate_card %}

{{
    config(
        unique_key="carrier_code || '|' || service_level || '|' || zone::text || '|' || weight_tier_min_lbs::text || '|' || weight_tier_max_lbs::text",
        strategy="check",
        check_cols=["contract_base_rate_usd", "effective_date", "expiration_date"],
        invalidate_hard_deletes=True,
    )
}}

select
    carrier_code,
    service_level,
    zone,
    weight_tier_min_lbs,
    weight_tier_max_lbs,
    contract_base_rate_usd,
    effective_date,
    expiration_date
from {{ ref('carrier_rate_card') }}

{% endsnapshot %}