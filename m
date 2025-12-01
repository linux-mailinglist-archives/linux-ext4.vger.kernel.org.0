Return-Path: <linux-ext4+bounces-12113-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0BC9991B
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 00:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCE3A4A4D
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C072853F8;
	Mon,  1 Dec 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="UOlVcLZ+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8423D2B1
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631038; cv=none; b=fIdpLo3IssxDQgqiuFolr8qbg3tTZis+RcfAP8RjQHRMDWm6zu2g+J7raj3Q30MudUE0mvQOHWmNpYm7NKEFr7Nw9tSI9Kdg44Dtb3WNN1fWBCDR2LmHL/TK8zkjet+fRqVLatMuIiGN4mC6p4OIJPcCUZNwnsthOYYxFhTl+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631038; c=relaxed/simple;
	bh=o2nc9qwwgeOh4FGHa/JZvi2M8qyc+G1yYyz9G9Z8Fzg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e5LGcDtQPHjxFgugtvQ92hv5uVu1soObtY60mYSH2c1GGkE5ul43ZiMcZ7s1/W/lWsPoUgSiVcwSV/28BMVIT90nlcvxYoOb892ML6BwWnBUYuDjb3zBL9Oy/5zZwF4+Ii8/zIqECk1gfY4GNttFRIRTeGkb9gfWwiWWON7jbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=UOlVcLZ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2956d816c10so50684465ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 01 Dec 2025 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1764631035; x=1765235835; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuYFTIaTZO6Mx4FRJtuExOcCGS1V4ypFTCXF+F0seBo=;
        b=UOlVcLZ+LJscoqEBjt11dhYGokKSLRBnCuCoEbFMeTDW24KMlnFGR/d1dExGwto2p3
         dbGUQ0H7mbRsU0kPev/CpdXuKwbiTpGiiluJI7kA2TioBU82qim5qom9G0qeqw/MXFNv
         7nmRTMtryoBdAUJuCvP6PGNKX/HENdDEwIxkg4SWjGkaG+byY89qIf7NMTvBWKBnF3c+
         ymDFILKWr8bhzOhv93nf/eK2FviFTF45y1EU0P4KB8ATB4FocYwCCA+PQ+6sMNjyisSg
         i6KOXkIQF4FSn6O/5HRqsxdJQZSYSDO9I8V9MD2HYIV1yRoON3RiaFr0wbwdkj0+Nc9G
         o2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764631035; x=1765235835;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuYFTIaTZO6Mx4FRJtuExOcCGS1V4ypFTCXF+F0seBo=;
        b=qHumRAvq4yIFcRif3Hb/1QcNLvNkNQn/UxWKX7jMZ7iit4Gv04sLDIzQNATM9zY6xS
         UD239zq1ZkMn4RII8b/Z7ynTRvsuH213JwDVENrivPaY3Qt1R/EMRE9HxxWyKJi/EBHr
         PuuKRR9KaaKuzpjvt020XlsDeaQuvlZ2hVdZ24RGRSKlEtmvgT4i4W8kWoBoEbDSV/aZ
         +xCGFkK96gxIzk0oZDq9yP6Iqw64/RM/Schy7iK0p/vgmX1E0V/MbfYHt5bnqwdtkyit
         Lk/6P1cuXZ+N5KtVPI4n97ZQz678x4ge7/Ciw5C9gjF7R5g/LxAvR2PCOI8Kgbpea0V2
         LAZA==
X-Forwarded-Encrypted: i=1; AJvYcCXc3RGHt2dLr5CTfUyWGtn4QdEmTxe+I8c+1+nwqJ8MFGbOcLhTPwhnafeS8PAGDvWi3gBDW0eUAeHH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6ubR1Q8cUhtCbCJHund/b4S6JKYclbM03PJtc64u6mgPl5Du
	J7xXBb6WDjIEc17DW+wLH7Ypqwu2cjUt8VIVNoP/2iSkqk58hW81bu59iay3Ko2GrdN14mQsgbc
	SWYyuZRQ=
X-Gm-Gg: ASbGncuyEwotW4V4innSHcZuqk3myXi7VpeJl2jsGOw2b4ILOzpMQ3qmAJRJadkhCky
	xPPRhqMP3fQHmm+mRR0zrvbSxpS9Uq5VyIBAVmSKQm6JzDy+QqdgHz0a2j/rQm4/PgtIjf73Qmq
	oZ+Ucdy0/tNVaI8hBybvsxEfh60hnYmw6FKN/7mL1sTijkMeIVWQilBhi3BvtM2EHxbJqpythIS
	nHpyRDpad5SLJS2K3hjzHscd9w1QE6WueoJ2cXi5NUFzJGJgTob+gkhJB/RiPJc34Ylfvch12ix
	3Wt9SLB1YUoCrgAtsW0ed6KXXVba0VkB0XGGvk0LJlQkZzPIJvT/evcSpAE0QmZHk3dII0QdP+i
	okym2zXA/bU3t/2NHbVVL8L15BZEkGjhUz3D3thc5kweePUvq9m2FFsAidPP2iDu3tl+XPLKp3S
	G5MnP7sR9+UrwgVC1Np3/UXiGFwngzIQDnbxFgTUCnkWiceEdGmVsCuRiTkA1U8PmXHw==
X-Google-Smtp-Source: AGHT+IF19Erg32gaWSVfPHRnaGpQFfp/O1WzKSdK8s0yOvCmWaB7/uL0T8v265OGtJbFdS03ebK9rg==
X-Received: by 2002:a17:903:2c10:b0:298:42ba:c437 with SMTP id d9443c01a7336-29b6bf75998mr414747795ad.50.1764631034699;
        Mon, 01 Dec 2025 15:17:14 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27648sm134566135ad.52.2025.12.01.15.17.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2025 15:17:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
 (2)
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20251201161648.GA52186@macsyma.lan>
Date: Mon, 1 Dec 2025 16:17:02 -0700
Cc: syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>
References: <690bcad7.050a0220.baf87.0076.GAE@google.com>
 <20251201161648.GA52186@macsyma.lan>
To: Theodore Tso <tytso@mit.edu>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Dec 1, 2025, at 9:16=E2=80=AFAM, Theodore Tso <tytso@mit.edu> wrote:
>=20
> That being said, we probably should just not try to expand the inode's
> extra size while evicting the inode.  In practice we don't actually do
> this since we haven't expanded the inode's extra size space in over a
> decade, and so this only happens in a debugging mount option that
> syzbot helpfully uses, and not in real life.

I think we would regret removing this if/when we *do* expand the inode
size.  We used this functionality to upgrade filesystems online when
i_projid was first added and users suddenly wanted to use project =
quotas.
If we need some new inode field in the future it will be good to have =
it.

> Also, there's no real point in doing this on the evict path,
> especially if the inode is about to be released as part of the
> eviction.

This could check in ext4_orphan_cleanup()->ext4_evict_inode() path
that this is orphan cleanup with EXT4_ORPHAN_FS and skip the expansion?
As you write, it doesn't make sense to do that when the file is being
deleted anyway.  Something like the following, which adds unlikely() to
that branch since it may happen only once or never in the lifetime of
any inode:

Cheers, Andreas
---
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..ae48748decc5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6481,7 +6490,8 @@ int __ext4_mark_inode_dirty(handle_t *handle,
 	if (err)
 		goto out;
-	if (EXT4_I(inode)->i_extra_isize < sbi->s_want_extra_isize)
+	if (unlikely(EXT4_I(inode)->i_extra_isize < =
sbi->s_want_extra_isize &&
+		     !(sbi->s_mount_state & EXT4_ORPHAN_FS)))
 		ext4_try_to_expand_extra_isize(inode, =
sbi->s_want_extra_isize,
 					       iloc, handle);






