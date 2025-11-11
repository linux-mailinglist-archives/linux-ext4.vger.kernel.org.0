Return-Path: <linux-ext4+bounces-11777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE64C4E93B
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE70F3B4825
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D633F39B;
	Tue, 11 Nov 2025 14:35:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157B3328E9;
	Tue, 11 Nov 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871736; cv=none; b=J5q6xh2fM4inMzujhcztPCwzq8DIt1ikLOLf2JcaLV76MvKTDTkUv5l7ckJKdTQfwt/YPw/7lZOq9XDt4+9pB99dZnB87/xQ/fsAPdOkOpeoXVep26VdyBAFAKTfuBsqnbmmh5BJRKCVpvfPGl8u6XMxMYDsyXpCGw41suN4ZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871736; c=relaxed/simple;
	bh=dVoOH5mGAhrPScTZXWE+bMUY8L1DmWDBNb1pvV1WJ3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkuTh8VPYR5VGAVuPO4RM4+thn43Z67N/5rHJvMkvUDHG1d4MVRKNJ8DqlibBJStqJf/xlhw0Rr3jlwG8c13JHhzwAOeNcIsw6wEpYnKASsQkLnLbZwPXuJDaQoaDfm7QgWUJiupfJo7z2iJCoF6RGlN1nxyD3V4ss3gmlBr9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tb375X5zKHMdt;
	Tue, 11 Nov 2025 22:35:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 30D651A0DFE;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S23;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
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
Subject: [PATCH v3 19/24] ext4: support large block size in mpage_prepare_extent_to_map()
Date: Tue, 11 Nov 2025 22:26:29 +0800
Message-Id: <20251111142634.3301616-20-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251111142634.3301616-1-libaokun@huaweicloud.com>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S23
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rWFW3XF4xGw15Cw45Jrb_yoW8WrWfpF
	W5W3ykCr4fX342gFWSgF1qvwsrtas3GayUJFW5tFyYqa45Kr95uryUtFnYvFs5tFWxAryr
	XF4SkryfWa1xJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWkSsIpDUAAAsc

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
index 1ac7ca9479eb..c09859786563 100644
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


