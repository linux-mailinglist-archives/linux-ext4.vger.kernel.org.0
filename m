Return-Path: <linux-ext4+bounces-10836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9EBD1F7F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33663B3FB9
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8492ED16C;
	Mon, 13 Oct 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWUOxepc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE72E8B6C
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343316; cv=none; b=YPBqS02eWn2/IEu3ALSR66A7yTQ+x7Xb++lsknTi3syXTSIuMeLg9uhtPOyPHJWcYeDuy4jpAkPg94VJqCai1g4jpO6XeUEXXc66K99ZOvkNjOptIpTX8DYSrq9kJS9GxwlPicz1QNMO//RBk1sdeoRu7ONvLTdx8CsE7jrcqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343316; c=relaxed/simple;
	bh=ZDF9V6SdJC6O5Ci089i93CmqQdlIvNR7SmEpklYtaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OURJb1JML9J6KGr03s01K6x/f/sG5qttZPg3JZtF9atsoPf2mRVL9PywwSeMnKYKIvsf7zKu7j3UB3xxxZFZXr4UUd5E+5x0aWg8CJ2tRc2j5fhKp7YjIuBe5lVIRSBoIDGApI4ru+aqF4KwS1HUrCuk7SOH5X6X+4+5Ya7kHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWUOxepc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece1102998so2216112f8f.2
        for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343312; x=1760948112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=TWUOxepc3LLnWjGWhlpuHdQuyOvh1ON8xPxTWN1Zt6RiP1dtffxt4BH+p9AwPuPWyA
         geHyO99HKN5xJeEgPSwZSVggoXYsZPRq4ILO8nzuMg5ZksDS24Zk+jMdG16+tMSJImxz
         wtpNPgMSRbeik7p43Pew6RjImi0HsVflcYX0kBYv0BIi5iPuPZO6MNT5BEoyQ3Axt4hL
         IrsdBj05F4bFxR+l/enqx/DIwwBTw8wttmrzTfskfs/TkXAAGD9nuV6pFiLgc9vaRJZ8
         HHMC3vJMy38yQU6/w5sVcUlez0lZ+Ayesxup9glXl39siTmpxyelVxLCOFwS7MPAsAHF
         J0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=i4QMPuhgE35gD4KCdZK2HQEeOwC/sJAm7ffLlK1S5zWw96IOcX+P4vYEAmkh34pDIx
         fNc/NjD1SqzEIGdZhImBnC/w5wAyqSZtg3Os/WaidE6RPPXOjZrG4SjQ//azq50EpMfa
         puoCNOkyDRsIEGqTxHKxhCRj9n73nuJWLMJ3B+i4OuMoCXTac/ZU2QEShCkt4OGCVtXy
         F8Lw6nUtyVZ6+GLUbZSstwHWAgm3p5qBKsr3bexnnMKrf3/Z+lvUqs4T9RWF0TtBVYeg
         noKCr/bNKic3Ya7MjC6RXc/6vyHeHsiwQ9VcXUXQ+ajxEf5c8aU6Y6/Tc+lcNdHrHlsh
         1ZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVIUgRM4mb73fgjBf21xl8VNlDUL88+OQfbjRRW9EwoB3PjkSrVlLAvhSsrHur8OVMfRdiw3nDneYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bd7+En6HM3aUo2pBfjX5izfytuN7lICkK+6H1DiT7WMuwZkJ
	wDuF/PPtG7w89C5gjCL+vn6PmNHZ7NzCI+sGxvEZsEZMyNyeZyYoT8VmWVuDWsRLZ+rjL4KV4gF
	j+S6iXeug6RtbqIFLw0cJJYSCJlH9gssUIQ/tX54JQg==
X-Gm-Gg: ASbGncs40LSWCLbm7eAEx5MagZuxRfdpsdmemctzs4a8CjEZ5nhrjsuimbMkAl3WIBj
	TzMNOTwLsRhYSuL2xCo+XoULV/ZFd2K/kfxjsDcSF9eaiH6R3bI8Rup/3KP5LIjS6CurMWNjhsm
	wLC5MN+tmJVOL8fbAVJj5P/1rk9fuJU2SXVsq08r71hoH881oxf5o+emZQWMI23rclWh9ZE8Gqi
	yfM0szimBkEAQ/8lhO/9fbG1pNwjOrJI7M=
X-Google-Smtp-Source: AGHT+IEXSnK8vgh5qb4+sZ5l2hFRJWnorbBdcfDu2E4RvgYsaMIAeq5q8p6/Cp6GKDAeCkB0EX+DEBuZJrHy3pYKRvM=
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr13043087f8f.17.1760343312390; Mon, 13 Oct 2025
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
In-Reply-To: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 13 Oct 2025 10:15:01 +0200
X-Gm-Features: AS18NWCgT3XSP_MN-BMfr65K92-imDhnpGub1dZ7jpbkZ5N0Fj6p03e4QIM-oxw
Message-ID: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > In preparation for changing the filemap_fdatawrite_wbc API to not expose
> > the writeback_control to the callers, push the wbc declaration next to
> > the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>
> s/thr/the
>
> > start_delalloc_inodes.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> ...
>
> > @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >                              &fs_info->delalloc_roots);
> >               spin_unlock(&fs_info->delalloc_root_lock);
> >
> > -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> > +             ret = start_delalloc_inodes(root, nr_to_write, false,
> > +                             in_reclaim_context);
> >               btrfs_put_root(root);
> > -             if (ret < 0 || wbc.nr_to_write <= 0)
> > +             if (ret < 0 || nr <= 0)
>
> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
> asked for. So I think you need a change like you did in start_delalloc_inodes(),
> no ?

I understand nr is updated to what's remaining using the nr_to_write
pointer in start_delalloc_inodes(). Right?

--nX

> >                       goto out;
> >               spin_lock(&fs_info->delalloc_root_lock);
> >       }
>
>
> --
> Damien Le Moal
> Western Digital Research
>

