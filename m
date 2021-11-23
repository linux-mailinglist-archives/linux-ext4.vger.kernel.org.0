Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE445AC93
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhKWTjF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhKWTjD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 14:39:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738EC061746
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 11:35:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c4so312169pfj.2
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gWZdeoaC7jqVM8zeJ3InHmY5XgJ6AqsmAXMbMD6MVc=;
        b=RJbNLKJNENQkqCXxCv3ZqjAgJzmntRoY3C9WBVTRGPV4VV3BsA76Ni4hsnMjx2nH/v
         HoiW9wDtjxXp5Nt6qMkQL0DPLfSBqYL70YxFRSH4TO9PJ9rbhGeY0C9ffVxxiP3dggG6
         ohinBGy+D49Vm9oB3XNJcjF56eTmII8MaKy/6svWS/35apN6jxq7L2Jsl7ZSria5TcBs
         sLOxMGIhfsaMyGw+N0BmXXRNkuqqf4hp2KFJVKWMR0zMfA+xCeAOOLZYbsOOHncwIK6l
         JAuPbkyAWXwtk4Cvm6LivVMjAyUckXc1oEC/hdIwN1ZU2iT426Roiy5HqofbB7cbAMCs
         R42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gWZdeoaC7jqVM8zeJ3InHmY5XgJ6AqsmAXMbMD6MVc=;
        b=Z4H6IMRQsMxRjSa5DmlRI839eaBazyVCIJS9PuSXfaIVSz4Lzxf/qoULN3vfNtJCFP
         VPEaPyQPKxfQA9GciFbBaKL5DtCw8NveSS+F3aJWe6hjiA4kWr5wAPPnDAxLTo5Jhr2n
         gYKeYXy11CA8USluO++Gbf8DKY0VinhWeCgHSCemM9yd69H3lViOmA9mkjIOXFEhzzVg
         0lKkbZpRfTkueO2QR32cWqEF+136NPEsNXcGBiNYiCMmbiTxhSPO+j97wqgJlLjGBTMc
         zHrH4YNsTX/A9E54nDc/ueWOFscIayfhjBrRpVuvaWv/MkQVaMXL2N6MaUPHiDqaR7OE
         y2sw==
X-Gm-Message-State: AOAM531z5JmPeuaB/9lYfZnFuS22CbbKK272vXwFGqRcFlN76XRobhpE
        bMIR79eoVdFOHOgBp7YTofTD3yCLMnIuzq0GnVTzyg==
X-Google-Smtp-Source: ABdhPJyUgiLjRKYUsHsrV83l3gO1RrPxkMBAXyAi/veRroUOh2xEn4EazOAyxkpoKqaxXeG2LfQdh/0f6yLjguWrfLs=
X-Received: by 2002:a63:5401:: with SMTP id i1mr5642151pgb.356.1637696154262;
 Tue, 23 Nov 2021 11:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-14-hch@lst.de>
In-Reply-To: <20211109083309.584081-14-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 11:35:43 -0800
Message-ID: <CAPcyv4i=PnXu6ixHtj4Bqi0gy=bJJijrWgTNEcQ6uEJiut4PfQ@mail.gmail.com>
Subject: Re: [PATCH 13/29] fsdax: use a saner calling convention for copy_cow_page_dax
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just pass the vm_fault and iomap_iter structures, and figure out the rest
> locally.  Note that this requires moving dax_iomap_sector up in the file.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 73bd1439d8089..e51b4129d1b65 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,26 +709,31 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> -static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
> -                            sector_t sector, struct page *to, unsigned long vaddr)
> +static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
> +       return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> +}
> +
> +static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
> +{
> +       sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
>         void *vto, *kaddr;
>         pgoff_t pgoff;
>         long rc;
>         int id;
>
> -       rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> +       rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
>         if (rc)
>                 return rc;
>
>         id = dax_read_lock();
> -       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
>         if (rc < 0) {
>                 dax_read_unlock(id);
>                 return rc;
>         }
> -       vto = kmap_atomic(to);
> -       copy_user_page(vto, kaddr, vaddr, to);
> +       vto = kmap_atomic(vmf->cow_page);
> +       copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
>         kunmap_atomic(vto);
>         dax_read_unlock(id);
>         return 0;
> @@ -1005,11 +1010,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
>
> -static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
> -{
> -       return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> -}
> -
>  static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>                          pfn_t *pfnp)
>  {
> @@ -1332,19 +1332,16 @@ static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
>  static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
>                 const struct iomap_iter *iter)
>  {
> -       sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
> -       unsigned long vaddr = vmf->address;
>         vm_fault_t ret;
>         int error = 0;
>
>         switch (iter->iomap.type) {
>         case IOMAP_HOLE:
>         case IOMAP_UNWRITTEN:
> -               clear_user_highpage(vmf->cow_page, vaddr);
> +               clear_user_highpage(vmf->cow_page, vmf->address);
>                 break;
>         case IOMAP_MAPPED:
> -               error = copy_cow_page_dax(iter->iomap.bdev, iter->iomap.dax_dev,
> -                                         sector, vmf->cow_page, vaddr);
> +               error = copy_cow_page_dax(vmf, iter);
>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> --
> 2.30.2
>
