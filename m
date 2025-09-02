Return-Path: <linux-ext4+bounces-9778-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C7B3F218
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 04:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974EA7A6A76
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A9149C6F;
	Tue,  2 Sep 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1HzgYMk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094A6FC3
	for <linux-ext4@vger.kernel.org>; Tue,  2 Sep 2025 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778702; cv=none; b=H8NY7JUQR2OUF62qrAh8hf79sAJP6bpPQgm33ZMaLynQqLubix004EuFSg4erJRMkApeyZP/gSdjti2Jb9t8tLaRUeRWiE2fR2gNE2kcmM/krQQaLPGnMU38HVuOplVXY8NkaG0GcKTXC2R47u5ZQfCQG3d0Gp2Chd2/ay22QI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778702; c=relaxed/simple;
	bh=bwssp0EiZsQ+odOIMVIOyR3zjFdUEgD9eqqY+DUOt2U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ozK+7F1HYxy/wFnqWmGl3cQc3n+aisCcStTm1p+4FSZ2FWC/WZqz4Na052XuE8cCuJ1NFzOywOOx/IgD7Y/AXebQ71X15tFvvxf3weG/40KMoRiltYDSPdm4J0yyja8B6Tm4s6DQ4EiMmZck0RkA8jz9AcwgM97hCEquRoDlL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1HzgYMk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2818366b3a.3
        for <linux-ext4@vger.kernel.org>; Mon, 01 Sep 2025 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756778700; x=1757383500; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HIpoPFaDFtt3V5NwaJnahKGyuXSaoblojRcQYbUjRW4=;
        b=I1HzgYMkgxdad5zh4NWE5oWuTP6XUSwttJlpQCmWQYNDAHzMKYFip0zphwJMiNdqnR
         p2AH5f0Uj+u2XWleRTPLtvkutTg80zRn/rMCtqMw38wT9oUIoYZALeq6xknWEwrtjZD5
         o+92JEIF9oiU2cSn4mwknnLTf6AKeYPHpgtUp6rlRGGv7I+tP1pZ61OG9cChiV0gg+yd
         Fn/WQnrs4UnuibHLtnFXzzSFXAqKjjd7/8b17oQBqlCdj1GBC79My5F1C9isWBB+knIr
         TXccSkWAs0y+BKYlYv4KXwlyEeXetbZr9kmY3BBTyiBLIxId6n/A4thGnKyVn2zp2/oc
         QWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756778700; x=1757383500;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIpoPFaDFtt3V5NwaJnahKGyuXSaoblojRcQYbUjRW4=;
        b=K9I8YkuQmYCHahxsBpt+r28XQ4xQDtPWbpswIjyrU/co2ili6be0lnXT/AW3qjBlxf
         sx2t89AIXWzEMipoEXrkGdGT7d0rgUNJuBOxfX8aSn/rUOW8S3vDR31gBNCTCMB6M28B
         Ct2dRkcom+N4zkAlNipeoZMJnxQAroumrbMb7Bal/Us+Ib/CUoLJWuKV2D73Xalc6Tc2
         GZ5X8c+zdOvDm/GEZIXPiyWjSGuaeI+lpLPzGxTrP361THdjP+orvoRa3LsVE9SHrN5Q
         akc7uzs0mxUnQIlHGOsEsU/AH64upmuWq+5kbjnBUFzqELYCCnPYzU3+C8ybb7HAPn0J
         1NVg==
X-Gm-Message-State: AOJu0YzSyfUr3KxrToLYhPfFKWLQbA8LfMyCeZBWdzHj3FkGK/sWuKp0
	gc84fsTES2MohG29ilkvkdu1Q8kHV10A2zBYHB6sG4MitphJi0LtuMzAmtMNeQ==
X-Gm-Gg: ASbGncvMMsSpnZc7nCg30tDQma4peP3KHRX0O2ct6+qnuT0rU3YjDC2x0Z+6bS+dPv/
	P4nsiUry1G/3e1I373XBio+4+NBmZqSOWhC/B8RVqPobxYjwrfs9bclkzfHkHSyDnXAHfLHcmmN
	5FKZIvP30nC/Xjcy7/ZacBbBKvJ4y7EZYfkNBH5yzSBNIspQJb/w018RMKnK1SZ719dKpjF0A7G
	3d8dfgogu8EWdMr4GDLLUO9d1eesKcfd7c2+v15/zT60qVjch5TWo2VUsbCRbjxR/MhavK8/qHR
	Rt5290dxnPKBUO8XQnQTZQSAyeT7GDeUmaxv0gy4XL+UNhOJWtlqKjEN3IY0UvrXZEdRW7ulHo7
	16ZN4asVTg3xGyyI=
X-Google-Smtp-Source: AGHT+IHfI4085doHk2oiwNmH63372oC0GJYCP1qCK9PQ3rweLTcxHpfcTCusZbOq9bx/ip7MZdr7kg==
X-Received: by 2002:a17:903:1c1:b0:249:112c:f947 with SMTP id d9443c01a7336-249448e49a4mr119202595ad.19.1756778699639;
        Mon, 01 Sep 2025 19:04:59 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390e6bsm117837895ad.96.2025.09.01.19.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 19:04:58 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
In-Reply-To: <20250901112739.32484-2-jack@suse.cz>
Date: Tue, 02 Sep 2025 07:05:18 +0530
Message-ID: <87wm6hk561.fsf@gmail.com>
References: <20250901112739.32484-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> changed the error handling logic in iomap_iter(). Previously any error
> from iomap_dio_bio_iter() got propagated to userspace, after this commit
> if ->iomap_end returns error, it gets propagated to userspace instead of
> an error from iomap_dio_bio_iter(). This results in unaligned writes to
> ext4 to silently fallback to buffered IO instead of erroring out.
>
> Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> unnecessary these days. It is enough to return ENOTBLK from
> ext4_iomap_begin() when we don't support DIO write for that particular
> file offset (due to hole).
>
> Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)


Thanks Jan for taking a deeper look and root causing that the problem
lay in iomap. I agree with the fix.

w.r.t Atomic DIO write: 
Earlier we explicitely used to check (in ext4_want_directio_fallback())
if the write request was atomic, in that case we never want a fallback.
However that was mostly a safe guarding. As I looked into it we have
multiple checks at multiple places to safe guard atomic write DIO
request. ext4_iomap_alloc() for atomic writes ensures that allocation
always happens for the full requested length, IOMAP layer also ensures
that if the bio formed is not of the full user requested length then it
will return an error.  We also have a WARN_ON_ONCE(1) in ext4 in-case if
we ever fallback to buffered-io for atomic DIO request.
So I believe we are good in this case.

The change looks good to me. So please feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..c3b23c90fd11 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> -{
> -	/* must be a directio to fall back to buffered */
> -	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> -		    (IOMAP_WRITE | IOMAP_DIRECT))
> -		return false;
> -
> -	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC)
> -		return false;
> -
> -	/* can only try again if we wrote nothing */
> -	return written == 0;
> -}
> -
> -static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -			  ssize_t written, unsigned flags, struct iomap *iomap)
> -{
> -	/*
> -	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code for
> -	 * non-atomic write so that we fallback to buffered I/O and attempt to
> -	 * complete the remainder of the I/O.
> -	 * For non-atomic writes, any blocks that may have been
> -	 * allocated in preparation for the direct I/O will be reused during
> -	 * buffered I/O. For atomic write, we never fallback to buffered-io.
> -	 */
> -	if (ext4_want_directio_fallback(flags, written))
> -		return -ENOTBLK;
> -
> -	return 0;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  const struct iomap_ops ext4_iomap_overwrite_ops = {
>  	.iomap_begin		= ext4_iomap_overwrite_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> -- 
> 2.43.0

