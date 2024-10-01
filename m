Return-Path: <linux-ext4+bounces-4426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804D98BC08
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FF01C215D4
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351A1C2422;
	Tue,  1 Oct 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlFzBzby"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F321BE23E;
	Tue,  1 Oct 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785606; cv=none; b=lv0+iANhT2MFGy3Id5ysl0Q2Ikzisj5ZCso43LGfzH92Zz+8xcYFy2PcdrZ5pC7Ffuh095gX3/4Yz5xSr7B64JolafFpIUNmHL7u69b9YS40fCg6pVKNq6QNjb2SZ6MiSGVoceK/nrlH5qQam3tQtbx1a/11JQ+J743hgZx/kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785606; c=relaxed/simple;
	bh=AGPCgGoPK0o7ImVCFMIR6f4YdZ5vqlo0qXoFD3Py+sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WspJFaFf673Owtztxs2WifJjPItSUxTfQFQGmWFJsRuJud5nJbwyY/9HW5sFBaW1HhAP2zupSfNF6BAQCRb4Wsiv25gjRR7swHqXgHexkuD4q6POblSA+oYSELrE2i2QA7BqVgfvYDOsPfONdp+oQ6MHprKSDPWcyoZcjvMXRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlFzBzby; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4209835a12.2;
        Tue, 01 Oct 2024 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727785604; x=1728390404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRzKZIrwY6F9e/sw1cQ+5sS/xRxVwVb7Ja72YV9Dmp0=;
        b=hlFzBzbyOv10cztOKQOuOAaPztczrWyS83cJNKCGZPKbwxUva70JxosbYt87G3DGMq
         9GBv8Kwv1awahtmRVYo/NBDwrV81FVNoR5bKpqzU8ftsA9ZEz+AJQgN0vv8X0qRSrUlO
         mC7OjZ5TkrJfSExq3tFSPhyvcSl5GESiATFW2dGlVdu2rotf0LIocliuD7xBiwqAD6g4
         k7iiVRn2kt12L4anH9qJ+wOI17Xd0WgsirByQ2xb+tW/Agr7K0ZZo38yR9t/qiOeV7ue
         XmUs3oSnGetV/PrdfFxuiMqL2ndQgBhDEXl4EPX13r/52oFrMykKou4iyJfRNJXDqB3e
         rFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785604; x=1728390404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRzKZIrwY6F9e/sw1cQ+5sS/xRxVwVb7Ja72YV9Dmp0=;
        b=JBagdcNbdNPPO4j5BXP44RvVFi31qIIjCXUFy4zNoPIqAJhDbg+V/v39s55X/tG5na
         LP/ly+sBYqaGZYHg4P+YTmFXCGjaBB0u4XlAhIZLJ55/jo58ZUAXFgo2QQGu9PTUbadL
         M2FZaN66zHnNdOyK0c8by2c4MQEogHcJkbdciL9gFSmgF/rEb7qbk6WcgZjZtApMR60C
         yWMbx/O5vXU3JIpXNLKyo9R9TLUVXGNbcl0eVlO1rFDPXtFDDBUb4b2CSl2E1WJ8pd29
         x/l29BLpLUj0lZos4k8HLrcePC7XG24eCiY/uE61jE2ZWnL5hzM+bB/xn31hV9Md4ImC
         ufDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Oh1Gw1kzRt+RvqxEgK5SsWrYmfPfSTGrg53skXzbePef5NUBM2MwVvMqNm0Ppjt7bAImWq9EqeUo9e0F@vger.kernel.org, AJvYcCXH8UqFE4do+XuQN+Mnto38+9evhUe13l8a17y7oxatyXUBQ7/0e0lGP1Z8Ob7xuj70dy6OVJEa7qyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXQAkooQ44/WO9fJ3VCbR431t9Z5544SuKeJ1xNcL86Lt0sD8
	wAVOa69mOrUxS7XYvkr5Ck87uQv66L7862cLlmSLHmIQNFT0mS29KYlrs0V5OxtTMd1Y1M++r6Y
	OrwL9lmpummII0A4QsyMCoGunuK4=
X-Google-Smtp-Source: AGHT+IEwQbSQ9LoiduXFTA+CUH43wANHBCWgxsjU8ItWClAd+cmKuW97/b+uJv9z8j5ppoJtoNx1i2gj2p0SzQ213eU=
X-Received: by 2002:a05:6a20:9c8e:b0:1c0:ef24:4125 with SMTP id
 adf61e73a8af0-1d4fa6feaa8mr20228804637.26.1727785603815; Tue, 01 Oct 2024
 05:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920150013.2447-1-aha310510@gmail.com> <C833DBDC-CBEE-4A98-A42E-E39CE2333037@dilger.ca>
In-Reply-To: <C833DBDC-CBEE-4A98-A42E-E39CE2333037@dilger.ca>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 1 Oct 2024 21:26:32 +0900
Message-ID: <CAO9qdTGwLoZGokr+RpTu2z6FVbB_UGM_tgE7qAr8k8Pr9Sx17Q@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: prevent data-race that occur when read/write
 ext4_group_desc structure members
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 20, 2024, at 9:00 AM, Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > Currently, data-race like [1] occur in fs/ext4/ialloc.c
> >
> > find_group_other() and find_group_orlov() read multiple ext4_groups but
> > do not protect them with locks, which causes data-race. I think it would
> > be appropriate to add ext4_lock_group() at an appropriate location to solve
> > this.
> >
> > [1]
> >
> > ==================================================================
> > BUG: KCSAN: data-race in ext4_free_inodes_count / ext4_free_inodes_set
> >
> > write to 0xffff88810404300e of 2 bytes by task 6254 on cpu 1:
> > ext4_free_inodes_set+0x1f/0x80 fs/ext4/super.c:405
> > __ext4_new_inode+0x15ca/0x2200 fs/ext4/ialloc.c:1216
> > ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> > vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> > do_symlinkat+0xe3/0x340 fs/namei.c:4641
> > __do_sys_symlinkat fs/namei.c:4657 [inline]
> > __se_sys_symlinkat fs/namei.c:4654 [inline]
> > __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> > x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > read to 0xffff88810404300e of 2 bytes by task 6257 on cpu 0:
> > ext4_free_inodes_count+0x1c/0x80 fs/ext4/super.c:349
> > find_group_other fs/ext4/ialloc.c:594 [inline]
> > __ext4_new_inode+0x6ec/0x2200 fs/ext4/ialloc.c:1017
> > ext4_symlink+0x242/0x5a0 fs/ext4/namei.c:3391
> > vfs_symlink+0xca/0x1d0 fs/namei.c:4615
> > do_symlinkat+0xe3/0x340 fs/namei.c:4641
> > __do_sys_symlinkat fs/namei.c:4657 [inline]
> > __se_sys_symlinkat fs/namei.c:4654 [inline]
> > __x64_sys_symlinkat+0x5e/0x70 fs/namei.c:4654
> > x64_sys_call+0x1dda/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:267
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > value changed: 0x185c -> 0x185b
>
> I see now after you sent this patch that all of these cases are for
> read-only access to the free inodes count, which doesn't really
> matter if the value is racy.  These values are only used in heuristics
> for block group selection, and if the value is wrong then creating a
> new subdirectory may be in a different group, but that doesn't make
> much difference.
>
> It looks like the write side of all these accesses are already under
> ext4_group_lock(), so the code is actually correct and not in danger
> of two threads updating bg_free_inodes_count_lo/hi inconsistently.
>
> We probably *do not* want locking in the read case, as it will cause
> unnecessary lock contention scanning groups for subdirectory allocation.
>
> My suggestion at this point would be to go back to using READ_ONCE() and
> WRITE_ONCE() in ext4_free_inodes_count()/ext4_free_inodes_set() like in
> your original patch. but *only* for functions used by find_group_*(). We
> want to be warned by KASAN if any of the other fields are accessed without
> a proper ext4_group_lock(), since READ_ONCE()/WRITE_ONCE() does not fix
> _lo/_hi tearing.
>
> It probably also makes sense to add comments to all of these functions
> that they should hold ext4_group_lock() for access/updates, *except*
> ext4_free_inodes_count() can be called to read the inode count without it
> if the result does not need to be totally accurate.

Thanks for the comment! Then it seems appropriate to annotate
ext4_free_inodes_count() called in find_group_* so that KCSAN does
not report it. I will write a v3 patch that implements this and send it to
you right away.

Regards,
Jeongjun Park

>
> Cheers, Andreas
>
> > Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> > fs/ext4/ialloc.c | 27 ++++++++++++++++++++++++---
> > 1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> > index 9dfd768ed9f8..5cae247ff21f 100644
> > --- a/fs/ext4/ialloc.c
> > +++ b/fs/ext4/ialloc.c
> > @@ -500,11 +500,14 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
> >               for (i = 0; i < flex_size; i++) {
> >                       if (grp+i >= real_ngroups)
> >                               break;
> > +                     ext4_lock_group(sb, grp+i);
> >                       desc = ext4_get_group_desc(sb, grp+i, NULL);
> >                       if (desc && ext4_free_inodes_count(sb, desc)) {
> >                               *group = grp+i;
> > +                             ext4_unlock_group(sb, grp+i);
> >                               return 0;
> >                       }
> > +                     ext4_unlock_group(sb, grp+i);
> >               }
> >               goto fallback;
> >       }
> > @@ -544,14 +547,17 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
> >       parent_group = EXT4_I(parent)->i_block_group;
> >       for (i = 0; i < ngroups; i++) {
> >               grp = (parent_group + i) % ngroups;
> > +             ext4_lock_group(sb, grp);
> >               desc = ext4_get_group_desc(sb, grp, NULL);
> >               if (desc) {
> >                       grp_free = ext4_free_inodes_count(sb, desc);
> >                       if (grp_free && grp_free >= avefreei) {
> >                               *group = grp;
> > +                             ext4_unlock_group(sb, grp);
> >                               return 0;
> >                       }
> >               }
> > +             ext4_unlock_group(sb, grp);
> >       }
> >
> >       if (avefreei) {
> > @@ -590,11 +596,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
> >               if (last > ngroups)
> >                       last = ngroups;
> >               for  (i = parent_group; i < last; i++) {
> > +                     ext4_lock_group(sb, i);
> >                       desc = ext4_get_group_desc(sb, i, NULL);
> >                       if (desc && ext4_free_inodes_count(sb, desc)) {
> >                               *group = i;
> > +                             ext4_unlock_group(sb, i);
> >                               return 0;
> >                       }
> > +                     ext4_unlock_group(sb, i);
> >               }
> >               if (!retry && EXT4_I(parent)->i_last_alloc_group != ~0) {
> >                       retry = 1;
> > @@ -616,10 +625,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
> >        * Try to place the inode in its parent directory
> >        */
> >       *group = parent_group;
> > +     ext4_lock_group(sb, *group);
> >       desc = ext4_get_group_desc(sb, *group, NULL);
> >       if (desc && ext4_free_inodes_count(sb, desc) &&
> > -         ext4_free_group_clusters(sb, desc))
> > +         ext4_free_group_clusters(sb, desc)) {
> > +             ext4_unlock_group(sb, *group);
> >               return 0;
> > +     }
> > +     ext4_unlock_group(sb, *group);
> >
> >       /*
> >        * We're going to place this inode in a different blockgroup from its
> > @@ -640,10 +653,14 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
> >               *group += i;
> >               if (*group >= ngroups)
> >                       *group -= ngroups;
> > +             ext4_lock_group(sb, *group);
> >               desc = ext4_get_group_desc(sb, *group, NULL);
> >               if (desc && ext4_free_inodes_count(sb, desc) &&
> > -                 ext4_free_group_clusters(sb, desc))
> > +                 ext4_free_group_clusters(sb, desc)) {
> > +                     ext4_unlock_group(sb, *group);
> >                       return 0;
> > +             }
> > +             ext4_unlock_group(sb, *group);
> >       }
> >
> >       /*
> > @@ -654,9 +671,13 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
> >       for (i = 0; i < ngroups; i++) {
> >               if (++*group >= ngroups)
> >                       *group = 0;
> > +             ext4_lock_group(sb, *group);
> >               desc = ext4_get_group_desc(sb, *group, NULL);
> > -             if (desc && ext4_free_inodes_count(sb, desc))
> > +             if (desc && ext4_free_inodes_count(sb, desc)) {
> > +                     ext4_unlock_group(sb, *group);
> >                       return 0;
> > +             }
> > +             ext4_unlock_group(sb, *group);
> >       }
> >
> >       return -1;
> > --
>
>
> Cheers, Andreas
>
>
>
>
>

