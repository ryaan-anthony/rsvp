# frozen_string_literal: true

site_manifest = [
  { site_id: 'test', template: 'sites/main' },
  { site_id: 'foo', template: 'sites/alt' }
]

Site.create!(site_manifest)
