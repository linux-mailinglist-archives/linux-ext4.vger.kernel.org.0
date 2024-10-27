Return-Path: <linux-ext4+bounces-4818-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E99B1D4F
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B39281BB1
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4C13D539;
	Sun, 27 Oct 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KWnFBQXe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01F2C182;
	Sun, 27 Oct 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730027407; cv=none; b=r5JOhOul5GGzrQY0DPvO6na+COrs4iIbMhPpvNIDu3fuxxoz/KOjobRqW7OGgUP4Nts5LAVIZZrkEBHjgvX4kUm8BlztyRsQgTzIkq3HIPw+vipp7V8VXlQrE6/kHrsNIblM/GyqjjXwDiREwFRdtppWmqyNd6tusizgcqb4A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730027407; c=relaxed/simple;
	bh=m706RRhxZmjDTKjTZ9iaDsIdEbRocWoQozTDZyDsaVE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=awGV+OxtOpM2BaUu60WQIIQhk8ORTq/C15wFayx3mlVHUv8qVecyz4HLzNYlvEEQXt4JKMLtBuYU0x14D2hJO6ptm4uk1K0xABcFSULvG/pBVgLOwb16tt1el7zpg4u99arXGxIaP/xTxHy4WV1B5cbh7SmToLeVxQpV6PVNbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KWnFBQXe; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730027401; bh=PaY5oQgrwqScWGmqZoVuDoZ/xHTBa5mLxTsz++JoPzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWnFBQXehEAP57aTbfeYd6f8ZJ4A9RbZpdkuenKMrVvPPHDYRbxjFS6GDUtIItvza
	 OPUS88V/m9cI3OrfmRYB4pXnxt3Ahv183h/Aq8BpMzMy26nZxOSIqsmuk73EpdNVLn
	 5sc+HUbszFOaEKXFh9Y9b4UJCACrr9yJtvX7j52E=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 27AA1E1E; Sun, 27 Oct 2024 19:09:58 +0800
X-QQ-mid: xmsmtpt1730027398tv56ynrx8
Message-ID: <tencent_E4CFC65D09852ECE2EF28C83A7C3C6E41206@qq.com>
X-QQ-XMAILINFO: OaubouGXmhNzbGx0kjZ6wxDsl4w8Yx4QoxIEO9GMAxh2DnYt9uML6lXPz5nKif
	 iQNDPPk3LD53Of/T5+Iiy3ZOMUldi//LFgHjQ+EfeNHlXQTkKCUN+YvX0DeWmakbNWe/vl5y+cM4
	 CNDvbtPa3oY9uaRpluzBsbArD3ARlxJZ9XOpZR7qef1z7ilpr3Xv9O5ow3W4vdXZQEEjzaULRsEz
	 8Zps1stX42S0bpbCuNHiODP6SV7rCnQt8jAZbEfjZH6faGGHGBw5kHtnQn3MYyDyhlQoMcOUlZng
	 8mSxsM6XK9xlX6tl0i8PUgf9/zNWH6INfdjKpHafIgzMjutnAMffW261KPLZ+jyGbtZZlEgwkiDC
	 rVIZWXWknPgviMhF0fpRr99RcE+u4jB+TaqY38MYQEMEqpKBRwQ3oTNoyE6AdEkqLhq5XCsJrgPN
	 zBrYN8wlNjq537fuhtARDYa5gthq/YBN0mVjW+gJUVOnV2hoFWsnwlNCQDQVZgFrgIQSQeuPWPEj
	 SLaGjA5mzcmcOTb0NrMhu2tmj9VGKNWt3dC6Ty/rXti+o6mHb6ol2QslpkqdOBil5ErWutKwg3eT
	 lonj1ZGi+I3qLdQjm36u0dIw8KuJEOoHGENIC54gfK1mRHaaZCO9C1JhpkkM5MCESnqfn74fv7Sp
	 1UwS9cWhh0wFTScA4L5kIRWfYCW/GWGMmwoHaFYe0QbVLYJdtX0YsS6z1NTI1s0GYvx3AnUM6Lq6
	 ox2zNkT4AyodR/uEEWHOVUjYeN0ynyIKWUAanb+dWO+WOzpLOpVQx2tZ/zbnteyAUeKmdnzfR3hC
	 dFdqua81iKXoLm2tDZRTe2rSwY/Tndj9GJQKE3s+0c/fvKJ/UPdSPS7AhfHIrlBd3++TTXQaJLY7
	 gXqaAJWh04WRZOUg4ZG+Y/QE7tzptox/b+eFCjWN+kNJ8VL+gx79BYf8f5zOakCwaqLYz9pE0rdk
	 f4CDTtxdZjJwKps+zn7g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] ext4: Add a sanity check for next dentry when insert
Date: Sun, 27 Oct 2024 19:09:54 +0800
X-OQ-MSGID: <20241027110953.1876304-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
References: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a use-after-free in ext4_insert_dentry.

Before inserting the next directory entry, it is necessary to confirm
whether there is enough space in the next directory entry.
When the space is insufficient, it will not be inserted and an error code
-EINVAL will be returned.

Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/inline.c |  4 +++-
 fs/ext4/namei.c  | 32 ++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..e07ac540ed00 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2834,7 +2834,7 @@ extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *dir, struct inode *inode,
+int ext4_insert_dentry(struct inode *dir, struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..e318b13459d1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1022,7 +1022,9 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 					    EXT4_JTR_NONE);
 	if (err)
 		return err;
-	ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	err = ext4_insert_dentry(dir, inode, de, inline_size, fname);
+	if (err)
+		return err;
 
 	ext4_show_inline_dir(dir, iloc->bh, inline_start, inline_size);
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..843d23391b0c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2084,24 +2084,38 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *dir,
+int ext4_check_next_dentry(struct inode *dir,
 			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
 {
-
 	int nlen, rlen;
 
 	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
-		struct ext4_dir_entry_2 *de1 =
+		struct ext4_dir_entry_2 *nde =
 			(struct ext4_dir_entry_2 *)((char *)de + nlen);
-		de1->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
+		nde->rec_len = ext4_rec_len_to_disk(rlen - nlen, buf_size);
 		de->rec_len = ext4_rec_len_to_disk(nlen, buf_size);
-		de = de1;
+		de = nde;
+		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
+		return fname_len(fname) > rlen - EXT4_BASE_DIR_LEN;
 	}
+
+	return 0;
+}
+
+int ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
+			struct ext4_dir_entry_2 *de,
+			int buf_size,
+			struct ext4_filename *fname)
+{
+	if (ext4_check_next_dentry(dir, inode, de, buf_size, fname))
+		return -EINVAL;
+
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
@@ -2114,6 +2128,8 @@ void ext4_insert_dentry(struct inode *dir,
 		EXT4_DIRENT_HASHES(de)->minor_hash =
 						cpu_to_le32(hinfo->minor_hash);
 	}
+
+	return 0;
 }
 
 /*
@@ -2151,7 +2167,11 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	err = ext4_insert_dentry(dir, inode, de, blocksize, fname);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return err;
+	}
 
 	/*
 	 * XXX shouldn't update any times until successful
-- 
2.43.0


