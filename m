Return-Path: <linux-ext4+bounces-4836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565489B32E8
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD26A1F22810
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C963C;
	Mon, 28 Oct 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C+1ZjPzz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929454DA03;
	Mon, 28 Oct 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124766; cv=none; b=lABIcvNMTIoutxBRL4isVKlAtUVKVBkO3SoUog/OiBaEBMwSJK9EZ8MN1kXp4Ilmh+b8cQUcVgIgpa47sXjjN3ek1cUrKwUm4MxHLqX+DoW8IVDPCafJ9TLoGdXh2/Q25+0Zvn1EcVe1MeM1kqPJ8AWGJjMtXwXBHhodCK4oc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124766; c=relaxed/simple;
	bh=lccQNq4i918GrNwS9BdSkhhIpyUJbLYn74abYhsHJFE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iCLe35SLrWvw7M652om3QQFFS3QGY3KwIma1Z+h08/XtE8xxqDdGnjlI8JEFehZjTBBdRqBemIaqOIB1E44T6LDnE3tMq59PZdLBaSW3qnjCM//KLQBjVwE/17j3SwlKAK/sD4Z8URfP2K8/YpXM8V8vEa3xujyO29YTAKoIxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C+1ZjPzz; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730124454; bh=8TiYbtAb8TSjmDOw3s6DVg04LEVW7YJKUVgJfIkaEFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+1ZjPzz7seUYCAgNTm+AHy1ObZYDYIMTmq31+syLy57IzGSkkA66F46FMAEeF0O0
	 yOCZXdvhGchAdx5GqHZa7ScgemzbT7VGu/ZqNH1v59bDamIt6CcmTY66CwZZlPjBNJ
	 2JUK91Gk+bJbBg7IH5SCj4ZPzJyVJMeoCRzeBdTo=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 1DF06AA6; Mon, 28 Oct 2024 22:07:31 +0800
X-QQ-mid: xmsmtpt1730124451twzhv6b4w
Message-ID: <tencent_2EB5A7DB06DD92D88651C9B3EED8AEF38C06@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagV9MmQ/1zIYMmDM5OsVMyEIJJBXsbuqa/cDoqWdcIQT1WzWu/buD
	 e3uixi1oYRILDJJA+KFUJ3yCjTcZ2CslVuBNaMEX1AVHHWa48Nc0PNfAXx3hmhPMQmGtm4oYeEvB
	 9KxPrO3Lfdg4Yfsbi0EKQvUD5dEsvKaAynAVmTJ9Si6lDYjSG0mcg6hDElVT15sN4GCNcjQBCYy5
	 u7329aVB5Ym+A+puHmCOtfzjiDz3dO4643HqPaF5d7UOjSNwVgo77coMzhGpoP0pJwde1YsgxQ0U
	 S43CLAWVnS2WLkViObKPgMxgvPO4pqFDnIvUd7rSAzTJpktu1VUnjCqe0g253HtwevWyHQw136Tf
	 RijRuhTLYvjfuewd9eardJ9YkvDKZTQGIcqpmWN0KFjsi8vMZ1oqtPB6guYUUhpp9hDRreC7i9Ns
	 Tj48SI2Ye+WTMsSF3FGDGjr4LrEy/wZENgB2DtXG/5y8/gLPfg+T9TFj6cE1xyXLSo1ZucWOtJ+M
	 od3OHPhSgaJq3YC8EPkasEWIZA338NUj767qq9gjp2Sg3bWkkoIOkb8ib+EPA0mWpIjrMgqhnDt3
	 Wma8I6Q51ZvFmKQoFZNBt8H3GASyPw7yZioi6skfgpkEIUul+IDmN8vKxAGZNRbeAC78q1kH4mGp
	 3PZF8QRZA/kuf376hMg2G80zxXusVuC1QkiWl9qc5FEuRn39U2DtHw/GXBSUw+EdaeEJV3Aom0RA
	 XUy8mtSAT6zXTwfSghGfuZ86mY3yw8x7AIQDHyGLByBpODSAJLG5QJlKHTyjgsjBRNVnomm99fJI
	 f+Rk8p3mrTq3Fz6FTheogCk0DBz47u6hlQDg445hL+yAPrsFgPHnAaI4REj5qAesGJMaJYmRqBrd
	 3WvGrqO9UFJ5X2ER2FWFXwmJLER8ffxUBCIXeITf1iQX+wTuAzgHqWeFF0db4j970SMi4LuGS36w
	 P2mXUyEVpywG0tz63YYKBY7ro4tIuRMA9WM2xokmQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: lkp@intel.com
Cc: adilger.kernel@dilger.ca,
	eadavis@qq.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH V2] ext4: Add a sanity check for next dentry when insert
Date: Mon, 28 Oct 2024 22:07:31 +0800
X-OQ-MSGID: <20241028140730.2156701-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <202410272114.DrZ8huEU-lkp@intel.com>
References: <202410272114.DrZ8huEU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a use-after-free in ext4_insert_dentry.

Before copying the file name to the next directory entry, it is necessary to
confirm whether there is enough space in the next directory entry.
When the space is insufficient, it will not be inserted and an error code
-EINVAL will be returned.

Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: change check_next_dentry to static and comments

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
index 790db7eac6c2..1c9fedf36fb0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2084,24 +2084,38 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *dir,
+static int check_next_dentry(struct inode *dir,
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
+	if (check_next_dentry(dir, inode, de, buf_size, fname))
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


