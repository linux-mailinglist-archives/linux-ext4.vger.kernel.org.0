Return-Path: <linux-ext4+bounces-10321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B94B8D2D4
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 02:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E1F17F5A5
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138C208D0;
	Sun, 21 Sep 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6YV82Nc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B32199BC
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758415917; cv=none; b=azSQ2N2wYnbWIr5YKyed3O0DKbQWAMwu8UD8TatxMaF/4Thas9V4dEFrgEKeKHXY8Kg+WfryvnSNdphuBB3XYNsNFSuK+B1QXiTo08uQPa/6v/GrznkZDCg1rctxJvh66K2J5RtoyUGCZ8vT+M/e3XRLkievJYm5uGx514zkU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758415917; c=relaxed/simple;
	bh=PoRHjMaK9cl3ZUSV7wRstEajxreJfadcTH8KxOCIYA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRGJGMuaqTWHbmFyTh4kJEMn5k0tNz2GxLVFHPVa/r5/Bm5yRokjyBB68+1X2KCsnRW3bGNnd95gYrm/MTw6hzaOwWHnbKZXZFS27/p9aNsZJCchZxVNkJLmtpBM2WsFnAN0tkToxvkL/vdsC7LCDxfBUgeHcvW86TSXYOF/ZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6YV82Nc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so3196495a12.0
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758415915; x=1759020715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrnGLrfF8sa1arNZn1Fafdegznbwome1oxqjSMd6TZA=;
        b=J6YV82NcouyQBq8ARJc5yJM4bGagMRGhmUW3FA8rCicQFezPPPKKdgjy0luHYcueYK
         w92GTybQcMhu8j1Ub38OrEl8IWHHDu+OsX6V0jY3B+kJtHwNSIMQiSINtgJxFuG8tPDl
         Juh4sVMwTELV/jaOtDu10LdNA/1i32S0EVX8uaj5XyE3X3x9aAgVW+HmopXTQ7QMsBQM
         UNUtsfqaEXuxWzvRZU8wnkQKQgkS6+/I6JM0clif7Lx9+XVg0Id9+zuAXy353pONDEvK
         MX/TtrweVezuY8U8yF0Z6JfQ750+sT6/vHvKF7kO1y7hYm+Zweq716u4BDF6cTuzrJ4g
         HhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758415915; x=1759020715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrnGLrfF8sa1arNZn1Fafdegznbwome1oxqjSMd6TZA=;
        b=E/Gc5dbDR9hzMqOgVdKXiHM7ghHDGDyekGGecsoaDOwZj0PN2ZSBu6wbN4eDxyw4Uq
         bjIdNp9Ehnx36sw2ZFK62FQJEFRv1Zuum8HgT4PpEtWKhAuW43NdDXssdibHLswXyZzA
         ci25zS7RhPm8lZ0UNG8N4bXJK9GwaY7RV/9xD9ljYmKtGlCDLJigLtsap9B4oXUAePbn
         59oPsBo77P572eC/5x3KVRe48rdfg6MiN+AsXpaa2mtKXhkLjAO4W3UVcehB8ZyGe/XM
         ylG/cwNsuH7BuEsvWSqhLHHg5S/3bdRhoabXbH7+t4WzwEvSk7Sls4tR5sXH1pi2qWiD
         seyA==
X-Forwarded-Encrypted: i=1; AJvYcCXzg/UhvEgfWofDbffRbfRYCUgTKtiXvpZrLzOmwUcL/pPx8IOGGLoIaBaB94QY/CoPRrby2XCbG8aF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7naMpeKuKvKj7HF6KbnqFRD7DxsVYAaZFY+no0i1CiMbTUaj
	YM62omwhqUzHqbiFPQVN4i69unDk0VlMEJLS0IHbvDHTEeUhMZicDU7K
X-Gm-Gg: ASbGnctP1krFj8rsEOdswu/MpJfXWkVBJITMpS8HoPtwbMAcWx/KWJ+YusFqYdU1bkQ
	i1hWAv+H53lqu7N77v+8ADsLheuXdkou2p9FYNsMBuGO8cakrqt1lbKR6MAZXKlPeJ5htp6dqFO
	qxNhy1yQ/jKoc9ch6ZpZMN7WO/6U9qYYojy/q7QQhX0kDiRaIdzpIkIqyx0n4enHJn++C/YZP09
	5A6avzAkqaIkMi+yUBQ4eKCX4Mh2RDAIAe09vZdD5DXGfRVnPTMc6Z+B+BBPpTRLeuMU646pC52
	humMy0tTAMfuj+2UjjnwjFDsfsVoiY8iIcqgfB6nF5I8JDWGcu1xE0hvkHo0JDXQwbDcax7jZFa
	ak9UL+larHmZVDilEEQAaosSqvWBNxqHZg+VtTxJvXHhxWB0ox9rMe8ZDFSTjc4OzPhL2wopEoX
	Ky99c=
X-Google-Smtp-Source: AGHT+IHCMtXZKy7Znd85IPXIwP3sRzvIRAyKaak2jIng6HMNURtyv6VelR4ElkRAXLjimuFJS2hlyQ==
X-Received: by 2002:a17:90b:48c1:b0:32e:716d:4d2b with SMTP id 98e67ed59e1d1-33091914ec7mr9725420a91.3.1758415915063;
        Sat, 20 Sep 2025 17:51:55 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9135:55f6:8a14:ad5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607e9475sm9272742a91.19.2025.09.20.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 17:51:54 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] nsfs: validate file handle type and data in nsfs_fh_to_dentry()
Date: Sun, 21 Sep 2025 06:21:47 +0530
Message-ID: <20250921005147.786379-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add comprehensive validation of file handle type and data in
nsfs_fh_to_dentry() to prevent processing of handles with incorrect
types or malformed data. This fixes a warning triggered when
open_by_handle_at() is called with invalid handle data on nsfs files.

The issue occurs when a user provides a file handle with an incorrect
handle type or valid FILEID_NSFS type but malformed data structure.
Although the export subsystem routes the call to nsfs, the function
needs to validate that both the handle type and data are appropriate
for nsfs files.

The reproducer sends fh_type=0xf1 (FILEID_NSFS) but with a data
structure from FILEID_INO32_GEN_PARENT, resulting in invalid ns_type
values that trigger warnings in the namespace lookup code.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..7f3c8e8c97e2 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -461,8 +461,17 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
+	if (fh_type != FILEID_NSFS)
+		return ERR_PTR(-EINVAL);
+	if (fh_len < sizeof(struct nsfs_file_handle) / sizeof(u32))
+		return ERR_PTR(-EINVAL);
 	struct path path __free(path_put) = {};
 	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
+	if (fid->ns_type != CLONE_NEWNS && fid->ns_type != CLONE_NEWCGROUP &&
+	    fid->ns_type != CLONE_NEWUTS && fid->ns_type != CLONE_NEWIPC &&
+	    fid->ns_type != CLONE_NEWUSER && fid->ns_type != CLONE_NEWPID &&
+	    fid->ns_type != CLONE_NEWNET)
+		return ERR_PTR(-EINVAL);
 	struct user_namespace *owning_ns = NULL;
 	struct ns_common *ns;
 	int ret;
-- 
2.43.0


