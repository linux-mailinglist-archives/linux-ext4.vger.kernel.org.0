Return-Path: <linux-ext4+bounces-9334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16097B21800
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 00:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC1262494A
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF82DAFC5;
	Mon, 11 Aug 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EDmXTefE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4572701C0
	for <linux-ext4@vger.kernel.org>; Mon, 11 Aug 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950458; cv=none; b=qdWdgoVYNRXyj3+Vl+Vu9/3ur2xXsFlCjskeDNULtLhWs7/zIoRALhq4kioSL332FCCGdmv8BABbHKeVqKHjMs7PhEQySAhdZ4xBwe4ik7JEdxxoKBid32/ltfHr4WCxXnmBtjLuTAR/2r4X+SI4QjilN0FK3pSaiITyMRUWXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950458; c=relaxed/simple;
	bh=esWlmt9famZe00ef95muzVKF2UFlfNU0ydBp971fb58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0+C5DquCK5rlLqghLvyCGd8R3t+XOC9rrSMxwEONAUTPCOZVrzIqWsprCvTL+9o6D8t4ipdJAqNxC6pwuwYY6B4/u+hMTzlXCty0clj4gl2usYpx4jy7tZWiik1lz6Py/571rGLvE1w+Z6JaicjpF7p7AqQxYchRmJH5QD/LX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EDmXTefE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78294a233so4220519f8f.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Aug 2025 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754950454; x=1755555254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=StXsv7n9ycDoKUvCDAMzA/5f9WpekoxbNKKgKKyZkTE=;
        b=EDmXTefEvRAF29L4XUlvJeKSvtTaq20Q9BrtrH0gfREbc9o2pG5Z+Asglx3ZBT8Us3
         woYs7erdxhNXjEd6rbmFsHj9mm9986LxSJ8PTOVS6khx2R8wAeysCIqC/ciEsMqT3qpI
         8kQOHsja9p65JJqOCShkid2MJ95lmdOo7AGUffM33diC+iUmuFqaHdbdRH78tC5k1pZd
         i82mP82wsZXv3u6mBk0mlK7J9n8tGKnLNohP/C6AtSDIFD5apLK1l06lkHGnQA3ZWI7v
         sDA9Tj8z/PfSPeT0AyX/FfulotxibX10vOYYaKTZiDriM8YAkSWaG+wub+r0nZiNHovW
         N5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950454; x=1755555254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StXsv7n9ycDoKUvCDAMzA/5f9WpekoxbNKKgKKyZkTE=;
        b=dyLCzxK0tXNW81eopIE/lrSPF/SlG9VqFXxjLbyOrTo24vWHLaYaO5DUsSnHbiH8eg
         f6dVFIBWdj5HQbP+Upy+rYNDPqaadU6/f57a4o9HEIHisnMFV+OGNwledSmJMptvecF1
         hyps27BUHcFlo+a5wKsoAVrpQH9nRd/7OPTllCwvsxtiYx+SfdJMhCKiYy1v9dZBOYe3
         EE9zdESyYOEAlrcs6AFh8IgBydmDQS5mPwiF3Zuuqm8MZMp6zF/jj3rhHqg0yOw7yZmy
         9OlZ6mt1gGNbSrBCp2mvUwxcJE+7/8Njg0x54VAsMWoyc5EL++NgBwvXD5F6fW+Tjh+0
         QNAw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7EoVaSHyovWmT1fpVBgOzBAU5gMYQ75kcHikVkPCOEA1puU1wcL3Vez6Luzz4uGZBk61JolLcyYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SAMNW5sds5ACOy6Th4Ur0Vo5PZMdbNE6d5+VQXfllMi0es7h
	InwHwxRJHa/aWuUa+2h5rLacAjetyDU90Dfy5dmjs07C1wNDeOa+Ss2OrUUhF50dHUY=
X-Gm-Gg: ASbGncskthUOTo/KIhIW9OCzYeWFs7DNpR1mrdvPqjKPz29fbTZiiSaKGeMz19JNfeM
	F3ZxuBif6utN7+fRIiS4c/dfyRG3yathpT9XxAecY2jr7FtgRKBM2o7ZTBbcGtwidpCgdXSDljZ
	PqYY5Itsv4ov6gHOv4vqOUGi0CuS240Nzv+8Hqc9BokDP9gBwiw0VbIvxzJTT8QlpsCQr/cfHR0
	uZ3AibBDZMnsoFdOmosido5Gd29nPHIATQv0iPTL7ILZ9w0w7nL/BvAx6JlA2M0YvurWyUaVGFK
	ayBgDiQXnv+eVO6JYRn8NAzErVhlOmb3u2GsxUnlVyJAU45yBUJJtaomMBW3nBPssr3f7NK2qND
	cEgBCr99de08ZTEDGFcrCcEvPI9qgnCFTbPdXlyXOAorv5nu14g==
X-Google-Smtp-Source: AGHT+IGSdozthHUW2k0+iswqlCm3CAwaYuPZuTFax2g2J4kvjOKNSIh9iivUtHMpRpDhMHigS8WuEw==
X-Received: by 2002:a05:6000:4284:b0:3b8:d271:cdc5 with SMTP id ffacd0b85a97d-3b911004755mr1090920f8f.34.1754950454370;
        Mon, 11 Aug 2025 15:14:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd167sm27862529b3a.78.2025.08.11.15.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 15:14:13 -0700 (PDT)
Message-ID: <869c9ca6-2799-4ae0-8490-f383d7e0564b@suse.com>
Date: Tue, 12 Aug 2025 07:44:09 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
 <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
 <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>
 <20250811154935.GD7942@frogsfrogsfrogs>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250811154935.GD7942@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/12 01:19, Darrick J. Wong 写道:
> On Sun, Aug 10, 2025 at 07:36:48AM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/9 18:39, Zhang Yi 写道:
>>> On 2025/8/9 6:11, Qu Wenruo wrote:
>>>> 在 2025/8/8 21:46, Theodore Ts'o 写道:
>>>>> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>>>>>
>>>>>> 在 2025/8/8 17:22, Qu Wenruo 写道:
>>>>>>> Hi,
>>>>>>>
>>>>>>> [BACKGROUND]
>>>>>>> Recently I'm testing btrfs with 16KiB block size.
>>>>>>>
>>>>>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>>>>>> But there is a simple patch to change it to support all block sizes <=
>>>>>>> page size in my branch:
>>>>>>>
>>>>>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>>>>>
>>>>>>> [IOMAP WARNING]
>>>>>>> And I'm running into a very weird kernel warning at btrfs/136, with 16K
>>>>>>> block size and 64K page size.
>>>>>>>
>>>>>>> The problem is, the problem happens with ext3 (using ext4 modeule) with
>>>>>>> 16K block size, and no btrfs is involved yet.
>>>>>
>>>>>
>>>>> Thanks for the bug report!  This looks like it's an issue with using
>>>>> indirect block-mapped file with a 16k block size.  I tried your
>>>>> reproducer using a 1k block size on an x86_64 system, which is how I
>>>>> test problem caused by the block size < page size.  It didn't
>>>>> reproduce there, so it looks like it really needs a 16k block size.
>>>>>
>>>>> Can you say something about what system were you running your testing
>>>>> on --- was it an arm64 system, or a powerpc 64 system (the two most
>>>>> common systems with page size > 4k)?  (I assume you're not trying to
>>>>> do this on an Itanic.  :-)   And was the page size 16k or 64k?
>>>>
>>>> The architecture is aarch64, the host board is Rock5B (cheap and fast enough), the test machine is a VM on that board, with ovmf as the UEFI firmware.
>>>>
>>>> The kernel is configured to use 64K page size, the *ext3* system is using 16K block size.
>>>>
>>>> Currently I tried the following combination with 64K page size and ext3, the result looks like the following
>>>>
>>>> - 2K block size
>>>> - 4K block size
>>>>     All fine
>>>>
>>>> - 8K block size
>>>> - 16K block size
>>>>     All the same kernel warning and never ending fsstress
>>>>
>>>> - 32K block size
>>>> - 64K block size
>>>>     All fine
>>>>
>>>> I am surprised as you that, not all subpage block size are having problems, just 2 of the less common combinations failed.
>>>>
>>>> And the most common ones (4K, page size) are all fine.
>>>>
>>>> Finally, if using ext4 not ext3, all combinations above are fine again.
>>>>
>>>> So I ran out of ideas why only 2 block sizes fail here...
>>>>
>>>
>>> This issue is caused by an overflow in the calculation of the hole's
>>> length on the forth-level depth for non-extent inodes. For a file system
>>> with a 4KB block size, the calculation will not overflow. For a 64KB
>>> block size, the queried position will not reach the fourth level, so this
>>> issue only occur on the filesystem with a 8KB and 16KB block size.
>>>
>>> Hi, Wenruo, could you try the following fix?
>>>
>>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>>> index 7de327fa7b1c..d45124318200 100644
>>> --- a/fs/ext4/indirect.c
>>> +++ b/fs/ext4/indirect.c
>>> @@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>>    	int indirect_blks;
>>>    	int blocks_to_boundary = 0;
>>>    	int depth;
>>> -	int count = 0;
>>> +	u64 count = 0;
>>>    	ext4_fsblk_t first_block = 0;
>>>
>>>    	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
>>> @@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>>    		count++;
>>>    		/* Fill in size of a hole we found */
>>>    		map->m_pblk = 0;
>>> -		map->m_len = min_t(unsigned int, map->m_len, count);
>>> +		map->m_len = umin(map->m_len, count);
>>>    		goto cleanup;
>>>    	}
>>
>> It indeed solves the problem.
>>
>> Tested-by: Qu Wenruo <wqu@suse.com>
> 
> Can we get the relevant chunks of this test turned into a tests/ext4/
> fstest so that the ext4 developers have a regression test that doesn't
> require setting up btrfs, please?

Sure, although I can send out a ext4 specific test case for it, I'm 
definitely not the best one to explain why the problem happens.

Thus I believe Zhang Yi would be the best one to send the test case.



Another thing is, any ext3 run with 16K block size (that's if the system 
supports it) should trigger it with the existing test cases.

The biggest challenge is to get a system supporting 16k bs (aka page 
size >= 16K), so it has a high chance that for most people the new test 
case will mostly be NOTRUN.

Thanks,
Qu

> 
> --D
> 
>> Thanks,
>> Qu
>>
>>> Thanks,
>>> Yi.
>>>
>>
>>


