Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43E3FB21C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhH3HzB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhH3HzA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D69C061575;
        Mon, 30 Aug 2021 00:54:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y23so12599901pgi.7;
        Mon, 30 Aug 2021 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qV6OtCVBWcTizrfIVpMoyQFjiimKyipNfQI+73uY/1I=;
        b=iWNiHU34cAj7o3N36B9+/Th/hfnWa+eAnLfbNL1jKMDh3CtNfgtDbBx91x4uWSmZeg
         8z1EZ8ZbefnDUqt80hYArTM2deIzpWr1j/mJXaETAQmf80vEMZJ/gGyOj9dIXbrTyp5N
         aj4JTP5FA1NzfQdBn3nCGIwvqO0Jv4w4bD/tcdwCbTaGTsOlESXzTdWLqqIv/O2NhUpE
         /pbZnlaf9VaTN2r5neaM78bmIt1z8QgRovn1qV/BZcFG7ilBMUfeounUolxY5pkbY/El
         KY3I/M4VjowZKVFO5C2e+0gUoD2prlaxl8nQA5V/HmVgnFocJogRyrj4PtwbqtOhVQ67
         F5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qV6OtCVBWcTizrfIVpMoyQFjiimKyipNfQI+73uY/1I=;
        b=UEwf/K9b+A8WrUlJyUj/eMMMLuohT+zRiPQppApiDCq2gMiSVHeVjuIMGVZHLXrZ/p
         AFOqzeZMTDayEuHGEBxHW/awONMtxtFNaNWpr73+AEKYPYhhTPx5+vjaVnaAPJ0gSW3N
         J2dvpMX+6d8MJTFqgE4apnlE2A6yIJBae0WaJqacncxduzAhb5YOMaqlaZ0j5LjWxdia
         Ninm+y6GLYx8VKxWfi3nAsrmWWUSy6jRuiukJQBBokYL6P4sjszsRkYSpTtEL1wt4c3o
         467xeyo5DF7iyF1J/Uxl8PXS3QdkDCaIv061I9gJPczk/6mL4RrAb5il86CHO+QkCpyx
         xKLw==
X-Gm-Message-State: AOAM533rpHoIyhrQ+igFPWjk5JRYCDNqZlGObxtyBMdtN1/RCen6p9JF
        /XkZLC29ePk+CKcjUXgPh+k=
X-Google-Smtp-Source: ABdhPJw5zjIs5K90SY5f8KVIOl0mHrAVIU/T4uod/6GGzkvYA47hj5a4bPUOsaDvtm44FmfcVSmuoQ==
X-Received: by 2002:a63:df06:: with SMTP id u6mr7907608pgg.148.1630310046791;
        Mon, 30 Aug 2021 00:54:06 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:06 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 0/5] ext4: get discard out of jbd2 commit kthread
Date:   Mon, 30 Aug 2021 15:52:41 +0800
Message-Id: <20210830075246.12516-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all

This is the version 4 patch set that attempts to get discard out of the jbd2
commit kthread. When the user delete a lot data and cause discard flooding,
the jbd2 commit kthread can be blocked for very long time and then all of
the metadata operations are blocked due to no journal space.

The xfstest with following parameters,
MODULAR=0
TEST_DIR=/mnt/test
TEST_DEV=/dev/nbd37p1
SCRATCH_MNT=/mnt/scratch
SCRATCH_DEV=/dev/nbd37p2
MOUNT_OPTIONS="-o discard"
has passed. The result is consistent w/ or w/o this patch set.

There are 5 patches,

Patch 1 ~ 3, there are no functional changes in them, but just some preparation
for following patches

Patch 4 introduces a async kworker to do discard in fstrim fation which implements
the core idea of this patch set.

Patch 5 flush discard background work in ext4_should_retry_alloc, This fix the generic/371

Any comments are welcome ;)

V3 -> V4:
 - In patch 1, avoid modify two lines in patch 1 when remove 'grou'p parameter
 - In patch 4, remove redunbant queue_work() in ext4_mb_release(). And queue background
   discard work to system_unbound_wq as it is not a urgent task.
 - In patch 5, flush discard kwork in ext4_should_retry_alloc(), instead of invoke
   ext4_should_retry_alloc in fallocate again.
   
V2 -> V3
 - Get rid of the per block group rb tree which carries freed entry. It is not neccesary
   because we have done aggregation when wait for journal commit. Just use a list
   to carry the free entries.

V1 -> V2
 - free the blocks back to mb buddy after commit and then do ftrim fashion discard

 fs/ext4/balloc.c  |   8 ++-
 fs/ext4/ext4.h    |   3 ++
 fs/ext4/mballoc.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 3 files changed, 148 insertions(+), 79 deletions(-)

