Return-Path: <linux-ext4+bounces-4483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1A990C0C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29D91C21E50
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D01F28D5;
	Fri,  4 Oct 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsGz7mDM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A61F28C4;
	Fri,  4 Oct 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066145; cv=none; b=ebJpFaiH11f6qkukjM4Vl+QgnKA3fvIJEs2XT0d0F3DKYgkkblMHUdBZAv1Qh7vn3UrYn68ndwz1YCMDGzMFBJmhGQ9/HvYSZKo4Al+SncyrUnp7qkB02Bl7eR5D/mthq+4zEU6PtrAV69+NzdoBxokp4xnNWbDt0VO5vbmLyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066145; c=relaxed/simple;
	bh=KxKgC5AVnCmGX4gStU//FRcLXEDEgMAAdXF++34WPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAKOMPpxazAlBfKZ2R6v0ClvnVOZknV7aWC/OShMZ0siC8uSd7jYQWbM1ycR72W/gMacwWee9OwY8HBnNUrfhQALH9kvFcorHDqrOtWnb5Nxfm6mIdsOyOB9UF5Wyszs9Z9JE9J4/XrhqtSxl145n0gUzNLi4v48HjcseDsnGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsGz7mDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3F0C4CED1;
	Fri,  4 Oct 2024 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066145;
	bh=KxKgC5AVnCmGX4gStU//FRcLXEDEgMAAdXF++34WPvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsGz7mDM+TBywBm16gBdLoXTW/mE7WWURwnKgX7Q1k3Sy0SsolOGqJEGVtqi/Or4k
	 XiTC/n5z3xFiNIR7G9ValhTXI8wDwsYTiCrpZi9Qr9Diq5Kpc34VkgDSdAZ1RH67wb
	 6NeKug0+smW4Uk0e0yISc2Ft7ZiAN9tkOo9RCEr5VFbCaTyQ04cG9FsjRM6P6H61Kn
	 eCRhukG6141GRi6WK9m6HKK5YJ+Cilqb2yhB2McVYuN1+XtGJs31CcRhezniHQXAVT
	 AX61qiI/903rl5ZnNadLZbMn2/IovvMxkkEOQ3fxmPvYWG7x3doH53PIWuUBIGEfuW
	 l2H9VJkdOWNpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 13/70] ext4: ext4_search_dir should return a proper error
Date: Fri,  4 Oct 2024 14:20:11 -0400
Message-ID: <20241004182200.3670903-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 1311ad0464b2a..12af7c7e09c1a 100644
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
@@ -1802,7 +1804,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
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


