Return-Path: <linux-ext4+bounces-4406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9A98B6DF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4199D1C22194
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296219ABAE;
	Tue,  1 Oct 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGt21HQj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD719A292;
	Tue,  1 Oct 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771122; cv=none; b=W17gjQRlluZSt7yNQ+awkNSNKe8D1vNNp/v7/VI3auFUgAzLcM6acu+05acBp9azOiXLdGiX1gia9dfKsvGidX+e73zqJsJcryvQhUs4EeOhhWKmpauHN+9KZaPSzqa8DlMKPLTeDZW5iqXA04OC17RNEku+M1IAsi/ohdLA+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771122; c=relaxed/simple;
	bh=EU3sgtn4DXMz6YcK+VSDmOMxYa+S5yUUdTVOKmy5kWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgHDalK0TSYjl2QCFnWRYwfGOYipCnwSEEdnb1xl83bgfNtKWR/EHOCNrwOR2zngKO0ug+IfdPl/0IN9RW7TwVJsI8pLABGPaHVzhoZijp0I1grCnZ5y4Z7VeTxxz1cuOQGtSvnQrb90PRW8JkNT2MtRNj0ngx83cNsFyiNmMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGt21HQj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so691496366b.2;
        Tue, 01 Oct 2024 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727771119; x=1728375919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkxMsxXOxgn3VlmEMdu8a32/0K8lNsfFBfaK/Bmgj7o=;
        b=LGt21HQjIDaNo58vGlgw40TfXHMNbzvk8WdxNYqcsft4pAIVlp+g+74XoY7DoIIhdt
         UVwmJxczwyNFvpIAIZiAiBlw5/fjHGHMOODNecWw7PyUHJlGK/dT7EQbbAUsCn/8cZhB
         ZcATalFxwjxq+vkZ9rjZZYGIhybS016HFBtyQI8VvWUJ0fwC7BeuKeBMbvXM+THwA1ox
         gonDE4BZi9NHQV11f4GKAoZPPcnNBiQ+R3Mszet28m0E1Kx7uq+UVKDT3aVdQznTn7a+
         WkjuEluN1cvMXFYazK52j+nqFSgKx6NA0JJMvBeh1Y43RGFDKhPa+Sc0RhzvI3KN/5Oy
         1tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771119; x=1728375919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkxMsxXOxgn3VlmEMdu8a32/0K8lNsfFBfaK/Bmgj7o=;
        b=a+hIDLyVkgkANuN+76qoZY5/TdSGZV3bJk+VdEz5ysKtGWCjoVp4F1TwLe+vixuruR
         IAp7N0vK5x9WppLI4jfERNwQ4HB7J0/bloI2fsrgP9KVwR3eXwUfvhcVtW5UsO23+igN
         yl5lJNgGctywjYanRxqIQg+E3JOFzdjPwQFRL8X0gV6XMrDjchk1W5MkRLzEgdxMg8ug
         vtvX5lh1OM8T/h1bct/ASEFBpDP7GB36whpvY+nRpMfLFF5K5epIiQuC9cQ86ExSrLvm
         UvfdDUWgwH3u2eisu5rvJewnSHdTbZtPFFU7pDVfufWODEXG/jIVF5C8xDWgCte2ArLW
         LM9A==
X-Forwarded-Encrypted: i=1; AJvYcCUEm9t0KeUszUBjdDBzC6joDU6Y1HqKm61NfjMLJFYBdwx723FTE+c27mPrIcJDuXfSaxkt5TBvr5T2+r4n@vger.kernel.org, AJvYcCV09b0bCbE9Voc8msqqm5qeBAacZxolMhm8XSTy0/Ul5CsYQseMb4SJGPSoUIUWOIDbaF+BmTZLILcg@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIT5gaYLc1wVwwQD0jQFBILXbQ5G8TBhWA9nmaicohSM8SZjh
	vYfk7cYLT8NV4v8W95FgP0Vh1tR5PLBIrHk0nry+XAcE8wmXx4YmVmmA8f6X
X-Google-Smtp-Source: AGHT+IEzklHXSuyDV1kt46UC7J7MnAGtMBQfEJ46IUrGQ5oG6ZTDkPRTKGMiMwhFfX7g2YXH0/PMKw==
X-Received: by 2002:a17:907:9715:b0:a8a:6c5d:63b2 with SMTP id a640c23a62f3a-a93c49182a8mr1776462166b.18.1727771118930;
        Tue, 01 Oct 2024 01:25:18 -0700 (PDT)
Received: from Max.. ([176.12.138.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776cesm664837766b.40.2024.10.01.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:25:18 -0700 (PDT)
From: Max Brener <linmaxi@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmaxi@gmail.com
Subject: [PATCH v2] ext4: Optimization of no-op ext4_truncate triggers
Date: Tue,  1 Oct 2024 11:24:59 +0300
Message-ID: <20241001082459.14580-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
v1: https://lore.kernel.org/lkml/20240926221103.24423-1-linmaxi@gmail.com/T/

Changes from last version: Moved vfs-level changes to be ext4-level,
and improved the description of the patch.

This patch enables skipping no-op 'ext4_truncate' calls. Analyzing the kernel
with ftrace shows ext4_truncate is being sometimes called without making any
impact, and sometimes userspace programs might call ext4_truncate in vein. By 
detecting these calls and skipping them, cpu time is saved.

I'll fix this by skipping ext4_truncate call in 'ext4_setattr' when the file's size
hasn't changed AND it hasn't been truncated since the last disk space preallocation.
It is meant to consider the case when ext4_truncate is being called to truncate
preallocated blocks too. Notice that so far, the condition to triggering 
ext4_truncate by the user was: if (attr->ia_size <= oldsize) which means it is
being triggered when attr->ia_size == oldsize regardless of whether there are
preallocated blocks or not - if there are none, then the call is redundant.

Steps:
1.Add a new inode state flag: EXT4_STATE_TRUNCATED
2.Clear the flag when ext4_fallocate is being called with FALLOC_FL_KEEP_SIZE flag
to enable using ext4_truncate again, to remove preallocated disk space that may
have resulted from this call.
3.Set EXT4_STATE_TRUNCATED when ext4_truncated is called successfully.
4.Don't skip ext4_truncate in ext4_setattr when the size of the file has either been
reduced OR stayed the same, but hasn't been truncated yet. This is in order to allow
truncating of preallocated blocks.

Signed-off-by: Max Brener <linmaxi@gmail.com>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 4 ++++
 fs/ext4/inode.c   | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..34128a88e88f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1915,6 +1915,7 @@ enum {
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_TRUNCATED,		/* Inode is truncated */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..b480c29dfc65 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4782,6 +4782,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 		goto exit;
 	}
+
+	if (mode & FALLOC_FL_KEEP_SIZE)
+		ext4_clear_inode_state(inode, EXT4_STATE_TRUNCATED);
+
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
 	lblk = offset >> blkbits;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..cbdad3253920 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4193,6 +4193,8 @@ int ext4_truncate(struct inode *inode)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
+	ext4_set_inode_state(inode, EXT4_STATE_TRUNCATED);
+
 out_stop:
 	/*
 	 * If this was a simple ftruncate() and the file will remain alive,
@@ -5492,7 +5494,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * Call ext4_truncate() even if i_size didn't change to
 		 * truncate possible preallocated blocks.
 		 */
-		if (attr->ia_size <= oldsize) {
+		if (attr->ia_size < oldsize ||
+			(attr->ia_size == oldsize &&
+			!ext4_test_inode_state(inode, EXT4_STATE_TRUNCATED))) {
 			rc = ext4_truncate(inode);
 			if (rc)
 				error = rc;
-- 
2.43.0


