Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA08351AFE
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhDASEJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbhDASAm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 14:00:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75402C0319C9
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m11so1915156pfc.11
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t492gz204tnmW8P1Alci2kDvg8PktRFfcjMMSK/MNys=;
        b=ey+m35jIu3aIbAv9Qq1omN1LcaO7OO2+DiNuhyc5UeAIAUv7j6ViekxKdF+mtUSy3K
         yGEvnnFyfhBJ7JF23TkMjS15F/EN09geVfP765gonQ7wVOBZMK/6eYJKFOZwe/X2/VDf
         H3k2HNyN+RsVZvu8kzlxoldSm3JhxwahUy+TTK3gEDn9lS6txHzJjdXehxz/bRble5F3
         RVzVMLca5A6A4c0uN0Zfny7jSnNXuGp4kZ7j+Xi1xY9LbkIB4UU3GT+6bx1PdofmAjSq
         BPWs+0iDnbTx0QZkaNJV9up2j5fK9SvHfpm3w7uKh19sn1BeV4yD3kcfzF7QBqJsGkcv
         qH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t492gz204tnmW8P1Alci2kDvg8PktRFfcjMMSK/MNys=;
        b=EoW/zL8x+O5YSs3Fw0tvlWmI+CcL+P0xtjF7wrGshS6k8sojicm4bKQkzXOVP3+7pP
         yc6dnr8aFJHwIt072X0VQl+QX5IzX0tEJjAcEOydUxWNobNn8nBgH3smp2Lb0h7Dc8pd
         rI319zBNYx+IhXqwIcyJytmmLsyEevVPAxyrGUaBeZEyJvCxL7pMuON/lEi1gRFGZImp
         4uevJYZmZvtD8Tz+hpX2v9rFF7L0VBt4WCfrHLioLxoBWcif/Vft1fGEiIzzFFpRefqo
         WBznPmFUydSsHPN05DHeqckh6VlY42fklXR6ZoXH9eVzHdq1xYo4C4q5A1wL0v+CLKF7
         rl/g==
X-Gm-Message-State: AOAM531zolWMlEdchzXqwCY2hNwX9WGpxqDtRRuxaNuKCa5xEmFYoJj4
        Rp22qYISxakwO1jDkhV5DrGBhuSSFG0=
X-Google-Smtp-Source: ABdhPJyxVhKph2ZGi+kxukEtSik5NpWTIx8KTAwowlZi3saDYYWHv8QMoi7r+JTnBzDFWrowKPIGsw==
X-Received: by 2002:a63:4522:: with SMTP id s34mr8270031pga.250.1617297697390;
        Thu, 01 Apr 2021 10:21:37 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:36 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 0/7] Block Allocator Improvements
Date:   Thu,  1 Apr 2021 10:21:22 -0700
Message-Id: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
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

Changes from V5:
----------------
- Turned block bitmap prefetching on by default
- Fixed a bug where for cr >= 2, we were skipping first group without
  searching in it
- Renamed mb_linear_limit to mb_max_linear_groups

Harshad Shirwadkar (7):
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: add ability to return parsed options from parse_options
  ext4: add mballoc stats proc file
  ext4: add MB_NUM_ORDERS macro
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures
  ext4: make prefetch_block_bitmaps default

 fs/ext4/ext4.h    |  34 ++-
 fs/ext4/mballoc.c | 590 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h |  22 +-
 fs/ext4/super.c   |  92 +++++---
 fs/ext4/sysfs.c   |   6 +
 5 files changed, 680 insertions(+), 64 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

