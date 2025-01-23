Return-Path: <linux-ext4+bounces-6226-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8177A19FD5
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 09:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92E316DDFA
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8F20CCE8;
	Thu, 23 Jan 2025 08:23:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1220C013;
	Thu, 23 Jan 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620627; cv=none; b=FvRvy4BjdYpVZSZJvopMBt7HvxAeDZ36vzIhNGRlUUG2EiRqieVXUjid08+V4Pb1mK3v1TApU1fJbDxjcDNfUIl4/AlfvFg5uDqJBNFm4mywWHSVDXQn18Qp+yp01lyVNoX+DNZCIymmrM0WQJvsSniyQgTLzacuDT8RmzpHaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620627; c=relaxed/simple;
	bh=g8h+rfSlu5ec4PxXOx6KdQXc9mSKhjQS46BzH8ZWhSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKdKmNBtHlkFm6O6+uHgzBw8JoHw3acjULFfPG4cks8YFvglRszjwuUfZqa8202gjvF2xDXEedD4EBqtdRFADqv79jtiItNEzV25e8zCY5YuAgO6MFTEdbMWeTp54L71DUobsU8BBgtHrk37WBOg3jkFmhwFeLJ5xTJS0/dKIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ydv8s5Vzgz4f3jt3;
	Thu, 23 Jan 2025 16:23:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 41C251A083F;
	Thu, 23 Jan 2025 16:23:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCH7GCL_JFnxur_Bg--.47357S4;
	Thu, 23 Jan 2025 16:23:41 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	ojaswin@linux.ibm.com,
	yi.zhang@huaweicloud.com
Cc: akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ext4: remove unneeded forward declaration in namei.c
Date: Fri, 24 Jan 2025 00:20:49 +0800
Message-Id: <20250123162050.2114499-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
References: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7GCL_JFnxur_Bg--.47357S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUAr47trWDZw47KFWUtwb_yoW8KrW5pF
	4fJ3W5Kr48XF1DuFW8Zw4xAw1a9w1kW3srJrZrG34rKFy7tr12q3ZrJr4xZFy5try8WF12
	yFs8Kry5Ca18WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
	CS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAqzxv26xkF
	7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRMCzZJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unneeded forward declaration in namei.c

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/namei.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index adec145b6f7d..c3a80df51328 100644
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


