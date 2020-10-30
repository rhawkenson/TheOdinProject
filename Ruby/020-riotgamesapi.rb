require 'net/http'
require 'json'

KEY = "RGAPI-c12c7ab5-09e9-414d-ae39-7db99053cc42"

ACCOUNTS = [ # region, name, id, account_id, puuid, login
  ["jp1", "NotｰYourｰFriend", "1vuEHnx-sgN-9NVqSj_yZIij3TTNL0tToVwuMOYsaFqwN0o", "9SuJNT9ieVUYgb-wUd67VsydOVuzUBEPCIDp9gNKgiessEVuxd_zW2zE", "mDe-25TYe6XAzX712WICBetWtqK0e2byId_qRV-GNRG1y3vb5CHuEhCgpBVaWoM0dpr5PyHyxYQQaw", "FioraJapan3001"],
  ["jp1", "soloplayer", "BQdl3hJ6dw2xoxefq-yqGQy9UQxRy8I-7Qv7bvmXx3R7vp0", "B373CoaCU8rvo8zASkEH-ryv7jn40EbynfAulL2oIYVXgcapzrHhuK5L", "eXqAWlIR44HS9EEInGXNVfHy9y7XjtvvT3PYpmvVCYtJbGbasRziwChiSndN2gIq5QlixBk7mzFU7w", "FioraJapan3002"],
  ["jp1", "OnlySplit", "5vyHhEAVlD0PsntQRrLDKFIEa6F1TifCCsw7fhjtS_hFwx4", "5GxoMBzNNOY7q4kadypaRRevMAr1bs1h9itLnAYU9cy83ox3RTLWGk91", "I9DMXTstP1KsdA0s3rvzx4R409EExtHCX1eeMtW8l4RVDOOSIzNVkAS7HQzpWJYxINn0AKPII1YXsQ", "FioraJapan3003"],
  ["jp1", "SlashーMuteーAll", "qfJedg5jJ4i4kge9kWXz80PacepAMR4jcy-K87dbPG7xKyY", "XFaEk4Z2i_KNwpjcqTUFcwGVUmtB92Rqmpkh8yxGW_Cf4BZcxhgceiXZ", "NcaCw68it3SFjkhVoA2UTm78fdlhpUq9T5NIqh5ATapwbKsBd1CHGtkGVDLJ-_zfxIMKy2puK5JotA", "FioraJapan3004"],
  ["jp1", "憤怒調節障害者", "47Q8OF_FY0Y6swWVIIyL5EeHCy57LpjEliWg3g8nA33A_Wk", "QxPitPyfEoBg6hzdESHMM0QTj0AHvIqOu6bPnjIfXTYqxscJgbtEjMcb", "i-XRQ3-22eU1oUzXXQA_5gw9hpi6cLcnMuV-BSDIa2071BnWsRFQnfMpgEiiclhEkIxgXocm6eEZdg", "FioraJapan3005"],
  ["jp1", "通報しないで", "UFsKj0KezohbTw5lp_42OTEjFlYgtZrkot9Am4l90rSaggk", "AkKnBnmtqPKEJWF5wXsM7FA1nxKX0pdPZmZZOPYRFTbYtNpvT2xWfvA5", "a9P8NBxe1zQZ-hQtlfN4KbkO9Im-SjD59_AGmzMloMJPYje0FUuebLK21RNCDKazVnF8MpxJHQ6pjA", "FioraJapan3006"],
  ["jp1", "ThisServerIsHell", "XGTX6MZAUMfwbP6nsGTRfWJiZJLAdmLS_a1hFjiiSmF_xUU", "RZz-fH150GXPb-ZfgzWPczMbwGXuUCNTLmx-b5cSlbZR1eVSCiUqM_XB", "84U5ioHhJKv2haxZsT_xjOV46iUGWTHfpHbhGz1rhsUGuB-5NNvagLLmEhWfd3uuB4BYCE-9oDG0NA", "FioraJapan3007"],
  ["jp1", "MapUnawarePlayer", "8Uaa6eVROsRvQVxXSCSAgxK6OPIp6uFvQF-Aiw-S0SouV4c", "3fwS6y6Z3K_aLVMmOM7Tq0U7k5lvPXVWphDrK5mBTulvhgH7DRz2oht6", "61CaWm8I9442aH3ZOZJNLahYzNlGcsaczmIDo0vJj3mIHfFJvtI00TF1hYvd3yZb8vZFPm_gS6G_mA", "FioraJapan3008"],
  ["jp1", "MyTeamAreTards", "qxmfUHXGrouULfAyTzZ1KeOjUgZjLSvRzbTW2v4Fsc9eZoE", "vnpxFIg61oX-vmW9CkZwA0f69AQdfwXtBAeQB4oR3wqVltN2-itbo9RD", "wQT4m2HBOwaw-D7u3a44uhterhK4Ejupi1Vb1uCYmqf0ursBU6ol7gxZdyIYFr-KOld-fQHJqdYyhQ", "FioraJapan3009"],
  ["jp1", "試合後報告するよ", "-4myNAxuhvOTo108wq3zfYHo6LzNMZU-G5OPL88OJ1WFYeE", "sCfJJjTDEmJ0U6Gwnz4TtdbvgxU7C7nUoE06AoKHo516Kexlb75brEOW", "heTGHlVY6R40z8uPj5bLq0_7rgkItNBylKH1J8ROi4loBi-mVZB6RJ1z0Og8FfdE-clCSpIb2gL9DA", "FioraJapan3010"],
  ["jp1", "沈黙は金 allmute", "zaErMp1BAme0XE6t226FfjZCI2LgiKoTZYGCOltM9Ik4FJE", "6psss58buAe85iXZ6ymITIYB_b9jQqeFcNfeR8BsxCyTv1oGOZocAWKa", "A40CUfFjPO8veNd8-yuc5djRyzuTsLdb2hdD5T0yabRDUYw1ZDntUpVjWdMcp7T1ecrewY__1G5mfQ", "FioraJapan3011"],
  ["jp1", "Fiora1v9", "O4hlsKxj0QS5mGNP_VrSKF70QjsSqTCvwgVyLeYSG9JT1uo", "93ilrTYa6fEIfBziOXuMILkruG7p3joWYqcyZEjbI7epVpJAXY3lwxF0", "o33xPXQUn8AhhBdyjYmktkO4SSWWX4ZzaRwCoHy4iwzgq8KU1zlt7pEQVQJ8qfwJ2-qVSEh0IXDSGw", "FioraJapan3012"],
  ["jp1", "沈黙と無視1v9", "woZrF3tBcPV6LwBEvC-_tScAQovTr7TrM3Muck-UyVWC6Ww", "_ExrxQffXFyGLEnUMoQAb8Bun44dMQq7L8agHIv6CdCNCcMvKLfYhYxK", "TZEirlgZy19-qJ8dDdBOK-B_yF8Edcu1zgNmwBM1R8hoK0B6tHwnBxbxwN8vP5Z0mFVQCxoBC__6YQ", "FioraJapan3013"],
  ["jp1", "Fiora Bluesteel", "BDAENSMfUBO8ca1qMRHZMsVt9XOiOllQ9i3wuSX9i4ZbVsPiLv3GIQ1nNQ", "SuRjXeq8MXqU-rcxW7AEu6tP2DAULk-Ms_UfSixFNAPW8Ax-efMG6C9V", "bWPIZ_N1qW7K1GURvhMFQudBky2mKDAHu4bj4xGfoQS6T0l8FEws3epkGu72ZQboP8Ir4KCNE2pUuQ", "FioraJapan3014"],
  ["jp1", "1v9JapanServer", "4N3dPl8b8gAuVUIoM9hzntNKOJG3RnAfrHgs7lzZASFHpac", "EoAsCqw8beeqXaDONLcSFNNYs47ZNhdEsav4kyqMs4WkrB95aXA5IAUN", "L1jxODpfAPzMmeQh6eOF8UzAwzowG1RJalS5AFqfycGi5TwjquVwG246Dl0QObPdS-xwqoSLbr7zxA", "FuckYouJapanVeryMuch"],
  ["jp1", "WinnieーTheーFlu", "Xp201qztAPq0pLyyOi9G8zEIgURtoW3xo92mJYmYh4eeLVQ", "HNOj0Xhdg2kek3S7O9Pj2VUuD7jEpuODssFqkVwDrCsuBNAaC23TlLhC", "7xLwqQIMndyCyfjyUuRYua46-WY8nB9HP8m0fVjvfprlxOK9RZ8_tN23a3pqroz4yFL4tmh-uL64iw", "WinnieTheFluJP"],
  ["jp1", "ーMuteーAllー", "GQp-RW6giYETrUyrlRTrVzTMlyOynS8Rh2cRGWS41DjwEMQ", "8ROb4-HHE_V4-frhVkIFJEwthA1Jh7gz3lWwyqOWP4i7rdzJR_4_CqDo", "B8uK94XYBrc0lJqpoqn8SDDLqL4ei5VpxLsWQyxrkvNi8GZX3Bz812IqxZZeLe8ySTWsyjZ8bEiUcA", "RiotJapanSucks"],
  ["jp1", "ーTiltedFioraー", "4wrTjYCL3C7l06JiW4n9Fk0izoT8bnuFNV29FyBp_OLRtx8", "gCzh7X8ivg3dkkACcmsd2rS7OLQvR2oPob6UoIz5DJPVY6akvqeNbxze", "bgnA3xh4UG_gIffzqEF11yVEBwSicSuwuNngVvKvIlDXnDPr9M_E8r1BUVLmt6eFRb57LJi1AWzSCQ", "FioraTiltMaster"],
  ["jp1", "自転車で旅しよう", "aPpf15z8AbjQF-GijHLzc3OID4kR5aQ4avM9tJijRWy9Tb8", "6f8JYa5JuPQeYhMJMPqbk4s1dAq-T09Hz03jZCzYEzPcqIjzBDQAvk4w", "ydRrmqc4Y4wsmMpxUk8gIf79iEiCRuWQOe_LUsW_T0HGD0qp2GKex3WJma1W4u2la5lgDWFcb42TZg", "jrzlmcbr"],
  ["jp1", "蘇生完成フィオラ", "GQkNdcFAusBCQoVv-eyKRhu9lyGpBvk3_JJUa0j45NCq-Xk", "kKAdT0Ldm_oAboWJJV09AU-gZ8uDllod-vt9uZ_I4wGTAP35AMx4OOqK", "l8haiEl5Ct-2zjhbPUmJb9CeUIguV-e1URz-oLR7AiIvl8yWdA0PXeskAOB7Xd2vgKgF-yQh0FXM2w", "DorskJapan"],
  ["jp1", "FKuJPserver", "c-fOMud-JV24iP8jRw69THMyFu3ts8YXQ9eVuenakYexzZs", "yN_wSTDBl0CzehbitRyDnys6-kBAO06vnDpO6CnxgZQ34zPuSM45fEDx", "d4ROoo9lKq3mK6f19N-z4HuAdTvSJpq-FJTG1PMhzq2jFMRpVO7ts5YM34uVdvK8dLd0IQkAPougCg", "bunchoftardsriot"],
  ["jp1", "また停止フィオラ", "iffQNQ6f7aa-FQcJAdgwZQih0-3En12h4_58wUun8eroqc4", "-o5l5nehorEedei6MKJGSVNWn9ouzerQ6kgP1fXl6l-17SYPAunC4mMS", "VJCuM_NKx-ZmDTtPwVrbuLhpZZMNWIASULTf057q72DVrUwswNY2u5BA7XebpEUNrkl4EwXPy6mKkw", "fuckyouriotweakbans"],
  ["jp1", "永久停止フィオラ", "YQvIyNpuB0TVPt4O0Ls3LIDvXFqAJUDJ79tKJrxQ2U0dMn0", "DXRlnwswtSIY1McaYtd1YLOshQYlb18fmBdttwTkSYrSME_c9SO5kvoG", "jOBcSna685WltzQChVQiliPOR-lc6JfUo1i9yNUHJA5b4Ejr-EbqQjWOswOaPbQGw4lWWLIiEpICdA", "CyberiaAlita99"],
  ["jp1", "フランスDSK", "z4YheTw_f6KI8Ag3XsAB66Fcs0yhgJmkdC7qD5HR72YxhAs", "KQvdRxZ2f50fMAGAVbm3DoEmIcNmZuNRs2sMULJOVs3D8M6PI_p8u_N3", "5Pep2idKRecQkCkhJXH4oaxtThZQ8RmEI0X1NdKS9KL2xfOP24ljNTH98Jvb7461SZtRQ-hlfVqiPQ", "DorskFRinJP"],
  ["euw1", "DorskFR", "Tf-7gIFgwTfJq7GKcFc8SvMAuv5UDKazCnXIfppFkjaWUCcr", "PVFZshoWulQxDiFVrqzvUtpB2kOHxTI579H0IxjqKAP3NcQ", "WykX1XWqGM9vCFAfmxq3zSNeGbWUXCetEyemqPyZ_g0rRJveEB4CEFTVp2dCU_6Kb_y0oaXEBUWIOA", "DorskFR"],
  ["euw1", "DorskJP", "kmkkp6PRNUditqR3DtxrB4-PicnmzV1eLgqSeuHFZjUCTSBz", "4fw8WVVWilS31tb9yKZPI-VUYRb-7PlC4sbJJFCdWfQYoGAbytSuElwI", "18V2NamHZtap3ADxU00ILTemx1IYqwt4KSIMlbjOFzTWM0gTgo0WwW-rdiSEzploGR87ptkjXwN6rw", "DorskJP"],
  ["eun1", "Dorsk", "yoL7exLyLzpj1-LV9OGoee2xfUWrBMaVcEWaW0K0e3JezuY", "D05JkkEVHXovuB_fYibN4fBqPz4NEZoxk09sFNBG4pzzlFPA_bZiLHD1", "jmHsyylVI0uOJ9lXP9L1e06J0L9YBtiVdX5fhhUPkp0KbDIB2mHAcGIo9sdT9rBZaARWfxQCXbYjOA", "Dorsk"],
  ["na1", "JapanServerSucks", "pL_WU40pULrNXltLcNQDOfUDBqEBTeY0mX5-XCnq_6fThGwi", "YkVAMTav1XFPOSpE-VLpBgWpb9KRsadCiWYBBMAz1vJjRWNGCQPdplT_", "2_vCpgD21aYU4lwRxaIP9u4ba53m2kHFE_8T8iaxASix8EFhNEqU3Sor4pNi3XlbPldxtneDiBQ1qQ", "FioraJapan"]
]

def get_account_ids
  account_info = []
  ACCOUNTS.each do |region, name, id, account_id, puuid, login|
    url = "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{name}?api_key=#{KEY}"
    uri = URI.parse(URI.escape(url))
    net = Net::HTTP.get(uri)
    parsed = JSON.parse(net)
    puts parsed["name"]
    puts parsed["puuid"]
    account_info.append([region, parsed["name"], parsed["id"], parsed["accountId"], parsed["puuid"], login])
    sleep 0.2
  end
  return account_info
end

def get_mastery_total(champion_id)
  total = 0
  ACCOUNTS.each do |region, name, id, account_id, puuid, login|
    url = "https://#{region}.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{id}/by-champion/#{champion_id}?api_key=#{KEY}"
    uri = URI.parse(URI.escape(url))
    net = Net::HTTP.get(uri)
    parsed = JSON.parse(net)
    puts "Account: #{name}, Level: #{parsed["championLevel"].to_i}, Points: #{parsed["championPoints"].to_i}"
    total += parsed["championPoints"].to_i
    sleep 0.1
  end
  return total
end


def get_all_matches(champion_id, type)
  total = 0
  ACCOUNTS.each do |region, name, id, account_id, puuid, login|
    url = "https://#{region}.api.riotgames.com/lol/match/v4/matchlists/by-account/#{account_id}?champion=#{champion_id}&queue=#{type}&beginIndex=10000&api_key=#{KEY}"
    uri = URI.parse(URI.escape(url))
    net = Net::HTTP.get(uri)
    parsed = JSON.parse(net)
    total += parsed["totalGames"].to_i
    puts "Account: #{name}, type: #{type == 430 ? "normal" : "ranked"}, total: #{parsed["totalGames"].to_i}" 
    sleep 0.1
  end
  return total
end

#get_account_ids
total_mastery = get_mastery_total(114) # Fiora
total_normal = get_all_matches(114, 430) # Fiora Normal
total_ranked = get_all_matches(114, 420) # Fiora Ranked
puts "- - -"
puts "\nTotal Mastery Points for Fiora is #{total_mastery}."
puts "Total normal: #{total_normal}, Total ranked: #{total_ranked}, Total Summoner Rift: #{total_normal + total_ranked}"