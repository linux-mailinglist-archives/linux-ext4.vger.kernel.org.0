Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D212D599
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 02:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfLaBtc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 20:49:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfLaBtc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 20:49:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so34118350wro.2
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2019 17:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07AuPXVLJFhJzylfeDo0+cRXVqZPZhtDlZAW2k47QCE=;
        b=QaRNBM8jiz0LI2btcMJaQadYiO9gLfBugWMqhb8zzcZJCxqqewl/mWqgJggobo2XBS
         Pzz6171QSFFmYkS/l+sHIfusTQGWNxRuO6ko3+9MM7DysczSTvDJ3E0gKs4ckfsglMKU
         QAjKvAmAE3sypP96FDPdO7jcwmJmEthenqNypFmEGzMCqvJEyZ5epy96rpxM4jgWOt7N
         0vZjsnuHVFFCPbZDSC/7m10xxrbjnCLwI+9icz6VibRrSWEvn2EL4bor65vZhw96NZXa
         oOc43k+JScDuV0gX5OeWnCb6E0fZ9c0djMpBr7OFz6YPfPQRYVq7xTKDdTTh4/7XA1aT
         NhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07AuPXVLJFhJzylfeDo0+cRXVqZPZhtDlZAW2k47QCE=;
        b=KIO7FLriiNB8LXxBLZIX2oMHzRmpFLlZRFtKufBROoYYWDKQeqqI7BQ7dl+OHyWcaC
         zfVy1TqiX3JEfctqV+EzagUKkZEJJSjEWMTAPKfpTwcWUC1Kpgg5QTrhTMOhh+c4/LX2
         CqiZJfuMgdoVP52kw8oQOQYDtG0BZ+nYRx/Y35bX0TvfkeJcyTPNzXaNJIKtEuAGgASn
         FSxf2XOaevVO9gnkhl0Qzdv9VuvnJ1nU6IyzWd4a+4Vs9jYtrrLF7vzbeBowdrEPI7VT
         j4thusPYBqfdDoe7nD+82rgKxedeQ6PrTAj2l7fsCjlWKl3QFdhWZEnf89rL6bFFDwMg
         DoEQ==
X-Gm-Message-State: APjAAAUEwmzBWQghL9ThSYtHMplKhlUNXLZ9gkMNkFBtTZS8wyLt3ecZ
        +0/StbntK03Cl9512/b+kd3urwmNXwXPgr9/Qmw=
X-Google-Smtp-Source: APXvYqzkRPW34ly1IYbDqUs8P7I5wTxy/tq73+kssL4OhWZfxTQTu9cx2BmK1ZUL/NIan0eFbcmrFwJZZ64Y9Oq/0F4=
X-Received: by 2002:a5d:480f:: with SMTP id l15mr69734672wrq.305.1577756969493;
 Mon, 30 Dec 2019 17:49:29 -0800 (PST)
MIME-Version: 1.0
References: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
 <20191230151921.GA125106@mit.edu> <37689479-8118-4ED1-A98C-4A3E982B4575@dilger.ca>
 <20191230195218.GC125106@mit.edu>
In-Reply-To: <20191230195218.GC125106@mit.edu>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Tue, 31 Dec 2019 09:49:08 +0800
Message-ID: <CAP9B-Q=82R8p41AdEjV1Pq3d83pM4_SGdW_U2qm5cg9Z8Zus3w@mail.gmail.com>
Subject: Re: [PATCH] e2fsprogs: fix to use inode i_blocks correctly
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, dongyangli@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 31, 2019 at 3:52 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Dec 30, 2019 at 11:37:40AM -0700, Andreas Dilger wrote:
> >
> > No patch is attached?
>
> Oops, here you go.
>
>                                 - Ted
>
> commit c90cea86eeef89f29f7bd5535fbaa5809a812cc7
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Mon Dec 30 10:12:58 2019 -0500
>
>     ext2fs: add ext2fs_get_stat_i_blocks() function
>
>     The function ext2fs_inode_i_blocks() is a bit confusing whether it is
>     returning the inode's i_blocks value, or whether it is returning the
>     value ala the stat(2) system call, which returns i_blocks in units of
>     512 byte sectors.  This caused ext2fs_inode_i_blocks() to be
>     incorrectly used in fuse2fs and the function quota_compute_usage().
>
>     To address this, we add a new function, ext2fs_get_stat_i_blocks()
>     which is clearly labelled what it is returning, and use it in fuse2fs
>     and quota_compute_usage().  It's also a bit more convenient to use it
>     in e2fsck, so use it there too.
>
>     Reported-by: Wang Shilong <wangshilong1991@gmail.com>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Wang Shilong <wangshilong1991@gmail.com>

Thanks!
Shilong

>
> diff --git a/e2fsck/extents.c b/e2fsck/extents.c
> index 3073725a..e9af1bbe 100644
> --- a/e2fsck/extents.c
> +++ b/e2fsck/extents.c
> @@ -264,7 +264,7 @@ extents_loaded:
>                 goto err;
>
>         ext_written = 0;
> -       start_val = ext2fs_inode_i_blocks(ctx->fs, EXT2_INODE(&inode));
> +       start_val = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode));
>         for (i = 0, ex = list->extents; i < list->count; i++, ex++) {
>                 memcpy(&extent, ex, sizeof(struct ext2fs_extent));
>                 extent.e_flags &= EXT2_EXTENT_FLAGS_UNINIT;
> @@ -302,15 +302,10 @@ extents_loaded:
>                 ext_written++;
>         }
>
> -       delta = ext2fs_inode_i_blocks(ctx->fs, EXT2_INODE(&inode)) - start_val;
> -       if (delta) {
> -               if (!ext2fs_has_feature_huge_file(ctx->fs->super) ||
> -                   !(inode.i_flags & EXT4_HUGE_FILE_FL))
> -                       delta <<= 9;
> -               else
> -                       delta *= ctx->fs->blocksize;
> -               quota_data_add(ctx->qctx, &inode, ino, delta);
> -       }
> +       delta = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode)) -
> +               start_val;
> +       if (delta)
> +               quota_data_add(ctx->qctx, &inode, ino, delta << 9);
>
>  #if defined(DEBUG) || defined(DEBUG_SUMMARY)
>         printf("rebuild: ino=%d extents=%d->%d\n", ino, list->ext_read,
> diff --git a/lib/ext2fs/blknum.c b/lib/ext2fs/blknum.c
> index 9ee5c66e..31055c34 100644
> --- a/lib/ext2fs/blknum.c
> +++ b/lib/ext2fs/blknum.c
> @@ -85,6 +85,22 @@ blk64_t ext2fs_inode_i_blocks(ext2_filsys fs,
>                  (__u64)inode->osd2.linux2.l_i_blocks_hi << 32 : 0));
>  }
>
> +/*
> + * Return the inode i_blocks in stat (512 byte) units
> + */
> +blk64_t ext2fs_get_stat_i_blocks(ext2_filsys fs,
> +                                struct ext2_inode *inode)
> +{
> +       blk64_t ret = inode->i_blocks;
> +
> +       if (ext2fs_has_feature_huge_file(fs->super)) {
> +               ret += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
> +               if (inode->i_flags & EXT4_HUGE_FILE_FL)
> +                       ret *= (fs->blocksize / 512);
> +       }
> +       return ret;
> +}
> +
>  /*
>   * Return the fs block count
>   */
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 59fd9742..ca5e3321 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -908,7 +908,9 @@ extern int ext2fs_group_blocks_count(ext2_filsys fs, dgrp_t group);
>  extern blk64_t ext2fs_inode_data_blocks2(ext2_filsys fs,
>                                          struct ext2_inode *inode);
>  extern blk64_t ext2fs_inode_i_blocks(ext2_filsys fs,
> -                                        struct ext2_inode *inode);
> +                                    struct ext2_inode *inode);
> +extern blk64_t ext2fs_get_stat_i_blocks(ext2_filsys fs,
> +                                       struct ext2_inode *inode);
>  extern blk64_t ext2fs_blocks_count(struct ext2_super_block *super);
>  extern void ext2fs_blocks_count_set(struct ext2_super_block *super,
>                                     blk64_t blk);
> diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
> index ddb53124..6f7ae6d6 100644
> --- a/lib/support/mkquota.c
> +++ b/lib/support/mkquota.c
> @@ -503,8 +503,8 @@ errcode_t quota_compute_usage(quota_ctx_t qctx)
>                 if (inode->i_links_count &&
>                     (ino == EXT2_ROOT_INO ||
>                      ino >= EXT2_FIRST_INODE(fs->super))) {
> -                       space = ext2fs_inode_i_blocks(fs,
> -                                                     EXT2_INODE(inode)) << 9;
> +                       space = ext2fs_get_stat_i_blocks(fs,
> +                                               EXT2_INODE(inode)) << 9;
>                         quota_data_add(qctx, inode, ino, space);
>                         quota_data_inodes(qctx, inode, ino, +1);
>                 }
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 94cd5f67..2cfc6af3 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -754,23 +754,6 @@ static void *op_init(struct fuse_conn_info *conn)
>         return ff;
>  }
>
> -static blkcnt_t blocks_from_inode(ext2_filsys fs,
> -                                 struct ext2_inode_large *inode)
> -{
> -       blkcnt_t b;
> -
> -       b = inode->i_blocks;
> -       if (ext2fs_has_feature_huge_file(fs->super))
> -               b += ((long long) inode->osd2.linux2.l_i_blocks_hi) << 32;
> -
> -       if (!ext2fs_has_feature_huge_file(fs->super) ||
> -           !(inode->i_flags & EXT4_HUGE_FILE_FL))
> -               b *= fs->blocksize / 512;
> -       b *= EXT2FS_CLUSTER_RATIO(fs);
> -
> -       return b;
> -}
> -
>  static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
>  {
>         struct ext2_inode_large inode;
> @@ -794,7 +777,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
>         statbuf->st_gid = inode_gid(inode);
>         statbuf->st_size = EXT2_I_SIZE(&inode);
>         statbuf->st_blksize = fs->blocksize;
> -       statbuf->st_blocks = blocks_from_inode(fs, &inode);
> +       statbuf->st_blocks = ext2fs_get_stat_i_blocks(fs, &inode);
>         EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
>         statbuf->st_atime = tv.tv_sec;
>         EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
