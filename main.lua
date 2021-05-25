function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")			--disable blurry scaling

	main_font = love.graphics.newFont("pc98.ttf", 16)
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(main_font)

	setting_pitch = 1.0

	MSGS = {
		"please let me help you. come inside.",
		"i can restore your life.",
		"stop and rest here.",
		"i can give you magic. come back anytime.",
		"i am much too busy to talk to a stranger.",
		"hello!",
		"hello young fellow.",
		"sorry. i know nothing.",
		"each town has a wise man. learn from him.",
		"find the heart in southern parapa.",
		"only the hammer can destroy a roadblock.",
		"welcome to rauru",
		"get candle in parapa palace. go west.",
		"goriya of tantari stole our trophy.",
		"you saved the trophy come see my uncle.",
		"in parapa desert use this magic to survive",
		"i cannot help you anymore. go now.",
		"hammer... spectacle rock... death mtn.",
		"do not go south without a candle.",
		"find magic in a cave south of the castle."
	}

	sfx_talk_a = love.audio.newSource("speech_a.wav", "static")
	sfx_talk_b = love.audio.newSource("speech_b.wav", "static")
	sfx_talk_c = love.audio.newSource("speech_c.wav", "static")
	sfx_talk_d = love.audio.newSource("speech_d.wav", "static")

	sfx_talk_e = love.audio.newSource("speech_e.wav", "static")
	sfx_talk_f = love.audio.newSource("speech_f.wav", "static")
	sfx_talk_g = love.audio.newSource("speech_g.wav", "static")
	sfx_talk_h = love.audio.newSource("speech_h.wav", "static")

	sfx_talk_i = love.audio.newSource("speech_i.wav", "static")
	sfx_talk_j = love.audio.newSource("speech_j.wav", "static")
	sfx_talk_k = love.audio.newSource("speech_k.wav", "static")
	sfx_talk_l = love.audio.newSource("speech_l.wav", "static")

	sfx_talk_m = love.audio.newSource("speech_m.wav", "static")
	sfx_talk_n = love.audio.newSource("speech_n.wav", "static")
	sfx_talk_o = love.audio.newSource("speech_o.wav", "static")
	sfx_talk_p = love.audio.newSource("speech_p.wav", "static")

	sfx_talk_q = love.audio.newSource("speech_q.wav", "static")
	sfx_talk_r = love.audio.newSource("speech_r.wav", "static")
	sfx_talk_s = love.audio.newSource("speech_s.wav", "static")
	sfx_talk_t = love.audio.newSource("speech_t.wav", "static")

	sfx_talk_u = love.audio.newSource("speech_u.wav", "static")
	sfx_talk_v = love.audio.newSource("speech_v.wav", "static")
	sfx_talk_w = love.audio.newSource("speech_w.wav", "static")
	sfx_talk_x = love.audio.newSource("speech_x.wav", "static")

	sfx_talk_y = love.audio.newSource("speech_y.wav", "static")
	sfx_talk_z = love.audio.newSource("speech_z.wav", "static")

	bg_test = love.graphics.newImage("bg_test.png")

	sp_aika_base = love.graphics.newImage("vn_aika_base.png")

	sp_aika_eyes1 = love.graphics.newImage("vn_aika_eyes1.png")
	sp_aika_eyes2 = love.graphics.newImage("vn_aika_eyes2.png")
	sp_aika_eyes3 = love.graphics.newImage("vn_aika_eyes3.png")

	sp_aika_mouth1 = love.graphics.newImage("vn_aika_mouth1.png")
	sp_aika_mouth2 = love.graphics.newImage("vn_aika_mouth2.png")
	sp_aika_mouth3 = love.graphics.newImage("vn_aika_mouth3.png")
	sp_aika_mouth4 = love.graphics.newImage("vn_aika_mouth4.png")
	sp_aika_mouth5 = love.graphics.newImage("vn_aika_mouth5.png")
	sp_aika_mouth6 = love.graphics.newImage("vn_aika_mouth6.png")
	sp_aika_mouth7 = love.graphics.newImage("vn_aika_mouth7.png")
	sp_aika_mouth8 = love.graphics.newImage("vn_aika_mouth8.png")
	sp_aika_mouth9 = love.graphics.newImage("vn_aika_mouth9.png")
	sp_aika_mouth10 = love.graphics.newImage("vn_aika_mouth10.png")

	speaker_frame = 1

	frame_timer = 0

	current_letter = ""

	currentmsg = 1
	elapsed = 0
	letters = 0

	anim_wait = 50
	anim_timer = 0
	anim_frame = 1
	anim_mode = 0
end

function love.update(dt)
	frame_timer = frame_timer + 1

	if frame_timer == 5 then
		if elapsed ~= #MSGS[currentmsg] then
			elapsed = elapsed + 1
			letters = math.min(math.floor(elapsed), #MSGS[currentmsg])
			check_phoneme()
			test_speech()
		else
			speaker_frame = 1
		end
		frame_timer = 0
	end
	letters = math.min(math.floor(elapsed), #MSGS[currentmsg])

	update_eyes()
end

function love.draw()
	love.graphics.draw(bg_test, 0, 0)

	love.graphics.draw(sp_aika_base, 8, 8)

	draw_eyes()
	draw_mouth()

	love.graphics.printf(MSGS[currentmsg]:sub(1, letters), 8, 360, 500)

	love.graphics.print("pitch: " .. setting_pitch, 8, 456)
end

function love.keypressed(k)
	if k=='z' then
		if elapsed ~= #MSGS[currentmsg] then
			elapsed = #MSGS[currentmsg]
		else
			currentmsg = currentmsg + 1
			if currentmsg > #MSGS then
				currentmsg = 1
			end
			elapsed = 0
			letters = 0
			speaker_frame = 1
		end
	end

	if k == "up" then
		setting_pitch = setting_pitch + 0.01
		set_pitch()
	end

	if k == "down" then
		setting_pitch = setting_pitch - 0.01
		if setting_pitch <= 0.0 then
			setting_pitch = 0.01
		end
		set_pitch()
	end
end

















function check_phoneme()
	i = elapsed
	current_letter = MSGS[currentmsg]:sub(i, i)

	if current_letter == "a" then
		phoneme_a()
	elseif current_letter == "e" then
		phoneme_e()
	elseif current_letter == "f" then
		phoneme_f()
	elseif current_letter == "i" then
		phoneme_i()
	elseif current_letter == "l" then
		phoneme_l()
	elseif current_letter == "m" then
		phoneme_m()
	elseif current_letter == "o" then
		phoneme_o()
	elseif current_letter == "s" then
		phoneme_s()
	elseif current_letter == "u" then
		phoneme_u()
	elseif current_letter == "v" then
		phoneme_v()
	elseif current_letter == "w" then
		phoneme_w()
	elseif current_letter == "p" then
		phoneme_p()
	elseif current_letter == "b" then
		phoneme_b()
	elseif current_letter == "d" then
		phoneme_d()
	else
		speaker_frame = 1
	end
end

function phoneme_a()
	speaker_frame = 2
end

function phoneme_e()
	speaker_frame = 3
end

function phoneme_f()
	speaker_frame = 7
end

function phoneme_i()
	speaker_frame = 5
end

function phoneme_l()
	speaker_frame = 9
end

function phoneme_m()
	speaker_frame = 8
end

function phoneme_o()
	speaker_frame = 5
end

function phoneme_s()
	speaker_frame = 10
end

function phoneme_u()
	speaker_frame = 6
end

function phoneme_v()
	speaker_frame = 7
end

function phoneme_w()
	speaker_frame = 6
end

function phoneme_p()
	speaker_frame = 8
end

function phoneme_b()
	speaker_frame = 8
end

function phoneme_d()
	speaker_frame = 10
end











function draw_mouth()
	if speaker_frame == 1 then
		love.graphics.draw(sp_aika_mouth1, 8, 8)
	end

	if speaker_frame == 2 then
		love.graphics.draw(sp_aika_mouth2, 8, 8)
	end

	if speaker_frame == 3 then
		love.graphics.draw(sp_aika_mouth3, 8, 8)
	end

	if speaker_frame == 4 then
		love.graphics.draw(sp_aika_mouth4, 8, 8)
	end

	if speaker_frame == 5 then
		love.graphics.draw(sp_aika_mouth5, 8, 8)
	end

	if speaker_frame == 6 then
		love.graphics.draw(sp_aika_mouth6, 8, 8)
	end

	if speaker_frame == 7 then
		love.graphics.draw(sp_aika_mouth7, 8, 8)
	end

	if speaker_frame == 8 then
		love.graphics.draw(sp_aika_mouth8, 8, 8)
	end

	if speaker_frame == 9 then
		love.graphics.draw(sp_aika_mouth9, 8, 8)
	end

	if speaker_frame == 10 then
		love.graphics.draw(sp_aika_mouth10, 8, 8)
	end
end



















function test_speech()
	i = elapsed
	text_char = MSGS[currentmsg]:sub(i, i)
	if text_char == "a" then
		talk_a()
	end

	if text_char == "b" then
		talk_b()
	end

	if text_char == "c" then
		talk_c()
	end

	if text_char == "d" then
		talk_d()
	end

	if text_char == "e" then
		talk_e()
	end

	if text_char == "f" then
		talk_f()
	end

	if text_char == "g" then
		talk_g()
	end

	if text_char == "h" then
		talk_h()
	end

	if text_char == "i" then
		talk_i()
	end

	if text_char == "j" then
		talk_j()
	end

	if text_char == "k" then
		talk_k()
	end

	if text_char == "l" then
		talk_l()
	end

	if text_char == "m" then
		talk_m()
	end

	if text_char == "n" then
		talk_n()
	end

	if text_char == "o" then
		talk_o()
	end

	if text_char == "p" then
		talk_p()
	end

	if text_char == "q" then
		talk_q()
	end

	if text_char == "r" then
		talk_r()
	end

	if text_char == "s" then
		talk_s()
	end

	if text_char == "t" then
		talk_t()
	end

	if text_char == "u" then
		talk_u()
	end

	if text_char == "v" then
		talk_v()
	end

	if text_char == "w" then
		talk_w()
	end

	if text_char == "x" then
		talk_x()
	end

	if text_char == "y" then
		talk_y()
	end

	if text_char == "z" then
		talk_z()
	end
end




function talk_a()
	sfx_talk_a:stop()
	sfx_talk_a:play()
end

function talk_b()
	sfx_talk_b:stop()
	sfx_talk_b:play()
end

function talk_c()
	sfx_talk_c:stop()
	sfx_talk_c:play()
end

function talk_d()
	sfx_talk_d:stop()
	sfx_talk_d:play()
end

function talk_e()
	sfx_talk_e:stop()
	sfx_talk_e:play()
end

function talk_f()
	sfx_talk_f:stop()
	sfx_talk_f:play()
end

function talk_g()
	sfx_talk_g:stop()
	sfx_talk_g:play()
end

function talk_h()
	sfx_talk_h:stop()
	sfx_talk_h:play()
end

function talk_i()
	sfx_talk_i:stop()
	sfx_talk_i:play()
end

function talk_j()
	sfx_talk_j:stop()
	sfx_talk_j:play()
end

function talk_k()
	sfx_talk_k:stop()
	sfx_talk_k:play()
end

function talk_l()
	sfx_talk_l:stop()
	sfx_talk_l:play()
end

function talk_m()
	sfx_talk_m:stop()
	sfx_talk_m:play()
end

function talk_n()
	sfx_talk_n:stop()
	sfx_talk_n:play()
end

function talk_o()
	sfx_talk_o:stop()
	sfx_talk_o:play()
end

function talk_p()
	sfx_talk_p:stop()
	sfx_talk_p:play()
end

function talk_q()
	sfx_talk_q:stop()
	sfx_talk_q:play()
end

function talk_r()
	sfx_talk_r:stop()
	sfx_talk_r:play()
end

function talk_s()
	sfx_talk_s:stop()
	sfx_talk_s:play()
end

function talk_t()
	sfx_talk_t:stop()
	sfx_talk_t:play()
end

function talk_u()
	sfx_talk_u:stop()
	sfx_talk_u:play()
end

function talk_v()
	sfx_talk_v:stop()
	sfx_talk_v:play()
end

function talk_w()
	sfx_talk_w:stop()
	sfx_talk_w:play()
end

function talk_x()
	sfx_talk_x:stop()
	sfx_talk_x:play()
end

function talk_y()
	sfx_talk_y:stop()
	sfx_talk_y:play()
end

function talk_z()
	sfx_talk_z:stop()
	sfx_talk_z:play()
end



function set_pitch()
	sfx_talk_a:setPitch(setting_pitch)
	sfx_talk_b:setPitch(setting_pitch)
	sfx_talk_c:setPitch(setting_pitch)
	sfx_talk_d:setPitch(setting_pitch)

	sfx_talk_e:setPitch(setting_pitch)
	sfx_talk_f:setPitch(setting_pitch)
	sfx_talk_g:setPitch(setting_pitch)
	sfx_talk_h:setPitch(setting_pitch)

	sfx_talk_i:setPitch(setting_pitch)
	sfx_talk_j:setPitch(setting_pitch)
	sfx_talk_k:setPitch(setting_pitch)
	sfx_talk_l:setPitch(setting_pitch)

	sfx_talk_m:setPitch(setting_pitch)
	sfx_talk_n:setPitch(setting_pitch)
	sfx_talk_o:setPitch(setting_pitch)
	sfx_talk_p:setPitch(setting_pitch)

	sfx_talk_q:setPitch(setting_pitch)
	sfx_talk_r:setPitch(setting_pitch)
	sfx_talk_s:setPitch(setting_pitch)
	sfx_talk_t:setPitch(setting_pitch)

	sfx_talk_u:setPitch(setting_pitch)
	sfx_talk_v:setPitch(setting_pitch)
	sfx_talk_w:setPitch(setting_pitch)
	sfx_talk_x:setPitch(setting_pitch)

	sfx_talk_y:setPitch(setting_pitch)
	sfx_talk_z:setPitch(setting_pitch)
end





function update_eyes()
	if anim_wait ~= 0 then
		anim_wait = anim_wait - 1
	elseif anim_wait == 0 then
		if anim_mode == 0 then
			anim_timer = anim_timer + 1
			if anim_timer == 5 then
				anim_timer = 0
				anim_frame = anim_frame + 1
				if anim_frame == 4 then
					anim_frame = 3
					anim_mode = 1
				end
			end
		end

		if anim_mode == 1 then
			anim_timer = anim_timer + 1
			if anim_timer == 5 then
				anim_timer = 0
				anim_frame = anim_frame - 1
				if anim_frame == 0 then
					anim_frame = 1
					anim_mode = 0
					anim_wait = 50
				end
			end
		end
	end
end



function draw_eyes()
	if anim_frame == 1 then
		love.graphics.draw(sp_aika_eyes1, 8, 8)
	end

	if anim_frame == 2 then
		love.graphics.draw(sp_aika_eyes2, 8, 8)
	end

	if anim_frame == 3 then
		love.graphics.draw(sp_aika_eyes3, 8, 8)
	end
end













