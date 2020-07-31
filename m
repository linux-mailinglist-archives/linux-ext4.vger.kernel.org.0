Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7515F234749
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgGaODb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 10:03:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731597AbgGaODb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 31 Jul 2020 10:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596204209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cps8/F9QZ13raGQ0LNt7ieXiXD83betUld/eJQwHa/g=;
        b=MuGyMDnrHVr7ccFELYgbJfhTsgoAu+nJCcJJYmqMrGqiI81D1DhahczFmFCUlcbUpssWLr
        RiDJ3YDrMq0J5yb0040aFtxQ8rDeGgCsy8G+OHwFZr87NImnYapycVEJT4kPxQyMbIknHB
        V0cVgiwm+/sFOriKJLOox8BXpUmHSMc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-1cIZ4dShMq-Roo14q3ueDQ-1; Fri, 31 Jul 2020 10:03:27 -0400
X-MC-Unique: 1cIZ4dShMq-Roo14q3ueDQ-1
Received: by mail-oo1-f69.google.com with SMTP id a5so885458ooj.6
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jul 2020 07:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cps8/F9QZ13raGQ0LNt7ieXiXD83betUld/eJQwHa/g=;
        b=HzpnkLCuBssJ80CaRMpwkUfJKyLnMp3Ac/iEC6hMWdV6SBABliAsVOLmRSE9c37d4y
         fE9G45oSfHYHFFvlB67aurFVupcqqrq8v68lwO5dCQB7M1+Tav0cXAKzedbDpP4NpJ2F
         paWONXbeiv6J67/JoeL1upFuxpAc29LCrxMsoJirJUUEJ76cHqSkDFevvqZy0pEWurU6
         cUJsqYuJJA4abRVgPOczVmomWP2lEoprlR3VdFXrhqoc0PpqbqHNaFICyj6l2JaKmm7q
         x8Tjbfgq/GLwNF0oLonS0XTsRocuWVije03qlMYDlhbETr337Dresvez7Ww4D7rvOqlh
         9RiA==
X-Gm-Message-State: AOAM532JA09aYSpncG6y15gSzWAUU4Boa65uWP/gtzgcuzXdYlLrB66f
        Lh1x77vRaW1/7s02PW3VZRPrAuIOwJH9RS8jDI13+phAHnELaComLJpoDck55kJTeyCIZVqYdu6
        vy3WAElIt4UnIpN7GlYtmqivUaJKf2GX6vZ+PvA==
X-Received: by 2002:aca:5cc5:: with SMTP id q188mr2875438oib.10.1596204205912;
        Fri, 31 Jul 2020 07:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2o1MCathljqcbxdIfvbrQ4AoMpjkC6t7vNA2UlmPa6Y8MaoCbcKN4WLZ9gni27APqI9VwD7WX0IkKlBrdOtU=
X-Received: by 2002:aca:5cc5:: with SMTP id q188mr2875387oib.10.1596204205391;
 Fri, 31 Jul 2020 07:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200721183157.202276-1-hch@lst.de> <20200721183157.202276-4-hch@lst.de>
In-Reply-To: <20200721183157.202276-4-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 31 Jul 2020 16:03:13 +0200
Message-ID: <CAHc6FU4KpmW71xA1iX3rPp0evEPoYN3gjcSHt4de+K3R1ZKgEQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 3/3] iomap: fall back to buffered writes
 for invalidation failures
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 21, 2020 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> Failing to invalid the page cache means data in incoherent, which is
> a very bad state for the system.  Always fall back to buffered I/O
> through the page cache if we can't invalidate mappings.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/ext4/file.c       |  2 ++
>  fs/gfs2/file.c       |  3 ++-
>  fs/iomap/direct-io.c | 16 +++++++++++-----
>  fs/iomap/trace.h     |  1 +
>  fs/xfs/xfs_file.c    |  4 ++--
>  fs/zonefs/super.c    |  7 +++++--
>  6 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c4c..129cc1dd6b7952 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -544,6 +544,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                 iomap_ops = &ext4_iomap_overwrite_ops;
>         ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>                            is_sync_kiocb(iocb) || unaligned_io || extend);
> +       if (ret == -ENOTBLK)
> +               ret = 0;
>
>         if (extend)
>                 ret = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bebde537ac8cf2..b085a3bea4f0fd 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -835,7 +835,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>
>         ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
>                            is_sync_kiocb(iocb));
> -
> +       if (ret == -ENOTBLK)
> +               ret = 0;
>  out:
>         gfs2_glock_dq(&gh);
>  out_uninit:
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 190967e87b69e4..c1aafb2ab99072 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -10,6 +10,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include "trace.h"
>
>  #include "../internal.h"
>
> @@ -401,6 +402,9 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   * can be mapped into multiple disjoint IOs and only a subset of the IOs issued
>   * may be pure data writes. In that case, we still need to do a full data sync
>   * completion.
> + *
> + * Returns -ENOTBLK In case of a page invalidation invalidation failure for
> + * writes.  The callers needs to fall back to buffered I/O in this case.
>   */
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> @@ -478,13 +482,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>         if (iov_iter_rw(iter) == WRITE) {
>                 /*
>                  * Try to invalidate cache pages for the range we are writing.
> -                * If this invalidation fails, tough, the write will still work,
> -                * but racing two incompatible write paths is a pretty crazy
> -                * thing to do, so we don't support it 100%.
> +                * If this invalidation fails, let the caller fall back to
> +                * buffered I/O.
>                  */
>                 if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> -                               end >> PAGE_SHIFT))
> -                       dio_warn_stale_pagecache(iocb->ki_filp);
> +                               end >> PAGE_SHIFT)) {
> +                       trace_iomap_dio_invalidate_fail(inode, pos, count);
> +                       ret = -ENOTBLK;
> +                       goto out_free_dio;
> +               }
>
>                 if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
>                         ret = sb_init_dio_done_wq(inode->i_sb);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 5693a39d52fb63..fdc7ae388476f5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -74,6 +74,7 @@ DEFINE_EVENT(iomap_range_class, name, \
>  DEFINE_RANGE_EVENT(iomap_writepage);
>  DEFINE_RANGE_EVENT(iomap_releasepage);
>  DEFINE_RANGE_EVENT(iomap_invalidatepage);
> +DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
>
>  #define IOMAP_TYPE_STRINGS \
>         { IOMAP_HOLE,           "HOLE" }, \
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a6ef90457abf97..1b4517fc55f1b9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -553,8 +553,8 @@ xfs_file_dio_aio_write(
>         xfs_iunlock(ip, iolock);
>
>         /*
> -        * No fallback to buffered IO on errors for XFS, direct IO will either
> -        * complete fully or fail.
> +        * No fallback to buffered IO after short writes for XFS, direct I/O
> +        * will either complete fully or return an error.
>          */
>         ASSERT(ret < 0 || ret == count);
>         return ret;
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 07bc42d62673ce..d0a04528a7e18e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -786,8 +786,11 @@ static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (iocb->ki_pos >= ZONEFS_I(inode)->i_max_size)
>                 return -EFBIG;
>
> -       if (iocb->ki_flags & IOCB_DIRECT)
> -               return zonefs_file_dio_write(iocb, from);
> +       if (iocb->ki_flags & IOCB_DIRECT) {
> +               ssize_t ret = zonefs_file_dio_write(iocb, from);
> +               if (ret != -ENOTBLK)
> +                       return ret;
> +       }
>
>         return zonefs_file_buffered_write(iocb, from);
>  }
> --
> 2.27.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com> # for gfs2

Thanks,
Andreas

