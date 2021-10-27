Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546EA43D72E
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhJ0XJp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 19:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJ0XJo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 19:09:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EEC0613B9
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id in13so874591pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
        b=d6phRBLSNqEavLbFGa7qsltfCwCXOIkQGNewJdYfiMwINhHDbJ+v3Tvr+m7SXCKglh
         f1Y9JyoYsY7pru2o0qaf9ZrRobsN47Jue96kM8PwOADE6VAIkbXtDJTZy+mzrce1H5ii
         TDWfFC/E9fe8cXOG72hb4HndsLJ5qovtA1WXr8x1UXXNXsg6OU7/y9sWKZsB9Ro8FzaF
         3kotXlCmovzhrPQGnkvqh1aQ4+kBEwqSKMSlKnEz5Ahj4QsLMDMTI4jX5+IsmEJsZDOu
         D4ACx/M3ONMf14xOrt8n/jVyvHMKdyB04vPcp4aB9RBAawLg1e2wm7UXNUEREJEycjA9
         pSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
        b=SCuw1BU2Jatxev/puwnYGa3MRx0Et8ng9nVHVFc0yz2hevzXWBfclkplBePF2n16YJ
         7WWsVUCDgtKSPA+Q2eOa/7KCGiOi/GITveAj4rRL0E3NZiAwIPWSPgQUF0I+kibUrI5R
         UlhPwtzkS7v5qM8JAuzJKrtlg/0tfmGAouXhYRg5Ou8ldxreGHwjcb5+XP1YYmRZHFrn
         d9TMgMjVqYYYo2xl7irexrVHoIYpU/N/Bx2LfU26PtMkJ9Qd/8sXI1+2fAPR6bAiKUmM
         tb1sHvXu1xoBNxVL0KfgFhYdC6YLfjvBM8cssl08jKGcvovGPYKBYjpNl24qf2FZh5rW
         OVqA==
X-Gm-Message-State: AOAM531bgeK1KDIGxDR70zwHk3/iXNw7sCD6ErObjv/pugr2T5jIIbx2
        GLDc0XMwMKkW8i4HUi+gX1rDsn9piLZoD18v8kyAcg==
X-Google-Smtp-Source: ABdhPJxTOfk9fcqxHjqgG3f1vnNsNPlrTHxqnz6/LIE7U1wpYxfkWo7JAy9TqN/B72HDrJA9DjHrJAEIhgWs2Md2+FA=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr618659pjb.220.1635376038542;
 Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-6-hch@lst.de>
In-Reply-To: <20211018044054.1779424-6-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 16:07:07 -0700
Message-ID: <CAPcyv4iqkLQWEyqRYZPaBmA=bXyJy5DR699ch+wfBanY-MKu9g@mail.gmail.com>
Subject: Re: [PATCH 05/11] dax: move the partition alignment check into fs_dax_get_by_bdev
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.

Looks good.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 04fc680542e8d..482fe775324a4 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -93,6 +93,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>         if (!blk_queue_dax(bdev->bd_disk->queue))
>                 return NULL;
>
> +       if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> +           (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> +               return NULL;
> +       }
> +
>         id = dax_read_lock();
>         dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
>         if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> @@ -107,10 +113,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 struct block_device *bdev, int blocksize, sector_t start,
>                 sector_t sectors)
>  {
> -       pgoff_t pgoff, pgoff_end;
> -       sector_t last_page;
> -       int err;
> -
>         if (blocksize != PAGE_SIZE) {
>                 pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
>                 return false;
> @@ -121,19 +123,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 return false;
>         }
>
> -       err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
> -       last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
> -       err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> --
> 2.30.2
>
