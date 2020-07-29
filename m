Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC32327EF
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jul 2020 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgG2XQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 19:16:32 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36960 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbgG2XQc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Jul 2020 19:16:32 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 0F99B1ABA63;
        Thu, 30 Jul 2020 09:16:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k0vIr-0001K6-Fp; Thu, 30 Jul 2020 09:16:05 +1000
Date:   Thu, 30 Jul 2020 09:16:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: ext4/xfs: about switching underlying 512B sector devices to 4K
 ones
Message-ID: <20200729231605.GB2005@dread.disaster.area>
References: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=20KFwNOVAAAA:8 a=GcyzOjIWAAAA:8
        a=7-415B0cAAAA:8 a=E_J3gUCkgs7_eoKxu18A:9 a=CjuIK1q_8ugA:10
        a=aoJaUPc5O3oA:10 a=y6iZbZ3K2SMA:10 a=hQL3dl6oAZ8NdCsdz28n:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 29, 2020 at 07:38:33PM +0900, Takuya Yoshikawa wrote:
> I have a question: is it possible to make existing ext4/xfs filesystems
> formatted on 512B sector devices run as is on 4k sector devices?
> 
> 
> Problem:
> 
> We are maintaining some legacy servers whose data is stored on
> ext4/xfs filesystems formatted on lvm2 raid1 devices.
> 
> These raid1 devices consist of a few iSCSI devices, so the
> remote storage servers running as iSCSI targets are the actual
> data storage.
> 
>   /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server
>                  /dev/sdb  --(iSCSI)-- remote storage server
> 
> A problem happened when we tried to add a new storage server with
> 4k sector disks as an iSCSI target. After lvm2 added that iSCSI
> device and started syncing the blocks from existing 512B sector
> storage servers to the new 4k sector ones, we got
> "Bad block number requested" messages, and soon after that,
> the new device was removed from the lvm2 raid1 device.
> 
>   /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server(512)
>                  /dev/sdb  --(iSCSI)-- remote storage server(512)
>               *  /dev/sdc  --(iSCSI)-- remote storage server(4k)
> 
>   The combined raid1 device had been recognized as a 4k device
>   as described in this article:
>     https://access.redhat.com/articles/3911611

Rule of thumb: growing must always be done with devices that have
the same or smaller logical sector sizes. IOWs, the above will break
any filesystem that is formatted with alignment to the logical
sector size of 512 bytes...

> It seemed like 512B unaligned requests from the xfs filesystem
> were sent to the raid1 device, and mirrored requests caused
> the problem on the newly added 4k sector storage.

Yes, because XFS has permanent metadata that is logical sector sized
and aligned. Hence if the device has a logical sector size of 512
at mkfs time, you will get this:

> The xfs was formatted with its sector_size_options set to the
> default (512).
> See https://www.man7.org/linux/man-pages/man8/mkfs.xfs.8.html

and that filesystem will not work on 4k physical/logical
storage devices.

if you start with 4k devices, mkfs.xfs will detect 4k
physical/logical devices and set it's sector size to 4k
automatically and hence will work on those devices, but you can't
change this retrospectively....

> xfs: is it possible to change the filesystem sector size?

Only at mkfs time.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
