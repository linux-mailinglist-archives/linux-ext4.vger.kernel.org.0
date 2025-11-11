Return-Path: <linux-ext4+bounces-11779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28EC4E88F
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 410F14F1AA9
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0488340A6D;
	Tue, 11 Nov 2025 14:35:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E5334C28;
	Tue, 11 Nov 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871736; cv=none; b=hzwhhd9lSdJtTFyB+J1kZkiRn6PAvUvSD8kbjtbzgIYv1aRgTtuvd/MfOhsyKh+tugnbPfLloir7LcUN/NGx7hoiBow6vgDTw9L7FGpstDOcbgFmrvjUwza3MtnN8bj3bOAMF4W1KuoD2Xx0UgGmhwe/xq96/4dgi/p+ff3sg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871736; c=relaxed/simple;
	bh=qOpeQrUWEZr22pjL+quL4xX6rvFnH2QQqyJQo9YuSQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r35oxSEo0BKUHf8iXgarIi7l9K1ik6ionJiM4gwlirUhknpj8e6ofBXHjRMzardQuJMCdj4xGJD64fmUC7yVsktLFOnIWD+jFIURoy5Xv2xt+juW/UgE57tuSPYGzyBCnoIdowa1ArTLM4lSBjtHm+siP75ZyC4MuLWz0O5yV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5TZs108JzYQv35;
	Tue, 11 Nov 2025 22:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 05AFA1A0E12;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S20;
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
Subject: [PATCH v3 16/24] ext4: support large block size in ext4_mpage_readpages()
Date: Tue, 11 Nov 2025 22:26:26 +0800
Message-Id: <20251111142634.3301616-17-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S20
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDZFyxGrykZF45tF4Dtwb_yoW8XrWrpa
	93K3WkKFn7WryfuanxXF1kZrn5Ka47CayUXFZ3Xry3WFy7trySkwnFqas5XF4jqrsxZr93
	XF1fWry7AF45XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWkSsJdDJAAHsx

From: Baokun Li <libaokun1@huawei.com>

Use the EXT4_PG_TO_LBLK() macro to convert folio indexes to blocks to avoid
negative left shifts after supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/readpage.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f329daf6e5c7..e7f2350c725b 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -213,9 +213,7 @@ int ext4_mpage_readpages(struct inode *inode,
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
-
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	sector_t next_block;
 	sector_t block_in_file;
@@ -251,9 +249,8 @@ int ext4_mpage_readpages(struct inode *inode,
 
 		blocks_per_folio = folio_size(folio) >> blkbits;
 		first_hole = blocks_per_folio;
-		block_in_file = next_block =
-			(sector_t)folio->index << (PAGE_SHIFT - blkbits);
-		last_block = block_in_file + nr_pages * blocks_per_page;
+		block_in_file = next_block = EXT4_PG_TO_LBLK(inode, folio->index);
+		last_block = EXT4_PG_TO_LBLK(inode, folio->index + nr_pages);
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
 		if (last_block > last_block_in_file)
-- 
2.46.1


