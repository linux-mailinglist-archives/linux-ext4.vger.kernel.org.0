Return-Path: <linux-ext4+bounces-5681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF09F418B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 05:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CE16C858
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDDB14F108;
	Tue, 17 Dec 2024 04:05:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436E1EEE0;
	Tue, 17 Dec 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408354; cv=none; b=ZTonGlkeHP9h+5aeXN6Gq8Z1d6vptyr0Ru5LFmrGqKbEPJ1Kcr2PM3TKmKAH9OPQHH3F52gS214AXuxXwti3UkYGS4AOUpWOdZTXYvDt7/2YjMzZStfO1khc2kI76jUqstdO9bnRWu725cEPeSkBA8NFbtAdOdPl6viefqLAwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408354; c=relaxed/simple;
	bh=2v7fSlTKIeFhWdchzHD0EJ22oaD3v8QZn7F4U1+CnX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MS7kfuRoyrPpSuEULHv9ozKYBNGjRYn4X0Ar3noqy+gSAdT43L4pFmByhwh97RldOVe9hAV6TkmxrcN7M+qPqJqF0pfkbotylisr1+ca+I71xGQYfwDjN9RcbNxnYHmKXuKI0l2BZEQsbp2vsE4XOpzuEcaXzohPefd8xHmyj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC3BQ0t3Wz4f3jqb;
	Tue, 17 Dec 2024 12:05:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 88CA71A018D;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3VsOb+GBnwxC_Eg--.2804S4;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] jbd2: remove unused transaction->t_private_list
Date: Tue, 17 Dec 2024 20:03:55 +0800
Message-Id: <20241217120356.1399443-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3VsOb+GBnwxC_Eg--.2804S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kXFWDAw4xKr4fGryfZwb_yoW8tF4UpF
	95C3WIqryrCryUArn7Gr48JrW2qF4vkrWUGFyqk3Z3Ca17Kwn29FZrtrya9F98tr4F9ayj
	qF129ryUur4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3s2-
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

After we remove ext4 journal callback, transaction->t_private_list is
not used anymore. Just remove unused transaction->t_private_list.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 Documentation/filesystems/journalling.rst | 2 --
 fs/jbd2/transaction.c                     | 1 -
 include/linux/jbd2.h                      | 6 ------
 3 files changed, 9 deletions(-)

diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 0254f7d57429..74f6aa2e1009 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -112,8 +112,6 @@ so that you can do some of your own management. You ask the journalling
 layer for calling the callback by simply setting
 ``journal->j_commit_callback`` function pointer and that function is
 called after each transaction commit. You can also use
-``transaction->t_private_list`` for attaching entries to a transaction
-that need processing when the transaction commits.
 
 JBD2 also provides a way to block all transaction updates via
 jbd2_journal_lock_updates() /
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..9fe17e290c21 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -92,7 +92,6 @@ static void jbd2_get_transaction(journal_t *journal,
 	atomic_set(&transaction->t_outstanding_revokes, 0);
 	atomic_set(&transaction->t_handle_count, 0);
 	INIT_LIST_HEAD(&transaction->t_inode_list);
-	INIT_LIST_HEAD(&transaction->t_private_list);
 
 	/* Set up the commit timer for the new transaction. */
 	journal->j_commit_timer.expires = round_jiffies_up(transaction->t_expires);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 50f7ea8714bf..90c802e48e23 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -700,12 +700,6 @@ struct transaction_s
 
 	/* Disk flush needs to be sent to fs partition [no locking] */
 	int			t_need_data_flush;
-
-	/*
-	 * For use by the filesystem to store fs-specific data
-	 * structures associated with the transaction
-	 */
-	struct list_head	t_private_list;
 };
 
 struct transaction_run_stats_s {
-- 
2.30.0


