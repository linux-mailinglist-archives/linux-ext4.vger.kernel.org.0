Return-Path: <linux-ext4+bounces-5088-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9309C5E94
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908D6282BBE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EA215015;
	Tue, 12 Nov 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2hn4gktA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC120DD66
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431597; cv=none; b=HsETLSO0FfKh3JVO5zhz5sPCsXnT8V7mOtvu/U7F+YWJ33qRFvwWaoBFmYkF4ItOBaChkxi1iJzMByOOVXlo7mCjwzQF/g5PfbW0ldWTYwmgmGRxXVdD4MG5Ji9IEUIiB0fl6ag1XNadYfztrqSopi1t2G3FiWqCz4i0aM/UCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431597; c=relaxed/simple;
	bh=OaIUNL4wDulYBWCeL52yflc/neDWNsACf3HqYi4lxlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXQMr7GLefgoxXDEdzuriviosZjvM7pqhY/5/2vaGatrnWyrLqDDeyyUz5r0aXlQe+0m/sPH7tRWIQW4TV3/bJBf4CLIpoGzrBjIRl1cpJSCF1Hmrcvj5C87g0m7vDgbT0CNcMiLJ9x4vi7Kmi4POt9GhSEuXRRWl37YnyD5kBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2hn4gktA; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5fb8a4e53so3342824b6e.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431595; x=1732036395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=2hn4gktAu2bXg6QIK5HzUibtinBzYRFPoxDow1f3UmHelR9UGv5coMHakweqRMRIym
         kp3Ga015gohmr3A+IxrgVH8dnCo2csTaFvWUMf81Ti2IrCbc/yMHzg5YN6HLaaj5a1X8
         uznE2I9ayKEqXMbOkk4WKO+VkjGNDtd/OMJO64X6kiWttBuYwnCbBZ9F8g9YJRdr8Nz3
         5yEy6F+lSNbK591sinNhYy6uUXmevNJLAvuMtADMuYMdCLGyeQBNsEua/OiHiT8VjBI0
         BPdne/u4wIOZgLshPcZj9bHOYCn0Oj5an4xIpV3/yo0Yjz5h63XMyTXfGrRHxR5wUuaS
         QIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431595; x=1732036395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=JnTEQbYLOJ0+tIIc+hjd/lWTLFFbCWfN8/msFuquHtzfylghCSsXnodzc+4ReD5D+Q
         8IgduiUQQiyz84u48M7VMymSIjUzDvliOp2k0cTZ7cRtlk64QRDRxW614ZrPWw8rlyAq
         LAlouAcY2h93NNB4qd9VXt+MGSCfyEa03W77tacddJGIDbCVWTc9Bgbh1xn3ZM+hfTP/
         CU5/ntXHSCN7qTxlaFAVIxhSzJuukPFDVJm2e3qgG/GSEK4qm6u6L6bJMbrIGpkOvgH2
         Tkx4mgtEsSs/yASYVbdz0uw+Tvm7Nn5YsO6//bDN2UovOmDZydrYLcbJjc62Y7srza6u
         V+ww==
X-Forwarded-Encrypted: i=1; AJvYcCW7b59+eJz62XMhzogE1dbJYt1NnG/DjPEIfNO0/oJlEFurBmWhMMpJjMtq5pqpCjgLzmk4VcSnLUPB@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8Fn0XA+uLHqGZMTiGbTwRoIepvZtqTjWqagmDhF3/UygTn2S
	lrILLgkf3RJj2oMRnos9LQ8C1/f8SRlpVMsk2dLC+1zyXoV61aONFruk0vhFzNI=
X-Google-Smtp-Source: AGHT+IH644V99dOVg147q96OR3GJtIRC7XpOTmFUI9LGtr4TxaaFP6x3xC1BuVau04Ao7iJOTmXH6w==
X-Received: by 2002:a05:6808:10c9:b0:3e6:60dc:5aee with SMTP id 5614622812f47-3e794654540mr13513708b6e.3.1731431594747;
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca37c9sm2630818b6e.21.2024.11.12.09.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Message-ID: <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk>
Date: Tue, 12 Nov 2024 10:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ext4: add RWF_UNCACHED write support
To: Brian Foster <bfoster@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-13-axboe@kernel.dk> <ZzOD_qV5tpv9nbw7@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOD_qV5tpv9nbw7@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:36 AM, Brian Foster wrote:
> On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
>> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
>> and hence need the worker punt that ext4 also does for unwritten
>> extents. Add an io_end flag to manage that.
>>
>> If foliop is set to foliop_uncached in ext4_write_begin(), then set
>> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
>> folios as uncached. That in turn will make writeback completion drop
>> these ranges from the page cache.
>>
>> Now that ext4 supports both uncached reads and writes, add the fop_flag
>> FOP_UNCACHED to enable it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/ext4/ext4.h    |  1 +
>>  fs/ext4/file.c    |  2 +-
>>  fs/ext4/inline.c  |  7 ++++++-
>>  fs/ext4/inode.c   | 18 ++++++++++++++++--
>>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
>>  5 files changed, 40 insertions(+), 16 deletions(-)
>>
> ...
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..afae3ab64c9e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	int ret, needed_blocks;
>>  	handle_t *handle;
>>  	int retries = 0;
>> +	fgf_t fgp_flags;
>>  	struct folio *folio;
>>  	pgoff_t index;
>>  	unsigned from, to;
>> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  			return 0;
>>  	}
>>  
>> +	/*
>> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
>> +	 * foliop_uncached. That's how generic_perform_write() informs us
>> +	 * that this is an uncached write.
>> +	 */
>> +	fgp_flags = FGP_WRITEBEGIN;
>> +	if (*foliop == foliop_uncached)
>> +		fgp_flags |= FGP_UNCACHED;
>> +
>>  	/*
>>  	 * __filemap_get_folio() can take a long time if the
>>  	 * system is thrashing due to memory pressure, or if the folio
>> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	 * the folio (if needed) without using GFP_NOFS.
>>  	 */
>>  retry_grab:
>> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>>  					mapping_gfp_mask(mapping));
>>  	if (IS_ERR(folio))
>>  		return PTR_ERR(folio);
> 
> JFYI, I notice that ext4 cycles the folio lock here in this path and
> thus follows up with a couple checks presumably to accommodate that. One
> is whether i_mapping has changed, which I assume means uncached state
> would have been handled/cleared externally somewhere..? I.e., if an
> uncached folio is somehow truncated/freed without ever having been
> written back?
> 
> The next is a folio_wait_stable() call "in case writeback began ..."
> It's not immediately clear to me if that is possible here, but taking
> that at face value, is it an issue if we were to create an uncached
> folio, drop the folio lock, then have some other task dirty and
> writeback the folio (due to a sync write or something), then have
> writeback completion invalidate the folio before we relock it here?

I don't either of those are an issue. The UNCACHED flag will only be set
on a newly created folio, it does not get inherited for folios that
already exist.

-- 
Jens Axboe

