#!/usr/local/bin/ruby

require 'net/http'
require 'JSON'

HEX_PM_BASE_URI = "https://hex.pm/api"

def query_hex_pm(query)
    uri = URI(HEX_PM_BASE_URI + "/packages?limit=10&sort=downloads&search=#{query}")
    res = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
        begin
            JSON.parse(res.body)
        rescue JSON::ParserError => e
            warn e.message
            return []
        end
    else
        warn "Failed to download package list from hex.pm"
        return []
    end
end

def format_results(results)
    results.map { |r|
        name       = r["name"]
        human_url  = r["url"].sub(%r{/api}, '')
        github_url = r["meta"]["links"]["Github"] ||
                     r["meta"]["links"]["GitHub"]
        doc_url    = "https://hexdocs.pm/#{name}"
        mix_dep    = mix_dep(name, r["releases"])

        {
            title: name,
            subtitle: r["meta"]["description"],
            arg: human_url,
            variables: {
                mix_dep: mix_dep
            },
            text: {
                copy: mix_dep,
                largetype: mix_dep,
            },
            mods: {
                alt: {
                    subtitle: "Open Github (#{github_url})",
                    arg: github_url
                },
                ctrl: {
                    subtitle: "Open documentation (#{doc_url})",
                    arg: doc_url
                }
            }
        }
    }
end

def mix_dep(name, res)
    v = res.first["version"]

    return %Q[{:#{name}, "~> #{v}"}]
end

def format_for_alfred(results)
    JSON.generate({items: results})
end

query = ARGV[0]
puts format_for_alfred(format_results(query_hex_pm(query)))
