Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6367E5AD487
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiIEOKT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Sep 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiIEOKS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Sep 2022 10:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB0275DE
        for <linux-ext4@vger.kernel.org>; Mon,  5 Sep 2022 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662387015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aM9Hz/CxTU/5IZIiOb0wSytjLDU1CYz4f/uZlzEYfY=;
        b=WXhE9tE+lWskXL7dnxRIFOx82M1hrtyWC1zMSjoHGv+JpsLFoAduU4XWYEOByeCoMYIC7/
        7XBDNz8gfqUeOXwJPLKEcM3HTA63IHoRDKgCWlxianshklmZW4oqlVRJIhc2w4xvaOWG/v
        scfBuFAyCrPa1mN5TgQrb6ClPeB9J3U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-GFF7GfVfNfSIBYeZsCAw-w-1; Mon, 05 Sep 2022 10:10:14 -0400
X-MC-Unique: GFF7GfVfNfSIBYeZsCAw-w-1
Received: by mail-pf1-f199.google.com with SMTP id 200-20020a6217d1000000b00538090d37f3so4277906pfx.3
        for <linux-ext4@vger.kernel.org>; Mon, 05 Sep 2022 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/aM9Hz/CxTU/5IZIiOb0wSytjLDU1CYz4f/uZlzEYfY=;
        b=hwK+Sa2MkClXF5lJf2RIxuqyEJmptdKWQWmFXuqFgzoBt8TjV8Ok8oRaXuBer0we1j
         8MdO0pX0G5t1AO1uWUZsdxE2mlOAEON6HCxsiaqoSC3tm+ZEBJ+vxWv4QSflW2mTvf0e
         wCDhiDL7dyjgQXN1q8yT1VW5qQKr87C5aFBTwYElk/fDulZWIwlfj3EPZvJ4PWKW7+iO
         lPFTKdTKH8hi/Fy+Ai2CCIZLT7QpFz/qo9v1AMSvdBQqQZffndqdAroR97t19COLs5MH
         cZZKnTdz5hCUPamcHY+VXePAU3H5DBEWsPfd8wZmuPyD4ltQNMO5S8CoLETejtuuAV0G
         iXEw==
X-Gm-Message-State: ACgBeo3v3FmFem2cDYJtTudFButLOvRnzBl0aEtw6N8J32BnIXBuFh+a
        nk/yBSKZObJakcW5EAr0HEfLyr9zkjV2etioxl4vbH9hribZ5alSODTbI0wbid/2BhTgsY0Bm5m
        K7YSKARoQqx/x8KLs8Dd3HdWZqzPStEAX1f8akw==
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id be9-20020a656e49000000b00429cae6aac6mr41418480pgb.268.1662387013097;
        Mon, 05 Sep 2022 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Mbj0cnXfyvltZuZyI75OnAiCy5kv581MclsxMj6AKJtQBQIL0bE5MAfuVXEL2TcdEimwBiyT3tt6LHh8ASBA=
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id
 be9-20020a656e49000000b00429cae6aac6mr41418453pgb.268.1662387012811; Mon, 05
 Sep 2022 07:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220901133505.2510834-1-yi.zhang@huawei.com> <20220901133505.2510834-5-yi.zhang@huawei.com>
In-Reply-To: <20220901133505.2510834-5-yi.zhang@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Sep 2022 16:10:01 +0200
Message-ID: <CAHc6FU4XqSxUr3CS8zxu=Fh_kHytJbzezim0ie_cxdioW5R=FA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] gfs2: replace ll_rw_block()
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 1, 2022 at 3:24 PM Zhang Yi <yi.zhang@huawei.com> wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that always submitting read IO if the buffer has been locked,
> so stop using it. We also switch to new bh_readahead() helper for the
> readahead path.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/gfs2/meta_io.c | 7 ++-----
>  fs/gfs2/quota.c   | 8 ++------
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 7e70e0ba5a6c..6ed728aae9a5 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -525,8 +525,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>
>         if (buffer_uptodate(first_bh))
>                 goto out;
> -       if (!buffer_locked(first_bh))
> -               ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &first_bh);
> +       bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
>
>         dblock++;
>         extlen--;
> @@ -534,9 +533,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>         while (extlen) {
>                 bh = gfs2_getbuf(gl, dblock, CREATE);
>
> -               if (!buffer_uptodate(bh) && !buffer_locked(bh))
> -                       ll_rw_block(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -                                   REQ_PRIO, 1, &bh);
> +               bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
>                 brelse(bh);
>                 dblock++;
>                 extlen--;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index f201eaf59d0d..1ed17226d9ed 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -745,12 +745,8 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
>                 }
>                 if (PageUptodate(page))
>                         set_buffer_uptodate(bh);
> -               if (!buffer_uptodate(bh)) {
> -                       ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &bh);
> -                       wait_on_buffer(bh);
> -                       if (!buffer_uptodate(bh))
> -                               goto unlock_out;
> -               }
> +               if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
> +                       goto unlock_out;
>                 if (gfs2_is_jdata(ip))
>                         gfs2_trans_add_data(ip->i_gl, bh);
>                 else
> --
> 2.31.1
>

Thanks for this fix; looking good.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas

