Return-Path: <linux-ext4+bounces-6148-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C000A14B28
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 09:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36588188C3E7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F591F91D8;
	Fri, 17 Jan 2025 08:28:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EF1F8922;
	Fri, 17 Jan 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102532; cv=none; b=VlZwbiyhWq79zwZNgxbnUyOSvCmVSptI5aDqKKJIKFrIEDZ2pRwuqPGfcpQ88sZtDFtmuaOw3sJJc+4GtbqqLJXVYbehczrLvnZtXT0qVNC2hcsPehilUGFKOxKgoz6++Jx5WyEkLcXsAXx7TUskJjhSaQpBof1QT9b6ZwsW8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102532; c=relaxed/simple;
	bh=FB0gESHxwMdQ69uZNbzlzp81Ufa4xiL2O6BYs2iAwYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqwx9RW27mKdPl2eQvW25boSra9rAnmQ2qm9WKOC6eeESzPldois3VGtzHmqK6FCrON8H2f6G9HVL1xpE7Ji4LMTHZTzFNZAt1+AeUYyaMMbb55/5blk9bwZbP9paGy3VSnTSeb6gUjtWWPHwj4xr0rj3NupAgdfBH/2zy7U/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YZCYQ2Hczz4f3jRG;
	Fri, 17 Jan 2025 16:28:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF7321A1518;
	Fri, 17 Jan 2025 16:28:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+5FIpnZbnIBA--.46013S9;
	Fri, 17 Jan 2025 16:28:46 +0800 (CST)
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
Subject: [PATCH 5/7] ext4: correct behavior under errors=remount-ro mode
Date: Fri, 17 Jan 2025 16:23:13 +0800
Message-Id: <20250117082315.2869996-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250117082315.2869996-1-libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+5FIpnZbnIBA--.46013S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1UZF1rWFWxCFy3CFy8Xwb_yoW8tr47pF
	WrC3WkZrWvvF109a9rWayxXa429a10kFWUCr4I934xXrW5Arn3Zr48tF1Y9FyvgrWxWFyY
	qr1xKry7u3y3CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQALBWeKD3IBkwAAsN

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
---
 fs/ext4/super.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fc5d30123f22..8d9ac8770764 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -707,11 +707,8 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (!continue_fs && !ext4_sb_rdonly(sb)) {
-		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
-		if (journal)
-			jbd2_journal_abort(journal, -EIO);
-	}
+	if (!continue_fs && !ext4_sb_rdonly(sb) && journal)
+		jbd2_journal_abort(journal, -EIO);
 
 	if (!bdev_read_only(sb->s_bdev)) {
 		save_error_info(sb, error, ino, block, func, line);
@@ -741,13 +738,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		return;
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
-	/*
-	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
-	 * modifications. We don't set SB_RDONLY because that requires
-	 * sb->s_umount semaphore and setting it without proper remount
-	 * procedure is confusing code such as freeze_super() leading to
-	 * deadlocks and other problems.
-	 */
+	set_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
 }
 
 static void update_super_work(struct work_struct *work)
-- 
2.39.2


