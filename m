Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D643D8CF
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 03:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhJ1Bqn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Bqn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 21:46:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F4C061570
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 18:44:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y1-20020a17090a134100b001a27a7e9c8dso6270860pjf.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
        b=NwrWjK1zEgkC/h0OltkWmV8v6U9kycWNkAzFyZ2UqlXn15yubZLd83LVcZWNlLL1f0
         Fv5BW1FJAtxuVzU9kXByXaxfMtmiH5UDaukXhF9R+cJyfOGMfQT6zf04USpHM9TDLMLF
         8zm7+00diA9rU2lDu/DTfvUOEu2zCMioGVYImhjXSkJTydRCIKV9cRbUQapJjcrGiqMK
         QnZf8nIfPhTNHOoqGDCmmZuYu6PaW3nbxj784zhi1I6uIMMPp2z6oTqTZJk+LfG12Qzb
         jA/Y5wJffgH2J2qLufj0bLW03BgfGI/buoZEjp4mtmSwLrMRhWqThDSfNCSg+TsSc0DH
         V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
        b=6KUjoEQOHynmEtGvYz29qsGo6SHnwSpQd8n4F9qSOT2MT2kvWug3ztG8SzbWuOUKtT
         PSHodCncrW2GFnmVQrUur6x/AoXA3l5dZ2O/IsQqeYFGdEfu2jOGvabPGOmtmvPRR0Hv
         TB2+Bsj2C1YcCCf8PSQ8ingijViJsnj9Kaqrsyij6hgs02lBtYU8jqGt66S9P7T8jZJg
         Adz4lH3ZR+rh6rWFaICkRl29xCy1fKKmdCsXFuFeAlk3zJTXm/m7o+Vix34jv7F+KPnB
         M0m80QDeWlLoUjtstiEYGpHH0KWFQBw0mey5QzLe5s3uNC8XO1hQN7/UReo5nfQM4ZRs
         Fu2Q==
X-Gm-Message-State: AOAM5321iP++RDqCgiBKYkzz9VegD9v/Ai9AQ+wM9TNlTKjUjEjdYdLx
        S3g7ztR86IzwlD4j5VNidD9B8Lyu6OlTyIxxVlMJiQ==
X-Google-Smtp-Source: ABdhPJyk8c8xZHfkX0RONmluScnz61A4HGhWerdM4JYgASaD4FzedQ2nCFUwr5W/5xCzT57VlrSOf0tWDKABqHHbWT8=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr1240292plo.4.1635385456643; Wed, 27 Oct
 2021 18:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-12-hch@lst.de>
In-Reply-To: <20211018044054.1779424-12-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 18:44:04 -0700
Message-ID: <CAPcyv4ht6fZOdx4YN9FRCnmD2Wy4zzG7nJPQSdSPAgvZNHxoFw@mail.gmail.com>
Subject: Re: [PATCH 11/11] dax: move bdev_dax_pgoff to fs/dax.c
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
> No functional changet, but this will allow for a tighter integration

s/changet/changes/

> with the iomap code, including possible passing the partition offset

s/possible/possibly/

> in the iomap in the future.  For now it mostly avoids growing more

s/now/now,/

...all of the above fixed up locally.

Other than that, it looks good to me.

> callers outside of fs/dax.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 14 --------------
>  fs/dax.c            | 13 +++++++++++++
>  include/linux/dax.h |  1 -
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 803942586d1b6..c0910687fbcb2 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -67,20 +67,6 @@ void dax_remove_host(struct gendisk *disk)
>  }
>  EXPORT_SYMBOL_GPL(dax_remove_host);
>
> -int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> -               pgoff_t *pgoff)
> -{
> -       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> -       phys_addr_t phys_off = (start_sect + sector) * 512;
> -
> -       if (pgoff)
> -               *pgoff = PHYS_PFN(phys_off);
> -       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> -               return -EINVAL;
> -       return 0;
> -}
> -EXPORT_SYMBOL(bdev_dax_pgoff);
> -
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a916..eb715363fd667 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,6 +709,19 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> +static int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> +               pgoff_t *pgoff)
> +{
> +       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> +       phys_addr_t phys_off = (start_sect + sector) * 512;
> +
> +       if (pgoff)
> +               *pgoff = PHYS_PFN(phys_off);
> +       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +               return -EINVAL;
> +       return 0;
> +}
> +
>  static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
>                              sector_t sector, struct page *to, unsigned long vaddr)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 439c3c70e347b..324363b798ecd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -107,7 +107,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>
>  struct writeback_control;
> -int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
>  #if IS_ENABLED(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> --
> 2.30.2
>
