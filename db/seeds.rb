# frozen_string_literal: true

site_manifest = [
  { site_id: 'main', template: 'sites/main', body_class: 'site-main' },
  { site_id: 'admin', template: 'sites/admin', body_class: 'site-admin' }
]

Site.create!(site_manifest)
