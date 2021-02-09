Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3F3158DC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 22:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhBIVoC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 16:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhBIUj1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 15:39:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1CC0698D3
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 12:29:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b21so13217261pgk.7
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 12:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTsL/2weVaUp6jySO4swmTp0wqJQoJ4eNiOPaKp9ecE=;
        b=geHIyIZHvCw5TRC9zbbzEmErUNfmfbfpE+X5Seg0Ly+cKo+yy2neqDlhKA3KaIPXZk
         lfFoqfCNqsdAvDRoo1HvN0XXpfijskFpgUfK/+n8vIQDL1MCgk4I/dIK6pux8DgeLNO5
         gdbkUszcp72/z0LsMXUTFowEzRa9q13dUJEf8uj+GDr8npKB2omJNf8QfQuPDH9BxPsC
         xZYwYsks+PkvPzzvEDH0LuYv7JevSe26YAB7ANhgQbVfAJCLSjWoJJDAHMBtWZ0n68sF
         DwoBnxvlBEZDRqlNRFgLsCZ6hoiH9GShI4aRueRyUafDTmQZLINABVI0Znt7wiK/Up1l
         52KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTsL/2weVaUp6jySO4swmTp0wqJQoJ4eNiOPaKp9ecE=;
        b=C8hxxDef/saQ9zOQfVqvXF1iso+j+8i2rnDdb3rrAw65DZYA7yHuUoPnmbboWClOhw
         Wa577xF+yBmJd11R5bs6OPse85C6sGo/5qas9jksctShwyGzXgojFmeeKMrjSUDEc1zL
         zXVVuL/GsxM7m9I4DZzV8yBU0IZrUhbyskfD7TwC4pMl4mutexYrUY9itCETTl/PEfrP
         4qQDsHpKdD7q2G/bKZDrGoddBFc2x1Gi58hVGdmv9yG5G0xymzboLufWj+XWiNp/6Mr2
         nZ5kiEO70KjdcoT9Kxrj4Glr/7PRHCkc3q9uEuJThjIILpgOkQUtLR3llwiP+IulJmRq
         pJ7A==
X-Gm-Message-State: AOAM533dx6MOG2FlnUWmBFCZnqfXMaqjN2CfC8mEbrYwQg5lVqyomYf9
        j4D6hvgETzkA6Ksmt2R/m1ZPklIQVG0=
X-Google-Smtp-Source: ABdhPJxZqWY+52XZFDhD4OZtLcECkJeotH0tsEF0uAaA27WDxRDsTG90ZIb3XAfOZuT2xEoo79zStQ==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr23576823pgm.135.1612902544816;
        Tue, 09 Feb 2021 12:29:04 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1d7c:b2d9:c196:949c])
        by smtp.googlemail.com with ESMTPSA id p12sm3325827pju.35.2021.02.09.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:29:03 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, bzzz@whamcloud.com, artem.blagodarenko@gmail.com,
        sihara@ddn.com, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Improve group scanning in mballoc
Date:   Tue,  9 Feb 2021 12:28:52 -0800
Message-Id: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The patch [2/5] "ext4: add mballoc stats proc file" is a modified
version of the patch originally written by Artem Blagodarenko
(artem.blagodarenko@gmail.com). With that patch, I ran following
command with and without optimizations.

dd if=/dev/zero of=/mnt/file bs=2M count=2 conv=fsync

Without optimizations:
mballoc:
        reqs: 41
        success: 1
        groups_scanned: 63
        groups_considered: 20643620
        extents_scanned: 7851
                goal_hits: 0
                2^n_hits: 1
                breaks: 39
                lost: 0
        useless_c0_loops: 3
        useless_c1_loops: 39
        useless_c2_loops: 0
        useless_c3_loops: 0
        buddies_generated: 491561/491520
        buddies_time_used: 13078539152
        preallocated: 0
        discarded: 0

With optimizations:
mballoc:
        reqs: 42
        success: 1
        groups_scanned: 62
        groups_considered: 1011
        extents_scanned: 8062
                goal_hits: 0
                2^n_hits: 0
                breaks: 40
                lost: 0
        useless_c0_loops: 0
        useless_c1_loops: 0
        useless_c2_loops: 0
        useless_c3_loops: 0
        buddies_generated: 491561/491520
        buddies_time_used: 13165943648
        preallocated: 0
        discarded: 0

This shows that CR0 and CR1 optimizations get rid of useless CR0 and
CR1 loops altogether thereby significantly reducing the number of
groups that get considered.

Changes from V1:
---------------
- Incorporated Artem's patch that adds a few useful statistics for
  mballoc performace
- Added more fine grained locking for CR0 lists and CR1 tree
- Broke up ext4_mb_choose_next_group function to make code more
  readable
- Added a new mount option to provide a switch for these changes

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (5):
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: add mballoc stats proc file
  ext4: add MB_NUM_ORDERS macro
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures

 fs/ext4/ext4.h    |  23 ++-
 fs/ext4/mballoc.c | 477 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h |   7 +
 fs/ext4/super.c   |   6 +-
 fs/ext4/sysfs.c   |   4 +
 5 files changed, 485 insertions(+), 32 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

