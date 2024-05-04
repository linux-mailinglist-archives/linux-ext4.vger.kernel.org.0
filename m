Return-Path: <linux-ext4+bounces-2291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7388BB89A
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 02:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F201C2333D
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FAA2A;
	Sat,  4 May 2024 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uh9QUZk4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0575629
	for <linux-ext4@vger.kernel.org>; Sat,  4 May 2024 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714781203; cv=none; b=jkWHCqJGImLB5Yyt30Ddhz0U7ld1igP3Zff4OHRGwVDxOChQpWOO9qWmewlnMN0R9T0nryGOeirEs7z3eW6ExKPpbjWey87y7GuIAj7ydKo5lN2wg6ir3/LkutPwSyawYzj375wjBhD9c02tICSAMGCQu8kDjC28b4HejqGyEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714781203; c=relaxed/simple;
	bh=vz8fEXNEpkIPSn5g1PNjjc3JvKCRVPWeCD8msX88hOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jKt/dMaUMzSYB0G70cJfVsHsv/Vj+yll099r71az6/xtjOvfHr/0p2GvAHURrXHasP07HsLFtstEqd/jm2DXc+4XkiQS68nENAzrIKckPn5S8CUxQgYiO+5kcz76HcT02p2cPDPRR9on5vvk2bIJ3xJU5hQ5/Q6Bp+22p0F7FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uh9QUZk4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dd615b6c44so2069321fa.0
        for <linux-ext4@vger.kernel.org>; Fri, 03 May 2024 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714781200; x=1715386000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TfJtgffpkqCiQ9mrug8v5y9CVV1swOm72noayeLLO6w=;
        b=Uh9QUZk4njb7+gJ598Ix0pK+qqZbkktAsl+gumHFHTio2ONCVMW/BtcYKXfvpOmPvO
         b5D6S/bP+9U3jmbfPReF0YhwzzbczhCN2LElJRvSeoNnIqujB8rAWQ+FhSWO6bdp3UO1
         GJ73viQ4ZKIIhyH4hzIgLLOjcWw8skBme9ijcOURBMxxRPg/ufZfB/w/aRb3f9rZoshI
         S72gQ3JQgMJv4sUgu2Xeq1pTmNFIPtRKrmyazwq0+jylfhPDKv+l3382q14zoPWfA4Bn
         500rdB7NOLjt2FJbozQK+B0CJNgusiGG4sPistV0B7bDSBQYm1ybwQmFktDC8IvE2XWE
         YswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714781200; x=1715386000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfJtgffpkqCiQ9mrug8v5y9CVV1swOm72noayeLLO6w=;
        b=gQVD60kN8zH71T5aF8miQ/tEdarHFi1YSADz7juJA+kFeCoOUSah9hQXYatCr1H8WR
         jvcSqcbGORWiaB2vD2DliTtWmtjM+ojxX7Xvmt5JZ7dPZrh/uNKd2v0zOBuZq/jkkG5I
         BpSfg9vFE/sQQ+pFQWYDJv4sjgNYLQ9gfbxrIVMga22lD/UonnHUpB3RjIwgKBgpBcR8
         rJt0Qp4C7uWh9J//sMgIShK8B4H3D6bAINQ+KD0U9zO8BAwDNlQQ902o6VLWYiHlRKsR
         T5hQGbPQsh5+NK8pEyPDbkwR7R6Sogn2q7Zu9sXx9ee2HwiXt33RlPT1pc3BHHS52a+d
         0XVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBofapXB1yO70cM5Nlr/wK4J9cgc9dXfs2b66jXGCjTe0qMREkMYGSwDeDWjznkyQHs4oRncSdJR+FPxlD33q9Aj/ph99s9wZ//Q==
X-Gm-Message-State: AOJu0YzDIjloR+L6ArsYW/jO2UP6H3MLWA8a4SkX9PFMzJ6fIkSV4LG9
	5IUCK6AkYTVVLU1TfXrTuH5gvP2rOBriaaYPBojBRIaRJuc9OuKLGFhT8sXhHz0=
X-Google-Smtp-Source: AGHT+IEc6D3FXmuASp9VLlJfLHJR+VEyO3MVyD+G/ea1vuHdp41NiOjPqnvHkKMEPu1PWRfUWGRKCg==
X-Received: by 2002:a2e:3618:0:b0:2e1:5684:8fa3 with SMTP id d24-20020a2e3618000000b002e156848fa3mr2687724lja.22.1714781199807;
        Fri, 03 May 2024 17:06:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090b278e00b002abb8a187dbsm5760562pjb.4.2024.05.03.17.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 17:06:39 -0700 (PDT)
Message-ID: <eb812b45-e28d-430d-a7a3-5b73edcc8057@suse.com>
Date: Sat, 4 May 2024 09:36:33 +0930
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
 <459ec128-eddd-4575-ab28-788f340a6a7c@suse.com>
 <7a33ff31-e570-4775-b82f-1c6413656699@oracle.com>
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
In-Reply-To: <7a33ff31-e570-4775-b82f-1c6413656699@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/4 08:57, Anand Jain 写道:
> 
> 
> On 5/4/24 06:23, Qu Wenruo wrote:
>>
>>
>> 在 2024/5/3 21:55, Anand Jain 写道:
>> [...]
>>>>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>>>>> *prealloc)
>>>>
>>>> This function is called for every file extent we're going to create.
>>>> I'm not a big fan of doing so many lookup.
>>>>
>>>> My question is, is this the only way to determine the flag of the 
>>>> data extent?
>>>>
>>>> My instinct says there should be a straight forward way to determine 
>>>> if a file extent is preallocated or not, just like what we do in our 
>>>> file extent items.
>>>
>>>
>>>> Thus during the ext2fs_block_iterate2(), there should be some way to 
>>>> tell if a block is preallocated or not.
>>>
>>> Unfortunately, the callback doesn't provide the extent flags. Unless, 
>>> I miss something?
>>
>> You're right, the iterator interface does not provide any extra info.
>>
>> And I also checked the kernel implementation, they have extra 
>> ext4_map_blocks() to do the resolve, and then ext4_es_lookup_extent() 
>> to determine if it's unwritten.
>>
>> So I'm afraid we have to go this solution.
>>
>>
>> Meanwhile related to the implementation, can we put the prealloc flat 
>> into blk_iterate_data?
>> So that we can handle different fses' preallocated extents in a more 
>> common way.
>>
> 
> I initially thought so, but is blk_iterate_data::num_blocks always
> equal to extent::e_len in all file data extent situations mixed
> with hole and unwritten combinations? If not, then the flag might
> not be appropriate there, as it doesn't apply to the entirety of
> blk_iterate_data::num_blocks.

I do not think we need @num_blocks to match extent_len.

We're already doing some kind of merge inside block_iterate_proc(), and 
if we find previous extent flag doesn't match the current one, we just 
need to submit the previous one.

Although I also believe we need some better abstraction for the common code.
The current one doesn't explain everything well for things parameters 
like disk_block/file_block.

Thanks,
Qu


> 
> Thanks, Anand
> 
>> Thanks,
>> Qu

