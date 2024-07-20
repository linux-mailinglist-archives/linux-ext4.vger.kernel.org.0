Return-Path: <linux-ext4+bounces-3339-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B19381FC
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9299D1F2154E
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9121145B34;
	Sat, 20 Jul 2024 16:04:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196D1DDF6;
	Sat, 20 Jul 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491478; cv=none; b=tC/5EBH5eHInKDcOUZnn3RT45JBA5fyQLI202x4nZvQS9CFPNbw17hyCTZzE71liP5wdhbcnZn65s+Eq1rBBlNcdqByoRMNd6MkfiyQsHYycYS7WqeI48Ktu/6jdrEbBX52xNHkTcvWqiSSew0xjV2cV2wX3BIfPGf4E6lVb9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491478; c=relaxed/simple;
	bh=LqpWzp7/nj0tCjZcWIUfBJcCOUKHmD2ZFyrH9aS2e3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETp6gPmam8lZXjqGO+KLLfSrNKMGHgRL97gLMZWCZSc7yPa6+5Q9N1lPMktIhH3Rk9pdGiWAteKTCqtCoF3KcE3YmqHrgJJAFHeqNAZAiZJ+WhAGqLdfKPbQNH6Rm6JJKf1rQwa3j8QjXC6EIUuZd0NIEyQ1aPFRmormbkBFCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp81t1721491468tm4sucxc
X-QQ-Originating-IP: jHITME9sc8nOgy0FpNDztWA4jh8kfo8GZnIJ+mZLdQU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Jul 2024 00:04:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8820326611417253085
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yi.zhang@huawei.com
Cc: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	niecheng1@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v2 4.19 1/4] ext4: check and update i_disksize properly
Date: Sun, 21 Jul 2024 00:04:07 +0800
Message-ID: <CBA4773FBA840F79+20240720160420.578940-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240720160420.578940-1-wangyuli@uniontech.com>
References: <20240720160420.578940-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Zhang Yi <yi.zhang@huawei.com>

commit 4df031ff5876d94b48dd9ee486ba5522382a06b2 upstream

After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
isize"), i_disksize could always be updated to i_size in ext4_setattr(),
and we could sure that i_disksize <= i_size since holding inode lock and
if i_disksize < i_size there are delalloc writes pending in the range
upto i_size. If the end of the current write is <= i_size, there's no
need to touch i_disksize since writeback will push i_disksize upto
i_size eventually. So we can switch to check i_size instead of
i_disksize in ext4_da_write_end() when write to the end of the file.
we also could remove ext4_mark_inode_dirty() together because we defer
inode dirtying to generic_write_end() or ext4_da_write_inline_data_end().

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20210716122024.1105856-2-yi.zhang@huawei.com
Reviewed-by: Cheng Nie <niecheng1@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/ext4/inode.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 646285fbc9fc..d8a8e4ee5ff8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3207,35 +3207,37 @@ static int ext4_da_write_end(struct file *file,
 	end = start + copied - 1;
 
 	/*
-	 * generic_write_end() will run mark_inode_dirty() if i_size
-	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
-	 * into that.
+	 * Since we are holding inode lock, we are sure i_disksize <=
+	 * i_size. We also know that if i_disksize < i_size, there are
+	 * delalloc writes pending in the range upto i_size. If the end of
+	 * the current write is <= i_size, there's no need to touch
+	 * i_disksize since writeback will push i_disksize upto i_size
+	 * eventually. If the end of the current write is > i_size and
+	 * inside an allocated block (ext4_da_should_update_i_disksize()
+	 * check), we need to update i_disksize here as neither
+	 * ext4_writepage() nor certain ext4_writepages() paths not
+	 * allocating blocks update i_disksize.
+	 *
+	 * Note that we defer inode dirtying to generic_write_end() /
+	 * ext4_da_write_inline_data_end().
 	 */
 	new_i_size = pos + copied;
-	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
+	if (copied && new_i_size > inode->i_size) {
 		if (ext4_has_inline_data(inode) ||
-		    ext4_da_should_update_i_disksize(page, end)) {
+		    ext4_da_should_update_i_disksize(page, end))
 			ext4_update_i_disksize(inode, new_i_size);
-			/* We need to mark inode dirty even if
-			 * new_i_size is less that inode->i_size
-			 * bu greater than i_disksize.(hint delalloc)
-			 */
-			ext4_mark_inode_dirty(handle, inode);
-		}
 	}
 
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
-		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
+		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
 						     page);
 	else
-		ret2 = generic_write_end(file, mapping, pos, len, copied,
+		ret = generic_write_end(file, mapping, pos, len, copied,
 							page, fsdata);
 
-	copied = ret2;
-	if (ret2 < 0)
-		ret = ret2;
+	copied = ret;
 	ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
-- 
2.43.4


