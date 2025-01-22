Return-Path: <linux-ext4+bounces-6198-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF4A19059
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC4616BA4F
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD8212B2F;
	Wed, 22 Jan 2025 11:11:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D5211708;
	Wed, 22 Jan 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544293; cv=none; b=j4AwQegE6uq5eJAjiaBRnfmBVeNaj1WpzJFCkTgOyop/sDB+a+3gtyBLrqxdamAtdxJX9nJAnl6+gaBEb/yMehJIUIny1JtgGa6Aul4bsnRYfi5oYn7HpJA1b7F8zxEun/mXsYNgh/B7tQtiFXYEJ/lPJ9JRjNPRuVMtH/eZECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544293; c=relaxed/simple;
	bh=fIAkcKYMDllIW6WkfHlYd44GaNc9ji80+BmQsRxIHQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFyWEOA5TWC7xRaVkSTCMzqdduC/dymGr1zJpbixVAm5gr9zfmjeL4vyXivbKq35aJkMywO/OfDBhJpvIGsgdHcKUkQiJyp/mu2Na2XuYgIUK32O64ADYTELjBKcJKwmkMZVoUO5d0vt4P0L5MJGPrJH6nnDe5N3DsuAUvZh6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdLwx2B9Gz4f3jqw;
	Wed, 22 Jan 2025 19:11:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BBDF81A0E59;
	Wed, 22 Jan 2025 19:11:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19Z0pBnW0KsBg--.50502S10;
	Wed, 22 Jan 2025 19:11:28 +0800 (CST)
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
Subject: [PATCH v3 6/9] jbd2: drop JBD2_ABORT_ON_SYNCDATA_ERR
Date: Wed, 22 Jan 2025 19:05:30 +0800
Message-Id: <20250122110533.4116662-7-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122110533.4116662-1-libaokun@huaweicloud.com>
References: <20250122110533.4116662-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19Z0pBnW0KsBg--.50502S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13Cw1fWw18CFWrXw48Crg_yoW5JrW7pF
	95Ga40yrWDZFW8Crs7WFsrArWYq3yFkFWUWFn8uw1Fga17t3WfK3y2qryftas0vrsa9w40
	qFy7C347u34qvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMNLgABsU

From: Baokun Li <libaokun1@huawei.com>

Since ext4's data_err=abort mode doesn't depend on
JBD2_ABORT_ON_SYNCDATA_ERR anymore, and nobody else uses it, we can
drop it and only warn in jbd2 as it used to be long ago.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c      | 4 ----
 fs/jbd2/commit.c     | 6 ++----
 include/linux/jbd2.h | 3 ---
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8bff0d3f807e..87f5ab48b7f4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5785,10 +5785,6 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 		journal->j_flags |= JBD2_BARRIER;
 	else
 		journal->j_flags &= ~JBD2_BARRIER;
-	if (test_opt(sb, DATA_ERR_ABORT))
-		journal->j_flags |= JBD2_ABORT_ON_SYNCDATA_ERR;
-	else
-		journal->j_flags &= ~JBD2_ABORT_ON_SYNCDATA_ERR;
 	/*
 	 * Always enable journal cycle record option, letting the journal
 	 * records log transactions continuously between each mount.
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index e8e80761ac73..b7a76ec1463d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -738,10 +738,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	err = journal_finish_inode_data_buffers(journal, commit_transaction);
 	if (err) {
 		printk(KERN_WARNING
-			"JBD2: Detected IO errors while flushing file data "
-		       "on %s\n", journal->j_devname);
-		if (journal->j_flags & JBD2_ABORT_ON_SYNCDATA_ERR)
-			jbd2_journal_abort(journal, err);
+			"JBD2: Detected IO errors %d while flushing file data on %s\n",
+			err, journal->j_devname);
 		err = 0;
 	}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 561025b4f3d9..f818bae19abf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1388,9 +1388,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_FLUSHED	0x008	/* The journal superblock has been flushed */
 #define JBD2_LOADED	0x010	/* The journal superblock has been loaded */
 #define JBD2_BARRIER	0x020	/* Use IDE barriers */
-#define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
-						 * data write error in ordered
-						 * mode */
 #define JBD2_CYCLE_RECORD		0x080	/* Journal cycled record log on
 						 * clean and empty filesystem
 						 * logging area */
-- 
2.39.2


