# frozen_string_literal: true

site_manifest = [
  { site_id: 'test', template: 'sites/main', body_class: 'main' },
  { site_id: 'foo', template: 'sites/alt', body_class: 'alt' }
]

Site.create!(site_manifest)
