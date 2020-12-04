Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6602CE644
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 04:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgLDDHJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 22:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLDDHJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 22:07:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E07C061A51
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 19:06:28 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so2322420plr.7
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 19:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ViR6Izd8QapysirlVQPOGTU6sGViWusybyXG5Wpai50=;
        b=W0ntIYl7t+F+xana+T1oCCKUDfhGHeqSS8U3VLg4FhyXZYPHpWTXq2vWKpyeLi3/Yf
         Crz7wvqFDF9OY17Mu123OctxkjmjHYxy1iiHWpKOIwqMu657FD5F9fgjXoEm74nMiVe4
         W7b7kMBqBG6c18L9pSirCPjbIjNZ77iaQnIs2UgxpL7V9LljsM4jJdW1avs8GOdWk/Yr
         FoQjuHc/NGax7AXEJqi0yfCj56HDaK710RTfgYkJMsADGIIOAdfPLf7+Un2hOhfR/buU
         uK5NWLjaW/vXxyQVsa7YX0gMiPIQ/QCR+hB7fs02bcPp26ADXhsLyepVhkxiUTQP/Wbp
         P/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ViR6Izd8QapysirlVQPOGTU6sGViWusybyXG5Wpai50=;
        b=NHAJwfmABvvIAIUWE6Xe338gpH5VTGQX8YnwHiy7jMlF06NbgqRHce7SJhIg9Fx+dq
         vXSHN95MMOWpcRBiZBNAM3r9BlChDsbT5jq6HH1ClI+YaFiPz2FdvUaXEwIx1zhr/KjQ
         PVJcbPW08bXejHr0EA9W3uYvBe3nYO+jo+HxLRf9LXdXt4j4c/8fGZip8PcCLVx8o0Z5
         bDR9TVVs+ozz5BRK5Oyekiv3bQ4Jj4EX6tB/ySmNqWRDDHFuNK8QqCKbk2IXj55bdkCt
         S14DBhrPWoyhSX+mnAYR9A39UjGLMUjGK6W0lfirRGetLFbuxM6nLBoXTd3NQHps7MC+
         wH2Q==
X-Gm-Message-State: AOAM532YZRCzig6pofIB2otKCMT0vcrBkiqy6EMGWX7ZASICmH2vBlH/
        wIhggX9Tu5FOam1k+CyrBSpNmZeLtSY=
X-Google-Smtp-Source: ABdhPJzZ82V6GDP7xaj8x0vHnYFfwpWtL71yY+0ySdsPlfuSnhslp/rD5xbnFy16Cft6TOdrbj1/ag==
X-Received: by 2002:a17:90a:1c09:: with SMTP id s9mr2100123pjs.83.1607051188435;
        Thu, 03 Dec 2020 19:06:28 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id w22sm2959219pfu.33.2020.12.03.19.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 19:06:27 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     bzzz@whamcloud.com, linux-ext4@vger.kernel.org
Subject: [PATCH v2] ext4: avoid s_mb_prefetch to be zero in individual scenarios
Date:   Fri,  4 Dec 2020 11:05:43 +0800
Message-Id: <1607051143-24508-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

patch cfd7323 introduces block bitmap prefetch, and expects to read
block bitmaps of flex_bg through an IO. However, it seems to ignore
the value range of s_log_groups_per_flex. In the scenario where the
value of s_log_groups_per_flex is greater than 27, s_mb_prefetch or
s_mb_prefetch_limit will overflow, cause a divide zero exception.

In addition, the logic of calculating nr maybe also flawed, because
the size of flexbg is fixed during a single mount, but s_mb_prefetch
can be modified, which causes nr to fail to meet the value condition
of [1, flexbg_size].

 PID: 3873   TASK: ffff88800f11d880  CPU: 2   COMMAND: "executor.4"
 #0 [ffff8880114a6ec0] __show_regs.cold.7 at ffffffff83cf29e2
 #1 [ffff8880114a6f40] do_trap at ffffffff81065c61
 #2 [ffff8880114a6f98] do_error_trap at ffffffff81065d65
 #3 [ffff8880114a6fe0] exc_divide_error at ffffffff83dd2fd4
 #4 [ffff8880114a7000] asm_exc_divide_error at ffffffff83e00872
    [exception RIP: ext4_mb_regular_allocator+3885]
    RIP: ffffffff8191258d  RSP: ffff8880114a70b8  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffffffff8191257a
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000005
    RBP: 0000000000000200   R8: ffff88800f11d880   R9: ffffed1001e23b11
    R10: ffff88800f11d887  R11: ffffed1001e23b10  R12: ffff888010147000
    R13: 0000000000000000  R14: 0000000000000002  R15: dffffc0000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffff8880114a7260] ext4_mb_new_blocks at ffffffff8191b6ba
 #6 [ffff8880114a7420] ext4_new_meta_blocks at ffffffff81870d6f
 #7 [ffff8880114a74e8] ext4_xattr_block_set at ffffffff819ced37
 #8 [ffff8880114a7758] ext4_xattr_set_handle at ffffffff819d4776
 #9 [ffff8880114a7928] ext4_xattr_set at ffffffff819d501b
    RIP: 000000000045eb29  RSP: 00007ff74e97bc38  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000000000055bf00  RCX: 000000000045eb29
    RDX: 00000000200000c0  RSI: 0000000020000080  RDI: 0000000020000040
    RBP: 00000000004b068e   R8: 0000000000000001   R9: 0000000000000000
    R10: 0000000000000002  R11: 0000000000000246  R12: 000000000055bf00
    R13: 00007fff50fc111f  R14: 00007ff74e97bdc0  R15: 0000000000022000
    ORIG_RAX: 00000000000000bc  CS: 0033  SS: 002b

To solve this problem, we need to set the upper limit of s_mb_prefetch.
Since we expect to load block bitmaps of a flex_bg through an IO, we
can consider determining a reasonable upper limit among the IO limit
parameters. Comprehensive consideration, we take BLK_MAX_SEGMENT_SIZE.
This maybe a good choice to solve divide zero problem and avoiding
performance degradation.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/mballoc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 24af9ed..e3ea7af 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2395,9 +2395,10 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 
 				nr = sbi->s_mb_prefetch;
 				if (ext4_has_feature_flex_bg(sb)) {
-					nr = (group / sbi->s_mb_prefetch) *
-						sbi->s_mb_prefetch;
-					nr = nr + sbi->s_mb_prefetch - group;
+					nr = 1 << sbi->s_log_groups_per_flex;
+					if (group & (nr - 1))
+						nr -= group & (nr - 1);
+					nr = min(nr, sbi->s_mb_prefetch);
 				}
 				prefetch_grp = ext4_mb_prefetch(sb, group,
 							nr, &prefetch_ios);
@@ -2732,8 +2733,12 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	}
 
 	if (ext4_has_feature_flex_bg(sb)) {
+		int len;
+
 		/* a single flex group is supposed to be read by a single IO */
-		sbi->s_mb_prefetch = 1 << sbi->s_es->s_log_groups_per_flex;
+		len = min(BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9),
+			  1 << sbi->s_es->s_log_groups_per_flex);
+		sbi->s_mb_prefetch = len;
 		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
 	} else {
 		sbi->s_mb_prefetch = 32;
-- 
1.8.3.1

