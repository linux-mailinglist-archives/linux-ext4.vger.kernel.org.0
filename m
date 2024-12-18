Return-Path: <linux-ext4+bounces-5723-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387969F5C3D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 02:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AB516A9B5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925C481B6;
	Wed, 18 Dec 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3t7Uh0Zj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14935976
	for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2024 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485318; cv=none; b=fUdfgUw4kiYnNMiCwehWm15JqgYtgEQHUl88RaXoZHUmtMaqal+DW8cETsxHygV17St9fyD26CrTuXW1sEd0OSzPyNCmkc518k9e3i4BqEIu6iF7BjtBye2H8meChPRXYc156ujRv3i3fdP1ABTSiRZGqIgIj02dijeMCJdJYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485318; c=relaxed/simple;
	bh=oeajVWfYtSBf7NvTffP7dQrCm1p2yu93+XLPibw0bqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iaoom6uc7LmD2Bj/UmEYMAG3eCo/spc1fDoFha25CvPAfSHphCo65qBk9HSn9TJjs13pbG+4UMjX5+YCyFgFKB1N9l8OqEx2oRYIs1kFJyLOzgafh/A0fEJoj9V3CjO/0hUBnhnzoYSdrTjneCYNboB8auAATiFWN22+Vc8bBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3t7Uh0Zj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso4685130276.0
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2024 17:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734485315; x=1735090115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T46I2T3SzoqnxA5b1AnH9vTr5ly2Nw2VGqfQo57RDiM=;
        b=3t7Uh0ZjT5xjtrKIvIIJOCHEiIvOuPvFx6CIwSZOBhsibBGFFlrE/dHcl8A8/GUPwU
         k8T40BrEQd3PC6VCTG/63Xwx5YuzIleThZaYH16qd2c+A+ZqF0NPwAAG/m3vLWjILJNL
         Md40jyG5E7hDxAFq/70h1qGzNl1Yl5zHCs97/+CbKE5vrksgb/Qv3GSlRR1jtv33gaMV
         FzvLrFPJ6ll2vybFt4muxXnzn3vKO4mkh2PSoCgoSSKSMVfrN1V3RocQMQzmkQo6e22y
         SqBp9SkbV45z8rpmW2IRjVpoqFGeP608Xyi0Hgw6QP7AvbIESP+scImoHOfwSRxVD90J
         1gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485315; x=1735090115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T46I2T3SzoqnxA5b1AnH9vTr5ly2Nw2VGqfQo57RDiM=;
        b=JiQ96NBS546fFlN1Scz+q5lXNC/L4DQ5QwNY2e77hbMA3t5ly/SF+LW1GgXzN+cfDR
         BooT7z+fXR/z0xJm22mdAUvju4lAYzJJOKN7vMEfuM3amrvjG4dhr4uBwvB2vLzmkjq5
         Vjlky64Y/inD8WSRGxWtL6iAx/eOggLU7UFyNbBzsv2p7wHReeTbLsHcJ3ExRmYFWnQw
         ORRIQtNsC1929xW6B4p6RDahFtOxmAWdWl31w6RI4YeqpMvuV5jDfl6Ol6bgKfo0fJWS
         R48AdragEjFkWquBwSGib+LJHE88GlRpd/xbyhIshep5MGRwUIMWcxlAGY9Mi/yDiV0m
         JfDA==
X-Gm-Message-State: AOJu0YyNqNc7wxagVeRLKkQhHDqanV++l9rNhZDF74rTxrm/fz/zs++F
	1w4yFjPWHxvxTn0cXchrtQS5PyPw+ooDsPnD3A2f3g7eK8PCroMQQf1G3Wk7ENcNMfxg0BP4I04
	y8S/XIiAVvGu3bYmCD2QchC7QwMrp1hkXQs6W
X-Gm-Gg: ASbGncvANcM5M0XgXJu4qrIrAH2FbTLT6sUE5apiTSqRb+rgusUkb0c44qubn1Qa5g0
	yTimfjwi04t5EVqxHtocMoSMVk+HZm3UKxRb/DoifsGJnJ+E736NHhFioXTwMqWgh
X-Google-Smtp-Source: AGHT+IHUNt4/Vf2ykJ9d6/DhLuJfW6cwP/sc7y6YwDu9FxJfyyeCTVc3/lIBMn9zWJQJQJmz8+Kcjg/CrTLlGe0aC2g=
X-Received: by 2002:a05:6902:2382:b0:e4b:6ef6:e7bf with SMTP id
 3f1490d57ef6-e536222cd17mr1032564276.32.1734485315194; Tue, 17 Dec 2024
 17:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212224958.62905-1-sarthakkukreti@google.com> <Z18iP6I56m3SeJVr@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
In-Reply-To: <Z18iP6I56m3SeJVr@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Sarthak Kukreti <sarthakkukreti@google.com>
Date: Tue, 17 Dec 2024 17:28:24 -0800
Message-ID: <CADR0QSL1XYQp426vEorTKn4xY0yeGuFVynmdEaNiz1UFuu_zVw@mail.gmail.com>
Subject: Re: [PATCH] fallocate: Add support for fixed goal extent allocations
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 10:39=E2=80=AFAM Ojaswin Mujoo <ojaswin@linux.ibm.c=
om> wrote:
>
> On Thu, Dec 12, 2024 at 02:49:58PM -0800, Sarthak Kukreti wrote:
> > Add a new flag to add support for fixed goal allocations in
> > ext_falloc_helper. For fixed goal allocations, omit merging extents and
> > return an error unless the exact extent is found.
> >
> > Use case:
> > On ChromiumOS, we'd like to add the capability of resetting a filesyste=
m
> > while preserving a set of files in-place. This will be used during
> > filesystem reset flows where everything apart from select files (which
> > contain system applications) should be removed: the combined size of th=
e
> > files can exceed the amount of available space in other
> > partitions/memory. The reset process will look something like:
> >
> > 1. Reset code dumps the FIEMAP of the set of preserved files into a
> > file.
> > 2. Mkfs.ext4 is called on the filesystem with -E nodiscard.
> > 3. Post mkfs, the reset code will utilize ext2fs_fallocate w/
> > EXT2_FALLOCATE_FIXED_GOAL | EXT2_FALLOCATE_FORCE_INIT on the extent lis=
t
> > created in step 1.
>
> Hey Sarthak,
>
> On the e2fsprogs side, the change looks straight forward enough and
> irrespective of the use case having FIXED GOAL for fallocate makes sense
> to me. While you are at it, I would just request you to fix the comment
> above ext2fs_new_range():
>
>  /*
>   * Starting at _goal_, scan around the filesystem to find a run of free =
blocks
>   * that's at least _len_ blocks long.  Possible flags:
> - * - EXT2_NEWRANGE_EXACT_GOAL: The range of blocks must start at _goal_.
> + * - EXT2_NEWRANGE_FIXED_GOAL: The range of blocks must start at _goal_.
>   * - EXT2_NEWRANGE_MIN_LENGTH: do not return a allocation shorter than _=
len_.
>   * - EXT2_NEWRANGE_ZERO_BLOCKS: Zero blocks pblk to pblk+plen before ret=
urning.
>
Sure, let me add and send that as a quick v2.

> That being said, the usecase seems interesting to me and I have a few
> questions about it:
>
>  1. So if i understand correctly, after mkfs your tool will essentially
>     handcraft the FS by using lib/ext2fs helpers to fallocate the exact
>     physical blocks where your files are supposed to be on disk. I believ=
e
>     you'd also need to recreate inodes/xattrs etc for the files to make s=
ure
>     they are identical after mkfs?
>
Correct, the restore tool will ensure that inode, attrs and xattrs are
regenerated.

>  2. I'm assuming you don't expect the underlying storage medium to change
>     across this reset and hence using the same physical block works?
>
>  3. I wonder if there are any other ways of doing this without having to
>     handcraft the FS in this way. It just seems a bit fragile.
>
Yes, the underlying block device remains the same. The preservation
mechanism is primarily intended for system files with attached integrity da=
ta;
more specifically, we use dm-verity to validate the integrity of these
files before
use post-reset.

Cheers
Sarthak

> Regards,
> ojaswin
>
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
> > ---
> >  lib/ext2fs/ext2fs.h    |  3 ++-
> >  lib/ext2fs/fallocate.c | 21 +++++++++++++++++++--
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> > index 6e87829f..313c5981 100644
> > --- a/lib/ext2fs/ext2fs.h
> > +++ b/lib/ext2fs/ext2fs.h
> > @@ -1446,7 +1446,8 @@ extern errcode_t ext2fs_decode_extent(struct ext2=
fs_extent *to, void *from,
> >  #define EXT2_FALLOCATE_FORCE_INIT    (0x2)
> >  #define EXT2_FALLOCATE_FORCE_UNINIT  (0x4)
> >  #define EXT2_FALLOCATE_INIT_BEYOND_EOF       (0x8)
> > -#define EXT2_FALLOCATE_ALL_FLAGS     (0xF)
> > +#define EXT2_FALLOCATE_FIXED_GOAL    (0x10)
> > +#define EXT2_FALLOCATE_ALL_FLAGS     (0x1F)
> >  errcode_t ext2fs_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
> >                          struct ext2_inode *inode, blk64_t goal,
> >                          blk64_t start, blk64_t len);
> > diff --git a/lib/ext2fs/fallocate.c b/lib/ext2fs/fallocate.c
> > index 5cde7d5c..20aa9c9f 100644
> > --- a/lib/ext2fs/fallocate.c
> > +++ b/lib/ext2fs/fallocate.c
> > @@ -103,7 +103,7 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
> >                                  blk64_t alloc_goal)
> >  {
> >       struct ext2fs_extent    newex, ex;
> > -     int                     op;
> > +     int                     op, new_range_flags =3D 0;
> >       blk64_t                 fillable, pblk, plen, x, y;
> >       blk64_t                 eof_blk =3D 0, cluster_fill =3D 0;
> >       errcode_t               err;
> > @@ -132,6 +132,9 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
> >       max_uninit_len =3D EXT_UNINIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
> >       max_init_len =3D EXT_INIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
> >
> > +     if (flags & EXT2_FALLOCATE_FIXED_GOAL)
> > +             goto no_implied;
> > +
> >       /* We must lengthen the left extent to the end of the cluster */
> >       if (left_ext && EXT2FS_CLUSTER_RATIO(fs) > 1) {
> >               /* How many more blocks can be attached to left_ext? */
> > @@ -605,12 +608,15 @@ no_implied:
> >               max_extent_len =3D max_uninit_len;
> >               newex.e_flags =3D EXT2_EXTENT_FLAGS_UNINIT;
> >       }
> > +
> > +     if (flags & EXT2_FALLOCATE_FIXED_GOAL)
> > +             new_range_flags =3D EXT2_NEWRANGE_FIXED_GOAL | EXT2_NEWRA=
NGE_MIN_LENGTH;
> >       pblk =3D alloc_goal;
> >       y =3D range_len;
> >       for (x =3D 0; x < y;) {
> >               cluster_fill =3D newex.e_lblk & EXT2FS_CLUSTER_MASK(fs);
> >               fillable =3D min(range_len + cluster_fill, max_extent_len=
);
> > -             err =3D ext2fs_new_range(fs, 0, pblk & ~EXT2FS_CLUSTER_MA=
SK(fs),
> > +             err =3D ext2fs_new_range(fs, new_range_flags, pblk & ~EXT=
2FS_CLUSTER_MASK(fs),
> >                                      fillable,
> >                                      NULL, &pblk, &plen);
> >               if (err)
> > @@ -681,6 +687,16 @@ static errcode_t extent_fallocate(ext2_filsys fs, =
int flags, ext2_ino_t ino,
> >       if (err)
> >               return err;
> >
> > +     /*
> > +      * For fixed goal allocations, let the allocations fail iff we ca=
n't
> > +      * find the exact goal extent.
> > +      */
> > +     if (flags & EXT2_FALLOCATE_FIXED_GOAL) {
> > +             err =3D ext_falloc_helper(fs, flags, ino, inode, handle, =
NULL,
> > +                                     NULL, start, len, goal);
> > +             goto errout;
> > +     }
> > +
> >       /*
> >        * Find the extent closest to the start of the alloc range.  We d=
on't
> >        * check the return value because _goto() sets the current node t=
o the
> > @@ -796,6 +812,7 @@ errout:
> >   * - EXT2_FALLOCATE_FORCE_INIT: Create only initialized extents.
> >   * - EXT2_FALLOCATE_FORCE_UNINIT: Create only uninitialized extents.
> >   * - EXT2_FALLOCATE_INIT_BEYOND_EOF: Create extents beyond EOF.
> > + * - EXT2_FALLOCATE_FIXED_GOAL: Ensure range starts at goal.
> >   *
> >   * If neither FORCE_INIT nor FORCE_UNINIT are specified, this function=
 will
> >   * try to expand any extents it finds, zeroing blocks as necessary.
> > --
> > 2.47.0.rc1.288.g06298d1525-goog



--
Sarthak Kukreti | Software Engineer | sarthakkukreti@google.com | 650-203-5=
572

