Return-Path: <linux-ext4+bounces-8930-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0926B00AEE
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 19:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9177188D28E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B662F1FC2;
	Thu, 10 Jul 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONQ/FdIu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F82F1FD6;
	Thu, 10 Jul 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170330; cv=none; b=t0g9E8SbpnbyPCalqTCmXPt9uKIYnRQ+6AwpeCvvy/PUfDsJBMOict6gxPyyn35EouBFt1hwEPYxW/g6hbvXJjQilu3G1Az7juMz2yYmTj64VCCCyVXL+AjYaX8RMDQt5gVwAr6ib3B43vXfRwDHEZ9heIY8PMdg8RnZ0jeHC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170330; c=relaxed/simple;
	bh=RMiBxXMIExHjrQ5CjfuwngCONhN8pR/mYQ7OvvLxwQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1dNAXJl4SiSgJ+7uMGaoJCD/fp/UTNWF1J9LdZqL2kmK0/N38OkSTCaW3rE8v19/vJkVWdiG6fHx7sqwNeGii7LkK1ucP9GQtqX21vatik/RlYItugCkhBsLqKjNyxGMdt3YCiwJN0pPgTc5FG1YbKNLYHFke6LHu6Zyt38HVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONQ/FdIu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1311241b3a.2;
        Thu, 10 Jul 2025 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752170328; x=1752775128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7j+JCMiDb4JtXc3MOQmFv9GxAMqAiPIPGtSjr7S+qIk=;
        b=ONQ/FdIupgst0JEg98aDLJthCirSeXVrMyGZazJrwSnBOn4shCKYmZ77UMeGudwwtr
         URkL/ROpIOW4a85/tMG99TAIYd99T93ZnKhqBQmoou1lFK+sh8x7wAd6nar7yl0yn4nP
         Yb55hUyesgf3lKZi5Eezpds2ukWYPaJuTK0cR5b3xBz781y+C03KpEmslY3/FuZ6Jz9f
         QdpRwLbJ8wTnaQCACxEcH7fATttpcj5D65KaUF98HHYT9Lvrn3h+HSx9n+cLZgaF07jw
         cTA3aZfMPIgSH5gLPZo+00EcqNTB5ZMtOa27ZQBt39avombZ9tXV+qCsxRO5M6VB078K
         Dfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752170328; x=1752775128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7j+JCMiDb4JtXc3MOQmFv9GxAMqAiPIPGtSjr7S+qIk=;
        b=jWpBgIa550nu1ggh0Mw/Hq64WFGhPqTtIHM8c7iJEZbLXuYBkZsBK0ZHm+u9hI2yKm
         tY+6hP0K7ASiazmmzn58uUfeav46Ibza+oaHzwz1aAYI7f/PEbEEArrgRam5bnRKF+no
         itNRNmqf2GufmrXMFqttmue3+KjGTc3ozXTtPo9VajuNbCPY4uwb7AxJshpcN+gtKoYB
         4QhiId08t8Iq0Ev9O0ull6dBfriWJrF26LYneKs6hBphSB8U0wGUE/dpJEez13DdoY22
         EA5NxJwYTJsWxpQQ+VJ7myqGdKkD/JqZlgAHZkdOOcCaEd1IFuKVvs2ySobFxRXEnMKc
         V5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVqb39NggY7ISab7X2vFETJcD9xR5nvwfaPP417aGtrKBt1NbmmVpr46dbIac+9tGdu+pypVf6h5Kw18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzNus7ee3XvJLIRPgymuvN72AQohYgfARRPjWlHwYZIkHz8oY
	WUkX0uZA4AYzko3fPeFKvCI+VLwnatfi0ZEyiSqY2az7VBUtaxoLQenUxA0qvP8v
X-Gm-Gg: ASbGncv73M9TPA6mpOwUsjfsKiCbFKNsRF7+gX+1nkFFsd0WgHb+9Lq3m504b2TdXxN
	I5AKyrO4KPNiDZlc/eVlBxUduVE81MUA6Xeog6SOnI6A5ABoSpTiUWeTOO4sLUmh7E462u7bh0G
	jlDuoCni1jqiKalQimfPouvsY27heF+4QztXXicmDQ52lhhtPYybNwEr16UmwJ9Fd5AOTcu5yrK
	HmCmfBk/yXm7a+F7QnBdaDr/hEtv97LS6i3IWAsZlRavvRMSah45txNxz5Yx2iu8WnTo14epmDd
	0kRfJEnLPy9AF1PIlVJpWD78gGOKv0r5OE6PxAixymIl7Gv9rCXC8vhuLwGrwu8l
X-Google-Smtp-Source: AGHT+IGkkMII08ZOc6L7grJj22CXwVJWqsSmTzC56usdWEm9xdDsvdEpw1UTLx/jxrKjhfu26FYdcQ==
X-Received: by 2002:a05:6a00:2e15:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-74eb55b90bbmr5515241b3a.15.1752170328089;
        Thu, 10 Jul 2025 10:58:48 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:36ac:5579:b731:a4fe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm1621499b3a.76.2025.07.10.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:58:47 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] ext4: bail out when EXT4_INLINE_DATA_FL lacks system.data xattr
Date: Thu, 10 Jul 2025 10:58:38 -0700
Message-ID: <20250710175837.29822-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A syzbot-generated disk image triggered a BUG_ON in
ext4_update_inline_data() when an inode had the EXT4_INLINE_DATA_FL flag
set but lacked the required system.data extended attribute.

ext4_prepare_inline_data() now checks for the presence of this xattr and
returns -EFSCORRUPTED if it is missing. This prevents corrupted inodes
from reaching the update path and causing a crash.

[1] Syzbot crash log:

  EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
  fscrypt: AES-256-XTS using implementation "xts-aes-aesni-avx"
  loop0: detected capacity change from 512 to 64
  ------------[ cut here ]------------
  kernel BUG at fs/ext4/inline.c:357!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 5499 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-00348-g772b78c2abd8 #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  RIP: 0010:ext4_update_inline_data+0x4e8/0x4f0 fs/ext4/inline.c:357
  Code: ...
  Call Trace:
   <TASK>
   ext4_prepare_inline_data+0x141/0x1d0 fs/ext4/inline.c:415
   ext4_generic_write_inline_data+0x207/0xc90 fs/ext4/inline.c:692
   ext4_try_to_write_inline_data+0x80/0xa0 fs/ext4/inline.c:763
   ext4_write_begin+0x2d8/0x1680 fs/ext4/inode.c:1281
   generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
   ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
   ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
   new_sync_write fs/read_write.c:593 [inline]
   vfs_write+0x548/0xa90 fs/read_write.c:686
   ksys_write+0x145/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: ...
   </TASK>

[2] Reproducer image:
  https://storage.googleapis.com/syzbot-assets/f97118969515/mount_0.gz

[3] e2fsck output on the provided image:

  $ e2fsck -fn mount_0
    e2fsck 1.47.0 (5-Feb-2023)
    One or more block group descriptor checksums are invalid.  Fix? no

    Group descriptor 0 checksum is 0x8245, should be 0x353a.  IGNORED.
    Pass 1: Checking inodes, blocks, and sizes
    Inode 12 has INLINE_DATA_FL flag but extended attribute not found.  Truncate? no
    Inode 16, i_blocks is 3298534883346, should be 18.  Fix? no
    Inode 17, i_blocks is 17592186044416, should be 0.  Fix? no

    Pass 2: Checking directory structure
    Symlink /file0/file1 (inode #14) is invalid.
    Clear? no

    Entry 'file1' in /file0 (12) has an incorrect filetype (was 7, should be 0).
    Fix? no

    Directory inode 11, block #5, offset 0: directory corrupted
    Salvage? no

    e2fsck: aborted
    syzkaller: ********** WARNING: Filesystem still has errors **********

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=544248a761451c0df72f
Fixes: 67cf5b09a46f ("ext4: add the basic function for inline data support")
Tested-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 fs/ext4/inline.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1bbcdf40824..d9dcb0b09e5c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -399,6 +399,13 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 				    loff_t len)
 {
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
 	int ret, size, no_expand;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
@@ -409,6 +416,19 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 	if (size < len)
 		return -ENOSPC;
 
+	ret = ext4_get_inode_loc(inode, &is.iloc);
+	if (ret)
+		goto out;
+
+	ret = ext4_xattr_ibody_find(inode, &i, &is);
+	if (ret)
+		goto out;
+
+	if (is.s.not_found) {
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
 	ext4_write_lock_xattr(inode, &no_expand);
 
 	if (ei->i_inline_off)
@@ -417,6 +437,8 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 		ret = ext4_create_inline_data(handle, inode, len);
 
 	ext4_write_unlock_xattr(inode, &no_expand);
+out:
+	brelse(is.iloc.bh);
 	return ret;
 }
 
-- 
2.43.0


