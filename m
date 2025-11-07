Return-Path: <linux-ext4+bounces-11671-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F79C40792
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC69425A0E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D889337B85;
	Fri,  7 Nov 2025 14:51:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CE334C06;
	Fri,  7 Nov 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527099; cv=none; b=N916J5XujgdWgD4VB1GlHAKT/c/PB6SjJFYQ3v8oOUe+GqQe1eeM+tjeeez7Q5fc7PMH9zzzfWZrfo7SOExgsWbZLxAl5qThL93cR1nj9eZvTurZoz3oB8TQIUqz80li0+zTkdLj0BfPcYAEH/WsQjkEGYqaBFw/MU8CL8zc9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527099; c=relaxed/simple;
	bh=8z07ORJLuvNM84vCR2wCkKmp4t1hudpgLUW5sLQvkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0qEGwzbDs6qeaYxrI1RrBWidoAIq5S/Y6Xl0xvPPfJEHCvHlDVa7eNKKIspXpTPIGndba539a0+Qv4mU3XRD3uE5dchaf4Gv0blSnAxzHlXBdk5bFRxuTFbwdvVea9a+IAFclbDukiLR8zD03JGhdD/Mpp+X/eF6t0aKWGXxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d327Q01hqzKHMhQ;
	Fri,  7 Nov 2025 22:51:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5251E1A0EE1;
	Fri,  7 Nov 2025 22:51:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S17;
	Fri, 07 Nov 2025 22:51:24 +0800 (CST)
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
Subject: [PATCH v2 13/24] ext4: support large block size in ext4_mb_init_cache()
Date: Fri,  7 Nov 2025 22:42:38 +0800
Message-Id: <20251107144249.435029-14-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251107144249.435029-1-libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S17
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1ktr1DWw4UKFyfKr4UArb_yoWruw4Dpa
	9xKr15Gr18Wa9rW3ZrWayvvF1fG34xZF47GFWxXr1xCFy7Xw1FgFnrtr18JryUtFZrJF95
	XF15Ar13ZF1UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAFBWkNxrUVIQAAsi

From: Baokun Li <libaokun1@huawei.com>

Currently, ext4_mb_init_cache() uses blocks_per_page to calculate the
folio index and offset. However, when blocksize is larger than PAGE_SIZE,
blocks_per_page becomes zero, leading to a potential division-by-zero bug.

Since we now have the folio, we know its exact size. This allows us to
convert {blocks, groups}_per_page to {blocks, groups}_per_folio, thus
supporting block sizes greater than page size.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b454a41dd6c1..3f10c64ab2b1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1329,26 +1329,25 @@ static void mb_regenerate_buddy(struct ext4_buddy *e4b)
  * block bitmap and buddy information. The information are
  * stored in the inode as
  *
- * {                        page                        }
+ * {                        folio                        }
  * [ group 0 bitmap][ group 0 buddy] [group 1][ group 1]...
  *
  *
  * one block each for bitmap and buddy information.
- * So for each group we take up 2 blocks. A page can
- * contain blocks_per_page (PAGE_SIZE / blocksize)  blocks.
- * So it can have information regarding groups_per_page which
- * is blocks_per_page/2
+ * So for each group we take up 2 blocks. A folio can
+ * contain blocks_per_folio (folio_size / blocksize)  blocks.
+ * So it can have information regarding groups_per_folio which
+ * is blocks_per_folio/2
  *
  * Locking note:  This routine takes the block group lock of all groups
- * for this page; do not hold this lock when calling this routine!
+ * for this folio; do not hold this lock when calling this routine!
  */
-
 static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 {
 	ext4_group_t ngroups;
 	unsigned int blocksize;
-	int blocks_per_page;
-	int groups_per_page;
+	int blocks_per_folio;
+	int groups_per_folio;
 	int err = 0;
 	int i;
 	ext4_group_t first_group, group;
@@ -1365,27 +1364,24 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 	sb = inode->i_sb;
 	ngroups = ext4_get_groups_count(sb);
 	blocksize = i_blocksize(inode);
-	blocks_per_page = PAGE_SIZE / blocksize;
+	blocks_per_folio = folio_size(folio) / blocksize;
+	WARN_ON_ONCE(!blocks_per_folio);
+	groups_per_folio = DIV_ROUND_UP(blocks_per_folio, 2);
 
 	mb_debug(sb, "init folio %lu\n", folio->index);
 
-	groups_per_page = blocks_per_page >> 1;
-	if (groups_per_page == 0)
-		groups_per_page = 1;
-
 	/* allocate buffer_heads to read bitmaps */
-	if (groups_per_page > 1) {
-		i = sizeof(struct buffer_head *) * groups_per_page;
+	if (groups_per_folio > 1) {
+		i = sizeof(struct buffer_head *) * groups_per_folio;
 		bh = kzalloc(i, gfp);
 		if (bh == NULL)
 			return -ENOMEM;
 	} else
 		bh = &bhs;
 
-	first_group = folio->index * blocks_per_page / 2;
-
 	/* read all groups the folio covers into the cache */
-	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
+	first_group = EXT4_PG_TO_LBLK(inode, folio->index) / 2;
+	for (i = 0, group = first_group; i < groups_per_folio; i++, group++) {
 		if (group >= ngroups)
 			break;
 
@@ -1393,7 +1389,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 		if (!grinfo)
 			continue;
 		/*
-		 * If page is uptodate then we came here after online resize
+		 * If folio is uptodate then we came here after online resize
 		 * which added some new uninitialized group info structs, so
 		 * we must skip all initialized uptodate buddies on the folio,
 		 * which may be currently in use by an allocating task.
@@ -1413,7 +1409,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 	}
 
 	/* wait for I/O completion */
-	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
+	for (i = 0, group = first_group; i < groups_per_folio; i++, group++) {
 		int err2;
 
 		if (!bh[i])
@@ -1423,8 +1419,8 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 			err = err2;
 	}
 
-	first_block = folio->index * blocks_per_page;
-	for (i = 0; i < blocks_per_page; i++) {
+	first_block = EXT4_PG_TO_LBLK(inode, folio->index);
+	for (i = 0; i < blocks_per_folio; i++) {
 		group = (first_block + i) >> 1;
 		if (group >= ngroups)
 			break;
@@ -1501,7 +1497,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 
 out:
 	if (bh) {
-		for (i = 0; i < groups_per_page; i++)
+		for (i = 0; i < groups_per_folio; i++)
 			brelse(bh[i]);
 		if (bh != &bhs)
 			kfree(bh);
-- 
2.46.1


