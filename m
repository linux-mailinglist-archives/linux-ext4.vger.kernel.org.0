Return-Path: <linux-ext4+bounces-5759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59D9F7313
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D6916B419
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4013959D;
	Thu, 19 Dec 2024 03:02:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031350285;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577349; cv=none; b=p3f1OXP00HlwoksrzX6e0gdDG4JUFECLNCRm+S3PWc5Opl9qeQ0k+vM2DXXrYxo7Gnsa0GDg3wTm/1DbmJUPfV+d6PGFo49RUhCEP0xw1iVLFjfYHWoLLfuj02jhTbnZipw2LOwcU79Wbie7inz6V5iTrlSLT9sByph0MtfSg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577349; c=relaxed/simple;
	bh=4NF5PJEuPc3gpNPNtaQ2hIGJ9bYr0mNJNEskpB2NmmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzuP5ZfL/WPJBYepeZi4pAVeLV+99z7RfvdwLt/cLaMqPh+VjK+kjh0tCgctwl8/VG8DGUjS91rBWB1UJQdMYdIIaO6v96c8sEQ/eFy/Fw8pEGwNrkHawwPDOeqYw6EeTmLczST/VAWEOnOe5rECJOtKhDylWcePy9MwOZKb5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDFhC66DRz4f3kFT;
	Thu, 19 Dec 2024 11:02:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 617041A0196;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S5;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ext4: remove unneeded forward declaration in namei.c
Date: Thu, 19 Dec 2024 19:00:24 +0800
Message-Id: <20241219110027.1440876-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUKFW3XFy8JF43Jw47urg_yoW8tF1xpF
	4rJ3W5Kr48XF1DuFW8Zw48Aw1a9w1vgr9rJrZrG34FkFy2qr12q3ZrJr4xZFyrtry8WF12
	yFs8Kry5Ca18WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3G-eDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unneeded forward declaration in namei.c

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/namei.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8ff840ef4730..33670cebdedc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -291,36 +291,6 @@ struct dx_tail {
 	__le32 dt_checksum;	/* crc32c(uuid+inum+dirblock) */
 };
 
-static inline ext4_lblk_t dx_get_block(struct dx_entry *entry);
-static void dx_set_block(struct dx_entry *entry, ext4_lblk_t value);
-static inline unsigned dx_get_hash(struct dx_entry *entry);
-static void dx_set_hash(struct dx_entry *entry, unsigned value);
-static unsigned dx_get_count(struct dx_entry *entries);
-static unsigned dx_get_limit(struct dx_entry *entries);
-static void dx_set_count(struct dx_entry *entries, unsigned value);
-static void dx_set_limit(struct dx_entry *entries, unsigned value);
-static unsigned dx_root_limit(struct inode *dir, unsigned infosize);
-static unsigned dx_node_limit(struct inode *dir);
-static struct dx_frame *dx_probe(struct ext4_filename *fname,
-				 struct inode *dir,
-				 struct dx_hash_info *hinfo,
-				 struct dx_frame *frame);
-static void dx_release(struct dx_frame *frames);
-static int dx_make_map(struct inode *dir, struct buffer_head *bh,
-		       struct dx_hash_info *hinfo,
-		       struct dx_map_entry *map_tail);
-static void dx_sort_map(struct dx_map_entry *map, unsigned count);
-static struct ext4_dir_entry_2 *dx_move_dirents(struct inode *dir, char *from,
-					char *to, struct dx_map_entry *offsets,
-					int count, unsigned int blocksize);
-static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
-						unsigned int blocksize);
-static void dx_insert_block(struct dx_frame *frame,
-					u32 hash, ext4_lblk_t block);
-static int ext4_htree_next_block(struct inode *dir, __u32 hash,
-				 struct dx_frame *frame,
-				 struct dx_frame *frames,
-				 __u32 *start_hash);
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
 		struct ext4_dir_entry_2 **res_dir);
-- 
2.30.0


