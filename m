Return-Path: <linux-ext4+bounces-633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23CA8226FE
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A11F22E4C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF722171C4;
	Wed,  3 Jan 2024 02:30:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EA29CA;
	Wed,  3 Jan 2024 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4YbV2STCz4f3mLj;
	Wed,  3 Jan 2024 10:30:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 97A151A017F;
	Wed,  3 Jan 2024 10:30:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX2A62xpRlYWmAFQ--.14269S7;
	Wed, 03 Jan 2024 10:30:17 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ext4: remove unused return value of ext4_mb_release
Date: Wed,  3 Jan 2024 18:28:17 +0800
Message-Id: <20240103102821.448134-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240103102821.448134-1-shikemeng@huaweicloud.com>
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2A62xpRlYWmAFQ--.14269S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rWr4xKr1UGr47KF13CFg_yoW8Wry5pF
	s8Ar18Cr4UuF1DuanrWF4UWw1Igw1xury8GrWSg34Sqr9xtryxAFnrtF1j9F1FqFZ7GFnx
	Za1jgFyUCr4fC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of ext4_mb_release.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 2 +-
 fs/ext4/mballoc.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8ccebe0d4..fb35cae16 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2902,7 +2902,7 @@ extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
 extern int ext4_mb_init(struct super_block *);
-extern int ext4_mb_release(struct super_block *);
+extern void ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
 				struct ext4_allocation_request *, int *);
 extern void ext4_discard_preallocations(struct inode *, unsigned int);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f79e87ad3..8d6246db3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3725,7 +3725,7 @@ static int ext4_mb_cleanup_pa(struct ext4_group_info *grp)
 	return count;
 }
 
-int ext4_mb_release(struct super_block *sb)
+void ext4_mb_release(struct super_block *sb)
 {
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
 	ext4_group_t i;
@@ -3801,8 +3801,6 @@ int ext4_mb_release(struct super_block *sb)
 	}
 
 	free_percpu(sbi->s_locality_groups);
-
-	return 0;
 }
 
 static inline int ext4_issue_discard(struct super_block *sb,
-- 
2.30.0


