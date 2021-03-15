Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CD33C495
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhCORhp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbhCORh3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53CC06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t18so9185330pjs.3
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qQi2A2uL+W6a1XnuMlwtDAdiRqrMqgMWFVmP6ZyAFM=;
        b=t2+O/ofMB0ap+rJI1x9PrxPET563bV7blCsuMh9fV+J326fiSeoL8A/wZjyA7E1HHj
         uL3DIOoIGnxl0xkx/8ZCrep0yNyOBQCOLGKZ2RwhcO3y4U264PMolmVUjP4tGKifxtOl
         NzWBERPbN7OYTgdidAfUPDjQ0bz/QHjh0+yufSF2j6KSygYFMJmd4RFpCFBg4J6KoUz3
         GTznV3iVsSnCvYttZMsig1RWgvu+0nNuyaMJHsapNSoXL1a6kVxtP/faDS+/xgxuO9Sy
         LkUDYmYuvYvBbav6d798qcNCB8tE5uhN+gEFwn3/QM51Z+zQCNJS98gHP1bHrsz8z5E+
         pXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qQi2A2uL+W6a1XnuMlwtDAdiRqrMqgMWFVmP6ZyAFM=;
        b=mJee0uyBjC9Vv8nBz+FmQH/FToeg2WB7OYaLwyNI69prxUvKMSAnE/5WD/+MILksdZ
         2UYmp1H2L5iX+WwSA6vOa5m7eMoqCOg5GoBrWxLRrMe1O7BuGAtffp/mox2WyIE5v2fG
         0oNv9ZThmIQ4xIJVgGbp7pxcZuhl+axzlRkutOV/S+6Cdt4927MWhJ7KRcPVem74nVSq
         d/rEZYG8XzvVPgIyVDP0YmSyK42g+m591WbM2NP6/bUWBDBSQBZR3wdhZlpGS3VHe9q8
         GPbDuSvDnznSd9j5m3NzPwiIX5aVvaZ3hUwRo031BTd7//8DGyGAdoqiS6HOwKQHodAY
         BM+w==
X-Gm-Message-State: AOAM532tS+l/VzNqPHINHb57NFkr7imEvEL/sJmBQCbhrddJYrXg5uK2
        I/lWrK1mZ6k5ycI5LPf0Ik9jis/FdFE=
X-Google-Smtp-Source: ABdhPJxoV5Jn9FX41Gj6Z48e9FP/K6CnGLcQfKfW3uFivYNRp/2tc2aEN8jEqYPM3dYR07iEEn7PXA==
X-Received: by 2002:a17:902:e5ce:b029:e5:dc8a:7490 with SMTP id u14-20020a170902e5ceb02900e5dc8a7490mr12642114plf.37.1615829848609;
        Mon, 15 Mar 2021 10:37:28 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:28 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Block allocator improvements 
Date:   Mon, 15 Mar 2021 10:37:10 -0700
Message-Id: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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

Changes from V3:
----------------

- This feature is now enabled by default for disks which have at least
  16 groups. This can be turned off by passing mb_optimize_scan=0
  mount option and can be turned on unconditionally by passing
  mb_optimize_scan=1 mount option.

- Reorganized stats by cr level

- Added ability to send parsed options back to the caller in
  parse_options() functions in super.c

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (6):
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: add ability to return parsed options from parse_options
  ext4: add mballoc stats proc file
  ext4: add MB_NUM_ORDERS macro
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures

 fs/ext4/ext4.h    |  30 ++-
 fs/ext4/mballoc.c | 567 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h |  22 +-
 fs/ext4/super.c   |  78 +++++--
 fs/ext4/sysfs.c   |   6 +
 5 files changed, 646 insertions(+), 57 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

