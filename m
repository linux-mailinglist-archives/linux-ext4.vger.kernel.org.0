Return-Path: <linux-ext4+bounces-8413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581EAD89E5
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16357A69C8
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B82D4B5D;
	Fri, 13 Jun 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O0ooJviV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8626B76B
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812371; cv=none; b=GR1CiSaQ2S73WsfRYW494Pnc2O0m4ObDoQiYSOocuEpBzwQ4Li1hTQAcY3alsq0dFrKc67jd6tVabwqEC5W+l0sAzp7Zwz34cg/i7E29PS8c7JYSy+cja2gQXzBejRA0Teyh3zPR1+hF8o7rSMhauGa9VUZ/jCpq3dbn80swKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812371; c=relaxed/simple;
	bh=XFy/8yfk7JZ4RyFHEQ/BD+L/128e1XOOKof/uk2gf9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCUZ3EGfS/TOE/fOrAne7MtU6cBFJw4lQL4oEf6xMZEbkNY0qnAyekO1626gN2fVJz9Rdai5KI829Ly728Pd/KZqcKFWadSALmDfVd6lHThnH7snmjFijcN7mbZMV1VONLusboVs8fTq94bfiezW0tyKcmVhrh6CzjynDQWPNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O0ooJviV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450dd065828so15990225e9.2
        for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749812368; x=1750417168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yjABFEbFdOl3Pms6BvnmQIRa8WXGUA0GBCflTCpoZY=;
        b=O0ooJviVkR7i4kQanM9nCy5Qr6ni7Bd3Ztgf5G/oIpqQ5y8Hu1uVS0O8vuReu4MryH
         FbYR3KoEmtgu8TNKwl65DBAXTFpw2ZMXKTgec4JN/xnEPDDjJzrPlDKdpOWpVawmG/fS
         MMA/nRtYEcNuDYjpCZduqtGQchLWJm3mAo3TjSFSzElTJW/nM4hVUWHFeSMULyzkZ/lf
         bOofgd2yWurpOcmlfjiOlhE+c7hAKfMKA1OKtbyqBfBhHzT+V68gYqbO7bE1kA15zZJ5
         FwLZxMencaIaBfGT7/vJZA/1B/nsTpPMhLdFGISZR+4R8osrliN9/OZgJnCews1HLTqK
         zDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812368; x=1750417168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yjABFEbFdOl3Pms6BvnmQIRa8WXGUA0GBCflTCpoZY=;
        b=GxbmjD/j8yygswJPFYllKYbWLByP7ZglyouVu+5RKv4JRTYUJ7tnIF8We0gCjIqN4t
         Tsyk9roshv8Z+fJ83OwKKwki6fnGn+ZDH0qZNO9HsWp+fcLaGuhv9MKrGX6AQfAULUVh
         flQ7qD2GfmD1vanzV3039wMpmAJOH65CMzR1rgSZZ1sROab7NY/+iRATuhOz2lBUGEc0
         6QxmueAV40pqb+Jk/DlqPm2nOW/x5GDlKA6dyiV9TXNs3HndmiMyOy4ZovYCEK8NS+Rj
         F8frMmf2rREJ7/lFWo7zdGa0IYzvfsZhw7EYmW2gwnZUg10SmBpmLU3reJXl//aSSCgU
         ekwg==
X-Forwarded-Encrypted: i=1; AJvYcCXlTcJ5px3MS+AU5M52IDNrorUFtlve0AHZtKUFVuAM+7N/0f4A1eAuY9ir6qBT4wXEtY8WHkLw2+u8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cYpIpMyFr6m/O8/mNK9m8Pfn1h52GOBIHxIA423a72PxvfHI
	TD1SP15Mxr+SnAhlcn6bUHAh76+Np22lqJU88z+UsIXvP8+g7dROw2NvijJwBGu4+tsHwlbZXOh
	txTE=
X-Gm-Gg: ASbGnctsd1LLqGyZpYXc0p4HyQsywAZ3PnKY5UE/R64YoGPBpoG0LFvoWHow7msuR8f
	KO/Sv+6MJQwLcBjQFOW00/dVc65W/29xH7E1YOFKqyM/HcBzQXE04eOfnTF8MgE9IvQ8aPJAHqQ
	WvHojQ1CYmja7l+3pyuiAbEj8whNnxCcW8MzCmTeUSW0nQ7GhIlOqeM01QHAc1xiDbI8yWTh82z
	S29wrr6unawcWHXl4tweTQNux5P4gcaf/nzriWLJ0ugKeor01M/tiRTsydR35ct0OKkMgNo+te1
	4qAQJhx2VynxfZfCbTeFlc09frj6GpMhOf0oA8PpRcmBIcJc6Lr09WmIoSt7Dw==
X-Google-Smtp-Source: AGHT+IF2edISGBsvo7+crxR1N8tb3F5pUWE6nOeqlDrNKfzDvaZa+ADQzmNdG8SwkT8+I/FBnJncCw==
X-Received: by 2002:a05:6000:4012:b0:3a5:2cb5:6429 with SMTP id ffacd0b85a97d-3a56877f0fbmr2617997f8f.43.1749812367854;
        Fri, 13 Jun 2025 03:59:27 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ce947sm1285463b3a.156.2025.06.13.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:59:27 -0700 (PDT)
Date: Fri, 13 Jun 2025 18:59:05 -0400
From: Wei Gao <wegao@suse.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: Handle fiemap on empty files to prevent EINVAL
Message-ID: <aEytOcFNAI7ZcxzM@MiWiFi-CR6608-srv>
References: <20250612142855.2678267-1-wegao@suse.com>
 <20250613152402.3432135-1-wegao@suse.com>
 <mxios5pbq3vq5267on4vnt5siozd4nap5w7wemsd2vlxoooexd@ia2ezhdu7ujq>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxios5pbq3vq5267on4vnt5siozd4nap5w7wemsd2vlxoooexd@ia2ezhdu7ujq>

On Fri, Jun 13, 2025 at 11:42:17AM +0200, Jan Kara wrote:
> On Fri 13-06-25 11:18:38, Wei Gao wrote:
> > Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> > i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> > would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> > then result in an -EINVAL error, even for valid queries on empty files.
> > 
> > Link: https://github.com/linux-test-project/ltp/issues/1246
> > Signed-off-by: Wei Gao <wegao@suse.com>
> 
> ...
> 
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index 30f8201c155f..591db2b4390a 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -895,9 +895,15 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >  		u64 start, u64 len)
> >  {
> >  	int ret;
> > +	u64 i_size;
> >  
> >  	inode_lock(inode);
> > -	len = min_t(u64, len, i_size_read(inode));
> > +
> > +	i_size = i_size_read(inode);
> > +
> > +	if (i_size > 0)
> > +		len = min_t(u64, len, i_size_read(inode));
> 
> 
> Thanks! This would actually lead to excessively slow fiemap for 0-length
> files. So what I've ended up with is attached modification of your patch.
Thank you for your patient review, I really appreciate it. 

BTW i have stupid question:
Where can I see the real-time status of this patch? such as whether it has been merged?
I have checked https://patchwork.kernel.org/project/linux-fsdevel/list/
but do not find current patch, maybe this patch need specific sent it to
linux-fsdevel@vger.kernel.org? I just get maillist through scripts/get_maintainer.pl but
mail list not contain linux-fsdevel@vger.kernel.org.

> 
> > +
> >  	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
> >  	inode_unlock(inode);
> >  
> > -- 
> > 2.49.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> ---
> 
> From a099b09a3342a0b28ea330e405501b5b4d0424b4 Mon Sep 17 00:00:00 2001
> From: Wei Gao <wegao@suse.com>
> Date: Fri, 13 Jun 2025 11:18:38 -0400
> Subject: [PATCH] ext2: Handle fiemap on empty files to prevent EINVAL
> 
> Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> then result in an -EINVAL error, even for valid queries on empty files.
> 
> Link: https://github.com/linux-test-project/ltp/issues/1246
> Signed-off-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://patch.msgid.link/20250613152402.3432135-1-wegao@suse.com
> ---
>  fs/ext2/inode.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 30f8201c155f..177b1f852b63 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -895,9 +895,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
>  {
>  	int ret;
> +	loff_t i_size;
>  
>  	inode_lock(inode);
> -	len = min_t(u64, len, i_size_read(inode));
> +	i_size = i_size_read(inode);
> +	/*
> +	 * iomap_fiemap() returns EINVAL for 0 length. Make sure we don't trim
> +	 * length to 0 but still trim the range as much as possible since
> +	 * ext2_get_blocks() iterates unmapped space block by block which is
> +	 * slow.
> +	 */
> +	if (i_size == 0)
> +		i_size = 1;
> +	len = min_t(u64, len, i_size);
>  	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
>  	inode_unlock(inode);
>  
> -- 
> 2.43.0
> 

