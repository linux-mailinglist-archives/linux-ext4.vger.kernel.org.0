Return-Path: <linux-ext4+bounces-11785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01983C4E943
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEBB3B7352
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39EA3451AB;
	Tue, 11 Nov 2025 14:35:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FD338586;
	Tue, 11 Nov 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871737; cv=none; b=T1R1HDLb2jnoXwH0gDSEcXOxWtXGB1mY4gzLGjSJyJzouO0qUuUbI3jHj66BkKol4a+VixIZd9Sqp9TIcgwptpQrtWWPR9Sig+2opLtTc5IhKznJpQNbRIrh+tuZyuqMGV150vDn8tfaCqZQTzl26mhN5Hq6muQCigZnraA/brE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871737; c=relaxed/simple;
	bh=GUmH/tJHuyD4vWxcAuOvGmfo+GiRreSrhnayX5WBJ1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYHGq0fl2LJo1Y3av/BTK9hpnnCXSam6Lm7tLhN+ZjhawuObkJr/sdsaQoxLo6R4XC4O3afPQGToP7x3CwVT58HvzK5c8r/xzDqnwC+fxGUd9XPE0uIsiCLKk0wCngPrP1/BN1NtSEbpSdGQRbdphLKJ+cBMXZNzKbIAIL5Ya/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5TZs1wvWzYQv3P;
	Tue, 11 Nov 2025 22:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 24C001A0E1E;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S22;
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
Subject: [PATCH v3 18/24] ext4: support large block size in mpage_map_and_submit_buffers()
Date: Tue, 11 Nov 2025 22:26:28 +0800
Message-Id: <20251111142634.3301616-19-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S22
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rWFW3XF4xGw15Cw45Jrb_yoW8Xw1xpF
	W5W3yDWFs5urWI9F4IqF1DZrnrtayIga1UXFWFv34aqFyUKr10krn5t3W8Zan5JFWxtrW8
	XF1SkryxW3W3CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWkSsJdDJQAAs3

From: Baokun Li <libaokun1@huawei.com>

Use the EXT4_PG_TO_LBLK/EXT4_LBLK_TO_PG macros to complete the conversion
between folio indexes and blocks to avoid negative left/right shifts after
supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 80c2860abed2..1ac7ca9479eb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2297,15 +2297,14 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 	struct folio_batch fbatch;
 	unsigned nr, i;
 	struct inode *inode = mpd->inode;
-	int bpp_bits = PAGE_SHIFT - inode->i_blkbits;
 	pgoff_t start, end;
 	ext4_lblk_t lblk;
 	ext4_fsblk_t pblock;
 	int err;
 	bool map_bh = false;
 
-	start = mpd->map.m_lblk >> bpp_bits;
-	end = (mpd->map.m_lblk + mpd->map.m_len - 1) >> bpp_bits;
+	start = EXT4_LBLK_TO_PG(inode, mpd->map.m_lblk);
+	end = EXT4_LBLK_TO_PG(inode, mpd->map.m_lblk + mpd->map.m_len - 1);
 	pblock = mpd->map.m_pblk;
 
 	folio_batch_init(&fbatch);
@@ -2316,7 +2315,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			lblk = folio->index << bpp_bits;
+			lblk = EXT4_PG_TO_LBLK(inode, folio->index);
 			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
 						 &map_bh);
 			/*
-- 
2.46.1


