Return-Path: <linux-ext4+bounces-987-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66783F56A
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00C41C21260
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jan 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7EB25778;
	Sun, 28 Jan 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N94MsA1f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822923745;
	Sun, 28 Jan 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443607; cv=none; b=fF3t1sEklustsxqzCJhOVnrpkAJMtscyU9jFFOU+paqgSJ9QWwH3BAygW8lP9eLTOz00NAAcdxIEgVLeh8RDj9jBR/ZBdK8KEIXHvN+P76umQkZ54vBV6IUJ3u+4ULy2Y4of8OCwJclZ75CFxuUHOpidNB4rgeevd7moFH8UElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443607; c=relaxed/simple;
	bh=f9PDLY10s6cbdhdHgeMpfON+edLlohHjzPQZ2rvCi1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdxbmySpMYF5qW9CM4nIm19CkT8qD+hkDl4vbZEh6PSgEE8RakIK8kRt8kDHQj97BmAlqUqk8t9g8uFkCNdoDXmPY7Hc+PzF7G31rPD14slF7MICp/BH9ryzpd/ZanCIMRyctH3fgNiTD6zWWuq3Xpp7EUvbVPgaQdids/v5TVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N94MsA1f; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso1396915a91.3;
        Sun, 28 Jan 2024 04:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706443605; x=1707048405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdYWix9MLGyIiOpDsa0IEwbUnBYiApF1tiDO/VUJfmQ=;
        b=N94MsA1fTyI6xj9j+56F1Q+Y3AoqW/s91bbgRaV2JBtwsaS7B2rrg/QyVUkTzk4eFO
         RRbWMQUHeezzGh5GVq8vk+OuMsOrEm+5ni8TjO7mj9ULvK5/jdbh4CdEwDOgRaNBnGEU
         x2fQO1BCJ4mmv1GNkyoDxs9A9eiW36qfeToVz49xCnUytJpgzKHNwvcJLYM6DPKveKE1
         fbLsyK9QHd5DrJdb9xcEEzrmDKkKKDIZ/rH0jBsToeTx7ppBgLqLTovU0yWz56tGusnj
         vatpqtmsqlakynF4XL9NyUmIodX2e8hyb5jdNWcKqP6teCQT0pYS/u+hMF6HtNGamrqg
         jqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443605; x=1707048405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdYWix9MLGyIiOpDsa0IEwbUnBYiApF1tiDO/VUJfmQ=;
        b=j/YAJfN2768obweXzIvV8MAU/Pquki+2HDnmb5cOtjFGzCGcFjHzAXQkfo6SwZjN9V
         3uJy42k096GMsN1dQ7Tw8MUkkWb4aveDB5b48GW266/e08URzI4b+vQGBJsazMCdu9OY
         7TaUa5+K74L1tw7izuHCrLgenEFuqmESSVJQRYYj/JoW5/1IeH9zztevcuhtRp91PTLb
         J+rG7GoKmFfCxJoJFTNrs+hZwa/Du1wJXP+b7xHPN+tcJS5IIg3gpv5V10eAJThv896Q
         TB+0oP2COcN1QQp5C4Su/Mw4n5/dxhJuHJev94dwvlKVSL5HBbEnwbkQOfKDDoD4sdeL
         QbOQ==
X-Gm-Message-State: AOJu0YyZmxWV+tPDgbZAIi2umArcv1RmbqanUOuexCc91ocR9/sTcLT4
	eTFrF0GnW+zQuKQjkq2yL1ITyjdecnKtRIJoePIlLd0iAVYHFO9A
X-Google-Smtp-Source: AGHT+IHzqGRQIGFru6cZBQNX+nVoceeUgd32+snZnuMXIXyu8w+OOpjTbCqw7DvsxYDeNkZD+uefyQ==
X-Received: by 2002:a17:90a:5913:b0:290:19bc:2138 with SMTP id k19-20020a17090a591300b0029019bc2138mr1911886pji.89.1706443604827;
        Sun, 28 Jan 2024 04:06:44 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f29:8500:aaa1:59ff:fe2b:a859])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090ac29500b0028d134a9223sm2949509pjt.8.2024.01.28.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:06:44 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id 485C63040CBF;
	Sun, 28 Jan 2024 04:06:43 -0800 (PST)
Message-ID: <a25e5ee6-70c2-421f-92c2-407b43a7c61e@gmail.com>
Date: Sun, 28 Jan 2024 04:06:38 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
Content-Language: en-US
To: Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
 <358aaf68-0618-41e6-9adf-04e211eb690e@gmail.com> <87jznyr6xd.fsf@suse.de>
From: Daniel Dawson <danielcdawson@gmail.com>
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
In-Reply-To: <87jznyr6xd.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I didn't see your message until now. Sorry.

On 1/24/24 9:13 AM, Luis Henriques wrote:
> Bellow, I'm inlining a patch that started as debug patch that I've used to
> try to understand what was going on.  It seems to workaround that bug, but
> I know it's not a real fix -- I don't yet understand what's going on.

Thanks for this. I'm not sure if you meant to say you think it works 
around the present issue. I just tested it, and it does not. In case you 
missed the start of the thread, here is the test I gave for triggering 
the issue:

$ rm -f test-file; dd if=/dev/zero of=test-file bs=64 count=3 
status=none; lsattr test-file

Instead of writing the file all at once, it splits it into 3 writes, 
where the first is small enough to make the file inline, and then it 
becomes non-inline. Ideally, the output should be

--------------e------- test-file

but delayed allocation means it instead shows

------------------N--- test-file

until sync. I also gave this code for testing SEEK_HOLE:

https://gist.github.com/ddawson/22cfd4cac32916f6f1dcc86f90eed21a

> Regarding your specific usecase, I can reproduce it and, unfortunately, I
> don't thing Ted's suggestion will fix it as I don't even see
> ext4_iomap_begin_report() being executed at all.

To be clear, that function is called in a few specific circumstances, 
such as when lseek() is called with SEEK_HOLE or SEEK_DATA, or with 
FIEMAP. When I traced the kernel myself, I did see it being executed 
from the lseek() call. The changes are to address the file not yet being 
converted from inline, where the contents are still written where the 
map would otherwise be. If you treat it as the map, you get nonsense. 
Something else needs to be done.

I'm not clear on whether his proposed changes would then allow an 
application to function properly under such a condition, but it should 
at least *not* give ENOENT.

After testing what I think are the changes he proposed, I find it 
doesn't work. If I remove the "&& iomap->type == IOMAP_HOLE", lseek() no 
longer gives an error, but instead returns 0, which I'm pretty sure 
won't work for the affected use case. Either way, I'm not sure I 
interpreted his description of the changes correctly.

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


