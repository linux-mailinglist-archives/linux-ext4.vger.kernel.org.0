Return-Path: <linux-ext4+bounces-9180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F052CB10EC4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6632AE632A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841092E9EDF;
	Thu, 24 Jul 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYVFqr9q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6490285CA6;
	Thu, 24 Jul 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371057; cv=none; b=BmWMWIi2RwG7KPoN71kEpw/h2RFi8gRVGw5gzOVRIRyEyTwYgehFN6cSthBZNSffv3GrH8XJo/gkLNx3S4aOTzfF1KHgYtZ/TveWF4DVXLgKfjaqZEfgVnUIg87LZD7kfyuECBA08lKlea5lvfYa8i8UnU/2eHvp07eV9pWoYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371057; c=relaxed/simple;
	bh=oEyTAtEPc9vesVtOJTzjCDgWf5g1dqPtjTmkp+aTkKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KE8hIZEShSsagsjyYYgv90+IE/b938jpAv/LIN1OitrdXwaM+PJc9YGypUrjbQiTm//ZCPfssbai/BYb0hq/Dfm+4we++bIM5XbYhZbFLj2yL4y8iTqdf7FcqVBxNrVCqf+ZLSMR25mSxDU2u0RNAf/w7/gK9tLvfLJwquPa9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYVFqr9q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1229626b3a.0;
        Thu, 24 Jul 2025 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753371055; x=1753975855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gssr82r4eh7ZkbBhA3woKxWVUDGOM/d4DYOG6IoOCmI=;
        b=cYVFqr9q7bq3nDWRIudPwTJNHMtkap5cvyNs5QuTO05Qr+ELncVlufXdZ5HwDBkRHQ
         SawJN0d+T3+31ISVwFoa4X+22p8h0DhC0489eCkvvYO4cR6bmwbsNqG41sOuMvjOW5kJ
         5ZCmd9v7wMtDtDnY8Heaa4oWEE4XqdLnAElLYdfriNVooWw/wyPXJzDkdeel10ppgNDv
         ELiddxx5PCYU5SBQRbcFnDuYJwkf+/i9ZoXyZtHoITDmC4N4QfXhiqbv0wZWlIM2pWCs
         hp0VXG2wCRYkkPlZ3XM0Uv0mloX7+HRj2ugcC/chrYvw01M/gG42jzcHO9s+fJ4iXYUR
         Yk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371055; x=1753975855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gssr82r4eh7ZkbBhA3woKxWVUDGOM/d4DYOG6IoOCmI=;
        b=oydymi0lOoNqMkWwNqktb6ZU/mbK6sstsRrs/GzeSI3WqcTvmgoOA7XfYBowdq5Jqr
         MPUU3jL4zOWe7MmdC1JRtRzOsalbjJfUNYZY9roErfwFUWBvKBz+uBtE5dBDzHi1UXGx
         AA8qd65bCbMBaAYVeb+OwdkHB6AREbwm+KFlLAFlmOshjJ5RdnSsh3Zw8p8UrRKZEkxv
         piA++9IESvZ7iA34gl07BhJItpjT5UqPj2cp53Uh3Xf3tSP19PM0H12XnLq0TRqVBYLq
         nLbmuyN9eWAFx8MgnP39afKfxhNJ62Ry1n1KlxEDgzC0MVZ2zMYIh7cPtOnqs38J2OuJ
         aJpg==
X-Forwarded-Encrypted: i=1; AJvYcCVSzhUVm7ObbisuGWoKg6gTwYzz3pfEQNhnCZ9Y2kJrBBrIbKqM/4/1hulbc6vg65zOrhtCW4QBfRWQ@vger.kernel.org, AJvYcCWxZ9sjJNxKGBuxyIeKjssvnqLMx/H6Nd8SQhs2Ac7tTU+Zr1YJhEaGZGsIkG3Fvw2a0ryOXUcy931D7jjE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+thTvO65K2gHn1/sF7nbqc0luHmah1yfhcBU9teNV4J87gzP
	HlgeQvCrecAVTKQbkDXQ06Tvvn0MYIO3yMvRz+cT12TpWaXuGqVn5ZQXTfXM9eCywec=
X-Gm-Gg: ASbGnctLP0aqR/7NbzPJHQV5cez1U54SLbJOA09UZsjKntwVmHhq6dm9xpSqd3rTjnl
	tnWZu6d49VtV5DSr87Mlb6tEkz9OB4QgQmdW6g0fvI+Qop5HrJE4u/Fh12UXJxRdshKFZbyxiJH
	7lxJm75MUhbjiTOCfmR/vWOVetRcGv7w2K9GX/UcjD5sVm0QGJOwD2Lay3LDzbCs/dV0QmqlU6/
	MbE5yKwwVlCLbTxsG4fr+90j5fhgm/WDm+AJkrt3pPf8mjuWDd3fCkUTojsRR+a4b14P3d+yR+I
	0/hQMNpZNj3pbjsdfMpkoLZREHx5I8tfjNjBNk2NL6QM5JQTN1beuyEtxLqeVObHRVPCL+7/dks
	w4zGAYzo8arToo+jDWdGHrUZFiEbeApYxqcRgoBjPY7wQWwmA+KVtYnL6vb1YUabo
X-Google-Smtp-Source: AGHT+IGzZgydZ34GP3VtRK6Ub7++NtVagSY5tR5d2dAFwoPTyun3szY1zfLoa5yJRffui44PJ2DU0w==
X-Received: by 2002:a17:902:e948:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23fa5d5ec54mr39073715ad.20.1753371054655;
        Thu, 24 Jul 2025 08:30:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a82f:ebb8:7335:2344:5a58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f3d3sm18381885ad.40.2025.07.24.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:30:54 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] ext4: prevent module unload while filesystem is in use
Date: Thu, 24 Jul 2025 21:00:44 +0530
Message-Id: <20250724153044.149890-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

preventing attempt to unload the ext4 module while the fs is still actively
mounted by adding a check before exit

The crash occurs because ext4_inode_cache still contain objects
in use when kmem_cache_destroy is called

This is a log of the bug produced by crepro given by a local syzkaller

[  301.647795] BUG ext4_inode_cache (Tainted: G  R                ): Objects remaining on __kmem_cache_shutdown()
[  301.652120] -----------------------------------------------------------
[  301.652120] 
[  301.653366] Object 0xffff88800ec88008 @offset=8
[  301.653877] Allocated in ext4_alloc_inode+0x27/0x1a0 [ext4] age=46055 cpu=0 pid=616
[  301.655766]  ext4_alloc_inode+0x27/0x1a0 [ext4]
[  301.657063]  alloc_inode+0x2b/0x120
[  301.657570]  iget_locked+0x1ae/0x3e0
[  301.658137]  __ext4_iget+0x243/0x1af0 [ext4]
[  301.659197]  ext4_lookup+0x1b5/0x3e0 [ext4]
[  301.660784]  __lookup_slow+0xd1/0x1f0
[  301.661575]  walk_component+0x1a7/0x250
[  301.662411]  path_lookupat+0x9a/0x2f0
[  301.663179]  filename_lookup+0x14e/0x2e0
[  301.663947]  vfs_statx+0xb9/0x240
[  301.664622]  __do_sys_newstat+0x62/0xd0
[  301.665376]  do_syscall_64+0x80/0x2c0
[  301.666091]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Was not able to reproduce on my host system
Tested in a Qemu instance

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 fs/ext4/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..c6c77369a252 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7480,8 +7480,24 @@ static int __init ext4_init_fs(void)
 	return err;
 }
 
+static void ext4_busy_check(struct super_block *sb, void *data)
+{
+	int *is_busy = data;
+	*is_busy = 1;
+}
+
 static void __exit ext4_exit_fs(void)
 {
+
+	int is_busy = 0;
+
+	iterate_supers_type(&ext4_fs_type, ext4_busy_check, &is_busy);
+
+	if (is_busy) {
+		pr_warn("ext4: Cannot unload module, filesystem is still in use.\n");
+		return;
+	}
+
 	ext4_destroy_lazyinit_thread();
 	unregister_as_ext2();
 	unregister_as_ext3();
-- 
2.39.5


