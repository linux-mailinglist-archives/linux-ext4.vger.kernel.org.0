Return-Path: <linux-ext4+bounces-4493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A2990D9C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03931C222AA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5131D8E0D;
	Fri,  4 Oct 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu9N5UDz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FD1D8DFC;
	Fri,  4 Oct 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066453; cv=none; b=uRaxobw3sWx1PJ7rv12koyM5n5yvFPj5EfzqgF+Nc2GQHnXEmS/Z4QeSyzHP2ImvLiD1/7jVKFSQnSihhl3vJvzhQf6If8UP6LYQ4oM5LN47IrCAqd1IdIAayzx3gxrypO9UtEPL1aID1DngRdhfLppgxmoA23aR45fdaIuNFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066453; c=relaxed/simple;
	bh=MpjN8gJQXl6jFYhiF4prqjH7PPkfoHsfDbohUSen1ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrhwqcI+EF+PA7kkYNSD7RXk9zG7lfZ7BUJf5X4yg5CY1P/OmRYY8p0XvBXwoSszts0UdZc1IBa05dRB1YoI4e90GX+toLiGprAsAeQqXVSZYSjFr7Fx96wkTe72yrA5I8jh2C2W8oWNCoVMCPNICLCjK2hy4h164X/v3yAwGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu9N5UDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC6CC4CEC6;
	Fri,  4 Oct 2024 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066453;
	bh=MpjN8gJQXl6jFYhiF4prqjH7PPkfoHsfDbohUSen1ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nu9N5UDzLvb4yR/KnUcQf9XTjZheijLYUrAMwosvV7QEKsRh3vu5+eByH5fKMr91M
	 3sjhM6/+AfiUWsKyJlGzaZL8GMD0/oAVAuq+y0AJkneAA/PRbJKmNymF0tyEr5sYqB
	 ce9QOt5q+t5OR4AYsnloobL1NBwIWM27JrldqvCtkQ6gdJ9Cq0+eHLyoIe35s2xm3W
	 dDkxtiSY8duJditEZ5pkXNLIMqAfjc9CQeJZqOPm8yADmSIbVmhG7v2dCBuQtVHY6p
	 44NTVf9IT2HX+4jxTZcoYE9BXLQTpXWrYsbbj3WHP4ih6tz3pI5aUPepoMAv9oiQl3
	 XPSV0JHEKnWmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/42] ext4: ext4_search_dir should return a proper error
Date: Fri,  4 Oct 2024 14:26:19 -0400
Message-ID: <20241004182718.3673735-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit cd69f8f9de280e331c9e6ff689ced0a688a9ce8f ]

ext4_search_dir currently returns -1 in case of a failure, while it returns
0 when the name is not found. In such failure cases, it should return an
error code instead.

This becomes even more important when ext4_find_inline_entry returns an
error code as well in the next commit.

-EFSCORRUPTED seems appropriate as such error code as these failures would
be caused by unexpected record lengths and is in line with other instances
of ext4_check_dir_entry failures.

In the case of ext4_dx_find_entry, the current use of ERR_BAD_DX_DIR was
left as is to reduce the risk of regressions.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://patch.msgid.link/20240821152324.3621860-2-cascardo@igalia.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 173f46fa10687..883d0aa35325c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1526,7 +1526,7 @@ static bool ext4_match(struct inode *parent,
 }
 
 /*
- * Returns 0 if not found, -1 on failure, and 1 on success
+ * Returns 0 if not found, -EFSCORRUPTED on failure, and 1 on success
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
@@ -1547,7 +1547,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
-				return -1;
+				return -EFSCORRUPTED;
 			*res_dir = de;
 			return 1;
 		}
@@ -1555,7 +1555,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		de_len = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 		if (de_len <= 0)
-			return -1;
+			return -EFSCORRUPTED;
 		offset += de_len;
 		de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
 	}
@@ -1707,8 +1707,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		} else {
 			brelse(bh);
-			if (i < 0)
+			if (i < 0) {
+				ret = ERR_PTR(i);
 				goto cleanup_and_exit;
+			}
 		}
 	next:
 		if (++block >= nblocks)
@@ -1803,7 +1805,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		if (retval == 1)
 			goto success;
 		brelse(bh);
-		if (retval == -1) {
+		if (retval < 0) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
 			goto errout;
 		}
-- 
2.43.0


