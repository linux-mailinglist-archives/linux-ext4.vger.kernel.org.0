Return-Path: <linux-ext4+bounces-5643-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648689F20A4
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2024 20:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7721887C46
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC01AF0C6;
	Sat, 14 Dec 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnS1YUX5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2B19D07C;
	Sat, 14 Dec 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734206173; cv=none; b=rxaYL4DLwnzUVOdhOv4iZtfW5Fls04F3A8T9SlDaVNO1Rf4WpCbYkX42vwsKaxXanz3vgjwndjHIPj1iv9ZQi+60QOEgwSGaqNPKsx9u1ZhoNLImZQ4vmTMjVltGK5WGfupGzak1O7G5zgOe7HMDjkouYyKU0MCo36tAkS5gGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734206173; c=relaxed/simple;
	bh=2/PC+Vj7HoKTgLvvtazGZWIYrZFD+gplw0Wi3F0H3GY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pQtMkhNN1Upufv+bzJnbJMLapGyS2+MOyyqGO0OaqGw/CM87X26L9XvOb5E3+eW1kiI2MFEviPv5azu4myuDQZsQwcdjrqAvBZYz+Ve6P/dvYPqZ0G4tIjmZMRCAlp/eYm5xCqac1dRWyOuFxFSqbDKF7XzcsOJaAyvcrGndONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnS1YUX5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54024ecc33dso3107798e87.0;
        Sat, 14 Dec 2024 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734206169; x=1734810969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4moWdmb49UZDL++57SdlyR9ZwMXMyBGAAH7KseBthQ=;
        b=ZnS1YUX5XK6d0Jw7OcWPO3yjzGX01BYkAl842EiA3mQkXl/OSZ9CCA6Vl0ZegZnkIF
         RY6dZEOPDnZoiOgPnGufgOQzmfWXXmTZKIaj/EY8mKZRl1tqQ6udossfXsVzWr3Zcogu
         wRjf6h8LXuvcp4OOTLuRWcpSGz0qWsCvOOKxqEeQ/jITr89AKXYSDrsNko9lsAr/L0Rn
         ROBKF8Pzp9pIIB1XJ+PLFu1CaaBAjUMU8g5EXXFf65O1Efiopf1b1WTR08W6tLDJaWyx
         B63bcmtzIvtOq1ROQZFmKAvaba+9PSeQRNMI96nUrEVtAzYFg4yVkqlcDj59XcG62B/V
         yZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734206169; x=1734810969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4moWdmb49UZDL++57SdlyR9ZwMXMyBGAAH7KseBthQ=;
        b=PhE8G4erDJOGOZLAJbJcJ+cgwDeGwliBAUMieFwFqBt4w0J2feuXSyXZB+VLfWf20a
         a1t++L965qW+rKhcb1F6c/Vqg5FbrDIsMhO41qNlTkjhjvAkNHutrWxym8aaFLuodHup
         120ManeLec5plDNfPbJQPtRZXsbt9oPNqFr5STLGhdZmDaX1PIIQviOfTyNp73RFOneY
         5X6OBV+CFcFSLv7V5zcqntbbHW9hBJFh7ERXcIRHnYzYPk3Lkc8o0ZIhOA1q+TQLbAIq
         hVqsXJUaoG265LSvA8CeJRLF59zpx0xMyoyYJzmWuXJQhnZqYxH7vdT0AfpMntJESQce
         Wu8w==
X-Forwarded-Encrypted: i=1; AJvYcCU36GH+i+/Whx/s6UnmXgyknB6A9HUtn6XKlxFiquFi+nVwJKQKAzHd0gnfybEKo9jt+7Rqn9rle5FEDbo=@vger.kernel.org, AJvYcCWwvTH67HR5WkqldfLBA3he9nTuNmI/gGEGLyDg1t6/x7WKV9rfAdjtcV547p40GTGMx7T1JvMv@vger.kernel.org
X-Gm-Message-State: AOJu0YygxKhExF8wnPrx1nmsolXOBm1HuiZBVyzYgipsQsmOa3f/vl3q
	FH/Lq9CSbljFXtn6TyFbI0ZBVFaQEWw16qkY7jGwiziuyQ3Awkkp7oPang==
X-Gm-Gg: ASbGncuAV7ApbCHfxz7SPTho8EK6I229CGMvQ0hoV16Fa11AyTJ1pvlFcpYxENXZlyX
	8sLeQfAAAkmLqVqmOiQa8tZdE7OMM5JMlQevbDTjiOSy6n4L5YmB9e2N1B+B38vHl/cwZHBoLl6
	7QBYZUg6DnmxTvekH7he0URnEUTNVhU4zEo8UJUc0FGNPNleqTWuxJiLkFARgjH67GqYB1p4H3J
	vC0UmRTscJOXwuRzsWu2sDDKwhQmtmientvh8M0t+1eWcYbL41EphGLwp4=
X-Google-Smtp-Source: AGHT+IF+V898aa8es++yx4jtxALz/gz5NZVNHRd80/3Ve/PFi0SUagDRAnW8ou4IejHJpmg34vVMoA==
X-Received: by 2002:a05:6512:3189:b0:53f:8c46:42bc with SMTP id 2adb3069b0e04-5408fac7b0fmr2135432e87.2.1734206169262;
        Sat, 14 Dec 2024 11:56:09 -0800 (PST)
Received: from [192.168.0.91] ([188.242.176.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c2bd77sm298258e87.282.2024.12.14.11.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 11:56:07 -0800 (PST)
Message-ID: <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
Date: Sat, 14 Dec 2024 22:58:24 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Nikolai Zhubr <zhubr.2@gmail.com>
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, jack@suse.cz
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
 <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
 <20241213161230.GF1265540@mit.edu>
Content-Language: en-US
In-Reply-To: <20241213161230.GF1265540@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ted,

On 12/13/24 19:12, Theodore Ts'o wrote:
> stable@kernel.org" to the commit description.  However, they are not
> obligated to do that, so there is an auxillary system which uses AI to
> intuit which patches might be a bug fix.  There is also automated
> systems that try to automatically figure out which patches might be

Oh, so meanwhile it got even worse than I used to imagine :-) Thanks for 
pointing out.

> Note that some hardware errors can be caused by one-off errors, such
> as cosmic rays causing a bit-flip in memory DIMM.  If that happens,
> RAID won't save you, since the error was introduced before an updated

Certainly cosmic rays is a possibility, but based on previous episodes 
I'd still rather bet on a more usual "subtle interaction" problem, 
either exact same or some similar to [1].
I even tried to run an existing test for this particular case as 
described in [2] but it is not too user-friendly and somehow exits 
abnormally without actually doing any interesting work. I'll get back to 
it later when I have some time.

[1] https://lore.kernel.org/stable/20231205122122.dfhhoaswsfscuhc3@quack3/
[2] https://lwn.net/Articles/954364/

> The location of block allocation bitmaps never gets changed, so this
> sort of thing only happens due to hardware-induced corruption.

Well, unless e.g. some modified sectors start being flushed to random 
wrong offsets, like in [1] above, or something similar.

> Looking at the dumpe2fs output, it looks like it was created
> relatively recently (July 2024) but it doesn't have the metadata
> checksum feature enabled, which has been enabled for quite a long

Yes. That was intentional - for better compatibility with even more 
ancient stuff. Maybe time has come to reconsider the approach though.

> You got lucky because it block allocation bitmap location was
> corrupted to an obviously invalid value.  But if it had been a

Absolutely. I was really amazed when I realized that :-)
It saved me days or even weeks of unnecessary verification work.

> Otherwise, I strongly encourage you to learn, and to take
> responsibility for the health of your own system.  And ideally, you
> can also use that knowledge to help other users out, which is the only
> way the free-as-in-beer ecosystem can flurish; by having everybody

True. Generally I try to follow that, as much as appears possible.
It is sad a direct communication end-user-to-developer for solving 
issues is becoming increasingly problematic here.
Anyway, thank you for friendly speech, useful hints and good references!

Regards,

Nick

> helping each other.  Who knows, maybe you could even get a job doing
> it for a living.  :-) :-) :-)
> 
> Cheers,
> 

