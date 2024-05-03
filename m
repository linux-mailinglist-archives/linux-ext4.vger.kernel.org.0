Return-Path: <linux-ext4+bounces-2289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BF8BB70B
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 00:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708861F23094
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960935C613;
	Fri,  3 May 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DlVRN5gz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA158ACC
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775015; cv=none; b=IL/6GWbwLFKYuJjmB559u+Ug/ej0NKuogzU+Q+RuzgD21iTeJdwOYfYRiEf+qAG6HskSy5QwEC5zB9hgUp4nZyXz9bOX/V+wXBuSTaI9stuCQZ5ZBo0DHREfbSe9L/GgWq6bUGB4Fkt9vPDAHg47vHIuYKVKW4bStLNung0rJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775015; c=relaxed/simple;
	bh=GHhnnIHJfJ92DPedei8BYIBhAHDmy0IvM5KsUX7Op2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lHFv/nue78kMsO+iz8uv6p9xTRq3zgy0lAAaFOqgxx079tEWe9PAACggSSFOuKYJCcOUQ6QB6Dp51Kvyi82y1t7U2Sdzga3Xz40uOspAFtFWOZSd6yTxWupEv8c/tM/Wglji9yyqNdMc+sjjJ3Y5kuvwiRnfdvWo5NQl8D2FBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DlVRN5gz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db101c11beso1924171fa.0
        for <linux-ext4@vger.kernel.org>; Fri, 03 May 2024 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714775011; x=1715379811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DCEZrdpakfm+PqVNCzRAy8fK2sg1YQMVy8goAU24hCg=;
        b=DlVRN5gzvzHg6Tbd0Q/llK4bvGkgg0OI+ZUSqfU/IOT2OPOCcTLgrE91AkAZjivY38
         lVJC1DTNrBpaR6fbwgwFnAXZw/OLKJijLsGPFdR8Kds6DEiLs08DBqxXMTCqB1bSyXWN
         04nX70oMnQHN5T1ZT8eSIUclXQ/Ln+VwjCt5+7WsuxLfKZc6syASLilqNXXnn4V82RgX
         VXPuQKEPOJe2+/bySSyAG7Cb/r5SIyj8I5oHUmc5RMfzonsASRzsGvS0rX4FKd2vnYMJ
         4o+gOPiI4PHCnf4q7zq2Fo1F/BMehOosdsq49kH9O31rpWjs+CPJcDp+K+eDfiQPXFyg
         yL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714775011; x=1715379811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCEZrdpakfm+PqVNCzRAy8fK2sg1YQMVy8goAU24hCg=;
        b=wtJO959S4qFSnmP4+mcB5tqKJVhQT8+FW/HtU2pEcUOdm17MyZUCKzOJu0mFzMM/WP
         TkXCrgFKnbXDMS9GbQOoEJwQ+6e//tojKs1+L97h74O3dxt1DCUP5nR9WrH2qAWd6R/q
         Q4+GG1jOqkRnffFfjavUUcTxE3X1sEnbrMj9sEpJ0fI1T6c2fSmIiU+Bmq2lzrET4/bt
         TZlfp/yCto1pn8KR71VVJAsD6yQEjGO1dwhI4xDJiV3HGMcUvVCp4YebqxZSRURpQc3f
         UFAN4Nzc1pOnIWidl4DA4lWMeQVU6g4byvCH3E1pkc4Ptpd98GDNiyx0cw+GfXwmWGd/
         0gCw==
X-Forwarded-Encrypted: i=1; AJvYcCWApp9SMveNMH0VSwZLDa+VB6p6d/AQkM69Pwp9UnxGjVHjh5xZjk+sisbmo7/fXNa/+deb1zuP93ThyIu3Qi97vvO4EGQNxTC4PQ==
X-Gm-Message-State: AOJu0Yww2ZFG5Bj5l/v4ptNIHsuZlkd9fdXdS2KwSxmazeyJo+k42dLK
	oISDyQOKPTQCkj/vzMTJ+cBB5X0NmPTGbEY4pQ/RkW9C7p97JVPzguYduoar1Jw=
X-Google-Smtp-Source: AGHT+IE17haMgXe70DG43aDoXD1L5toQrYsMV1brkL/qTHwgtWn0YsY0Dljj1PfS1uod9cy/3gDEmA==
X-Received: by 2002:a2e:a550:0:b0:2e0:12f1:f827 with SMTP id e16-20020a2ea550000000b002e012f1f827mr3044237ljn.43.1714775011201;
        Fri, 03 May 2024 15:23:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b001ec9e5ebab2sm3829243plk.107.2024.05.03.15.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 15:23:30 -0700 (PDT)
Message-ID: <459ec128-eddd-4575-ab28-788f340a6a7c@suse.com>
Date: Sat, 4 May 2024 07:53:26 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
 <48787c70-1abf-433e-ad3f-9e212237f9a5@suse.com>
 <8b5107fa-bcce-46dd-950b-775695d872e6@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <8b5107fa-bcce-46dd-950b-775695d872e6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/3 21:55, Anand Jain 写道:
[...]
>>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>>> *prealloc)
>>
>> This function is called for every file extent we're going to create.
>> I'm not a big fan of doing so many lookup.
>>
>> My question is, is this the only way to determine the flag of the data 
>> extent?
>>
>> My instinct says there should be a straight forward way to determine 
>> if a file extent is preallocated or not, just like what we do in our 
>> file extent items.
> 
> 
>> Thus during the ext2fs_block_iterate2(), there should be some way to 
>> tell if a block is preallocated or not.
> 
> Unfortunately, the callback doesn't provide the extent flags. Unless,  I 
> miss something?

You're right, the iterator interface does not provide any extra info.

And I also checked the kernel implementation, they have extra 
ext4_map_blocks() to do the resolve, and then ext4_es_lookup_extent() to 
determine if it's unwritten.

So I'm afraid we have to go this solution.


Meanwhile related to the implementation, can we put the prealloc flat 
into blk_iterate_data?
So that we can handle different fses' preallocated extents in a more 
common way.

Thanks,
Qu

