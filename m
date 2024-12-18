Return-Path: <linux-ext4+bounces-5727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231F9F5EEA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 07:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6977A2D45
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1A15852E;
	Wed, 18 Dec 2024 06:56:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD86154457;
	Wed, 18 Dec 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504974; cv=none; b=Gaa374OQ4lyUwL0/0yaZp2745XeX6IpISYJwo+pUBMSYn4nm1p6a+9oyjMQHBpxetEHxTWL3u/5SATfs6cmPliAwFgTfVHQ70fGQYzwRcDthdL+u6Dd85n4g0km3tfX0dHpHZq6G+6sIIFP8kJEGSydIuXmC1x9G9WWsS6JEiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504974; c=relaxed/simple;
	bh=WS94ivXWHTsIrraIOJmCvvBIWd7CABqyh2vbGrLDlkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeCMm8WJdvXX6YdGd52vSo5IDreWVnwMBtmYAsVftJqNrUStXISkOwbJzO0FwkOVN0pW/VHVra6zC5yTG2f4mot12rG2IhQvCIVaag6/LCFj5g8djwylTgwMVgoox85ror57lbmnb9+9BVYQC0a2MOqOMNurKpdXMVxTIPJX34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCkwP2fh3z4f3lDF;
	Wed, 18 Dec 2024 14:55:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E02521A058E;
	Wed, 18 Dec 2024 14:56:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnhMEHcmJnLjMnEw--.53472S4;
	Wed, 18 Dec 2024 14:56:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: corbet@lwn.net,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v2 2/3] jbd2: remove unused transaction->t_private_list
Date: Wed, 18 Dec 2024 22:54:13 +0800
Message-Id: <20241218145414.1422946-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
References: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnhMEHcmJnLjMnEw--.53472S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kXFW7JF45uF1fuw1rZwb_yoW8KFy5pF
	95u3WIqrW5CryUArn7Jr48JrW2vF40krWUGFyjk3Z3Ca17Kwn29FZrtryakF1Dtr4F9ayj
	qF129ryUur4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUa3x6
	UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

After we remove ext4 journal callback, transaction->t_private_list is
not used anymore. Just remove unused transaction->t_private_list.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 Documentation/filesystems/journalling.rst | 4 +---
 fs/jbd2/transaction.c                     | 1 -
 include/linux/jbd2.h                      | 6 ------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 0254f7d57429..863e93e623f7 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -111,9 +111,7 @@ a callback function when the transaction is finally committed to disk,
 so that you can do some of your own management. You ask the journalling
 layer for calling the callback by simply setting
 ``journal->j_commit_callback`` function pointer and that function is
-called after each transaction commit. You can also use
-``transaction->t_private_list`` for attaching entries to a transaction
-that need processing when the transaction commits.
+called after each transaction commit.
 
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


