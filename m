Return-Path: <linux-ext4+bounces-7048-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BFA7A2D5
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5014218966E9
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D224CEFD;
	Thu,  3 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="vo0VLuX2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309D24C664
	for <linux-ext4@vger.kernel.org>; Thu,  3 Apr 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683398; cv=none; b=jOYPk6bB7GB6VZAULCINluWNXPiGIETJXVKS5/xBJuL/UqykCw9T5ZIrG/lsq1zujibxJdoa4inZpahONobFsl/Mfv7Qb4+dkGcfjCpet8wBn725ihkkbc2gCFaNgeK3uzS00CPH9IN62cUghGUw3u0MNfde0dmQZpF44qI8bKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683398; c=relaxed/simple;
	bh=96Meq8dAjHmkDc3cuFH7OefetlMHbzjcjbEND0DosjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQAQ4muT635jrH8sKd6Mrct93gN/k0nxciyOa/CyDTwuxxkg1X+BeSEEWsHd30OmcM2w3kd44fSyi9mK+DuTFHelZY+kXrXph5HDhBNqxKhORbVDEdBptyaSe84JCldkg5cVhz2OxuQA6mTM63M6NbPk1bK4r10g9NQCUl+9rNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=vo0VLuX2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3011737dda0so577749a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 03 Apr 2025 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1743683396; x=1744288196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JynWWB72NrUYJsGMiQgV50eLd0vWOBT/+b5bHy2kTxI=;
        b=vo0VLuX2U0G0hTO0br91uhNJAZW/Du3HzjVf2yepkwgJOIWWaX4cYizmU6RhnBaeuE
         qyeePAdpSABvhT2L2A1n0caN+g1P2+DQkHNu6ZZ21r/DNz7Ze6rh7/QijUgYgszaUGNT
         YSIzF1pvNTqTgq5yc39ZjHmyy4briYFYkxDITJZqzHWBjjIk7HEkAaShYiFA1NNwBSER
         bE7+o1G524d1oUC4h7o5Jpan93fAiQVoJgHK5Yd5w9aEPxdBm0T64V4wp+xMIoDF2KHj
         9+guoHIsxshLlbSQQq+q1IiTAQaG4zC8A3r0lN89F+WzkvvdZFt4oSI/9IIlS7MqCkdJ
         1M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743683396; x=1744288196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JynWWB72NrUYJsGMiQgV50eLd0vWOBT/+b5bHy2kTxI=;
        b=HGchdvjd7nGL8I/NTdnCEFHmNpJkTHyDMA9mFE9EQVWjctnN4RFRKMbaLLG/4SW0Uq
         nzD5R+Hp9A18c+MGd2eijUNz0lPLrVpotkkXpb8rkM9PlJSYD/BOpuXLFw56+gamRBo1
         hzzNQmp/WRPviGqTAFLa2yhSYe1QBvNYuvoi2mZIccX4tE62kfCArKtKL5uPaxTiRRNe
         P8zVGgjk4/vg70Bqgi7XkYSxlcftl+6ycR4zKTb/GP9XoHq1ZRkB0/BxcVVpQU0cv9sO
         8QISiFbaBih3voWnEtlKToPyeFWEEHCzs9FLYBq8hCCkLolPiQvwF3tvgF8XRsLLc9od
         F7OA==
X-Forwarded-Encrypted: i=1; AJvYcCUXqNAEEz1nrmIVHoit2dU+zKa+Ketd8lbvT5j2x/3YR0WuJQrwWrQ4polx4O4IjKizQtrkUjPc0NeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YySbDr3KAQrOwzeXtIXjixZxNc/Rd7uJlZJm6PmP5S2Cm5+nXDz
	jOSQ+7ukgqeBtQ+/6kwRaSjAjAw/W6xayoFadhPSnfhajEkKELAk9FPJZKv5SQU3v+ahIZZAkjR
	NmMwdBoISnmFKsgzvCYarQgRKwSTTEX/G/0Bh7g==
X-Gm-Gg: ASbGncuxy0bibmycj0avRfirD4mY/MPDr2SAPwi5/QiRJbbm+Fv7rRy52/mf3C0jMye
	Dbw57bpCrJ/qxhgNu/MC/OYG2iYmxJDt8MckOlINvEQwWvgrRdBUicR1cyf4Qgla0BmFOdPuoY4
	sGs8CQve8sSNvfDwYZ0VtydEMCxV+4Vr2qu4rJbWuDEWg=
X-Google-Smtp-Source: AGHT+IEayLyncgjjwGctB0Q1Cv+cwNy95giRJK1hp6OCZnvGJSXclp9RE+2Tz4Bneyh+oUJ8WDN2IepwxlZELKH+IxQ=
X-Received: by 2002:a17:90b:5483:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-3057cc1c871mr3596324a91.20.1743683395876; Thu, 03 Apr 2025
 05:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8kvDz70Wjh5By7c@casper.infradead.org> <20250326105914.3803197-1-matt@readmodwrite.com>
In-Reply-To: <20250326105914.3803197-1-matt@readmodwrite.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Thu, 3 Apr 2025 13:29:44 +0100
X-Gm-Features: ATxdqUEw58AvlX_Q6xWmD0IoThd6wb6Y1DvzFiOHsKQDmm1qzfkUhri_eLGnAEw
Message-ID: <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
To: willy@infradead.org
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luka.2016.cs@gmail.com, 
	tytso@mit.edu, Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com, 
	Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:59=E2=80=AFAM Matt Fleming <matt@readmodwrite.co=
m> wrote:
>
> Hi there,
>
> I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.
>
> Does overlayfs need some kind of background inode reclaim support?

Hey everyone, I know there was some off-list discussion last week at
LSFMM, but I don't think a definite solution has been proposed for the
below stacktrace.

What is the shrinker API policy wrt memory allocation and I/O? Should
overlayfs do something more like XFS and background reclaim to avoid
GFP_NOFAIL
allocations when kswapd is shrinking caches?

>   Call Trace:
>    <TASK>
>    __alloc_pages_noprof+0x31c/0x330
>    alloc_pages_mpol_noprof+0xe3/0x1d0
>    folio_alloc_noprof+0x5b/0xa0
>    __filemap_get_folio+0x1f3/0x380
>    __getblk_slow+0xa3/0x1e0
>    __ext4_get_inode_loc+0x121/0x4b0
>    ext4_get_inode_loc+0x40/0xa0
>    ext4_reserve_inode_write+0x39/0xc0
>    __ext4_mark_inode_dirty+0x5b/0x220
>    ext4_evict_inode+0x26d/0x690
>    evict+0x112/0x2a0
>    __dentry_kill+0x71/0x180
>    dput+0xeb/0x1b0
>    ovl_stack_put+0x2e/0x50 [overlay]
>    ovl_destroy_inode+0x3a/0x60 [overlay]
>    destroy_inode+0x3b/0x70
>    __dentry_kill+0x71/0x180
>    shrink_dentry_list+0x6b/0xe0
>    prune_dcache_sb+0x56/0x80
>    super_cache_scan+0x12c/0x1e0
>    do_shrink_slab+0x13b/0x350
>    shrink_slab+0x278/0x3a0
>    shrink_node+0x328/0x880
>    balance_pgdat+0x36d/0x740
>    kswapd+0x1f0/0x380
>    kthread+0xd2/0x100
>    ret_from_fork+0x34/0x50
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>

