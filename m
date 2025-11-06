Return-Path: <linux-ext4+bounces-11543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83621C3D186
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 19:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F53188FD6B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7F3502B9;
	Thu,  6 Nov 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYn3tatX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB6239567
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454702; cv=none; b=HkuVz0NjlD2OY1wroVHUHMHAygHrlJ7VN/Co0R2VhDfeQjCcEIxDv3YeUGr+eCMJBx4WLYWzFmC5nxgxsRyBgtjNK+HwQ8oTAPCBTFq2nTuS83u+GJS0AaVSKED13AfRkrE/f22weCeedlzKjal8U/+AM8F0j76iTgq+Ti3VUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454702; c=relaxed/simple;
	bh=aW/M0ozuN6frSffp23tXS0zZal32MIeE157JEmMUccQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5C977zgQU0WiMv9CpYuXVkmt221CwakG3ODBK/dt4Nzx9R+2+vD4RcPsn/vcgBfVQ/tD1bu14qhD/rtdcmZAzJ7IlinZnhU+Q5OvBfeNNTuKnP6DUfe+aCxZLxA/V+tq1wYxjxYpSTTwSM1b2dD9Gvv5i7aUVhEt6rCwypc2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYn3tatX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso277735766b.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454699; x=1763059499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9ufBPoG2KfCBvN+6zYpV7SeT+nFfEZNWd/hOhQmw5Q=;
        b=fYn3tatXVbNBl9VzJGDYU3drs4+p0Htic3M9w+bgjOh/BV4eLdnUEa2vqWo2QTXrLZ
         2xo4KsHmqyp4v4J2lfFbfnjHRwRwOKDoWVwj55Un8+BzLPCy8159nJJUw46wiGuEwW8i
         gCfB596nB2wzDLhAcO9wdnQLD+4T1S6qd8hWhNU2e4ZIKz5X9GZw4Bc0HW8s4cS+6hTi
         mhnOYEbsIcoeVCqptdk+TQLZdtCUZuvEQNwzeQ/l2GWFWgoiI/l627cgL4oFBx+hcXZm
         3AwwNpzigZb2u7lk+OvqGm1veSevKFiA54cVb3bc3aidcxg3XFYSH2FMCg3Ro8JKL3lN
         HDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454699; x=1763059499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9ufBPoG2KfCBvN+6zYpV7SeT+nFfEZNWd/hOhQmw5Q=;
        b=rq+O5t26ZBSLp21zmAkPELjE+fzTtdCbR1BOD5vwUFFhEZraWFkHmZLUW65arCDucT
         GKfcQj7PiITQML+4bC4Z/f7k45We7ZztLwvh118nfV8cxTfiTBwqywbuEjvHr/Ru4qWt
         pElQ3/bk3xFI4hsK78qmkGfb9K58ISvWanVsLMWwDEf2J8BQ3A0mLR1yj8sCnO9Af0vs
         A8TQVd2ocHfgM2YwBCZ/k1cH75+bI+dADqvoBrYbaM6zcdWlcllXixABa4k2PFCd6jah
         +rDU0mnra6l4z2l74r/oXquXB55Mkz4SP88j44zKc8YMMuLD80VB7s38g2CNaujzcMVj
         8yqA==
X-Forwarded-Encrypted: i=1; AJvYcCUEdqb8EcCVWxYiYr9dceon/tooDDulks12qQYU4Bn/D5Jy3/ul1RjsxMujNXa9c9SSTauHNE65MIXv@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhcOC2bfhw33BwfFNoDR62HLuuimlxSmAqpmOViL2EXKj0p+z
	Lad4qOc4NyB9kMstltD0niTOXWkTUg7fandUVLBgR6spzoqXi500YmY1dkDbtgz9AW6aXoTu8yL
	ySjAnElYXjkowfk4g53GOtbxkB6sEq9snttw6zSo=
X-Gm-Gg: ASbGncs0UYqZuKfU51sQbLBX6bYAusGdRqD0rIRzrXIn2VmnaA7AMj40OuxbfhECxAM
	C5T/iC5w5JH8DXU0SG2mP32YFDl3HybUSPu7VVlPUkkIg2WxxBZRCyCZNaJ1oQet35fYBzOt/w/
	JdryqQvUrojvM/H9CeQXEHtu7MHWQQMwUlni6PUnD5W5PXxCjCEi7+GlHD2Psp+Ra8KHOYEwWTE
	nFRJDoMXdcl+AaDXZn+YXMzmqAsC9fjuEX0xBgR42OL1orbFPJ2D5AAE/SHrOqxdKj9wHz2mPGV
	5c+3QmFbZf19/E4RYHo=
X-Google-Smtp-Source: AGHT+IGa13xTlvD8l8vtpnf4JL559Pd2Si6m+X7a06yePBmTRpjI8LmUIrant9V0n2HfrSBhsopqYsgTdcoMXJaN05o=
X-Received: by 2002:a17:907:7f26:b0:b72:8398:f248 with SMTP id
 a640c23a62f3a-b72c072c2a6mr33192066b.2.1762454698302; Thu, 06 Nov 2025
 10:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810546.1424854.8347542331053081677.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810546.1424854.8347542331053081677.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 19:44:46 +0100
X-Gm-Features: AWmQ_blOEb8MRQ1qQGxDEg_rAYfyzNRIpQsoj5ndofaspYKj6cOr1J3_vvYGR-s
Message-ID: <CAOQ4uxh80xhhPWTQOi8pTc2b3qveYcNkNV0-hsxh3p2u27nuUg@mail.gmail.com>
Subject: Re: [PATCH 09/31] fuse: isolate the other regular file IO paths from iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com, 
	neal@gompa.dev, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:47=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> iomap completely takes over all regular file IO, so we don't need to
> access any of the other mechanisms at all.  Gate them off so that we can
> eventually overlay them with a union to save space in struct fuse_inode.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

I apologize for providing criticism which is not very productive.

Looking at this I don't feel much confidence to say that all cases are cove=
red
and worse, I don't have much confidence that future coder won't easily
write some code that accesses the wrong side of the union.

I don't really have great ideas on how to improve.
Maybe at least some of the gates can be inside the _nowrite accessors?

Please don't take this as any sort of objection to this patch.

Thanks,
Amir.

>  fs/fuse/dir.c    |   14 +++++++++-----
>  fs/fuse/file.c   |   18 +++++++++++++-----
>  fs/fuse/inode.c  |    3 ++-
>  fs/fuse/iomode.c |    2 +-
>  4 files changed, 25 insertions(+), 12 deletions(-)
>
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 3c222b99d6e699..18eb1bb192bb58 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1991,6 +1991,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>         FUSE_ARGS(args);
>         struct fuse_setattr_in inarg;
>         struct fuse_attr_out outarg;
> +       const bool is_iomap =3D fuse_inode_has_iomap(inode);
>         bool is_truncate =3D false;
>         bool is_wb =3D fc->writeback_cache && S_ISREG(inode->i_mode);
>         loff_t oldsize;
> @@ -2048,12 +2049,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, stru=
ct dentry *dentry,
>                 if (err)
>                         return err;
>
> -               fuse_set_nowrite(inode);
> -               fuse_release_nowrite(inode);
> +               if (!is_iomap) {
> +                       fuse_set_nowrite(inode);
> +                       fuse_release_nowrite(inode);
> +               }
>         }
>
>         if (is_truncate) {
> -               fuse_set_nowrite(inode);
> +               if (!is_iomap)
> +                       fuse_set_nowrite(inode);
>                 set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
>                 if (trust_local_cmtime && attr->ia_size !=3D inode->i_siz=
e)
>                         attr->ia_valid |=3D ATTR_MTIME | ATTR_CTIME;
> @@ -2125,7 +2129,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>         if (!is_wb || is_truncate)
>                 i_size_write(inode, outarg.attr.size);
>
> -       if (is_truncate) {
> +       if (is_truncate && !is_iomap) {
>                 /* NOTE: this may release/reacquire fi->lock */
>                 __fuse_release_nowrite(inode);
>         }
> @@ -2149,7 +2153,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct=
 dentry *dentry,
>         return 0;
>
>  error:
> -       if (is_truncate)
> +       if (is_truncate && !is_iomap)
>                 fuse_release_nowrite(inode);
>
>         clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 42c85c19f3b13b..bd9c208a46c78d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -238,6 +238,7 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>         struct fuse_conn *fc =3D fm->fc;
>         struct fuse_file *ff;
>         int err;
> +       const bool is_iomap =3D fuse_inode_has_iomap(inode);
>         bool is_truncate =3D (file->f_flags & O_TRUNC) && fc->atomic_o_tr=
unc;
>         bool is_wb_truncate =3D is_truncate && fc->writeback_cache;
>         bool dax_truncate =3D is_truncate && FUSE_IS_DAX(inode);
> @@ -259,7 +260,7 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>                         goto out_inode_unlock;
>         }
>
> -       if (is_wb_truncate || dax_truncate)
> +       if ((is_wb_truncate || dax_truncate) && !is_iomap)
>                 fuse_set_nowrite(inode);
>
>         err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> @@ -272,7 +273,7 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>                         fuse_truncate_update_attr(inode, file);
>         }
>
> -       if (is_wb_truncate || dax_truncate)
> +       if ((is_wb_truncate || dax_truncate) && !is_iomap)
>                 fuse_release_nowrite(inode);
>         if (!err) {
>                 if (is_truncate)
> @@ -520,12 +521,14 @@ static int fuse_fsync(struct file *file, loff_t sta=
rt, loff_t end,
>  {
>         struct inode *inode =3D file->f_mapping->host;
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       const bool need_sync_writes =3D !fuse_inode_has_iomap(inode);
>         int err;
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> -       inode_lock(inode);
> +       if (need_sync_writes)
> +               inode_lock(inode);
>
>         /*
>          * Start writeback against all dirty pages of the inode, then
> @@ -536,7 +539,8 @@ static int fuse_fsync(struct file *file, loff_t start=
, loff_t end,
>         if (err)
>                 goto out;
>
> -       fuse_sync_writes(inode);
> +       if (need_sync_writes)
> +               fuse_sync_writes(inode);
>
>         /*
>          * Due to implementation of fuse writeback
> @@ -560,7 +564,8 @@ static int fuse_fsync(struct file *file, loff_t start=
, loff_t end,
>                 err =3D 0;
>         }
>  out:
> -       inode_unlock(inode);
> +       if (need_sync_writes)
> +               inode_unlock(inode);
>
>         return err;
>  }
> @@ -1942,6 +1947,9 @@ static struct fuse_file *__fuse_write_file_get(stru=
ct fuse_inode *fi)
>  {
>         struct fuse_file *ff;
>
> +       if (fuse_inode_has_iomap(&fi->inode))
> +               return NULL;
> +
>         spin_lock(&fi->lock);
>         ff =3D list_first_entry_or_null(&fi->write_files, struct fuse_fil=
e,
>                                       write_entry);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9b9e7b2dd0d928..7602595006a19d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -191,7 +191,8 @@ static void fuse_evict_inode(struct inode *inode)
>                 if (inode->i_nlink > 0)
>                         atomic64_inc(&fc->evict_ctr);
>         }
> -       if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
> +       if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
> +           !fuse_inode_has_iomap(inode)) {
>                 WARN_ON(fi->iocachectr !=3D 0);
>                 WARN_ON(!list_empty(&fi->write_files));
>                 WARN_ON(!list_empty(&fi->queued_writes));
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index 3728933188f307..0a534e5a6db5f6 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode=
 *inode)
>          * io modes are not relevant with DAX and with server that does n=
ot
>          * implement open.
>          */
> -       if (FUSE_IS_DAX(inode) || !ff->args)
> +       if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->arg=
s)
>                 return 0;
>
>         /*
>
>

