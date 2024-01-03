Return-Path: <linux-ext4+bounces-639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C279F822709
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E40B21FD2
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828618650;
	Wed,  3 Jan 2024 02:30:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AD4A27;
	Wed,  3 Jan 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4YbT0Nqxz4f3nbD;
	Wed,  3 Jan 2024 10:30:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AF7591A0785;
	Wed,  3 Jan 2024 10:30:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX2A62xpRlYWmAFQ--.14269S11;
	Wed, 03 Jan 2024 10:30:18 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] ext4: remove 'needed' in trace_ext4_discard_preallocations
Date: Wed,  3 Jan 2024 18:28:21 +0800
Message-Id: <20240103102821.448134-10-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDX2A62xpRlYWmAFQ--.14269S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43tF4fZrykCw4fAw13Jwb_yoW8tF4Upr
	nrA3W8Ww43Z39Y9a1xZw18Zr45Zay09F4DJr4Sgw1UZF9xJF93KFnFqr1jyFyrArZYkFWS
	va4a9Fy5Zw18W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As 'needed' to trace_ext4_discard_preallocations is always 0 which
is meaningless. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c           |  5 ++---
 include/trace/events/ext4.h | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0e6beb3b4..091a832a8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5481,9 +5481,8 @@ void ext4_discard_preallocations(struct inode *inode)
 	struct rb_node *iter;
 	int err;
 
-	if (!S_ISREG(inode->i_mode)) {
+	if (!S_ISREG(inode->i_mode))
 		return;
-	}
 
 	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
@@ -5491,7 +5490,7 @@ void ext4_discard_preallocations(struct inode *inode)
 	mb_debug(sb, "discard preallocation for inode %lu\n",
 		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode,
-			atomic_read(&ei->i_prealloc_active), 0);
+			atomic_read(&ei->i_prealloc_active));
 
 repeat:
 	/* first, collect all pa's in the inode */
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb9..a697f4b77 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -772,15 +772,14 @@ TRACE_EVENT(ext4_mb_release_group_pa,
 );
 
 TRACE_EVENT(ext4_discard_preallocations,
-	TP_PROTO(struct inode *inode, unsigned int len, unsigned int needed),
+	TP_PROTO(struct inode *inode, unsigned int len),
 
-	TP_ARGS(inode, len, needed),
+	TP_ARGS(inode, len),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
 		__field(	unsigned int,	len		)
-		__field(	unsigned int,	needed		)
 
 	),
 
@@ -788,13 +787,11 @@ TRACE_EVENT(ext4_discard_preallocations,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->len	= len;
-		__entry->needed	= needed;
 	),
 
-	TP_printk("dev %d,%d ino %lu len: %u needed %u",
+	TP_printk("dev %d,%d ino %lu len: %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->len,
-		  __entry->needed)
+		  (unsigned long) __entry->ino, __entry->len)
 );
 
 TRACE_EVENT(ext4_mb_discard_preallocations,
-- 
2.30.0


