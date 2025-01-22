Return-Path: <linux-ext4+bounces-6209-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EBFA190E2
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3793E16A172
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D82212F9B;
	Wed, 22 Jan 2025 11:47:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4F2116E9;
	Wed, 22 Jan 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546448; cv=none; b=VbcXeLCgXlX6NhcUie6hKJr3kRib3/6h+wHpJKaBmfXvXKVfnu51KuG0QDmNy8xrvwU4NsZ3aB7m7jbtR7fVILM+Um2OBChXHw+9oDpOsimbnzL785qf8j8gm20QTExqFtVUcYQ4v2Sx+T9rQVwJjwXs1ZReMp1N8Rj94hFh7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546448; c=relaxed/simple;
	bh=7b5O0NvmGWMh8OnvqCD3BXSXC88ueUuHJtbapbt613I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krCsDM/Mr1plCNiBsGBjvhPfthAnOLg3uv2RF48xkUj7b3HElIXoZletllfyzqdBmq5KrgmN+zbQkZNSP9uMDWUtRY5sq9Pl6s8ETQAnyQJj3Rjh2t2UFvU2jllq3inGPhXJhJNL78Xf0BAZnQGHdlUF+xuE1t/rUNNpaVtJzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdMkF4PTjz4f3jdH;
	Wed, 22 Jan 2025 19:47:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4040D1A08FC;
	Wed, 22 Jan 2025 19:47:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S9;
	Wed, 22 Jan 2025 19:47:22 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 5/7] ext4: correct behavior under errors=remount-ro mode
Date: Wed, 22 Jan 2025 19:41:28 +0800
Message-Id: <20250122114130.229709-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S9
X-Coremail-Antispam: 1UD129KBjvJXoWxArWfAFyUZw4fZr13Cr4fuFg_yoW5Gr47pF
	WfC3WkZFWvvF10939xWayxZay2ga1IkayUCr47C34xXrZ8Ar1fZF4xtF1YgFykWrZ7Xa45
	Zr1xKrW7u3y3CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JU9Aw3UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMO7QABsU

From: Baokun Li <libaokun1@huawei.com>

And after commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag") in
v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in ext4_handle_error() under
errors=remount-ro mode. This causes the read to fail even when the error
is triggered in errors=remount-ro mode.

To correct the behavior under errors=remount-ro, EXT4_FLAGS_SHUTDOWN is
replaced by the newly introduced EXT4_FLAGS_EMERGENCY_RO. This new flag
only prevents writes, matching the previous behavior with SB_RDONLY.

Fixes: 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
Closes: https://lore.kernel.org/all/22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com/
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d8116c9c2bd0..098e62727aec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -708,11 +708,8 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (!continue_fs && !sb_rdonly(sb)) {
-		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
-		if (journal)
-			jbd2_journal_abort(journal, -EIO);
-	}
+	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
+		jbd2_journal_abort(journal, -EIO);
 
 	if (!bdev_read_only(sb->s_bdev)) {
 		save_error_info(sb, error, ino, block, func, line);
@@ -738,17 +735,17 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 			sb->s_id);
 	}
 
-	if (sb_rdonly(sb) || continue_fs)
+	if (ext4_emergency_ro(sb) || continue_fs)
 		return;
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 	/*
-	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
-	 * modifications. We don't set SB_RDONLY because that requires
-	 * sb->s_umount semaphore and setting it without proper remount
-	 * procedure is confusing code such as freeze_super() leading to
-	 * deadlocks and other problems.
+	 * We don't set SB_RDONLY because that requires sb->s_umount
+	 * semaphore and setting it without proper remount procedure is
+	 * confusing code such as freeze_super() leading to deadlocks
+	 * and other problems.
 	 */
+	set_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
 }
 
 static void update_super_work(struct work_struct *work)
-- 
2.39.2


