Return-Path: <linux-ext4+bounces-11545-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4596C3D413
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 20:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64ED3BE5D9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFE31BCBC;
	Thu,  6 Nov 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyL2PI5t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57622DF6F4
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457692; cv=none; b=RMwzlN1iKMFK2OsZgm8EZ3/ZtgiEQvBgJUlcIFH+ONLE1JqrQ4nnLCQedpLJShpLmv7dHi/Bswfbnh5/5dwkzwMllrn9dag3Xx94ITa/OPJEaHm6IXKthf6UvLrP51osqVSOTiD8A1ug3mjcbTNInK/Q7I6sbRtuu1tCgAIXpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457692; c=relaxed/simple;
	bh=T/3euURa4sf5pno5n07UA3H6TYwADkHD4DxPPNGT6W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmuc30O1hjbGOEJhRVHs/vvfFm6Uu15AXc/U2PIer15bT6hgvXnsk1oz3HfLHm7crNzpvqncD/NkYVP6Ud5aI8SEHZBI3JoyTZfCZBBBmaL/eUQGdlfvGujDg/pxkejzZx66qu0TA0buEezvYhd5T2d0rfabnO8TuuUK+eXGybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyL2PI5t; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b729f239b39so115013566b.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457689; x=1763062489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCBvcf/NJMhjuoNcaV9EjlbhEjMTciXlshR/lOPkPFk=;
        b=ZyL2PI5t4p40TnO1N19UYKSCxgoiuj5n22JXUq+xjSDI3fX8qDyh19Z+CAXxwCvSdj
         d4n4c89yfBvWyxmtK0Gkk8VLX0fRBCPy4rld0fHtYiWAbED8CNJHFxFxRAHbxPb/VHrS
         Dn3RBiaojFLrENqbm33rkUPU6U/EzGd+ubuLR2vSEV222OPI0NQkjAB1eas6LZKdG012
         sawKKfISfLG3qWRrAnW7IAdHKA4olmoFlMkIa6JF9zQvTEQ2rhWa1/4PZr1u7srtkgMX
         0qWO09MXSiyh6LXFcj5KqGKDhyMxEgeIqhp015AGbdOECmNEdZNUVwg4xUUV7YbJRVKu
         sAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457689; x=1763062489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCBvcf/NJMhjuoNcaV9EjlbhEjMTciXlshR/lOPkPFk=;
        b=YJ1e4hRXdB1Tj+IBLEF8LlXap/azOF4op51vOs2/3ZzInBaClcRo6Ttmafgu3dUJqR
         dhsD7CiJ7T16NKYN0611HiP5SIN/87nVVhyDM7TgDdxlOeIGDUpYGxaXxFLjp8dYgPBm
         /yT2gIzVZ1a7dqSZ4ZXwTg9GrPrRM6/0TVeblCY3CpMPfVNXdBUC+x+E5x3wwgaCV2oU
         rYOwthzcdZpNdUHdpmdn+PkDuXPyzXxH9qhIR8FQKuAFycsodQyKcqkwyKaqSrxXh7LF
         1vL7wCcPAP03kuHi1V0pM5Ls5Nh1+uqomaDtNOS7nZGZiYlGIEIC3h96sHhg0+k4wcZM
         7TPw==
X-Forwarded-Encrypted: i=1; AJvYcCVAMrYoZxoHWu/MzACLMS4QytcFLpQFLae6H0UEwqJzm+BYlipuqiNuF7DDVFJdECWqtVMPVr7vuYF8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SZRnLBJx9EaH0RydVd9ZcX9dM1Jikl2RCBW9Fp8FcfblG/Yl
	JaqI5deBHMBasb+n14OZt0y547Ohc93V3ZxsE03dyO1By5ASMNf4axFIF1FDHFOjnc0rytXjBmk
	7r7drXyYm3ktysbWq9ul6NQddZlMCSP4=
X-Gm-Gg: ASbGncvD5yiqJP3MbDrTnxt+gMX22NLKwtpkkEQ/cKWRhZ2gSp9LsciTep78vVWoc0K
	mdz+Cy8NTau2ejko/AQz2sH2QCERLe5L7WB8X8VNVFCDz17geqi6ShZalvv5F2QBnWmKAD2vuON
	EWSakvrf6YoFCZTv6EkAPtcG+1jmlvOZ7SOKVxbR/moJ8DzOYGeP0EHQGPs4DQOtLz0/KGMfP3p
	zobbunrLYYnTkWnawSURLyG5moR2Q7mwCbRgp76p9URYAfHemGPxxfhJsWHuU4yL5/zDYbVps10
	YlbLtOozOaY1svh638si4vyOEw==
X-Google-Smtp-Source: AGHT+IEDHxdgCYJuNF4Psgi4yycknqN7aYM8f3c/D+9flybAQhXx8OLT9RAar7ZocVrcCQXNf1dHRkhEGhitFBett60=
X-Received: by 2002:a17:907:970a:b0:b53:f93f:bf59 with SMTP id
 a640c23a62f3a-b7289645bddmr458133666b.29.1762457688968; Thu, 06 Nov 2025
 11:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106180103.923856-1-mjguzik@gmail.com>
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 20:34:36 +0100
X-Gm-Features: AWmQ_bmwHSwkUrd6OUGx9_ZPsDHuq69IIK4ETTJeTUhXllTD4dJ_LEyZsJjk-2c
Message-ID: <CAGudoHFVnOvshyXi9-1gMs+SOg5zc9e++iT9_Nz6UjwtmG6VuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] permission check avoidance during lookup
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 7:01=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> To quote from patch 1:
> <quote>
> Vast majority of real-world lookups happen on directories which are
> traversable by anyone. Figuring out that this holds for a given inode
> can be done when instantiating it or changing permissions, avoiding the
> overhead during lookup. Stats below.
>
> A simple microbench of stating /usr/include/linux/fs.h on ext4 in a loop
> on Sapphire Rapids (ops/s):
> before: 3640352
> after:  3797258 (+4%)
> </quote>
>
> During a kernel build about 90% of all lookups managed to skip
> permission checks in my setup, see the commit message for a breakdown.
>
> WARNING: more testing is needed for correctness, but I'm largely happy
> with the state as is.
>

Forgot to explain more in the commit message, so here it is right now:
how almost the entirety of inode_permission() can get elided for
inodes which qualify for it.
inode_permission()
{
        retval =3D sb_permission(inode->i_sb, inode, mask);
        if (unlikely(retval))
                return retval;

sb_permission starts with a check for mask & MAY_WRITE. Since mask is
MAY_EXEC, this does not need to execute.

        if (unlikely(mask & MAY_WRITE)) {

Same here.

        retval =3D do_inode_permission(idmap, inode, mask);
        if (unlikely(retval))
                return retval;

do_inode_permission starts with a check for IOP_FASTPERM. This is of
no relevance as we are skipping the perm checks and the behavior is as
if generic_permission() was always called.

Then generic_permission:
        ret =3D acl_permission_check(idmap, inode, mask);
        if (ret !=3D -EACCES)
                return ret;

We don't have to check the error code as we expect the perm is granted.

acl_permission_check:
       if (!((mask & 7) * 0111 & ~mode)) {
                if (no_acl_inode(inode))
                        return 0;
                if (!IS_POSIXACL(inode))
                        return 0;
        }

We don't need this as we already pre-checked the perm is at least 0111
and there are no acls set.

back to inode_permission:
        retval =3D devcgroup_inode_permission(inode, mask);
        if (unlikely(retval))
                return retval;

This checks if we are dealing with a device. The IOP_FAST_MAY_EXEC is
only legally set on directories, so it is an invariant we are not
dealing with a device and don't need to check that.

Finally this:
        return security_inode_permission(inode, mask);

.. *does* execute in the new scheme.

However, LSM has notpatchable calls inside and only 2 users, normally
not present on Ubuntu et al. Or to put it differently, this is a func
call to a nop slide on most kernels and with some extra work can also
get elided.

> WARNING: I'm assuming the following bit is applied:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 78ea864fa8cd..eaf776cd4175 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5518,6 +5518,10 @@ struct inode *__ext4_iget(struct super_block *sb, =
unsigned long ino,
>                 goto bad_inode;
>         brelse(iloc.bh);
>
> +       /* Initialize the "no ACL's" state for the simple cases */
> +       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_fil=
e_acl)
> +               cache_no_acl(inode);
> +
>         unlock_new_inode(inode);
>         return inode;
>
> Lack of the patch does not affect correctness, but it does make the
> patch ineffective for ext4. I did not include it in the posting as other
> people promised to sort it out.
>
> Discussion is here with an ack from Jan:
> https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omu=
r2l2opitn7lbvfm@rm4y24fcfzbz/T/#m30d6cea6be48e95c0d824e98a328fb90c7a5766d
> and full thread:
> https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omu=
r2l2opitn7lbvfm@rm4y24fcfzbz/T/#t
>
> v2:
> - productize
> - btrfs and tmpfs support
>
> Mateusz Guzik (4):
>   fs: speed up path lookup with cheaper MAY_EXEC checks
>   ext4: opt-in for IOP_MAY_FAST_EXEC
>   btrfs: opt-in for IOP_MAY_FAST_EXEC
>   tmpfs: opt-in for IOP_MAY_FAST_EXEC
>
>  fs/attr.c          |  1 +
>  fs/btrfs/inode.c   | 12 +++++-
>  fs/ext4/inode.c    |  2 +
>  fs/ext4/namei.c    |  1 +
>  fs/namei.c         | 95 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/posix_acl.c     |  1 +
>  fs/xattr.c         |  1 +
>  include/linux/fs.h | 21 +++++++---
>  mm/shmem.c         |  9 +++++
>  9 files changed, 134 insertions(+), 9 deletions(-)
>
> --
> 2.48.1
>

