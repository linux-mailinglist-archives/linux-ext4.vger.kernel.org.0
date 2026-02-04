Return-Path: <linux-ext4+bounces-13532-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCldB2fAg2k6uAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13532-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 22:55:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E2ECE2D
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 22:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B3B30154B5
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196E38E5F9;
	Wed,  4 Feb 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixPpDOHu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54C387345
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242142; cv=none; b=pHr3IuXTxQ6nwjl6QUtPNOUnPjBkj804giuwhFHTepR+V52CU53KsqbROGwMfEV5mQBUOphI4aUmFh60e+gXvW+NIGBgTPMe5LJAmX+sElckTifEc7OUU5d3+cvOofs4LC+qjHBoF9F3lUOpp5FsgD4SFgnC7M3pVZVGVpf+8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242142; c=relaxed/simple;
	bh=T5JBBCdCz/Gy5zuk1FsSEae54JwI7mUpkeI+tFTjrbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XShg++Eo0CBE2d8yHJ4RtM8iqeIdve/2spsoGbG9qUSq84m+mxm8b9kEqckbfsQ//B45NlJLFoOhtXXfGWk42C9YfTdNlriReD3aACyhLFHaZUbzurbg2cFtBZukZB6ZqZUIRTcOABrAwsNomFdsGqJChNjvCtGQLJYMea9vgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixPpDOHu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso2202595e9.1
        for <linux-ext4@vger.kernel.org>; Wed, 04 Feb 2026 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770242141; x=1770846941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wzXzQA+EkH19tBHUYwMIXENoflLuEWkjrxiDT3pFdo=;
        b=ixPpDOHuMN4PA3APZ8NSa9Gzhjl86lnpNaZBXLd4dfdH3wcK503gHxEvLvelfAUAyi
         4ZPsSZtp5M8TxsfuKFWTllOJjS2VEMaEegXk0aO0Radz28zJ81ynTdUGxl3JCjE1s+3y
         kEI6qgExlh1uBD/IfEEtkaqVrAgHjzHyck/VxjSe/PdroyXO5C/scBkSWtJEGFF0WL6x
         S3Adk4JK+Xa+RElVBE1VQXWKaKpk+9hKgki3YKEFT/vSNO5l7LTFzM3HeGr7bFx9e0ck
         xVRurmJLzQ/ngytI1L6Fwu5uy4A6TIh+ZrMM1brUwAYHXwd9hoJauU7CViBdfzKVdl4V
         xY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770242141; x=1770846941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wzXzQA+EkH19tBHUYwMIXENoflLuEWkjrxiDT3pFdo=;
        b=Fe2pkuhfI84+que60TIuwOSHdRYX68KPDdQefuxidNjI6QKtaTJsHl/k2u06Rre3RF
         eXOlCAwKsJ5UufcStgwKEETntKiI/ZDPDo6otJRKYhZhjg7Hb3Q2Olg4x1tiKu01AZwf
         Rny9j05+wZ+bPDQzhDxDRrhXg2bmnz+HoqEujQPzGedPGCzduR1apHdJkpRzgGelcpc/
         vFLTkTvkgy1nTGQzrM2CQFYeGmVHP71KkqHHLaakHjEnrMRFe1ra82vfJOOzJ+Lp5cV6
         B4rVUAmIWlp2lqQAITbnTJljKi1lPq7hbilq0aKupF/81k+Pvfpk9Q/DXOW/me0+/R35
         d0XQ==
X-Gm-Message-State: AOJu0YwFDwNbs3fmjR2WevkcPyMuMG73YPZ/USyP9J2EovFiNp0LVisL
	i+ZUFQj1BGs8a7NvMT39cjXb4qE/XYgmrFiopqusu80hcvqWxUeK5Yl2
X-Gm-Gg: AZuq6aJhuFfUrGox1da+JsjK6UMz93Y0vL4T4Qmu3WcG/yVX2FhQ2rd7yrglIeAEH5A
	ad5e2MqIF9R4ZswOWUMlGimnlOviftO0JCLCiXpBS7FdIbfwyOyfBynAyu2Jl+8b4FDgh75qhDs
	ijSfcSf/CGGtQUxIQeG4A2IjIqwACVDEhlGm9gke1qM//LlAAdKDvtBp5hQiullTf+OIOi/MFqM
	TBSZnS7nw4XzZS/KFlu84ID5rTwn+zqKLOQi18r1IC2Jq2ZJBVg5P8vG39IFIloTN0lMseT/U9o
	TkkL+GKjRGEYfKr1fChcfdF7nb43iBtTBNSz27KV0PEvf0VKlSKpvRYpTOTFj/xUsWUVLagcYUN
	HHNrbJ4LD18julGs2dmeKArkNSxYXWq9Kg0PkXMbNoDz7mdc4v9qSG+WqW7wIPP2G+P09iBh1sr
	Q2HMt+nAgvavH0mUTf2gg8tPTBtW4M0ylNdeHQadaBFwZ/7PbYySJ88w==
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr63904605e9.22.1770242140830;
        Wed, 04 Feb 2026 13:55:40 -0800 (PST)
Received: from [192.168.1.19] (adsl-84-226-179-133.adslplus.ch. [84.226.179.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe86bebsm26196675e9.10.2026.02.04.13.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 13:55:40 -0800 (PST)
Message-ID: <daff127b-08b0-4a3a-8faa-7e44f99189f9@gmail.com>
Date: Wed, 4 Feb 2026 22:55:39 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix journal credit check when setting fscrypt
 context xattr
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 anthonydev@fastmail.com
References: <8feeeec8-7330-47ae-9b54-9e789ebdfae5@gmail.com>
 <20260204205903.GA2197@quark>
Content-Language: en-US
From: Simon Weber <simon.weber.39@gmail.com>
In-Reply-To: <20260204205903.GA2197@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,fastmail.com];
	TAGGED_FROM(0.00)[bounces-13532-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonweber39@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A4E2ECE2D
X-Rspamd-Action: no action

Thank you for your comments, Eric!

On 04.02.26 21:59, Eric Biggers wrote:
> This patch doesn't actually apply to the stated base-commit, likely
> because of corrupted whitespace.  Make sure to use 'git send-email' as
> described in Documentation/process/submitting-patches.rst.
>
> The commit message should be broken into paragraphs, and ideally
> shortened a bit.  The code comment maybe could be shortened as well.
Excuse me for the patch formatting! This is my first kernel contribution, so please bear with me. The patch applied correctly on my end when I sent it to myself, but I seem to have mangled it when sending it to the mailing list. I'll make sure to adapt the patch itself, the commit message and code comment in v2.
> Since this is a bug fix, please include an appropriate Fixes tag.
I'm not sure which commit I should put in the "Fixes:" tag, since the bug arises from the combination of two commits: Firstly, commit 2f8f5e76c7da7871 introduced passing the handle through fs_data, and secondly, commit c1a5d5f6ab21eb7e introduced the check for sufficient credits in ext4_xattr_set_handle. Should I put the chronologically later commit (which would be the latter)?
> The specific scenario I'm concerned about is:
>
>     - FS_IOC_SET_ENCRYPTION_POLICY tries to set a directory to encrypted
>     - A crash occurs (in no-journal mode), leaving the inode having an
>       encryption xattr on-disk but not the encrypt flag
>     - e2fsck doesn't correct the inconsistency
>     - Userspace sees that the directory isn't encrypted yet and retries
>       FS_IOC_SET_ENCRYPTION_POLICY.  Due to XATTR_CREATE, it fails.

I think the scenario you describe is somewhat unlikely, but that doesn't mean that we shouldn't be able to deal with it cleanly of course. However the current patch does not have an issue with this scenario, since when ext4_set_context is called through the path from FS_IOC_SET_ENCRYPTION_POLICY, fs_data(=handle) is NULL and therefore my changed line is not executed. The flag would not be set and the ioctl would execute successfully. My commit message was a bit misleading here, making it sound like the ioctl-path actually reaches my suggested change.

I think the assumption "fs_data!=NULL implies that encryption xattr MUST NOT be present" would have to be documented clearly to prevent future issues. I see a few alternative possible approaches to ensuring this more cleanly, let me know if you think this is necessary, and if yes, which solution fits the best into the existing philosophy:
- Adapt e2fsck to remove encryption xattrs from inodes which do not have the encrypt flag. This might just be a good idea in general.
- Adapt fscrypt_get_policy to fix this issue itself on any inodes it is called on, which happens to check before a new context is set in the ioctl-path. I don't like this approach since it would make a getter function have side effects.
- We could also change the void *fs_data argument of ext4_set_context from a handle_t to a new struct containing a flag int as well as a handle_t. Then the given flag (if present) could simply be passed down to ext4_xattr_set_handle, or 0 if no fs_data is given. __ext4_new_inode could then pass that flag through the detour through fs/crypto. This would somewhat "self-document" away the assumption (if someone passes the struct with a flag int, they will know not to set XATTR_CREATE if the xattr is possibly already present).

Looking forward to your insights!

- Simon


