Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C92231CCD
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Kil (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 06:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Kil (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 06:38:41 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544AFC061794;
        Wed, 29 Jul 2020 03:38:41 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l26so591449otj.4;
        Wed, 29 Jul 2020 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IFF1irOJqdUETJCHFaBsg6OmWBfYFCwyibD9/Op1rYM=;
        b=NiajiFeXapFSLkg9Fcia++H17b4TapQkKaBWfWcoZqgcQvIOYHMNBPmw9Z37rdrfWS
         4c3SkUG7pXNrxgS4l3EErffvKWY0JivYsN4NSeORL/KG+aRbyDKpEuPTdOjSVC8jxY4k
         y04BHIzSyppanI7tEIbvycB+X0SKBDz9ofWkoKjqGyfZiYMO1sdKT1SzSIsjEgJOOWux
         RXt/PFZvfbzcxlMYNt4YHv4NC9j+vXFl+ehuaIeK66HVHBRi0eS5gQzoYmlD5WKsRmQN
         C8ejvMzQxWn0j7AIiv2+lWV752s0ZH6ZB86u+t3HFiNsd9pqay1YFa2jKavpSQ46u2Ij
         YUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IFF1irOJqdUETJCHFaBsg6OmWBfYFCwyibD9/Op1rYM=;
        b=ExD3CceF82XK5XGkddvL+lerT/9bGONqjJrwuneBTfAP9Mriq9c+gG6Ujl6H87H8za
         g+Xw4y5BuIof9AC1jrv0rQa0TjDSP4XJxSlNgqJrJ8360Wy8/JOSAC+r6z+nP7P01RG+
         IOO3KVLkbA2l0yQguPiodiZarh4cQiBzoapeHdTF1S2q21UP/SfSsr3RSLS/WrM21lfh
         q7yKmYG9kxcUf0/hmOi6HFeK6pX1RK/XwLq68q7C2czxa6cCNft+a0TCbxDoFeA5jZ8K
         X+2wKWh48ilBuAEd63WxaWqxbeoxtGnn2wcSL7gz410e76fVFdDQP0k+SO2NWkeLgHu0
         nj9g==
X-Gm-Message-State: AOAM530/huLinMfA8lP2jAEaJoRDYiLj03msASjtSCd07HXK32qCYiPV
        FurR2OAiS6oBOeWVJlwvDblbRNno+Unc2E7J5jcEed4FVIA=
X-Google-Smtp-Source: ABdhPJy848HJf2FYyv6C06g0pRiXGI8p0iDziqZgEZInSOsIlilb36b3qI5wirQMia3EfHaXcg5LW6I+FsrXtAlypFg=
X-Received: by 2002:a9d:7057:: with SMTP id x23mr602045otj.95.1596019120257;
 Wed, 29 Jul 2020 03:38:40 -0700 (PDT)
MIME-Version: 1.0
From:   Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Date:   Wed, 29 Jul 2020 19:38:33 +0900
Message-ID: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
Subject: ext4/xfs: about switching underlying 512B sector devices to 4K ones
To:     linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I have a question: is it possible to make existing ext4/xfs filesystems
formatted on 512B sector devices run as is on 4k sector devices?


Problem:

We are maintaining some legacy servers whose data is stored on
ext4/xfs filesystems formatted on lvm2 raid1 devices.

These raid1 devices consist of a few iSCSI devices, so the
remote storage servers running as iSCSI targets are the actual
data storage.

  /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server
                 /dev/sdb  --(iSCSI)-- remote storage server

A problem happened when we tried to add a new storage server with
4k sector disks as an iSCSI target. After lvm2 added that iSCSI
device and started syncing the blocks from existing 512B sector
storage servers to the new 4k sector ones, we got
"Bad block number requested" messages, and soon after that,
the new device was removed from the lvm2 raid1 device.

  /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server(512)
                 /dev/sdb  --(iSCSI)-- remote storage server(512)
              *  /dev/sdc  --(iSCSI)-- remote storage server(4k)

  The combined raid1 device had been recognized as a 4k device
  as described in this article:
    https://access.redhat.com/articles/3911611

It seemed like 512B unaligned requests from the xfs filesystem
were sent to the raid1 device, and mirrored requests caused
the problem on the newly added 4k sector storage.

The xfs was formatted with its sector_size_options set to the
default (512).
See https://www.man7.org/linux/man-pages/man8/mkfs.xfs.8.html

In the case of ext4, the device continued to run, but I was not
sure if there could be any problems.


Question:

Is it possible to change the underlying storage to 4k sector ones
as written above without copying the data on the ext4/xfs
filesystems to outside of the raid1 device?

ext4: I am not seeing any apparent errors after adding the 4k
  device. Is this an expected behavior?

xfs: is it possible to change the filesystem sector size?

  I read this explanation and thought if I could change the
  journal related metadata, it might be possible.
  https://www.spinics.net/lists/linux-xfs/msg14495.html


Thanks,
  Takuya
