Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47FC43D31B
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhJ0UtK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbhJ0UtJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 16:49:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C805C061767
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 13:46:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h193so4186207pgc.1
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
        b=TxZcat++g2F8swI/guncdG9/17Z/6RCDj0O4DaP3V2lEJrBjGy6sZkL1oaiVAPUX7i
         ibRs8fV27ZpLTrAbifA8zRst6y+Kk83j+VEjhNI+Vbneg5PK76uFu3Pt51HYTeEaMMd/
         OOX5Fw0eevNVN84NzUSIfUo21BQoeHWua4n8iiMA5hViXFqIkNINp7tTwt6Va0lJxObQ
         XbAdy+YG2LtzHKedjvpvUxc4S7WGprooI9+nPgi9DghDQrCCLYP8qAZgeT7medHBfAJw
         WFVgaDdPI0CXvVHu3YcuEB3ai43LJghhdT9dLcGlj4W6soszGfdT20P58PyL1vt7VaVP
         hqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
        b=LraLke5jPg+MYuY+bzoiNGTKE/TYwtKRVSDf08zgyWl61hPO4ksgdzM5AkhsK4kkVb
         pCjVo9S/kk7FZU2Jyzoi1ZTM13pOGujNVCf3dbgXexmx4eeNhAA/+Ta5KOObSrJas2K2
         q6PKVqWiXdmM4Hq+lO19QRCDcbxzFVfR93qKgjo1iRkIOht8hxLpXjYMelHlhn4qUaN4
         0ZMyHAVv1ewNqkOym6x+bt3HGsn64xadDPUxjf+c694CWTEQSXsHj1S8EXfrocCmvGry
         ppBqFGbP1nY+Qfi6xYm0TbcItSuwrc3WdhpuuiwROCsXqIkDVwX4D8FpSkLb54T8QaBp
         LCxA==
X-Gm-Message-State: AOAM532NkyW02V6hri0xPCOIrl8zH7kMCytQaxG8E9beXH8P+CeDleUc
        iPC2JJUZBREKpX/dr/LynehZBHLtF3+/NCIqFf4GvsWH2TLg7Q==
X-Google-Smtp-Source: ABdhPJzuYcyzIFqC2QDapdBCh3wTfdWUrlublr2aq9P2i1Emub6ylFDIqTcshjHDL5pSUpWP0gXhlJZ+k6Puz+OdoJE=
X-Received: by 2002:a05:6a00:1348:b0:47c:e8f1:69a3 with SMTP id
 k8-20020a056a00134800b0047ce8f169a3mr433025pfu.86.1635367603066; Wed, 27 Oct
 2021 13:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 13:46:31 -0700
Message-ID: <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[ add sfr ]

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan,
>
> this series cleans up and simplifies the association between DAX and block
> devices in preparation of allowing to mount file systems directly on DAX
> devices without a detour through block devices.

So I notice that this is based on linux-next while libnvdimm-for-next
is based on v5.15-rc4. Since I'm not Andrew I went ahead and rebased
these onto v5.15-rc4, tested that, and then merged with linux-next to
resolve the conflicts and tested again.

My merge resolution is here [1]. Christoph, please have a look. The
rebase and the merge result are both passing my test and I'm now going
to review the individual patches. However, while I do that and collect
acks from DM and EROFS folks, I want to give Stephen a heads up that
this is coming. Primarily I want to see if someone sees a better
strategy to merge this, please let me know, but if not I plan to walk
Stephen and Linus through the resolution.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=c3894cf6eb8f


>
> Diffstat:
>  drivers/dax/Kconfig          |    4
>  drivers/dax/bus.c            |    2
>  drivers/dax/super.c          |  220 +++++--------------------------------------
>  drivers/md/dm-linear.c       |   51 +++------
>  drivers/md/dm-log-writes.c   |   44 +++-----
>  drivers/md/dm-stripe.c       |   65 +++---------
>  drivers/md/dm-table.c        |   22 ++--
>  drivers/md/dm-writecache.c   |    2
>  drivers/md/dm.c              |   29 -----
>  drivers/md/dm.h              |    4
>  drivers/nvdimm/Kconfig       |    2
>  drivers/nvdimm/pmem.c        |    9 -
>  drivers/s390/block/Kconfig   |    2
>  drivers/s390/block/dcssblk.c |   12 +-
>  fs/dax.c                     |   13 ++
>  fs/erofs/super.c             |   11 +-
>  fs/ext2/super.c              |    6 -
>  fs/ext4/super.c              |    9 +
>  fs/fuse/Kconfig              |    2
>  fs/fuse/virtio_fs.c          |    2
>  fs/xfs/xfs_super.c           |   54 +++++-----
>  include/linux/dax.h          |   30 ++---
>  22 files changed, 185 insertions(+), 410 deletions(-)
