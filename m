Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA71212D36
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBTkB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBTkB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 15:40:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372EC08C5C1
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jul 2020 12:40:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j202so14328208ybg.6
        for <linux-ext4@vger.kernel.org>; Thu, 02 Jul 2020 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQ94TMcv/zLaySM3rs/sruhEiIq78oqdmhsmGmU78cw=;
        b=dA1wpo8hKNyZsm7QUHI08tPR4/dPF2b6osrQbmrQvQBWjr0mCBI2LuKfoJSoy1NhzV
         L1ugkA1/fBm2y+Fgy+5in34KhZptI4EQ0vZ1WMs6ordkKICJAbsEnlOhwJmeTv2qJRG/
         8GyncoT1F6yuvAirwinrzHg+ztgy6120PbF0PpVEpxiaXpU+a4ZBYVx5B6BOpWhzlPz8
         rhd9kMKRCgLymClp6FCGCa/r+lnZU9Wp77Fv71uIe0xbQb80iKobUj4vQ1Nxzn0rCIom
         kgxW+TDN675RlnwvtkKwiFRwKUuiUcL38y6VxPhuf1lWwSKnEKJVFtAT4e55I4s4f7Wd
         YikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQ94TMcv/zLaySM3rs/sruhEiIq78oqdmhsmGmU78cw=;
        b=KeV1/qQNFD0SLN3JnBuau2GcvhOMt9PTrgsotZ6tcQBdHvNCjWNPvltizUUb5Epq7T
         Zqu/jr+mEGtS8Wt3wHy5wLdHZF7EjCf0HfEl15g4JzKFaSwzzv6Au6qptI5LIfPZN+xT
         sj1Gt3cNWRSXhvJo4OIQuve7YEFGf0XLXMP5gWBfHmsGOA/1dor0yQ8A8k8O6ua1DSrS
         7e418vNh2UvFVD2xADvyuIvwSmNZ6ibIW6rqGbDs55nzRVd0YKnDGOywGyTfMxnaOz17
         5OsGYVdbGWUtI2812qY4xFxq1hc7/5hsTYkZHyuS1FcEhL81Sph8YP4GlkdOCn0SO0ma
         2vIw==
X-Gm-Message-State: AOAM532mNzlq/giYbRGhS1Ws/2zu/r8UQH+u3ctF6bQndbuWrvk+M+Zm
        cj7KS9km3sucgN8dr21Gw8aUaMQ+YSXjtkUTepdmdZTsKA+trA==
X-Google-Smtp-Source: ABdhPJwvsF+3UQgHilXfZk0SSjeqzV4g1gTwNOucnBg+YUi8PThQe/q6Twqw7OeGYw7+b/XMeYKHamO15jn8SJSnIPs=
X-Received: by 2002:a25:b94f:: with SMTP id s15mr49771747ybm.326.1593718799972;
 Thu, 02 Jul 2020 12:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-6nk9Cy6itStS917HxL7dvcy5=J+CCpSAqRoC9Um8P9LJ=kw@mail.gmail.com>
 <A735B112-0384-43F8-8F0F-CACFD34CEA67@dilger.ca> <CAG-6nk8vnj_tJzhjqLYRexrbJoGiVzP_wjam8ucm=_DB_Yx75w@mail.gmail.com>
In-Reply-To: <CAG-6nk8vnj_tJzhjqLYRexrbJoGiVzP_wjam8ucm=_DB_Yx75w@mail.gmail.com>
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Fri, 3 Jul 2020 01:09:48 +0530
Message-ID: <CAG-6nk8LDoPS85gVQ8+KLoPVGVP+PLYtBq5qaW2uMPO+ncL_pQ@mail.gmail.com>
Subject: Re: Grow ext4 filesystem on mounted device
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is what I found for sdd, looks like growpart didnt grow partition
of mounted device

 grep sdd /proc/partitions
   8       48  180355072 sdd
   8       49  173013999 sdd1

Thanks,
Alok

On Fri, Jul 3, 2020 at 1:04 AM Alok Jain <jain.alok103@gmail.com> wrote:
>
> Thanks Andreas,
>
> Device has only one partition, I also ran partprobe post growpart but
> still no luck :(
>
> # grep sdd1 /proc/partitions
>    8       49  173013999 sdd1
>
> Thanks,
> Alok
>
> On Fri, Jul 3, 2020 at 12:59 AM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Jul 2, 2020, at 13:18, Alok Jain <jain.alok103@gmail.com> wrote:
> > >
> > > =EF=BB=BFHi Experts,
> > >
> > > I want to grow the ext4 file system on mounted device by running
> > > resize2fs utility but it fails, same works in case of unmounted FS
> > > with additional invocation of e2fsck utility.
> > >
> > > This is what i am doing
> > >
> > > 1)Rescanning the device
> > > echo "1" | sudo tee /sys/block/sdd/device/rescan
> > > 2) Extending the partition
> > > growpart /dev/sdd 1
> > > 3) resizing the file system
> > > resize2fs /dev/sdd1
> > > resize2fs 1.43-WIP (20-Jun-2013)
> > > The filesystem is already 43253499 blocks long.  Nothing to do!
> >
> > What does "grep sdd1 /proc/partitions" show?  Is the kernel
> > aware of the larger partition size?
> >
> > > parted -s /dev/sdd1 print free
> > > Model: Unknown (unknown)
> > > Disk /dev/sdd1: 177GB
> > > Sector size (logical/physical): 512B/4096B
> > > Partition Table: loop
> > >
> > > Number  Start  End    Size   File system  Flags
> > > 1      0.00B  177GB  177GB  ext4
> > >
> > > Any help?
> > >
> > > Thanks,
> > > Alok
