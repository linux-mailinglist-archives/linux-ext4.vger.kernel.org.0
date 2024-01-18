Return-Path: <linux-ext4+bounces-845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E28312B0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 07:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3331283380
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 06:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741F8F7D;
	Thu, 18 Jan 2024 06:26:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994A8F60;
	Thu, 18 Jan 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559182; cv=none; b=n8lDeXXWb5jNGM4vSmk9/P5c9oVcEX/Jn8yyX4O7ls6rJFenaRMe9uFkedRp1gbkWbwbQc12ol/p/c1OsnmyizwAhIbmWcg1GI0z4j1yuxHidMtiMG9Ae0bs5NVlnaq9DtDbmws9z5TwWxHfofBXr/7wY+aAhTt6gzs+oB7JgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559182; c=relaxed/simple;
	bh=06hx4TXEtNfCn+LBiVcXorEGOJWWzHDB7F8IwbKCW6M=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID; b=tdHGN4Zhxa6oZWPkx5Y/krK3MK59ifHECPGPVQFP3ImkQ9haXjx/x58kI/XWCpYQFB77KjeYUkKc5YQNrnnvF34ctrLIIgN9UUtMJihRbU4X5d02EWFyh3JsXa24kuSOBteU3Nq5kDflYUztSr98sGg7s8uTZdGnde12fMzDBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp71t1705559151tlapz74m
X-QQ-Originating-IP: XdR0hHnqb0iwnfylwTSbcXKmxDgPk1mu6hduchUiZZ8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 14:25:50 +0800 (CST)
X-QQ-SSF: 0140000000000070C000000A0000000
X-QQ-FEAT: RiweTmIJF2xseBh7gybJzGTZ+m9Ezxnni0emG/mx3vZy0Cn015ekpWYKTwn+5
	ZtNo9gBuzpqwlWoWtWkHZ4zhBRQE6VtBtJiB1AOLfjlV9a6Vh6NvZYvgVr6xvl7gpx4BxRk
	2qwDJ58R4HJQ/k3kPqHCtGTcUkzJTSVS330YlT/gEFD3wkjwaM6iizRhrpIrP/LIYYMkpFr
	wjPw0bLKzsw2jX1ZgcJgUFFyDmXPfwcOvTcJMtKQpNOHrm55bNAAPKhHc4Wn6KRRwdur2Pt
	E2rP5I7lMx64Bd7emz9hlZoltp0jQ09GYNB5hWg/CJi48WL9y9FpVeYqjSmfwjYpxktR5KK
	zXKsu0b/wY97p60zWT+Gnybtzwh0DgxcUKTISJ+EQsf00jQTKKoJD+/cm05aO2Ee4YSCrHs
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4436156189766700866
From: Cheng Nie <niecheng1@uniontech.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheng Nie <niecheng1@uniontech.com>
Subject: [PATCH] ext4: fix the comment of ext4_map_blocks()/ext4_ext_map_blocks()
Date: Thu, 18 Jan 2024 14:25:11 +0800
Message-Id: <20240118062511.28276-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0

this comment of ext4_map_blocks()/ext4_ext_map_blocks() need
update after commit c21770573319("ext4: Define a new set of
flags for ext4_get_blocks()").

Signed-off-by: Cheng Nie <niecheng1@uniontech.com>
---
 fs/ext4/extents.c |  6 +++---
 fs/ext4/inode.c   | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01299b55a567..bb8fd760cc3c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4069,10 +4069,10 @@ static int get_implied_cluster_alloc(struct super_block *sb,
  *
  * Need to be called with
  * down_read(&EXT4_I(inode)->i_data_sem) if not allocating file system block
- * (ie, create is zero). Otherwise down_write(&EXT4_I(inode)->i_data_sem)
+ * (ie, flags is zero). Otherwise down_write(&EXT4_I(inode)->i_data_sem)
  *
  * return > 0, number of blocks already mapped/allocated
- *          if create == 0 and these are pre-allocated blocks
+ *          if flags doesn't contain EXT4_GET_BLOCKS_CREATE and these are pre-allocated blocks
  *          	buffer head is unmapped
  *          otherwise blocks are mapped
  *
@@ -4176,7 +4176,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,

 	/*
 	 * requested block isn't allocated yet;
-	 * we couldn't try to create block if create flag is zero
+	 * we couldn't try to create block if flags doesn't contain EXT4_GET_BLOCKS_CREATE
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
 		ext4_lblk_t hole_start, hole_len;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5af1b0b8680e..89f0949ebcae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -465,9 +465,10 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
  * Otherwise, call with ext4_ind_map_blocks() to handle indirect mapping
  * based files
  *
- * On success, it returns the number of blocks being mapped or allocated.  if
- * create==0 and the blocks are pre-allocated and unwritten, the resulting @map
- * is marked as unwritten. If the create == 1, it will mark @map as mapped.
+ * On success, it returns the number of blocks being mapped or allocated.
+ * If flags doesn't contain EXT4_GET_BLOCKS_CREATE the blocks are
+ * pre-allocated and unwritten, the resulting @map is marked as unwritten.
+ * If the flags contain EXT4_GET_BLOCKS_CREATE, it will mark @map as mapped.
  *
  * It returns 0 if plain look up failed (blocks have not been allocated), in
  * that case, @map is returned as unmapped but we still do fill map->m_len to
@@ -587,8 +588,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * Returns if the blocks have already allocated
 	 *
 	 * Note that if blocks have been preallocated
-	 * ext4_ext_get_block() returns the create = 0
-	 * with buffer head unmapped.
+	 * ext4_ext_map_blocks() returns with buffer head unmapped
 	 */
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED)
 		/*
--
2.20.1


