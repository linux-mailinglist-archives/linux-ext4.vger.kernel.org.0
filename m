Return-Path: <linux-ext4+bounces-10867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 698AABD8AFB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 12:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE47F4F7951
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4912FB98B;
	Tue, 14 Oct 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="d85UoATp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE82EB87B
	for <linux-ext4@vger.kernel.org>; Tue, 14 Oct 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436832; cv=none; b=lv7gQNuC1sNpVfLXQ00vH2n4jeX/JkxsQmLkAIg3yGruEEXlyJ8g8vZ4LCNCWmIWG73avSZ1RfJrmlGpdrsK/+jAkm/5ln1sirZNYqHP3QCy1CzyhGTTyBg7cSs8REpYGIZLk7ygOyjKlNQjgkxm9pteGiQAzf8v6Z82WLrLORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436832; c=relaxed/simple;
	bh=Eh5BVoIdj3E+g/qo7JJOEx2ayp6tBh/70JNpJI0OD+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlZwcGuyocYIseArhMaVnTtPMtnoVHtj48FZFMvxNj2okjYDJg9hHqz8vAd9PAF3uLGNtr0BAzDNoCVFryjXarRK7wcVY345pX1ZsC3n0zHwG0X8OImAMiTVrgzhWXKmj4Nb24lB4jQhzpTEpe7uFenvt8Mh+Voazs/VgZBCswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=d85UoATp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4318259f8f.0
        for <linux-ext4@vger.kernel.org>; Tue, 14 Oct 2025 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760436829; x=1761041629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=d85UoATp6fQGf77g72ufnB+c5XzyTEdYJpJ14ctGTEu/Sahws0rO3IgWEUJcWak6xM
         euwiPhvxcZ3gOWW3NLlzMZ+FnnpDl9BsItmr5CXTDFwibSpW3awPUFodQZMSoiyXS5LU
         tV9xx9GKK7lOayJSDblSwVye7gWNCEvq2XpYlmaWjQ/hYr+iD2113aTwn5qxygvYjV/S
         XDl4NUTgUkLu/9/BSQCHk/WP2hs6z+s6vcSi0pzL6eW6NiSgZyw+uJg6IeGvyNSlndGA
         WQPX2Ui+es4PLgUPGrIhx8B43nzbNPZEkhts4ipWPU4FnLgrdOUAKBX99Aiy8QGCaKkR
         NP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436829; x=1761041629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=rqRtGxy/dKP5GXy6fswfeCIiRYRnSnlxW6dOG7HhdBlA8bqlYn9PMQrQG7UV8fMisM
         cbcVdHfBZIOrDh6RYTp5HQWtLR3pF1o5xJe2jVV1wImLdCzZ+H0huEobfWfnwyhnZGCq
         bsKaLxdemZhCl1mr1FQD35RG6t3V6lRxsoLIduuMHJeg43EXF9fIklHaP4r8jGYHc1bF
         n8F0MeNG3JgOQeep88wWpTPZIaEFkPSIUZOBLeAv4I5ATUFkgZ4032fzbw9KQqLYkP81
         vf+MJIELcy2APalR6hndHtX0vtwHWflaMTkIbmn3YI/IYUrcXYudveLr65Qw6ZTip7mL
         mZdA==
X-Forwarded-Encrypted: i=1; AJvYcCV7zxvcs1IaU/WEDlRPszfzw6ZzQ7ikzDCP21Dchgb9+fZKL5L+LHpTV2uHupTyqOqgh6kagkjlJbti@vger.kernel.org
X-Gm-Message-State: AOJu0YwN87V5sJaWsLGp0xyKxTRKx6Xw2CQkEFz1V8GAu2AFs2gyotPz
	RD+guM6JknHB5z1a6WEfQ277FGtlYTRuTz2TaUYoHGL4lGvWqrfeDkLanWqkit6Toi8=
X-Gm-Gg: ASbGncsN3b+9s1EgcGrq457FdtyXjTzTjIeOIqYnq9Ekg7aHNY+iAItBoKBgVo+yWvB
	YK7BPRXyZhhXe4G35aNnT7GS0F6pH/Cw9K1uXeYN0FCWnyJI/vd3pGCtbFea1Y62HlVc412ZuVp
	d/5JH4Q8AmmzxAcUa0JpkvFUXWUvLkWj1jakU5SyDfEYwX+GrJUVPlVx4hb7kHH13Xb3tLmBYWR
	uc5e52rhjNmt0kZoORdoMcUDXhAXGa8E7A5MEjAEFQbxfbNqpwFI9Gwhv0oPDjRjauOYC12mGwX
	lM7Jg4jF6GP231uN2EM7aXrqqjSGyvT9tWtxs31nafu5b6BZn7Bt0iktRhgRABJzgX0wSXQP6m9
	DNfdkU2zAqxZEQsk9RG6HuMliaA==
X-Google-Smtp-Source: AGHT+IFWdFmuBH45KApzDATfMiXATkGI8VwBnZcXpUsUtaPvnVOQgNZ6Tnlsi5kbUQn142h2b+DYoA==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr15589331f8f.23.1760436828649;
        Tue, 14 Oct 2025 03:13:48 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm23371423f8f.32.2025.10.14.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:13:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:13:46 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251014101346.ep73uuigr25xu5a2@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
 <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
 <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>

On Fri, Oct 10, 2025 at 07:23:54PM +0200, Jan Kara wrote:
> 
> Maybe I misunderstood what you wrote about your profiles but you wrote that
> we were spending about 4% of CPU time in the block allocation code. Even if
> we get that close to 0%, you'd still gain only 4%. Or am I misunderstanding
> something?

Ah, I see. Yeah that's true but that's 4% of CPU cycles that could be
put to better use elsehwere :D

