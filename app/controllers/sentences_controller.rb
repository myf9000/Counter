class SentencesController < ApplicationController
  def new
    @sentences = Sentence.delete_all
  	@sentence = Sentence.new
  end

  def create
  	@sentence = Sentence.new(sentence_params)
  	if @sentence.save
  		redirect_to @sentence
  	else
  		render 'new', notice: "Your text wasn't added"
  	end
  end

  def show
    stop_words = %w[a able about above abst accordance according accordingly
                 across act actually added adj affected affecting affects after
                 afterwards again against ah all almost alone along already also 
                 although always am among amongst an and announce another any 
                 anybody anyhow anymore anyone anything anyway anyways 
                 anywhere apparently approximately are aren arent arise around 
                 as aside ask asking at auth available away awfully b back be became 
                 because become becomes becoming been before beforehand begin beginning 
                 beginnings begins behind being believe below beside besides between beyond 
                 biol both brief briefly but by c ca came can cannot can't cause causes 
                 certain certainly co com come comes contain containing contains could couldnt 
                 d date did didn't different do does doesn't doing done don't down downwards due 
                 during e each ed edu effect eg eight eighty either else elsewhere end ending 
                 enough especially et et-al etc even ever every everybody everyone everything 
                 everywhere ex except f far few ff fifth first five fix followed following follows 
                 for former formerly forth found four from further furthermore g gave get gets getting 
                 give given gives giving go goes gone got gotten h had happens hardly has hasn't have 
                 haven't having he hed hence her here hereafter hereby herein heres hereupon hers 
                 herself hes hi hid him himself his hither home how howbeit however hundred i 
                 id ie if i'll im immediate immediately importance important in inc indeed index 
                 information instead into invention inward is isn't it itd it'll its itself i've 
                 j just k keep  keeps kept kg km know known knows l largely last lately later latter 
                 latterly least less lest let lets like liked likely line little 'll look looking 
                 looks ltd m made mainly make makes many may maybe me mean means meantime meanwhile 
                 merely mg might million miss ml more moreover most mostly mr mrs much mug must my 
                 myself n na name namely nay nd near nearly necessarily necessary need needs neither 
                 never nevertheless new next nine ninety no nobody non none nonetheless noone nor 
                 normally nos not noted nothing now nowhere o obtain obtained obviously of off 
                 often oh ok okay old omitted on once one ones only onto or ord other others 
                 otherwise ought our ours ourselves out outside over overall owing own p page 
                 pages part particular particularly past per perhaps placed please plus poorly possible 
                 possibly potentially pp predominantly present previously primarily probably promptly 
                 proud provides put q que quickly quite qv r ran rather rd re readily really recent 
                 recently ref refs regarding regardless regards related relatively research respectively 
                 resulted resulting results right run s said same saw say saying says sec section see 
                 seeing seem seemed seeming seems seen self selves sent seven several shall she shed 
                 she'll shes should shouldn't show showed shown showns shows significant significantly 
                 similar similarly since six slightly so some somebody somehow someone somethan something 
                 sometime sometimes somewhat somewhere soon sorry specifically specified specify specifying 
                 still stop strongly sub substantially successfully such sufficiently suggest sup sure to the]

  	@sentence = Sentence.friendly.find(params[:id])
    @txt = @sentence.body
    arr = []
    arr << @txt.downcase
    text = arr.join
    @words = text.split(/[^a-zA-Z]/)
    # zliczenie znaków
    @character_count = text.length
    @character_count_nospaces = text.gsub(/[^a-zA-Z']/, '').length

    # zliczenie s³ów, zdañ i akapitów
    @word_count = text.split.length
    @sentence_count = text.split(/\.|\?|!/).length
    @paragraph_count = text.split(/\n\n/).length

    # utworzenie listy s³ów z tekstu, które nie s¹ s³owami pomijanymi
    # zliczenie tych s³ów i wyznaczenie procentowej iloœci s³ów pomijanych
    # w zbiorze wszystkich s³ów
    all_words = text.scan(/\w+/)
    good_words = all_words.select{ |word| !stop_words.include?(word) }
    @good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i

    # podsumowanie - wyodrêbnienie zdañ potencjalnie najbardziej znacz¹cych
    sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|\!/)
    sentences_sorted = sentences.sort_by { |sentence| sentence.length }
    one_third = sentences_sorted.length / 5
    @ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
    @ideal_sentences = @ideal_sentences.select { |sentence| sentence =~ /is|are/ }
    @ideal_sentences = @ideal_sentences.to_s.gsub(/[^a-zA-Z,.]/, ' ')
    @bad_percentage = 100 - @good_percentage

    @freqs = Hash.new(0)
    @words.each do |word|  
      if !stop_words.include?(word) 
        @freqs[word] += 1 
      end
    end
    @freqs = @freqs.sort_by {|x,y| y }
    @freqs.reverse!
    @freqs = @freqs[1..11]
  end

  private

  def sentence_params 
  	params.require(:sentence).permit(:title, :body)
  end
end
