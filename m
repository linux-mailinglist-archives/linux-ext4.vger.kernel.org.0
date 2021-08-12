Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99A3EA5CC
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhHLNjc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 09:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231602AbhHLNjb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Aug 2021 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628775546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ftldvm56N32FBKDd0CCHVOeViQnWhqhW1nBl9zqj/CY=;
        b=GvfRylOD2O2R0k9Li1r4KP8TPQGDOGswzCIICoZvtpwe7GIepmU50B42BV/3VkKx5s/u5S
        Ca2rsPKE8SxU+A1RJJza4JqRJJPe/HsiJUub847KLYcXWJ5GGFQNRU5JhHerP3u2PwDiGV
        8h+6Jk1ROBzJGqJDoultaFOMRhFv4gA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-lCN4H-qtMPqh6SoGXakG1A-1; Thu, 12 Aug 2021 09:39:04 -0400
X-MC-Unique: lCN4H-qtMPqh6SoGXakG1A-1
Received: by mail-pj1-f69.google.com with SMTP id 2-20020a17090a1742b0290178de0ca331so4269275pjm.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Aug 2021 06:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftldvm56N32FBKDd0CCHVOeViQnWhqhW1nBl9zqj/CY=;
        b=CnCMvuMILs1WeBiTpxAg9iWEjR5T1K/dEpuwZvZdovhxbnTbq1y0+TBAl5kQe69Ry5
         jD5yreBbotKb1Kz+XwVD4jiatiOjJrTM5icBaLdl/jjY4/6HpCWHmU7gzzfMTAcSjnP1
         vaPq+CTYyi9AKT5yKZc+CqzAhcWiHLo5NWRvFzX0K5VQNp0lwI5WirXNDBgmDLx08s+k
         CfcYhcr/3SYr/bexrxNrjzGv53xdDCAcnYoGb2758M4FFMkc0Vbrik9QNJ++KY0uSH7b
         7hPMHi8NmNjRRRxvsLBMPHzO4cc8tio3N45Izmht/8nlRh1vYTJ7mo5xjHzBCOCBneE5
         Ce9A==
X-Gm-Message-State: AOAM533o1w/QDRqUNBnaG0zZhIb03Vn9cDs2z/09pxWe3Kl9fQHr2GK+
        EUlhmSwWOpyJVY98JNbazHIiDcQsWf2kVwYWmyCsLOxFtOq+bLttpOLmcjym/h3libCLWKcOilR
        Td3SWp/LY96lQyHTIb1ZHVGCVofkEpvhWAcBR1Q==
X-Received: by 2002:a63:ba5c:: with SMTP id l28mr3862693pgu.311.1628775543509;
        Thu, 12 Aug 2021 06:39:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/w3ecZagfKPzWxtuQMj1cUNFE0t0H2iLDBE0Udbv7GpmBhCPcwOEd0KbJ5Zv45g7y8WAWh7KuWMes84jqRMA=
X-Received: by 2002:a63:ba5c:: with SMTP id l28mr3862677pgu.311.1628775543245;
 Thu, 12 Aug 2021 06:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YbqejLQJO-6-a0ETtNUitQtsYr3Q2b7xW4VV=6fXO6APw@mail.gmail.com>
 <CAHLe9YZN2LJHMzKPkA-g7C=fx-u-0Jw-2s6Ebyy-XUmv_5y-gg@mail.gmail.com> <20210812124746.GA14675@quack2.suse.cz>
In-Reply-To: <20210812124746.GA14675@quack2.suse.cz>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 12 Aug 2021 21:38:51 +0800
Message-ID: <CAHLe9YZCV3Ed5yf=jfOKNeXnJE6mdXepQozVyV=ugn_d4fYR3g@mail.gmail.com>
Subject: Re: [kernel-5.11 regression] tune2fs fails after shutdown
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan!

Yes. I will create a test case for fstests.

Thanks,
Boyang

On Thu, Aug 12, 2021 at 8:47 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Boyang,
>
> On Thu 12-08-21 09:47:30, Boyang Xue wrote:
> > (Adding the author of the commits)
> > Hi Jan,
> >
> > The commit
> >
> > 81414b4dd48 ext4: remove redundant sb checksum recomputation
> >
> > breaks the original reproducer of
> >
> > 4274f516d4bc ext4: recalucate superblock checksum after updating free
> > blocks/inodes
> >
> > I'm wondering is it expected please?
>
> Thanks for report! So for record the problem is not that superblock with
> incorrect checksum would ever get to disk with my patches but the checksum
> will be incorrect in the buffer cache until the moment we start writeout of
> the superblock. And tune2fs accesses the buffer cache and sees the
> incorrect (stale) checksum. It is impossible to fix this problem completely
> (the tune2fs access is fundamentally racy) but yes, I guess returning the
> checksum recalculation back will make the race window small and the cost is
> small. I'll send a patch for this shortly.
>
> Also can you perhaps make this sequence into a fstests testcase for ext4
> filesystem so that we have it covered? Thanks!
>
>                                                                 Honza
>
> > On Thu, Aug 5, 2021 at 10:35 AM Boyang Xue <bxue@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > kernel commit
> > >
> > > 4274f516d4bc ext4: recalucate superblock checksum after updating free
> > > blocks/inodes
> > >
> > > had been reverted by
> > >
> > > 81414b4dd48 ext4: remove redundant sb checksum recomputation
> > >
> > > since kernel-5.11-rc1. As a result, the original reproducer fails again.
> > >
> > > Reproducer:
> > > ```
> > > mkdir mntpt
> > > fallocate -l 256M mntpt.img
> > > mkfs.ext4 -Fq -t ext4 mntpt.img 128M
> > > LPDEV=$(losetup -f --show mntpt.img)
> > > mount "$LPDEV" mntpt
> > > cp /proc/version mntpt/
> > > ./godown mntpt # godown program attached.
> > > umount mntpt
> > > mount "$LPDEV" mntpt
> > > tune2fs -l "$LPDEV"
> > > ```
> > >
> > > tune2fs fails with
> > > ```
> > > tune2fs 1.46.2 (28-Feb-2021)
> > > tune2fs: Superblock checksum does not match superblock while trying to
> > > open /dev/loop0
> > > Couldn't find valid filesystem superblock.
> > > ```
> > >
> > > Tested on e2fsprogs-1.46.2 + kernel-5.14.0-0.rc3.29. I think it's a
> > > regression. If this is the case, can we fix it again please?
> > >
> > > Thanks,
> > > Boyang
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

