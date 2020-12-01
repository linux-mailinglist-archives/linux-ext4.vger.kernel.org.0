Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316AC2C9617
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 04:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgLADvF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Nov 2020 22:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgLADvF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Nov 2020 22:51:05 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628DC0613CF
        for <linux-ext4@vger.kernel.org>; Mon, 30 Nov 2020 19:50:19 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id t12so391235pjq.5
        for <linux-ext4@vger.kernel.org>; Mon, 30 Nov 2020 19:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kczptwppcT6Uz8lxbIimMTjrCcUO3Sl8093u1Pe71zk=;
        b=pLqQ1c0naBsXPSN7kj9dbeT0XoKaQTP43pNWsFQV5MjZJsXLw1PQxFUCgFCg+wxXlo
         eLaC2WSZz6L5QlUnXqhl5Dc7am8cbcDyU5isN9+IaiKL7B/vK/ZsVEsvHTM4eZJKGnIT
         KQkDGJy6wjVhWDvqufuPkFGqBT8S5r7WbS4eT/CniVgiXE+JLP64J8yHk0trFRo4gKnF
         7r1oLHaHecsBr6udMQzZ+8tjlLGkHhAyQBsJ68n8mAaqj7nhZ3mLV7uXz7GA4pVuurS3
         JFixgAgNcr8X39n0/xJxnu0RPEq9tJkCINr9p3RN6ycoD2oo2BKV6dFY71H1Pw9UUE7n
         7GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kczptwppcT6Uz8lxbIimMTjrCcUO3Sl8093u1Pe71zk=;
        b=nV+ycdOwwHMjKW0i8pPFhiZAE/K9xCCez4bEc8EhZBVop9MB633UpeL6o9vZSM5A8Q
         P5502z02jIw+l472KB4JdSYNAQ+CpLy+C78kvyjC0fmV+Pq7gU2E5v6/J0/gnZSc/M/J
         p0ltmUNwix59R63mk+L6E1h+L/3EwvPrhTUHgBNpVel4yUyXuKJfxNjaz+3amEfN63ib
         +IisQDrQ/47ARFFaHNgYi0Vth5rYBTa+ZQvrobTv1rmLaDUjSvQLcsVeKx8qjoo7/woj
         5aygCVNWB/afct9wAxyO5Er/rj0/V7HMdX6/9dcyoLmJY7hns88j0yV4Tb//z9MbPHFG
         4q+g==
X-Gm-Message-State: AOAM530Ig3sw424VbKb8r2pAICR47GADYE/m77C6VWHExvIoVqqhEG/5
        /IklXD7Kj6mjdopdPMior3zqTMVlx+w=
X-Google-Smtp-Source: ABdhPJzpTU0eOX1F+OeU89XBi4tduW0lztPQtwNaKnVxX6e1T0Bxl0eTFgd8UsszFYeZB7mLxzMYvA==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr663733pjl.169.1606794618906;
        Mon, 30 Nov 2020 19:50:18 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id js9sm1160417pjb.2.2020.11.30.19.50.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 19:50:18 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     bzzz@whamcloud.com, linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: avoid s_mb_prefetch to be zero in individual scenarios
Date:   Tue,  1 Dec 2020 11:49:35 +0800
Message-Id: <1606794575-6230-1-git-send-email-brookxu@tencent.com>
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

 PID: 3873   TASK: ffff88800f11d880  CPU: 2   COMMAND: "executor"
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

The maximum size of a single IO will be limited by multiple factors,
such as max_hw_sectors, max_dev_sectors, BLK_DEF_MAX_SECTORS. The
max_hw_sectors, max_dev_sectors are determined by the device, and
BLK_DEF_MAX_SECTORS is a constant. In most scenarios, users will not
modify max_sectors. Therefore, we can safely assume that the maximum
size of a single IO is BLK_DEF_MAX_SECTORS. So far, we have determined
the number of blocks that a single IO can hold. Usually the file
system block is a multiple of the disk block, but we will ignore this
for now. According to the current value of BLK_DEF_MAX_SECTORS and
comprehensive considerations, the maximum number of bitmap blocks that
can be loaded by a single IO can be safely limited to 2^12. This maybe
a good choice to solve divide zero problem and avoiding performance
degradation.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
---
 fs/ext4/mballoc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 24af9ed..06af4ca 100644
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
@@ -2700,7 +2701,7 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	ext4_group_t i;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int err;
+	int err, log;
 	struct ext4_group_desc *desc;
 	struct ext4_group_info ***group_info;
 	struct kmem_cache *cachep;
@@ -2733,7 +2734,8 @@ static int ext4_mb_init_backend(struct super_block *sb)
 
 	if (ext4_has_feature_flex_bg(sb)) {
 		/* a single flex group is supposed to be read by a single IO */
-		sbi->s_mb_prefetch = 1 << sbi->s_es->s_log_groups_per_flex;
+		log = min_t(unsigned char, 12, sbi->s_es->s_log_groups_per_flex);
+		sbi->s_mb_prefetch = 1 << log;
 		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
 	} else {
 		sbi->s_mb_prefetch = 32;
-- 
1.8.3.1

