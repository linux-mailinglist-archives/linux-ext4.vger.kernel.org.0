Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5639B212D29
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGBTeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBTeq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 15:34:46 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B739C08C5C1
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jul 2020 12:34:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o4so14347181ybp.0
        for <linux-ext4@vger.kernel.org>; Thu, 02 Jul 2020 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcodwUmetLzrGa/Qokfc7C4E4hosRqvK9nYWUWNhvh0=;
        b=VukUiJhK9+c0+vbGQH33dQzABVBCBs+I5oI72Jo+8tZ935e2KNb0U7KPvBYIBjsw1x
         qxC4bKAH0p7T6EV2I+2frL4gvq+w64saWzfz29h4nckyKPCtblosUu+9aF/0t1znVnxM
         qk9aPh32JVdSS7Yid/gBYvYKySSuNdemxADwZY4cMaUcQwyoyxEKnQJ1Yh1jbikI7SPB
         LIrz6nFClyBqIfMMViI6W6+Ir3eG87P6h9EPnGGCsneYRf+mCTV7/F1HUkXC0CFX12WX
         PpOJLF5h2+qwVUVc5NYQqoTDPieKkCkNle4Wt8Vj41ErP/rHaXZ0/q1LhYLwoKhiNTqV
         wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcodwUmetLzrGa/Qokfc7C4E4hosRqvK9nYWUWNhvh0=;
        b=BjQ55aZDKR7XerYKuRY6OrLvMtpxWWYFQ3BY6pF0gaS9Mi0BBhH+Nf3JBKLWPaF7Lx
         yu1ll1FgSy8CWHnt67KehWVMImZhdlYgWVYsGyePu4tHECHzaQvVP7FCmp9Ev6OrciLc
         GZDUlsZa4bLKq4aT98K4BshHXz3X1xGJi+2gxTKYer7pSoyxCAr4u2d6J9YmGROojJCs
         sIP1456nkNEyeYIYj+G/hY/o7x1ut58Jqev10YsvlYoGs/fua4cpg4Ix/aiPB5Ap0JP9
         ct5sE1e6PogPH1mbdC8APAadAtp7kDWWn6fheWDNC+tvrOvMcq4/QP8aG6hSYsUFHshZ
         n7Vw==
X-Gm-Message-State: AOAM532uqXFmgTUK2+FAn+NQhjt4ogCrLuwAofenjNelGZtOrYkO+cIY
        yVRLrmHf0yvPzlLBCkk1UJltLioys7aFMwnH/cY6eqhMmzhfbw==
X-Google-Smtp-Source: ABdhPJx98/FhDBFbC7Pr3FOG/cmuAP7SYjWs0Uczqzmde+SIjrBC6fcin7ZO1RDdOZ4zHwXaDaELXgHI95iBSDvdM+k=
X-Received: by 2002:a25:7542:: with SMTP id q63mr31109850ybc.19.1593718485156;
 Thu, 02 Jul 2020 12:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-6nk9Cy6itStS917HxL7dvcy5=J+CCpSAqRoC9Um8P9LJ=kw@mail.gmail.com>
 <A735B112-0384-43F8-8F0F-CACFD34CEA67@dilger.ca>
In-Reply-To: <A735B112-0384-43F8-8F0F-CACFD34CEA67@dilger.ca>
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Fri, 3 Jul 2020 01:04:33 +0530
Message-ID: <CAG-6nk8vnj_tJzhjqLYRexrbJoGiVzP_wjam8ucm=_DB_Yx75w@mail.gmail.com>
Subject: Re: Grow ext4 filesystem on mounted device
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Andreas,

Device has only one partition, I also ran partprobe post growpart but
still no luck :(

# grep sdd1 /proc/partitions
   8       49  173013999 sdd1

Thanks,
Alok

On Fri, Jul 3, 2020 at 12:59 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jul 2, 2020, at 13:18, Alok Jain <jain.alok103@gmail.com> wrote:
> >
> > =EF=BB=BFHi Experts,
> >
> > I want to grow the ext4 file system on mounted device by running
> > resize2fs utility but it fails, same works in case of unmounted FS
> > with additional invocation of e2fsck utility.
> >
> > This is what i am doing
> >
> > 1)Rescanning the device
> > echo "1" | sudo tee /sys/block/sdd/device/rescan
> > 2) Extending the partition
> > growpart /dev/sdd 1
> > 3) resizing the file system
> > resize2fs /dev/sdd1
> > resize2fs 1.43-WIP (20-Jun-2013)
> > The filesystem is already 43253499 blocks long.  Nothing to do!
>
> What does "grep sdd1 /proc/partitions" show?  Is the kernel
> aware of the larger partition size?
>
> > parted -s /dev/sdd1 print free
> > Model: Unknown (unknown)
> > Disk /dev/sdd1: 177GB
> > Sector size (logical/physical): 512B/4096B
> > Partition Table: loop
> >
> > Number  Start  End    Size   File system  Flags
> > 1      0.00B  177GB  177GB  ext4
> >
> > Any help?
> >
> > Thanks,
> > Alok
