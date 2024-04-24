Return-Path: <linux-ext4+bounces-2177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563E8B179B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Apr 2024 01:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F591F24A2E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201F16F27B;
	Wed, 24 Apr 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X33Hq1IQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C616F278
	for <linux-ext4@vger.kernel.org>; Wed, 24 Apr 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003178; cv=none; b=ak+GHi5aOiXvsJkIrDNA9N5NwiKA0hNFlPlUxakIRujwt5JBEbAyw7OWIrFJhA1ZoP2+LzEHxt+rPtvE+9ZQbsCN2MrQL10OXNsiQ/6D+ldmNvpSBlXgN4sPJELfe72pri0ai6/e2+RTJeLgBPcIsEzIDC3ThAdpD9jlRYiLDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003178; c=relaxed/simple;
	bh=Uzop+8nHAYmdh8DmhRqPSaymG2Yn4AxmfS9aV6Tem4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj3mgXw8BXOycwwO6Y1X/3gHp35kulkyzV7z+JJg7Uz8Bcnlgz+DiNG5o9mb4j2jxFLHPSS7gGFiv70Jd5xD70V31QRQSsnw+KU95bV0E0qYXALS6J66xN1h+Se1pUTfKW/t/gXohZTHuGOGYiqfD84FGUt+bZ0oYYPsAAL6bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X33Hq1IQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e5715a9ebdso3116425ad.2
        for <linux-ext4@vger.kernel.org>; Wed, 24 Apr 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714003176; x=1714607976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCTonMb076AQlhzsCPqQ1hCXHyvjA1NeoSKo3KByWoA=;
        b=X33Hq1IQzOICmGTYIjPJPy3NJcsMLvLP6BF0lVRWo2t0lityPVZWuUHC44FngdY7Gn
         ZRJ9UAssKOY7m8s/NibWsWXfZvg7mVXjvLJbgmH7JCRnzQlQKMYG8GbtXBrjc/NHjVyX
         2alyDuLOKvey549zk+KvXWfDaWd62/5X5K8DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714003176; x=1714607976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCTonMb076AQlhzsCPqQ1hCXHyvjA1NeoSKo3KByWoA=;
        b=vaK6Xxug4DRyc7zDkuC4/QvHmZVzbZqz8/jY/fJvXknWOiAEma6H7KVkAgG8SGXern
         7zicXiMVdDJ8zQEiF2X/KhIgAy/EUa0w7tKEHGRrO/ThtSkwaWfvYHhxL1ZK/InnoWYa
         WRjS4sLD8tB5ZHVNGHriZrZ16pV/IhLLGKMjnIPeLyFs3KzAXKb/V3/4ujWsXO7kT7by
         zR5xmZ7iWI1m+ptYJa0gchUweYeBnAKIQVNrI/s21YVkK/6/7SmAkYaCerQvr/U2/2Ly
         jq6pKWe5Cl3X1thxRB6FcWwh6N8hSa8X3U504O98bYjGbVDN55mYT7ZLZkyjlc+lZEkZ
         zlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ8ik6P/EtL8SpFEupyAY5E0Fm4oZZ23JKI95um/EcMfJdGUNCnbBnUW/S+Y4I7dlKCpGx0zWjiTzVqY/83RtxocmZiGqDMiDWQ==
X-Gm-Message-State: AOJu0Ywr9GohI7gxvJcfa2z8beON87JWS5xyT84tJsa2EMbGlwTjlWZR
	9/DvqiyPzqrNFCUfX3f5sVzcbyw+cYzAxfK+LfqEOxOIdFtCc3QxUxx6ZL8s9Q==
X-Google-Smtp-Source: AGHT+IHKqaR8hPRcwls+numOGMFqe07vfLrEj7Bd42CbrHC0kpIWlHWWHQMzzOVPRn+FCg+DWi9LVQ==
X-Received: by 2002:a17:902:d486:b0:1e5:8175:4968 with SMTP id c6-20020a170902d48600b001e581754968mr5306181plg.9.1714003175958;
        Wed, 24 Apr 2024 16:59:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b001e27557050dsm12540139plx.178.2024.04.24.16.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:59:35 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:59:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Justin Stitt <justinstitt@google.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: replace deprecated strncpy with alternatives
Message-ID: <202404241658.E0A17DE2E@keescook>
References: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>

On Thu, Mar 21, 2024 at 01:03:10AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> in file.c:
> s_last_mounted is marked as __nonstring meaning it does not need to be
> NUL-terminated. Let's instead use strtomem_pad() to copy bytes from the
> string source to the byte array destination -- while also ensuring to
> pad with zeroes.
> 
> in ioctl.c:
> We can drop the memset and size argument in favor of using the new
> 2-argument version of strscpy_pad() -- which was introduced with Commit
> e6584c3964f2f ("string: Allow 2-argument strscpy()"). This guarantees
> NUL-termination and NUL-padding on the destination buffer -- which seems
> to be a requirement judging from this comment:
> 
> |	static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label)
> |	{
> |		char label[EXT4_LABEL_MAX + 1];
> |
> |		/*
> |		 * EXT4_LABEL_MAX must always be smaller than FSLABEL_MAX because
> |		 * FSLABEL_MAX must include terminating null byte, while s_volume_name
> |		 * does not have to.
> |		 */
> 
> in super.c:
> s_first_error_func is marked as __nonstring meaning we can take the same
> approach as in file.c; just use strtomem_pad()
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Hi Ted, are you able to pick this up for the ext4 tree? If it makes it
easier, I can carry it in my tree instead...

Thanks!

-Kees

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/ext4/file.c  | 3 +--
>  fs/ext4/ioctl.c | 3 +--
>  fs/ext4/super.c | 7 +++----
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 54d6ff22585c..c675c0eb5f7e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -844,8 +844,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>  	if (err)
>  		goto out_journal;
>  	lock_buffer(sbi->s_sbh);
> -	strncpy(sbi->s_es->s_last_mounted, cp,
> -		sizeof(sbi->s_es->s_last_mounted));
> +	strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
>  	ext4_superblock_csum_set(sb);
>  	unlock_buffer(sbi->s_sbh);
>  	ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7160a71044c8..dab7acd49709 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1150,9 +1150,8 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
>  	 */
>  	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
>  
> -	memset(label, 0, sizeof(label));
>  	lock_buffer(sbi->s_sbh);
> -	strncpy(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
> +	strscpy_pad(label, sbi->s_es->s_volume_name);
>  	unlock_buffer(sbi->s_sbh);
>  
>  	if (copy_to_user(user_label, label, sizeof(label)))
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index cfb8449c731f..de16d045ca05 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6130,8 +6130,8 @@ static void ext4_update_super(struct super_block *sb)
>  			__ext4_update_tstamp(&es->s_first_error_time,
>  					     &es->s_first_error_time_hi,
>  					     sbi->s_first_error_time);
> -			strncpy(es->s_first_error_func, sbi->s_first_error_func,
> -				sizeof(es->s_first_error_func));
> +			strtomem_pad(es->s_first_error_func,
> +				     sbi->s_first_error_func, 0);
>  			es->s_first_error_line =
>  				cpu_to_le32(sbi->s_first_error_line);
>  			es->s_first_error_ino =
> @@ -6144,8 +6144,7 @@ static void ext4_update_super(struct super_block *sb)
>  		__ext4_update_tstamp(&es->s_last_error_time,
>  				     &es->s_last_error_time_hi,
>  				     sbi->s_last_error_time);
> -		strncpy(es->s_last_error_func, sbi->s_last_error_func,
> -			sizeof(es->s_last_error_func));
> +		strtomem_pad(es->s_last_error_func, sbi->s_last_error_func, 0);
>  		es->s_last_error_line = cpu_to_le32(sbi->s_last_error_line);
>  		es->s_last_error_ino = cpu_to_le32(sbi->s_last_error_ino);
>  		es->s_last_error_block = cpu_to_le64(sbi->s_last_error_block);
> 
> ---
> base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
> change-id: 20240321-strncpy-fs-ext4-file-c-c983d942dd39
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook

