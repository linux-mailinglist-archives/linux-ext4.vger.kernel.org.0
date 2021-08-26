Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FC3F8A4D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhHZOnM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbhHZOnI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 10:43:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A083C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 26 Aug 2021 07:42:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m17so1948517plc.6
        for <linux-ext4@vger.kernel.org>; Thu, 26 Aug 2021 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABTfU8gxdjv5n74FbYsyCDi8X7MNpO1jIxZ8zrk/JGc=;
        b=RnM+EalWmI3PqG7GROErhErzyPvDbZCl0KTyuEsZ8rvwaXbCmLGYFo0yra0yZXKsar
         gK732TMBNazrj5DR9ByMd3UdZOzjU1wCyhqFo++Dz5dnNmiau+yIflCs68+Qtk0bLvmD
         WU1qzs7I1dCdU4qAnLydv3o+dt60dwm1PpLP6xm8EaBkpVmN7pzNVF0vda5VBS3dKner
         IhF1jpU2gcPXjHxcJXA2tfQz0eUeS8yYMY+eKVIyig67TB1zvew32ziVngCOkemv3QEj
         yppNGbWtyBRoXelyhp6VliZ0pKhRgYBRfs19XpiXUpK4P59cmR42IxfV7c+kphMG8VWg
         3BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABTfU8gxdjv5n74FbYsyCDi8X7MNpO1jIxZ8zrk/JGc=;
        b=GGqAiu4m/THpv+NxmccOk4WbCIPUUKscSVzZLbOfthOR4FUF/71LcNHsw8O8dg0eIw
         jlVX1ygfh/nr13S2VAiIwvcSmqoBFwZDXYfAGfHX656o/1n9YW1P6Tdfqql/X49EAzLR
         e+xChX9Pt87S7XRkloeNc2NTk9kitEw9HaGZvh4dRZpMnpHQ1mPDeyY0Lf8rj2+iWLM1
         PT1+ghfcUnIjgvoKR1Q4R91SsC3s7ykkkqqc6Ojj78h+GfcRqxjRmnnN776rGzel+m0h
         YkXoy1n0TTI/2xRKrN3pz0HDqIodUSi70Mt3Fcuek0zodMXfnb4AuPuEKJjuJzlSch9q
         3iGA==
X-Gm-Message-State: AOAM532nsOmMNQEPZwA9rINlEJF591ESqe++loVxtx4R+ZDsg0uMPt4C
        7cF5erKF3mX3UV0BefEsSZGPK73SuxnCg6qW3Ddx0V9/yQY=
X-Google-Smtp-Source: ABdhPJzO1UFjPYxjHHDbPPyTeWuvMW2jYmROew+jJbFtaVcDFYVCU8mx/aezSMbrIMNKUs0Szwc4PU9+n1E6cYIivVo=
X-Received: by 2002:a17:902:ba90:b0:135:6709:705 with SMTP id
 k16-20020a170902ba9000b0013567090705mr3869473pls.79.1629988941096; Thu, 26
 Aug 2021 07:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210826135510.6293-1-hch@lst.de> <20210826135510.6293-4-hch@lst.de>
In-Reply-To: <20210826135510.6293-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 26 Aug 2021 07:42:10 -0700
Message-ID: <CAPcyv4ieXdjgxE+PkcUjuL7vdcnQfXhb_1aG2YeLtX9BZWVQfQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 26, 2021 at 6:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no point in trying to finding the dax device if the DAX flag is
> not set on the queue as none of the users of the device mapper exported
> block devices could make use of the DAX capability.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/md/dm.c | 2 +-

Mike, any objections to me taking this through a dax branch?

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2c5f9e585211..465714341300 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -650,7 +650,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>         }
>
>         td->dm_dev.bdev = bdev;
> -       td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
> +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
>         return 0;
>  }
>
> --
> 2.30.2
>
