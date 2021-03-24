Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89DC34852C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhCXXTh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbhCXXTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 19:19:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84880C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v3so15883209pgq.2
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkm1ZZWSFge6gUAX9K10ocTM/2eOaD9XzyqGZlSvrds=;
        b=VNtyl7jjdQrRQI6c/hGTrZxpnleV0DwiJUCjmsuZBtu83Xtbw9ZdKtKdD+qiZGFfb7
         ArCrXsfDxut34+Zgsc1QRhY/VA7egd8uEqNB8G6UCvUCKnZli7zf9NBkONKP81U0O31f
         ZoiwAd8ZqYoWBc491Bh80/Wsd6lMlrp9lygFBKpJ1vmiSU917dsuOBOLzAFLLBeltMSL
         6AHvHDYAIScK0dgeZncWbuA4PeJuua6kNok0nhnoLXCieUaRctD/pVudTdA+IZSbMHq5
         ARLX1HCa8kTHwtDt4Px6MV9klzIxTTj/N+DCz0L9IFNgnCi21KCEaRj98v9vwHNrN0On
         AZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkm1ZZWSFge6gUAX9K10ocTM/2eOaD9XzyqGZlSvrds=;
        b=Q8brmBL0fzBH09GWVcK9mIua4YsyB919zTAfENflGTE7ZxNM4+0MW5bRivB/HRd97I
         r6+AZ2H7K3LpP4Fcr8qVfwioq5ebplWPV7tm6xslbURwA9BAxXH2UTf/5wJ66es5IUAu
         B95maTHPtUCaO7Qqf88y44YkXBlPdpvpl+ZIGvXu8poy66Y8jc3Me/QvYVCV3ll/55e7
         ClwK/lb+WH65uU/mM6uKN1C8D7qu+KDoevOBkI41C7oTlbd5wYytfLRD7ZpvLiEBzznx
         eiTuoDnCMBKI6gMu5URm+uPucXFAd2I2kxp1qHY+aRccZh63GzcJu79yn2K0G45FAOtw
         2B+Q==
X-Gm-Message-State: AOAM530zIO2T49ZA6cnZ9QKydmVniuf8SgoZPKuHUv+G1W/9lWcx59TR
        f4TXO/H/8pr4M9Zj6YPpkVapAT1fxNw=
X-Google-Smtp-Source: ABdhPJyXEIsgLUPuOw7WnfQnHzxBnJ0Zbzy/D28TW0uexIxpdrQHHGQIaDEyngIC7hT3bPsaBVpepQ==
X-Received: by 2002:a63:f914:: with SMTP id h20mr5057518pgi.114.1616627971326;
        Wed, 24 Mar 2021 16:19:31 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:f8fe:8e5d:4c9f:edfd])
        by smtp.googlemail.com with ESMTPSA id z3sm3629928pff.40.2021.03.24.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:30 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Block allocator improvements
Date:   Wed, 24 Mar 2021 16:19:10 -0700
Message-Id: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series improves cr 0 and cr 1 passes of the allocator
signficantly. Currently, at cr 0 and 1, we perform linear lookups to
find the matching groups. That's very inefficient for large file
systems where there are millions of block groups. At cr 0, we only
care about the groups that have the largest free order >= the
request's order and at cr 1 we only care about groups where average
fragment size > the request size. so, this patchset introduces new
data structures that allow us to perform cr 0 lookup in constant time
and cr 1 lookup in log (number of groups) time instead of linear.

For cr 0, we add a list for each order and all the groups are enqueued
to the appropriate list based on the largest free order in its buddy
bitmap. This allows us to lookup a match at cr 0 in constant time.

For cr 1, we add a new rb tree of groups sorted by largest fragment
size. This allows us to lookup a match for cr 1 in log (num groups)
time.

These optimizations can be enabled by passing "mb_optimize_scan" mount
option.

These changes may result in allocations to be spread across the block
device. While that would not matter some block devices (such as flash)
it may be a cause of concern for other block devices that benefit from
storing related content togetther such as disk. However, it can be
argued that in high fragmentation scenrio, especially for large disks,
it's still worth optimizing the scanning since in such cases, we get
cpu bound on group scanning instead of getting IO bound. Perhaps, in
future, we could dynamically turn this new optimization on based on
fragmentation levels for such devices.

Verified that there are no regressions in smoke tests (-g quick -c 4k).

Also, to demonstrate the effectiveness for the patch series, following
experiment was performed:

Created a highly fragmented disk of size 65TB. The disk had no
contiguous 2M regions. Following command was run consecutively for 3
times:

time dd if=/dev/urandom of=file bs=2M count=10

Here are the results with and without cr 0/1 optimizations:

|---------+------------------------------+---------------------------|
|         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
|---------+------------------------------+---------------------------|
| 1st run | 5m1.871s                     | 2m47.642s                 |
| 2nd run | 2m28.390s                    | 0m0.611s                  |
| 3rd run | 2m26.530s                    | 0m1.255s                  |
|---------+------------------------------+---------------------------|

The patch [3/6] "ext4: add mballoc stats proc file" is a modified
version of the patch originally written by Artem Blagodarenko
(artem.blagodarenko@gmail.com). With that patch, I ran following
command with and without optimizations.

dd if=/dev/zero of=/mnt/file bs=2M count=2 conv=fsync

Without optimizations:

useless_c0_loops: 3
useless_c1_loops: 39
useless_c2_loops: 0
useless_c3_loops: 0

With optimizations:

useless_c0_loops: 0
useless_c1_loops: 0
useless_c2_loops: 0
useless_c3_loops: 0

This shows that CR0 and CR1 optimizations get rid of useless CR0 and
CR1 loops altogether thereby significantly reducing the number of
groups that get considered.

Changes from V4:
----------------
- Only minor fixes, no significant changes

Harshad Shirwadkar (6):
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: add ability to return parsed options from parse_options
  ext4: add mballoc stats proc file
  ext4: add MB_NUM_ORDERS macro
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures

 fs/ext4/ext4.h    |  30 ++-
 fs/ext4/mballoc.c | 572 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h |  22 +-
 fs/ext4/super.c   |  79 +++++--
 fs/ext4/sysfs.c   |   6 +
 5 files changed, 652 insertions(+), 57 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

