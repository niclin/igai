module ApplicationHelper
  def default_meta_tags
    {
      site: "iGai 愛改",
      description: '最好用的機車改裝精品二手交流買賣網，交流買賣精品不再麻煩。',
      keywords:    '勁戰, 雷霆, 58.5, 機車改裝, 二手機車精品, MSP大熱狗, 鍛造框, 排氣管, MDF2, DDS, 燒鈦, 合法館, 魚眼, 卡夢, 後扶手, 烤漆, 碳纖維, 鑄造框, 避震器, 前叉, 倒叉, BT601, 汽缸, KOSO, NCY, 新雅, TTMRC',
      og: {
        image: ActionController::Base.helpers.asset_path('showcase-3.jpg')
      },
      fb: {
        app_id: '2228012483910850'
      }
    }
  end
end
