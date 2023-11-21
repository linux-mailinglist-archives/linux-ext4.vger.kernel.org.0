Return-Path: <linux-ext4+bounces-53-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F87F233B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 02:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B73B2133B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 01:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0610A1D;
	Tue, 21 Nov 2023 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90CE7
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 17:40:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ6X22PwQz4f3lV9
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 890CD1A070A
	for <linux-ext4@vger.kernel.org>; Tue, 21 Nov 2023 09:40:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6MClxlGMf4BQ--.64879S5;
	Tue, 21 Nov 2023 09:40:38 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 1/6] ext4: introduce ext4_es_skip_hole_extent() to skip hole extents
Date: Tue, 21 Nov 2023 17:34:24 +0800
Message-Id: <20231121093429.1827390-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6MClxlGMf4BQ--.64879S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15ZFykZFyUurWfCF13XFb_yoWrJrWfpF
	9xZ345K3yrWwsF9ayfGw17Xr1Yqa48CrW7Jr9xKr1rK3WIqr9akF1UtFy2vF9YqrW8tr1Y
	qFW0k34DGa12ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR-eOJUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new helper ext4_es_skip_hole_extent() to skip all hole
extents in a search range, return the valid lblk of next not hole extent
entry. It's useful to estimate and limit the length of a potential hole
returned when querying mapping status in ext4_map_blocks().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c    | 32 ++++++++++++++++++++++++++++++++
 fs/ext4/extents_status.h    |  2 ++
 include/trace/events/ext4.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6f7de14c0fa8..1b1b1a8848a8 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -944,6 +944,38 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
+/*
+ * ext4_es_skip_hole_extent() skip hole extents and loops up the next
+ * delayed/unwritten/mapped extent in extent status tree from lblk to
+ * end.
+ */
+ext4_lblk_t ext4_es_skip_hole_extent(struct inode *inode, ext4_lblk_t lblk,
+				     ext4_lblk_t len)
+{
+	struct extent_status *es = NULL;
+	ext4_lblk_t next_lblk;
+	struct rb_node *node;
+
+	read_lock(&EXT4_I(inode)->i_es_lock);
+	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
+
+	while (es && es->es_lblk < lblk + len) {
+		if (!ext4_es_is_hole(es))
+			break;
+		node = rb_next(&es->rb_node);
+		es = rb_entry(node, struct extent_status, rb_node);
+	}
+	if (!es || es->es_lblk >= lblk + len)
+		next_lblk = lblk + len;
+	else
+		next_lblk = es->es_lblk;
+
+	trace_ext4_es_skip_hole_extent(inode, lblk, len, next_lblk);
+	read_unlock(&EXT4_I(inode)->i_es_lock);
+
+	return next_lblk;
+}
+
 /*
  * ext4_es_lookup_extent() looks up an extent in extent status tree.
  *
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index d9847a4a25db..4f69322dd626 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -139,6 +139,8 @@ extern void ext4_es_find_extent_range(struct inode *inode,
 				      int (*match_fn)(struct extent_status *es),
 				      ext4_lblk_t lblk, ext4_lblk_t end,
 				      struct extent_status *es);
+ext4_lblk_t ext4_es_skip_hole_extent(struct inode *inode, ext4_lblk_t lblk,
+				     ext4_lblk_t len);
 extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t *next_lblk,
 				 struct extent_status *es);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..84421cecec0b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2291,6 +2291,34 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 		  __entry->pblk, show_extent_status(__entry->status))
 );
 
+TRACE_EVENT(ext4_es_skip_hole_extent,
+	TP_PROTO(struct inode *inode, ext4_lblk_t lblk,
+		 ext4_lblk_t len, ext4_lblk_t next_lblk),
+
+	TP_ARGS(inode, lblk, len, next_lblk),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__field(	ext4_lblk_t,	lblk		)
+		__field(	ext4_lblk_t,	len		)
+		__field(	ext4_lblk_t,	next		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->lblk	= lblk;
+		__entry->len	= len;
+		__entry->next	= next_lblk;
+	),
+
+	TP_printk("dev %d,%d ino %lu [%u/%u) next_lblk %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->lblk,
+		  __entry->len, __entry->next)
+);
+
 TRACE_EVENT(ext4_es_lookup_extent_enter,
 	TP_PROTO(struct inode *inode, ext4_lblk_t lblk),
 
-- 
2.39.2


