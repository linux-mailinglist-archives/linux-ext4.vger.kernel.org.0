Return-Path: <linux-ext4+bounces-11985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF35C781D4
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF8CE3544ED
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EF343D9B;
	Fri, 21 Nov 2025 09:17:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBEB2D739F;
	Fri, 21 Nov 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716620; cv=none; b=EYhnT7R2b6P8Kt4lan/dLdpHiEht9V/YF9zhL0CYNX+YIkOaVPV7eKyW9e3P0+eEUuqc/OsFuLwHI7N+lOlkWdDRFwAI1w7LjN0z8cm4fdeJ0PmlzcH3NDSnR1q/bWkB4HblMMjGMYPZ8j5RV6J43ZsPzCXhYSWbGFa8DH2wxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716620; c=relaxed/simple;
	bh=x7mmQ4rl+dwpRTv8LX97qc42tEMEmyb92PE9kqtnaBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7tl6u1fRI3N9HyrCFOgFeYz60+nWaXbafZIOo6MAoxLOQ3zFrcDaaLsINQAdnjlTQiT6Yzr97L2Hnncmvf6NIUx+T3cL723ppvxvPGJwF4VDsRtNG1ap3PVQ0MXPhUG5oExRophvRVedMV86hmEpuUVhav86MWSEfZw6Esx4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCV284lcGzYQvHk;
	Fri, 21 Nov 2025 17:16:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E3F3F1A129F;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S23;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	ebiggers@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH v4 19/24] ext4: support large block size in mpage_prepare_extent_to_map()
Date: Fri, 21 Nov 2025 17:06:49 +0800
Message-Id: <20251121090654.631996-20-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S23
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rWFW3XF4xGw15Cw45Jrb_yoW8WrWfpF
	W5W3ykCr4fX342gFWSgF1DZwsFka4fGayUJFW5tryYva45Kr95uryUtFnYvFn5tFWIyryr
	XF4Skryfua17JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQATBWkf35kfGgABsj

From: Baokun Li <libaokun1@huawei.com>

Use the EXT4_PG_TO_LBLK/EXT4_LBLK_TO_PG macros to complete the conversion
between folio indexes and blocks to avoid negative left/right shifts after
supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f076477e2cf8..2a8a31a2b29e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2618,7 +2618,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	pgoff_t end = mpd->end_pos >> PAGE_SHIFT;
 	xa_mark_t tag;
 	int i, err = 0;
-	int blkbits = mpd->inode->i_blkbits;
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
 	handle_t *handle = NULL;
@@ -2657,7 +2656,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 */
 			if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
 			    mpd->wbc->nr_to_write <=
-			    mpd->map.m_len >> (PAGE_SHIFT - blkbits))
+			    EXT4_LBLK_TO_PG(mpd->inode, mpd->map.m_len))
 				goto out;
 
 			/* If we can't merge this page, we are done. */
@@ -2735,8 +2734,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				mpage_folio_done(mpd, folio);
 			} else {
 				/* Add all dirty buffers to mpd */
-				lblk = ((ext4_lblk_t)folio->index) <<
-					(PAGE_SHIFT - blkbits);
+				lblk = EXT4_PG_TO_LBLK(mpd->inode, folio->index);
 				head = folio_buffers(folio);
 				err = mpage_process_page_bufs(mpd, head, head,
 						lblk);
-- 
2.46.1


