Return-Path: <linux-ext4+bounces-3335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365639381E3
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 17:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C969DB213D3
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jul 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD9145B34;
	Sat, 20 Jul 2024 15:53:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8A133987;
	Sat, 20 Jul 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490832; cv=none; b=ORvg5nVQG87ehgUvnACfbwfvbANP+Us9l13K442t+iXo4UVN2kOQXlEHPjcT89U9PKsB3F5uFsHmAm1T8W+1+3O3zP8ILgu5UyV3exhXq62Cfw7Q1duELhJ2yM7L/beEe1jYfCXYEHIbrrQWEyilKtjXXBubDzClJ8RFCyeleiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490832; c=relaxed/simple;
	bh=9ox4G0hCdJSOFC677hcy/7FFw1kl0rPk8FHugppKxHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci+xnOYa80vh11OycYhJIyvZQoaGiK+73aJBNNC37duDoiJAw1tb5kExC56P2X8kSAjP46iUMomN4YNCYBkrD3WApY0x592BHCS1syYEY36PSzT0adaEY9Oyv78uVwzb1yTQgLQfLHjhzw1D5Wg5X1ofw0j52nV5/8P8XMRSXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp84t1721490808tam80m5u
X-QQ-Originating-IP: ty7/62pp/p88ttMIsQ84KQIjZOGBV4ahUwOAtGLFfzo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Jul 2024 23:53:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4382411021988501471
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
Subject: [PATCH 1/4] ext4: check and update i_disksize properly
Date: Sat, 20 Jul 2024 23:52:00 +0800
Message-ID: <71FF15A91ED5C348+20240720155234.573790-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240720155234.573790-1-wangyuli@uniontech.com>
References: <20240720155234.573790-1-wangyuli@uniontech.com>
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


