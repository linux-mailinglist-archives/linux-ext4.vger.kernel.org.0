Return-Path: <linux-ext4+bounces-1775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39938891252
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 05:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E458328989B
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157703A1DC;
	Fri, 29 Mar 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bsc6whB1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E68383A5
	for <linux-ext4@vger.kernel.org>; Fri, 29 Mar 2024 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685467; cv=none; b=l7k1axi7bv7m9aMYryD2i8KziCPFIMwYLhVyzTnHgg+cUJYdj8Zgo/i4lmjZyS2ZGtEsXUBpq+IonTSkdbdmwNwSme3WLxqEUxRLlGmVAYTFpQNxhV81k74Jl989exD8zp+Z4NffsDw0oGkOkQeGjQi6ngqsLmJenSFFf1R3qPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685467; c=relaxed/simple;
	bh=Sej1B+KPaAd1YJSUCEcu/2wZgvFA6dEVc0yLCqlWKKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOJ3inSSdfNBNA90Ul5qHTGakTkhOo6MnObJonIYforNCZE1IcnjSphEWhCJ10fuzszLzbPk3eT5LAKZamkecXxHQe4+523Ghib1FjKUKe4Kc7VYxT8lBTJFhAma+dmoZVv1kpmpFWQoa97awrqbBz82OWy/pEJ1rGHUCG1sDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bsc6whB1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def89f0cfdso21258335ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 21:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685465; x=1712290265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUIGGacJ5zX9tZrBNytRyyuYA7UqfnaLQvQzbVYvhP4=;
        b=Bsc6whB1aT4BfVf2DYDvvXHdKALklrXOeLkXkrHf34upWS1iCcvc6AAISo9LKFWhsO
         8lXeGDDPpfXbS8Thj6efTHMD9vImhs4EFze6Ek8JpC2MksAythzgnyOd97cOh+1Gwup0
         lSGn8Z5ESeQZk11+HXsYWo94aZqhiZmqL1Kjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685465; x=1712290265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUIGGacJ5zX9tZrBNytRyyuYA7UqfnaLQvQzbVYvhP4=;
        b=w64pkM4z2ZwWQyWoDk5mxkg+vqENAGm6iyyhw6hByJn/rYeARjeJ8ubJ1y4YGhXth2
         e8vQesgWDtfdITDd+/2exl9Jb8torkTxA1B24nx6hW+qCcJAT/i4QlBjBCrpNLpy389P
         PIWDF2R2C42m4t8cnJBsELpNQRea6SROA/APGaRtR9LmddAzH/309XaztPC/rXw9ihnt
         5C1ckEg6ghMsHPt+YBd86RiACBQo3bXMSbbmYrgRDNEcIbGQw/U87rKNt95osJ9E4hyR
         LHVClBVEC/uDzWWjY4fIS/crN2qtpwCGm7G0D4QLwttdEnb+bSnf/hjLu7ohOqUtJghw
         WiQA==
X-Forwarded-Encrypted: i=1; AJvYcCV2zd9wE5G/S2JB+SnmMT1hUCaO6fpDFSdZ6rK5zXpddiDLsfXBXxNcdMNmjiiY4/SoV6FJ8764lt2NV3uxUVSWIxkVIBTXviP5iA==
X-Gm-Message-State: AOJu0Yzq2oKblObZR9Cc5j2dVDASDeJuwbbiMYfOxB0Fko7NgnMXx79j
	Vuk14oVmrC1++lN7wasVuM5qauxxAS6u8DevOWqLXCAuHt1+UhpLp5iR1zbjNpGpCU/++6CUFWo
	=
X-Google-Smtp-Source: AGHT+IF11IWkI0TTAlwnE00yKbuCp0K/lKMT2EevXSIyOW0sCRAJmY0MqvYYhF8S0cgcHj6ziGPeig==
X-Received: by 2002:a17:902:cf04:b0:1e0:137e:cd66 with SMTP id i4-20020a170902cf0400b001e0137ecd66mr2022268plg.30.1711685465594;
        Thu, 28 Mar 2024 21:11:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902c64200b001e0e8e4f7e3sm2474716pls.206.2024.03.28.21.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:11:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:11:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: replace deprecated strncpy with alternatives
Message-ID: <202403282109.D174F1CE@keescook>
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

The only reason I can imagine the memset() being split here is to keep
it out of the spinlock. For a non-fast-path ioctl, I can't imagine this
being a meaningful reduction in lock contention, though.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

