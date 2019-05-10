Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3053B1A3D3
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 22:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfEJUOT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 16:14:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41326 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJUOS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 16:14:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id y10so5413515oia.8
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glYXor0GQ9DfKpghbnKPKxe+zUzoJeb7GoYJ26Vk6ps=;
        b=yf8U/VwdNl5tfgFPEKe5qh3THkRWZb9un60SOgkfJ/5LhvAwk90OALPbQmqH8NGPZg
         Cr23IQd+McBJGud2E9ep2+5K3niud5mH6fhTcdytKwGg0ifP80vvI1KiLl0J9xx4xwjq
         TEllzhY/P52SG7Zgqu0zO0TcVHYyKzcfJiA7uwMKIIPnUXohIrhjvrd+s0fzp7fbWFpQ
         y62fi/8hXK8LlUhb+lV4PauDhwTsmzrWQoEzPH1EBWKu2DNHNpcM/c0ugQiTxq1CS/Pn
         ELZfOgWViQuoOxYDdqZ2L8n4KiCZbfdn+ONJLYDNxFTBB6M7dS0ALwRsezeWWJXIVakV
         lNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glYXor0GQ9DfKpghbnKPKxe+zUzoJeb7GoYJ26Vk6ps=;
        b=VzlOioezYSCMUHwrHyFZJWphKE6TN8oKsQO46JJHrjgXw6W64NnuVEmwPR9tbdpP1B
         YPJG7IQwXtute2Z/6PCgEmnKMNIO8V5WX6XZWD+nVtI8pBQRFqaS1naQBiseUYpteIwP
         hzVGsxsHC6JOnE+L90UQ+ab+5Y92FaxQhF6jJzm5BowK1AbHJWm2Bu0ffYLJDfduDcvS
         eP2PyLr2ABteiU+tguQvI3kJnecnvbuud90+S6VeVRa7buyYpcIW7dL9vFZhj8qjtjeo
         P0gAOudq6FaAr0wgwi3YdBH7y6wjuQXxX4uXsOldCpT7z/jWx6aa4sjqNkJM2HhZt+6w
         bECA==
X-Gm-Message-State: APjAAAWK5Bs2/gKu4yM0WrPts8fX+FRpJPeye2FSAF/v6s+H0IkCcwYx
        zSlOo9lf1cYnlVsUi4yzPYQE6kwkaK/wLVk8GXuZXg==
X-Google-Smtp-Source: APXvYqx7Iy3DOMIV9DNLu2fGaxr7KgtVySuDwyKCLAPX5/jruFRFKJ7CbI+68cxoMCTMjkHKJ+jW3/SnCYNqZpzsnJI=
X-Received: by 2002:aca:4208:: with SMTP id p8mr6821131oia.105.1557519257995;
 Fri, 10 May 2019 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com> <20190510155202.14737-4-pagupta@redhat.com>
In-Reply-To: <20190510155202.14737-4-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 May 2019 13:14:07 -0700
Message-ID: <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Adam Borowski <kilobyte@angband.pl>,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 10, 2019 at 8:53 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_SYNC' flag which is set
> for nd_region doing synchronous flush. This later
> is used to disable MAP_SYNC functionality for
> ext4 & xfs filesystem for devices don't support
> synchronous flush.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/dax/bus.c            |  2 +-
>  drivers/dax/super.c          | 13 ++++++++++++-
>  drivers/md/dm.c              |  3 ++-
>  drivers/nvdimm/pmem.c        |  5 ++++-
>  drivers/nvdimm/region_devs.c |  7 +++++++
>  include/linux/dax.h          |  8 ++++++--
>  include/linux/libnvdimm.h    |  1 +
>  7 files changed, 33 insertions(+), 6 deletions(-)
[..]
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 043f0761e4a0..ee007b75d9fd 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1969,7 +1969,8 @@ static struct mapped_device *alloc_dev(int minor)
>         sprintf(md->disk->disk_name, "dm-%d", minor);
>
>         if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> -               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
> +               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops,
> +                                                        DAXDEV_F_SYNC);

Apologies for not realizing this until now, but this is broken.
Imaging a device-mapper configuration composed of both 'async'
virtio-pmem and 'sync' pmem. The 'sync' flag needs to be unified
across all members. I would change this argument to '0' and then
arrange for it to be set at dm_table_supports_dax() time after
validating that all components support synchronous dax.
