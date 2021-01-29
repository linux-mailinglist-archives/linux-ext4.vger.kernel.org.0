Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62453309019
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhA2Wa6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhA2Waw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 17:30:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37731C061573
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:08 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t29so7111557pfg.11
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1byzGTGYyQ7r7tZl14Kq5r8DcDQ1Gg2XNx6fgc0aNGM=;
        b=lEnqJFmqHMM1cKxrc1sLbBgaKvA03ERpBJsvFBTa5Y7x5WLE0D4KSHQt19bx+x+T0u
         ubp+NQC/IZIBBjRum8bTlNdERK+9LRlDgUGn/QjTxLJBJqkooHcmwUCNlWew6QNui2dO
         OxCFZUUPj5rYZspsgozofOmncRCj28XXyXbTbdDVFUczgs8mtL2vjLTbZDGQOBD+9+hu
         oMk30fF/ZLu4mGWgHKDc3FjijpvlxkA15yrkBHB0029Wmof0AIQKtRHcuxMKbRgsEl5z
         ptHJ57SL+60Y8akuTapn8/ts5iKYVoGOc4Y2x0wi1zQAVjtjRZUXj4F3aFJwgR4wFY+N
         77Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1byzGTGYyQ7r7tZl14Kq5r8DcDQ1Gg2XNx6fgc0aNGM=;
        b=jCaVp2M0kvwgfdE2OiO1lyNlfJFYL+H57LPX/awvhYlxNwPxLnyZlZz1ZGNW4ZN4GN
         YL9+FlRYVqFW24EfH7RJVDD8F5kFVZcfmlLb5kMijaZOPFbIwhfu8u8AzgHhc2Vvn8J6
         7ZDhxaNPRAGQ4UO0xCSb8jfZ+Gvjf5BcsI5ctaQb54f3Uz79VR40xeS7JW4gCfEjux0G
         WDLB6pPQv0I8h3ZMDUeD3H/dp6DDgCjJL57V1E071dUfIO0zQfeEtW4ZNVKB21FMA5OT
         BEBSZt8YmfFu8NlqgdgXPjAW8a3vjGN06kASZEqmessa4vqN1KKXOyeHTMnwqpPErYfY
         8Hlw==
X-Gm-Message-State: AOAM531Ca8KvsVFMTEHto6CoaN5b4k9P9DMW6btn6urmFCmj12UkYMhc
        dk2vfqF0SIz5YvcVzyeNV7m8bxSC4sQ=
X-Google-Smtp-Source: ABdhPJzOug/onM7tV+4MK+/ekOEy99KGxU/kaC2bH650C/kCDd8OMMjEm7ZwF6VXPlhz0kAfir67XA==
X-Received: by 2002:a62:774a:0:b029:1be:ca30:53ad with SMTP id s71-20020a62774a0000b02901beca3053admr6289937pfc.42.1611959407275;
        Fri, 29 Jan 2021 14:30:07 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id d14sm9719358pfo.156.2021.01.29.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:30:05 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 0/4] Improve group scanning in CR 0 and CR 1 passes
Date:   Fri, 29 Jan 2021 14:29:27 -0800
Message-Id: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
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
fragment size > the request size. so, this patch introduces new data
structure that allow us to perform cr 0 lookup in constant time and cr
1 lookup in log (number of groups) time instead of linear.

For cr 0, we add a list for each order and all the groups are enqueued
to the appropriate list. This allows us to lookup a match at cr 0 in
constant time.

For cr 1, we add a new rb tree of groups sorted by largest fragment
size. This allows us to lookup a match for cr 1 in log (num groups)
time.

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

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (4):
  ext4: add MB_NUM_ORDERS macro
  ext4: drop s_mb_bal_lock and convert protected fields to atomic
  ext4: improve cr 0 / cr 1 group scanning
  ext4: add proc files to monitor new structures

 fs/ext4/ext4.h    |  12 +-
 fs/ext4/mballoc.c | 330 ++++++++++++++++++++++++++++++++++++++++++----
 fs/ext4/mballoc.h |   6 +
 fs/ext4/sysfs.c   |   2 +
 4 files changed, 324 insertions(+), 26 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

