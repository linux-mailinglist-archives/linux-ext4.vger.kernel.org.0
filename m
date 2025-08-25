Return-Path: <linux-ext4+bounces-9593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BBB334D2
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 05:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC191200B59
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 03:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D84213E89;
	Mon, 25 Aug 2025 03:47:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA728E7;
	Mon, 25 Aug 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756093628; cv=none; b=s+A0OsA1pD+3MpBV9okheKSVZIlT2iQhn8kXPwISKMw/IIp9dWUhsgqJ3B9pbQelEM+Ir3t4KPR+fL0M/BJ3zzuSiB4lZNnvKsLzkAYSK9LrwsX9hpYkR8vZEw8EYBSZ9kkX4QVQYtLyLwEVHbb95ltTqVUgjaYACnrOcieVB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756093628; c=relaxed/simple;
	bh=ci12geZvUE4ohC/4x/GAiLoTapYyh0p67pS8EckDUSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ft4uY27gDJK0AUEKgpMPX4rQoFMe+ERU37eQD216e6l+jCgnAAhnqSVdBS8Q8T3AJYuCAg0oBNqwfFb2aDEdD2mMbjh59pndkykxa6icmnpwk8c6TEKvhC4yK/23fbegkv+DOaQCD5SCSFk11/3XvJOOybgKB3EGkgiIRRZOJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9GvF68g4zYQtM4;
	Mon, 25 Aug 2025 11:47:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 673361A0A25;
	Mon, 25 Aug 2025 11:47:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY613KtopsDUAA--.55486S4;
	Mon, 25 Aug 2025 11:47:03 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix potential null deref in ext4_mb_init()
Date: Mon, 25 Aug 2025 11:38:30 +0800
Message-Id: <20250825033830.2230202-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY613KtopsDUAA--.55486S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF47uw13KF1rtF47CFW7Jwb_yoW5Gw48pw
	n8JFyxKr4UGFyDCan7G3W5Xwn5Ka18WF1UG34fWF1rXF1UtrykCFn2qr1UAFyUKrWkA3Z7
	JFyqqr45tw48CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBWimynOITgABs8

From: Baokun Li <libaokun1@huawei.com>

In ext4_mb_init(), ext4_mb_avg_fragment_size_destroy() may be called
when sbi->s_mb_avg_fragment_size remains uninitialized (e.g., if groupinfo
slab cache allocation fails). Since ext4_mb_avg_fragment_size_destroy()
lacks null pointer checking, this leads to a null pointer dereference.

==================================================================
EXT4-fs: no memory for groupinfo slab cache
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP PTI
CPU:2 UID: 0 PID: 87 Comm:mount Not tainted 6.17.0-rc2 #1134 PREEMPT(none)
RIP: 0010:_raw_spin_lock_irqsave+0x1b/0x40
Call Trace:
 <TASK>
 xa_destroy+0x61/0x130
 ext4_mb_init+0x483/0x540
 __ext4_fill_super+0x116d/0x17b0
 ext4_fill_super+0xd3/0x280
 get_tree_bdev_flags+0x132/0x1d0
 vfs_get_tree+0x29/0xd0
 do_new_mount+0x197/0x300
 __x64_sys_mount+0x116/0x150
 do_syscall_64+0x50/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

Therefore, add necessary null check to ext4_mb_avg_fragment_size_destroy()
to prevent this issue. The same fix is also applied to
ext4_mb_largest_free_orders_destroy().

Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
Fixes: f7eaacbb4e54 ("ext4: convert free groups order lists to xarrays")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..6070d3c86678 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3655,16 +3655,26 @@ static void ext4_discard_work(struct work_struct *work)
 
 static inline void ext4_mb_avg_fragment_size_destroy(struct ext4_sb_info *sbi)
 {
+	if (!sbi->s_mb_avg_fragment_size)
+		return;
+
 	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
 		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
+
 	kfree(sbi->s_mb_avg_fragment_size);
+	sbi->s_mb_avg_fragment_size = NULL;
 }
 
 static inline void ext4_mb_largest_free_orders_destroy(struct ext4_sb_info *sbi)
 {
+	if (!sbi->s_mb_largest_free_orders)
+		return;
+
 	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
 		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
+
 	kfree(sbi->s_mb_largest_free_orders);
+	sbi->s_mb_largest_free_orders = NULL;
 }
 
 int ext4_mb_init(struct super_block *sb)
-- 
2.46.1


