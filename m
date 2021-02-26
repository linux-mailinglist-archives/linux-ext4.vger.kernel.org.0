Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C30326781
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBZThJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZThG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2173C061574
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q204so5878418pfq.10
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvUbrKBLZESMWSFGr9nCS7XUBmQQoaeWoZeV8VwbhD8=;
        b=YFQ4hKjPAmq9S0gj7fFfOXlVSVl/taOgwkOAoe1y/tX2BPv8LsL9O0U/e3Xcn7o7LV
         59hwQPtQcUjEMOKDsViBwFZDNgbcE0xzBwHV1TA5sWxUgVptqvS5AEDNYpnMaxL0g00o
         JYBugH3QoWHM6M+vWsASy3zzbYRyF5vkYxzyv/7qbzv8kFgXL88MVD6LzIa2xK99C+mU
         i0palnV6CsAf2m22U1bZV7ZxOSGFyW0bCtuxv31dTjPAIVeqRcvmuvFpt2L6+aioiJth
         KCOJRIjybL09o6B3Zj+aEUjwK6irkT8IAADHSEzalq3IXRTXbOH7AHYpS4yyb3JsEe2G
         0asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvUbrKBLZESMWSFGr9nCS7XUBmQQoaeWoZeV8VwbhD8=;
        b=oGxApazt6gd7RoN/uPF2buEwygrInUD2TvaeG7SSu+q03pdMtzWAVxUOfnRAmcx2pE
         uvejxm6tTcux4k3PSrtkOeUfVz8r0q4fivV9BzrH/5c6V+bDg1SchQ2vEKx57UNDLJug
         /GZi9PYVzK7IaBfaJpNxUjt3BgbLTejXs0aFhFlHlr/CDcfdZduvbI5ccmW9nfUpFnFE
         DGLtF5F8WU1GAQDqe+ZzkXgRc+xqETFA3BLZaefEmCWGuLzxHpOvrDo0tdfy4bS6c64o
         HTRC9dyUsyFhfNNf0VbaI0YkwAG0+XHpVY4NH4/H2Nv2CyRRo7hJKV0rmSB9YLyRqCSK
         QFgg==
X-Gm-Message-State: AOAM531IuxWZhNn/+vTj5/PpZ6y8Ve+YlvQ+tBwpw5s9JwYvmoFzo1fh
        758T2vAs0aQJ7XpcOtnlseNOSNN0foU=
X-Google-Smtp-Source: ABdhPJwJw5Alo6eia3+O96JdvfvTQks5OVvE94/fkwvF/RiSMPJr6xUu4e1tVJz999GPP8M3Ru8Gkg==
X-Received: by 2002:a63:5703:: with SMTP id l3mr4287065pgb.344.1614368184427;
        Fri, 26 Feb 2021 11:36:24 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:23 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 0/5] Improve group scanning in CR 0 and CR 1 passes
Date:   Fri, 26 Feb 2021 11:36:07 -0800
Message-Id: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: improve cr 0 and cr 1 passes

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

Changes from V2:
----------------
- Added mb_linear_limit sysfs tunable that controls how many groups
  should the allocator search in linear fashion before consulting the
  the new data structures.
- Added following optimizations:
  * Full groups are not added to either structures
  * MB_OPTIMIZE_SCAN is disabled for small file systems
- Updated documentation in the code
- Made output of mb_structs_summary output file to be YAML compatible
- Small fixes to change location of increment ac_groups_considered
  variable and added missed MB_NUM_ORDERS macro

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (5):
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: add mballoc stats proc file
  ext4: add MB_NUM_ORDERS macro
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures

 fs/ext4/ext4.h    |  24 +-
 fs/ext4/mballoc.c | 541 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/mballoc.h |  20 ++
 fs/ext4/super.c   |   6 +-
 fs/ext4/sysfs.c   |   6 +
 5 files changed, 564 insertions(+), 33 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

