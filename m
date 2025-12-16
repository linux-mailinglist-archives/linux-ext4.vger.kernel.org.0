Return-Path: <linux-ext4+bounces-12376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E0CC36E7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7943C307C2B0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62383349B1A;
	Tue, 16 Dec 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH7oe5BI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A883451DF
	for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886604; cv=none; b=DgjyZxyeSfHizitweFFCONuMt7SH+hBmzlil1yxGkCnI64UoaLW6VBO9EQ0tHLkln4UWBJP4Zl4A3zHxB535bo2MJ/8jA94jeiwc9OBUJSe9bg3KjdT0A/3CVhzovo5U8VPbRPXFlV5zrRJ8m+Ev/foUR+c5fELPOP72RbTK9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886604; c=relaxed/simple;
	bh=+OuTyfPiRyHJRaVNUHS0ZfufPGLqwrs9N3H9aVM5u4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqRCNFFUo4usOB/+FiCxdG1vaSdIpxSwQhsuLp7dMDUmKJvhn6KhZA2WfvELGC3+RXt4Er6qltoOW/dMF6Jycbv9A5qLondbCh1HwNCNiSD3/BiDUFjqR4RDNRe0AasU+IFsIr9wInfxF5XPk8XVR/4d8TqMyETuisj0syiMDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH7oe5BI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso2575995a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765886601; x=1766491401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nudjjo9tQjXv4Uc7N0zXlvtzn7nmSytE9z2pqTH9TYo=;
        b=fH7oe5BIHGr6ibBuhEuP6R9JfXMbU/iF5Jt68g8RsZGD+itkJUHsPgvuTZXnmB27DY
         mZvInhGw4rwu1SMmkUqHbIvQUSUX0fT6UZZuOcxy/tykuXlfQW/wvVXtMyZaWVN4KWAA
         m3KMwcIbDQrLjW/LLjXpRrKgswpErTwAHe/jwbU6yF3aQjxw+V/4fRC/coEyHe5goCXT
         XjP2PBV/eLy9E9G9MkGhH3LNHWRAlZvytdJF/q3irxMUwLgZ7cR3R95CxCoAfNy7fWgB
         Pu9AMB+JmSMHoLJe40sGaEN8iRC8nMQNIOFudl8N+MEIuz92enFtLudk6NZCHHtkl7Qa
         3jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886601; x=1766491401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nudjjo9tQjXv4Uc7N0zXlvtzn7nmSytE9z2pqTH9TYo=;
        b=AenK9d/DyNtZZOftoqd8m2wqARuwQVJO78REQ//wVo4NG/aJ+sinR7k7QjQymx69FX
         IdBnVsFEWVIEaOr31OAgZ9v6mtaiXNT0cOs+aot9Wi8ybXUgnELYXGYjWJhzd5hxNpb3
         JLbZV5WS4WJQmcyPFy9OiwUNwxfzGti9+GxeMSAHIuTG2c3mDIEqGT3FGSa7+/uHX69V
         R4yjMrFRhVncFawx6d6hoCt21qhHFP5l7pSxiWajAHGgY6mq5YTbjmSIR3W8AIoSOFua
         /y2t2DDu010n5kMAa4NbaKsPi7EH/5LJ+D3ughZqg9JRxZMIrhwXyTFYXIWAzTfqlUPe
         fwUQ==
X-Gm-Message-State: AOJu0Yy68oU3QilCx2aL2a84HFYmHQoVvT3tXPkRz9Ih5taM+t2+2KiS
	XWkgR1DZ8THIHYNVU19PNZF3vRo7nWc+RvGU6DQZm2nGqzxNfK78LZqIZp8mdg==
X-Gm-Gg: AY/fxX6N80K8+64kWOdF45S2YVKmGln2v9N94l2psDMozx32i83t+NbwQEdP0sTfjTC
	0AJu5lxAWYzC7nk2q3ezdt9uY5cUPrCX86h1oH5PVr+IxKMDrvXzSsVM/BO604ruuWo17iwgs7E
	pNYr8z+9nZT6Rvahyo2r8sT9Fy6abkMA25eswUmX79xjCeZuohBKEu6oyiOVLDMlEUIzmghI4ep
	xqlLPGyll9paeFpoDF+7Uh4l4K3SUnGS6FuWFAOTJ2zy3YRKT55GQ09ojmtYCveKbUs4BWU3izi
	4VOvBUQCjmlab7BQP4SJ9w9xwId3kYJZSX10nojDOjcgu8a13mSAUfmhEjM2k9XekpkIqIolIOr
	1rGJ5P7dLL7QA8ZJCfZz3ngVtY+O3f5GTK7cLjqRjjtnTk+fh2aLa1AbRBFSxI9a+9Zwx2IKjmy
	Dy3ac=
X-Google-Smtp-Source: AGHT+IGRE101MPbPNoCKbWtuok2GQamkgSTAc4yz+nOa0mSToWIwvtlKCanMm5xotu0FurQEcAzDWg==
X-Received: by 2002:a17:90b:4f41:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-34abd848841mr14720357a91.23.1765886601355;
        Tue, 16 Dec 2025 04:03:21 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba5e3sm11476016a91.5.2025.12.16.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:03:20 -0800 (PST)
Date: Tue, 16 Dec 2025 20:03:18 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <aUFKeAcD6NeBbZ6O@ndev>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216113504.297535-1-wangjinchao600@gmail.com>

On Tue, Dec 16, 2025 at 07:34:55PM +0800, Jinchao Wang wrote:
> syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> 
> When xattr_find_entry() returns -ENODATA, search.here still points to the
> position after the last valid entry. ext4_xattr_block_set() clones the xattr
> block because the original block maybe shared and must not be modified in
> place.
> 
> In the clone_block, search.here is recomputed unconditionally from the old
> offset, which may place it past search.first. This results in a negative
> reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> 
> Fix this by initializing search.here correctly when search.not_found is set.
> 
> [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> 
> Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  fs/ext4/xattr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 2e02efbddaac..cc30abeb7f30 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>  			goto cleanup;
>  		s->first = ENTRY(header(s->base)+1);
>  		header(s->base)->h_refcount = cpu_to_le32(1);
> -		s->here = ENTRY(s->base + offset);
> +		if (s->not_found)
> +			s->here = s->first;
> +		else
> +			s->here = ENTRY(s->base + offset);
>  		s->end = s->base + bs->bh->b_size;
>  
>  		/*
> -- 
> 2.43.0
> 

#syz test


