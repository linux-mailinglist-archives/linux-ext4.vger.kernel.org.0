Return-Path: <linux-ext4+bounces-14701-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 29yOMb/cq2m4hQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14701-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 09:07:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17E22AB5B
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 09:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38283301D301
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2026 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6353937FF64;
	Sat,  7 Mar 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDiGTL4e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE9224AF0
	for <linux-ext4@vger.kernel.org>; Sat,  7 Mar 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870844; cv=none; b=gDsmtx7zFec+ImRv8s51pvDKUSQ0fOfLic9OmzWIJp5Rek1gqtfOEh9w9RILmxAB+N1ysr8gtwqMYCgCo+x2/P41wdLXc2WJJJoyvbo1hnJqbdL5XZyyQPqbN7XT9bEQZBcQCQ6uv59IiCr0++IC+crGms61BVM73pBWf9mF5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870844; c=relaxed/simple;
	bh=oq+iz4kPf0H55Q3umDgEZN2qecJhLIt1F/9hUlbeAQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUAf61tNbAn9TMz+PUxN1R8DL4NcbHc2URYb9Jx2txKPymKKtUo0amWuRvT001CDyEAI4UZdZZaA5Q7Vw6XweUca0AUV6pMDVwHgNnLovUoivDcx5++0jUwP0LlZoeFwtlBbxQg+xjLO4w6yLndyYgwSuORauEYxtw9eQptKbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDiGTL4e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso4787285a91.2
        for <linux-ext4@vger.kernel.org>; Sat, 07 Mar 2026 00:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772870842; x=1773475642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykBhXdiVshR5/bIjEFW1N2WlYqoSU35PU0kZ16r0Zxk=;
        b=bDiGTL4ejKD8tGkmQBA2wHwtCHs1lMcDJwfdTHxRTyiq5FHuEwG6YRIKyb2AvW+G6P
         RRKQVrq4vxqO3Uzt72ixtUYjCU+L+XIWkHlj06owfRCE7dWDWnCUfem/FO+jDBLl54yg
         xs6o4gwPPA0AdGKhcg2wHw9FTkloyXSlOYl84tPd4AnIqCsWBlDBgbzFKhhzaf84xx6r
         ZZg2Surm92JBDpnGk5accRVg5ScpbhuyNdPLHgs70igGxP1D1ZOqjGT2l3syHTlof9c0
         Sh5D/O0MfI/pN15LG5Dx/zbsoGVGy0R3qhv4Uaq1eEHFXUXL0zCDO2cvXUxdE/5HszNM
         VH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772870842; x=1773475642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykBhXdiVshR5/bIjEFW1N2WlYqoSU35PU0kZ16r0Zxk=;
        b=Yukio5Z2ecPr4apVWFEApYxSzfEKQRDRMQOOAoxY7sqX0Sa+5M87KvcaeAZdSqJ9lk
         VCl/Xgsyhh/1NVCmAdIZjilW89CI1cYPYj4KgyZzf2X7HDTGSck0DurVhlVFMd0Dge8G
         4RBV8vzsoUTK+StIPc8kKxhwAQGfDN8fYLaSZC/Ncrwx00kS58rhBI9Sq9UJ4LE+jM1+
         4KuW7tiKnTjY/zLqH/R3hoKNKVY6wYWnR7KHyvtstyU660Lf1urfN9QEHFOZDmHcVYYV
         +m/HzELk8qF1ZMWh8MsZZNLYKls5pA8JfLm4v6h+G+wIcr00Lg8I65ZuNEPO5bXkHkQo
         MfOg==
X-Forwarded-Encrypted: i=1; AJvYcCVDE1rcIQUn0GRCb/RGO4NN8d42WR1bqYQfN5WC/UK7r9oZbdR3DWrnzUbVta0TlM/VurfVHI//9Q9+@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQDUVj5vkmAoGI6Mx3c6xbNN8JZaBlgNxcBa4Mcw0u/HOgo6v
	MbaMvu7E2eO+FvN8YBhT3w2WUzu+6o2z4mT8g9MuZA2xjq8oKUzcXqUumNZMhuS34pE=
X-Gm-Gg: ATEYQzyIR14YVh5mJQwqXr+rtKYVUIRO1N5PqQ79uz25xCNXHrD47p96OOfS59Oep0a
	WR8USiWLR2Ir0WdCKxtth9hMNQzSfzMdGJzHIqfo0EpOKE2p0xydThKVBYSmNs2qLhtmtUbmTi1
	6KVwfYlas8Jnr9qpGPjBdsQw4sij93Uz4vERCVLKdKsWkfUaTwvd59ZW3wWOszPW0Y/wls+ODxl
	AZBHY5y10EEEPnSaG5n3RCw+siQcZV5/cGponR8lqqsBUEAaWtk3OLCxWu3+UgbnRK3vE2360YM
	Q0uzmvAljmiDfVFkveZr6ZTqLhvbSD6ER9LeBYEMyUEB0zO01MXAtc4V02WFSVGHS4al5XSMFR8
	oQ7pYti72e+ad9jJotuVzP9y5BKC4kVdWFWECv5A1Mw++qu2b92kzqxC/ol2mpI+Xk5ZU5Kk0QH
	zFHtGoD/+Ro4I5fPEAL149Sah7STxXU2u6SPnoo4rxc1ZhsTs+0wGPSaJSKSXOwFEjYMWCBJlpz
	WOHMMWMIw==
X-Received: by 2002:a17:90b:3b50:b0:34c:2db6:57d5 with SMTP id 98e67ed59e1d1-359be15e3e8mr4332743a91.0.1772870842117;
        Sat, 07 Mar 2026 00:07:22 -0800 (PST)
Received: from ?IPV6:240e:390:a95:2e11:18d:20df:3e54:826f? ([240e:390:a95:2e11:18d:20df:3e54:826f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm3837508a12.11.2026.03.07.00.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 00:07:21 -0800 (PST)
Message-ID: <ca5688df-c101-41bf-ad4c-4a2a61d0591b@gmail.com>
Date: Sat, 7 Mar 2026 16:07:07 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: avoid allocate block from corrupted group in
 ext4_mb_find_by_goal()
To: Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org
Cc: jack@suse.cz
References: <20260302134619.3145520-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260302134619.3145520-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F17E22AB5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14701-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.886];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/2026 9:46 PM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> ...
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
> 
> EXT4-fs (mmcblk0p1): error count since last fsck: 1
> EXT4-fs (mmcblk0p1): initial error at time 1765597433: ext4_mb_generate_buddy:760
> EXT4-fs (mmcblk0p1): last error at time 1765597433: ext4_mb_generate_buddy:760
> ...
> 
> According to the log analysis, blocks are always requested from the
> corrupted block group. This may happen as follows:
> ext4_mb_find_by_goal
>    ext4_mb_load_buddy
>     ext4_mb_load_buddy_gfp
>       ext4_mb_init_cache
>        ext4_read_block_bitmap_nowait
>        ext4_wait_block_bitmap
>         ext4_validate_block_bitmap
>          if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
>           return -EFSCORRUPTED; // There's no logs.
>   if (err)
>    return err;  // Will return error
> ext4_lock_group(ac->ac_sb, group);
>    if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // Unreachable
>     goto out;
> 
> After commit 9008a58e5dce ("ext4: make the bitmap read routines return
> real error codes") merged, Commit 163a203ddb36 ("ext4: mark block group
> as corrupt on block bitmap error") is no real solution for allocating
> blocks from corrupted block groups. This is because if
> 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
> 'ext4_mb_load_buddy()' may return an error. This means that the block
> allocation will fail.
> Therefore, check block group if corrupted when ext4_mb_load_buddy()
> returns error.
> 
> Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block bitmap error")
> Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/mballoc.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e2341489f4d0..ffa6886de8a3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2443,8 +2443,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>   		return 0;
>   
>   	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
> -	if (err)
> +	if (err) {
> +		if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
> +		    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> +			return 0;
>   		return err;
> +	}
>   
>   	ext4_lock_group(ac->ac_sb, group);
>   	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))


