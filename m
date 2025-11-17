Return-Path: <linux-ext4+bounces-11874-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DFAC649DD
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FE23A7824
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98133343E;
	Mon, 17 Nov 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="IQ5EDc2m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576B30FC2A
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389253; cv=none; b=K20woIHNDBEC8dB1sfHrKIAHleQCQR1u/t0BMjUtc19InKVkZWGn6lXbk4fMKGoZcZz73axAwCawKGjsFrgHRmxkUkewhjqop2sK5DLfiZe3m+ykK4tcttdGTXJez3dDoZ70+revqaFs5rP7RqVSOj0PsAVYTy6dJpQoSVnD/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389253; c=relaxed/simple;
	bh=uOFmWd34SNOW0WSeH9ve8vatlJxo806lXJIQDOR18cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVMCR3Nf7TEEXRsbW2Ugn04+SZnUiVsgJQG0hIR8bN8EV39Jy82b8s2Zu0BuX0M4qAVqyC7r9W26TCR8kdiZhW8ct/L+i9qX6hsLoH85RcikwlLmzZwU8X17p1N82ezYNZ9TfVVns4UhWmTKutPMU0inDrYZC4WXc+QY+iVr9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=IQ5EDc2m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so4046037a91.2
        for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 06:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763389249; x=1763994049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDjwQ+AQw6XteHbhrcM93QrZO2AXe3GggbYl4g1PYWE=;
        b=IQ5EDc2mPK61X6n2a1zEjVn4nLylSI2FW0vZW9DdKnPLJoCX2M5esik0/3bAIqPw3g
         F/AZOjEPjWxjzPBFi0xAOLwXsVoFN4Yidoqsuef8t9dQb3tGZJdERIEWGLO/tdDk+Rmw
         eAslQ9+j4eAHVjm+cCL+nX9/+vvR62MjLqqbGq7wpLU2/RiFJgKtFF/16CPw3bG+Oeuo
         YxSrmMmgh7JixnbS82ekDPCFVkx9QeQ8jNAlrZViD0E9D/vybDxdTOIofiFdkPBqblWu
         oDerlMYc+k3+S94cI//2ULSHyx4uB0A8YY+w0LOWBLCWhdipOd1yXh7kGkSEtqvwJqkV
         MTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389249; x=1763994049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDjwQ+AQw6XteHbhrcM93QrZO2AXe3GggbYl4g1PYWE=;
        b=PKffA61Ok4wZraFdcp7XKEok7KcBsinv+6vHTJTXudERXjuACckkW99MhZO9Ab4Gs3
         Ircmxft8jUFU6CgcUPjNpudPFsxFOSPM0sgdo5KxNN8++Xmva5y+HPyHV2I+AW3auJZ+
         2AvdE43Mpdg52ab0F3VQxGxRmkVWbNOBDSfEKPB153xoYT5apDHM+vr3y1Sm00mwCvpL
         BToERHRML4/yChyNZzZgPScQ5XQ8I6GGBfT00agPzcmK2ucoBjPAAX14Yw9C/CBrpDM9
         4qe9YmzryxD0doHkTnxHqPC1E/qzAJeD/+l7ekxY8WlUA8UpHOZWvdt7sogu0MIrFeO7
         x91A==
X-Forwarded-Encrypted: i=1; AJvYcCW4iTkb5C+Q/aPOkgoIgYzeX2mqAm2XLYCDIAHjLpZs6j1oJ0l6Kgu9wA/F03xldJyqVEDQFXGJN7Kq@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8NL7HRQrcbciTI5PlBrFIKMaYBcXNLmdLjgoW6e5CRAfbR4W
	7QT/ZED+wk29AEGwk5uVG2QRT6Cif9O10uiAEIhh4UHF5mzl5hvpsboWf3SdEzujxnw=
X-Gm-Gg: ASbGncuL7s0rspwmMKOGQzIcIIblDDucH3fFAKdVdQZ8cxHo4Kuqzv0SXlQ/VrRxU4y
	PlriS1RZzzob8G9NB4pDd1ytUdMeUU01qPmPw7IWzu+VgFHweVCliaNrL3RyaJUU+ymhEo4EHh8
	RBNM27UvY5AdYyylbc3uMbFmwWDGvA9Bu2LELKNWMEZgR+vIAAI7p1kR1PA3ZA+gz9ukBxCN3+M
	8dHJh9eDUVgp6uei2iukyeby0TS32tyiFV/7HBAR+S+oP5A613WqUqJ5XLOpaJKoLw9oagDw4Rz
	+SaCjP2Scm+gMlcCM31ShqVo2GX8A+Vy8gMHQoQg8FGjBZPN/1m2ecdencZot7Ctp4ICuEaybVZ
	ynDDQ1yynr7e5cQ0qtDqwb0seVwoz3Sq2mQKfxJlK6wKomKMoxGal6ubYarytaSvwk41mKV/wGb
	wfZqD6prva7/rM/AG6uvDnt7MDzEwAQJA=
X-Google-Smtp-Source: AGHT+IH9BR8qFPAX7WtHfrZp+wziPSn5kFimyaTjHjveuWTGxlwiZFjVicXc5llUq5ydaR55j1pBCw==
X-Received: by 2002:a17:90b:2790:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-343f9e9f3a9mr15610880a91.11.1763389248980;
        Mon, 17 Nov 2025 06:20:48 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:d709:f3be:9719:dfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07b4b23sm18321505a91.13.2025.11.17.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 06:20:48 -0800 (PST)
Date: Mon, 17 Nov 2025 22:20:45 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <aRsvPXiuBSun/eVp@wu-Pro-E500-G6-WS720T>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
 <20251116193513.0f90712a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116193513.0f90712a@pumpkin>

Hi David,

On Sun, Nov 16, 2025 at 07:35:13PM +0000, David Laight wrote:
> On Sun, 16 Nov 2025 21:01:05 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > The original byte-by-byte implementation with modulo checks is less
> > efficient. Refactor str2hashbuf_unsigned() and str2hashbuf_signed()
> > to process input in explicit 4-byte chunks instead of using a
> > modulus-based loop to emit words byte by byte.
> 
> There are much bigger gains to be made - the current code is horrid.
> Not least due to the costs of the indirect calls.
> It is better to use conditionals than indirect calls. 
>

Thanks for the feedback. I'll remove the redundant casts, and for the
unsigned version I'll switch to using get_unaligned_be32() to avoid
duplicating the implementation. If this approach looks reasonable, I
can send a v2 that replaces the indirect calls with conditionals.

Best regards,
Guan-Chun

> 
> > 
> > This change removes per-byte modulo checks and reduces loop iterations,
> > improving efficiency.
> > 
> > Performance test (x86_64, Intel Core i7-10700 @ 2.90GHz, average over 10000
> > runs, using kernel module for testing):
> > 
> >     len | orig_s | new_s | orig_u | new_u
> >     ----+--------+-------+--------+-------
> >       1 |   70   |   71  |   63   |   63
> >       8 |   68   |   64  |   64   |   62
> >      32 |   75   |   70  |   75   |   63
> >      64 |   96   |   71  |  100   |   68
> >     255 |  192   |  108  |  187   |   84
> > 
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  fs/ext4/hash.c | 48 ++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
> > index 33cd5b6b02d5..75105828e8b4 100644
> > --- a/fs/ext4/hash.c
> > +++ b/fs/ext4/hash.c
> > @@ -141,21 +141,29 @@ static void str2hashbuf_signed(const char *msg, int len, __u32 *buf, int num)
> >  	pad = (__u32)len | ((__u32)len << 8);
> >  	pad |= pad << 16;
> >  
> > -	val = pad;
> >  	if (len > num*4)
> >  		len = num * 4;
> > -	for (i = 0; i < len; i++) {
> > -		val = ((int) scp[i]) + (val << 8);
> > -		if ((i % 4) == 3) {
> > -			*buf++ = val;
> > -			val = pad;
> > -			num--;
> > -		}
> > +
> > +	while (len >= 4) {
> > +		val = ((int)scp[0] << 24) + ((int)scp[1] << 16) +
> > +				((int)scp[2] << 8) + (int)scp[3];
> 
> The (int) casts are unnecessary (throughout), 'char' is always promoted to
> 'signed int' before any arithmetic.
> 
> > +		*buf++ = val;
> > +		scp += 4;
> > +		len -= 4;
> > +		num--;
> >  	}
> > +
> > +	val = pad;
> > +
> > +	for (i = 0; i < len; i++)
> > +		val = (int)scp[i] + (val << 8);
> > +
> >  	if (--num >= 0)
> >  		*buf++ = val;
> > +
> >  	while (--num >= 0)
> >  		*buf++ = pad;
> > +
> >  }
> >  
> >  static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
> > @@ -167,21 +175,29 @@ static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
> >  	pad = (__u32)len | ((__u32)len << 8);
> >  	pad |= pad << 16;
> >  
> > -	val = pad;
> >  	if (len > num*4)
> >  		len = num * 4;
> > -	for (i = 0; i < len; i++) {
> > -		val = ((int) ucp[i]) + (val << 8);
> > -		if ((i % 4) == 3) {
> > -			*buf++ = val;
> > -			val = pad;
> > -			num--;
> > -		}
> > +
> > +	while (len >= 4) {
> > +		val = ((int)ucp[0] << 24) | ((int)ucp[1] << 16) |
> > +				((int)ucp[2] << 8) | (int)ucp[3];
> 
> Isn't that get_misaligned_be32() ?
> 
> 	David 
>
> > +		*buf++ = val;
> > +		ucp += 4;
> > +		len -= 4;
> > +		num--;
> >  	}
> > +
> > +	val = pad;
> > +
> > +	for (i = 0; i < len; i++)
> > +		val = (int)ucp[i] + (val << 8);
> > +
> >  	if (--num >= 0)
> >  		*buf++ = val;
> > +
> >  	while (--num >= 0)
> >  		*buf++ = pad;
> > +
> >  }
> >  
> >  /*
> 

