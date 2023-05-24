Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B6870EF11
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjEXHKP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbjEXHJt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 03:09:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7219B2
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 00:08:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51408729f43so1324160a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684912054; x=1687504054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4naoP/v86EKmAo+u6ifRRW3QrLb6CXC2bVZOo7DIRg=;
        b=CfBlFjin9AiglVZYNj73FBrJiDD1bgOexikX1Ibnhzpuzz+5EcbqenYVDEno0ACDa2
         djfaNXoukq6AOI2QGVjbJUY4tHB5nQ6aQa9Gdah0n42uhwzekGmDHDHIYrNrS1Zi1uq7
         d0cnXvOfRcG2l6Z3wViMElw5AIOQmwbbeQ2o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684912054; x=1687504054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4naoP/v86EKmAo+u6ifRRW3QrLb6CXC2bVZOo7DIRg=;
        b=M4YEG/6nPA4F0RocLDrenO0JtM9punVYykwxqk7g1sKS9jmm1tRNYYiSGq/DS+rBWr
         YvKrMBV4XN3AdzzyWUNIaXmWDRf/OKzVBJPUYoVOmVwWNj53OTn+YltrLzrpoKYRJJ1z
         7dgHnpdZnTuZbhH62rQW8CighfvzvaEUQbD/O5G+ex70kgWKzQDCiGEsufIiSiHq4AQP
         W9ssmz5t/qa7Xa50VN0SMb09aNDFeFcAPhUoZStJ6CRT/NIo/Mgux+1xgIZn9kB+GtIS
         wGNj7xiBti8CUavZXnBhTXjhvHVd/sLqyLPW24JQFkKJpdW9EJRhHlDGxb7ErbE8XuNd
         yaNg==
X-Gm-Message-State: AC+VfDyOAfB4odlghrdI6mnTroU3EBt99Kz0lBzTUbK96pazTfFftOTu
        PsCASAkubDpZaVsYMRHNq+MT7JmBehAmsWo045gRqg==
X-Google-Smtp-Source: ACHHUZ5nu5V36cLreoQ/PYoDJkXFfcE1oq2Gs17vr1i/RZvs/lgKVxpySwPaw/RHPAbV3ltDCF676sVzrLwNPZ6r1Lg=
X-Received: by 2002:a05:6402:2792:b0:50d:83d4:6174 with SMTP id
 b18-20020a056402279200b0050d83d46174mr1222660ede.12.1684912053956; Wed, 24
 May 2023 00:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230524063810.1595778-1-hch@lst.de> <20230524063810.1595778-11-hch@lst.de>
In-Reply-To: <20230524063810.1595778-11-hch@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 May 2023 09:07:22 +0200
Message-ID: <CAJfpeguxVXm2pDeNk9M_S_0+ing1dFstaCfB30WcTRCjwwsJvg@mail.gmail.com>
Subject: Re: [PATCH 10/11] fuse: update ki_pos in fuse_perform_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 24 May 2023 at 08:38, Christoph Hellwig <hch@lst.de> wrote:
>
> Both callers of fuse_perform_write need to updated ki_pos, move it into
> common code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  fs/fuse/file.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 97d435874b14aa..90d587a7bdf813 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1329,7 +1329,10 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
>         fuse_write_update_attr(inode, pos, res);
>         clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
>
> -       return res > 0 ? res : err;
> +       if (!res)
> +               return err;
> +       iocb->ki_pos += res;
> +       return res;
>  }
>
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
> @@ -1375,41 +1378,35 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                 goto out;
>
>         if (iocb->ki_flags & IOCB_DIRECT) {
> -               loff_t pos = iocb->ki_pos;
>                 written = generic_file_direct_write(iocb, from);
>                 if (written < 0 || !iov_iter_count(from))
>                         goto out;
>
> -               pos += written;
> -
> -               written_buffered = fuse_perform_write(iocb, mapping, from, pos);
> +               written_buffered = fuse_perform_write(iocb, mapping, from,
> +                                                     iocb->ki_pos);
>                 if (written_buffered < 0) {
>                         err = written_buffered;
>                         goto out;
>                 }
> -               endbyte = pos + written_buffered - 1;
> +               endbyte = iocb->ki_pos + written_buffered - 1;

Wrong endpos.

>
> -               err = filemap_write_and_wait_range(file->f_mapping, pos,
> +               err = filemap_write_and_wait_range(file->f_mapping,
> +                                                  iocb->ki_pos,

Wrong startpos.

>                                                    endbyte);
>                 if (err)
>                         goto out;
>
>                 invalidate_mapping_pages(file->f_mapping,
> -                                        pos >> PAGE_SHIFT,
> +                                        iocb->ki_pos >> PAGE_SHIFT,

Same here.

>                                          endbyte >> PAGE_SHIFT);
>
>                 written += written_buffered;
> -               iocb->ki_pos = pos + written_buffered;
> +               iocb->ki_pos += written_buffered;

Already added in fuse_perform_write().

>         } else {
>                 written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
> -               if (written >= 0)
> -                       iocb->ki_pos += written;
>         }
>  out:
>         inode_unlock(inode);
> -       if (written > 0)
> -               written = generic_write_sync(iocb, written);
> -
>         return written ? written : err;
>  }
>
> --
> 2.39.2
>
