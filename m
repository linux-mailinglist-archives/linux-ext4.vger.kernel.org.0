Return-Path: <linux-ext4+bounces-12133-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F64C9DC2A
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 05:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BF6734AAFC
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC5277CA5;
	Wed,  3 Dec 2025 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwadDgeb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7A26F2A6
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737454; cv=none; b=i2UFwE5YCGr9ZPz9By3IJLI/XaTUqVdSWfw31v0yU/dKl0+bzAOVMB27PKu8D5+pOy9WPB7k8i1/qzFqBG15MNXjMQnTpmatm5I0aumo9BIwsvtkP8FaAd4hsel+jsiw5CKrtyxzgLy1E8lHlGx5feEX843O2DnNF2SxpYAkLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737454; c=relaxed/simple;
	bh=WRkvw9y5HoNBjcUU0LoCC9RbADhwK/oXbjBNd4/5ecs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cG+V2z4Vbs1A9GYOuMEFl2nARufaMAHNoHi4cTot9ne4mdnvcF9rlakHHVAgy4el+Jk75YkziYKEKcdswf/Jh4wTMElOWeogQvKDRFuV9Af5NbkztYmGsjYPspycyib5ZxeZu3VzC+yLf9DwSsotmsMQTiLlXH16ermXvJK0cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwadDgeb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b22624bcdaso722152685a.3
        for <linux-ext4@vger.kernel.org>; Tue, 02 Dec 2025 20:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764737450; x=1765342250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ij3x+HhyJRwHbQ9SvfWiI6SVjWRNqzjmCWDw4ugJUQE=;
        b=fwadDgeb9J7sbYINAeB/fwPds7eXyleTHlNfE1VQkmIhjAWwXYYHTlJNxu0PKIU8go
         XZTX0/1JwBjE1EWk9Wgdp14fazKzYKhuWnQTQE34mrPD1GtfelqOpMTFLGKx8aWH2Pcw
         LrSBCexUqbpYwEyAc/PCq95C+NSnEcomHBbWAKuW3DC7/fHH2ziurJF+tpplbL+crbOb
         +v93HPVGF6th8QgEFoNXlUnAR5n7tMpogSbpW1FiTnhJY09LR3hREE+69YtVEtmtc4m+
         EpQBizgldmx2+ICfeMnClaz9R4yak+QhRrzHrRrYBaksdhzZRcmBx7BjLINnJ2jTCC1l
         t6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764737450; x=1765342250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij3x+HhyJRwHbQ9SvfWiI6SVjWRNqzjmCWDw4ugJUQE=;
        b=GxmuVnKdGWEH0pNwK7Hm55K1W1GlArtJ418HxzKTBnlv9cyPR0vmK/33KAJoj1hXE4
         sZmxc0YVh/jP8DjqF7Nb25cZMESIxSnjSZRqJCCRLTcZgovoRRKlyHv0vK4qhbbM0UVi
         cFKsscydvN7D6gLrvaXaXScd+GYLk0dq1VsoyMhD+5WEddSvr8Tc6qH2rfrQOb9NbC/g
         pj+jnVn3V4YXghDMAGMP3km8lHGFGRcVT76GHDFrIxhRVFjSZqdCOLySfLbmmlpT6FKc
         ztzv2EuW3hMfWzKG+yuert4iMT4Ny0roKIId/GNUZHejJ+O+FROMzLNHd4Nmv5sByyRm
         d6tw==
X-Gm-Message-State: AOJu0YzW/+M7gsfVxLUuLTUWfBnYOoJ3eeLvyU7X63SPQwHpwfgrI18E
	nuMY8+Qvn1Lfe0ASeHeWN9fC72U/cdS/6RvMfew5cxVZn1EzUgQOleC7
X-Gm-Gg: ASbGncuvJlIaOW+M1GmeTp4/4f8xM+6EWyFKNPjQFE6x8OTChApdDoa+RD3vIJ3XxC0
	cfSAPrH8H2nqxHKNz8YCRv/drnEzkLMXduCImGVWLsYkULi268zObaR2F8qXo1t5GtalBFlxcr5
	GwlYS8nQ1DMDps48Rnjbo9eRJxwEcwJt8CZ5uHWfqhuswYgcj1DSy3xGt0RhPn5CSiK6ME1fBZS
	xyVX/x2K0oR2S4PYMZBnR561v+ouYTGX3wNheObz9QvtWlzUkqQ/w2gicsEDkTwUEP8DS3ItTYt
	vSA+jOZz8MhchQpVYE+S2TZN9aEmAhNGhAYj7RrHk/qvogQYIn+h8R3iNmLO0M2H0EAfwaBhNKD
	s4KjwWu41IHOLMInr42TyyJjYJud5vUcyZaJdZzCiovo3bLywQN3Hn3RH92TATmq+Y12U/xrmFM
	MIzomts86ZbkX/a6cA8dJaGHty0gGxLgvOJ+H4qoGq55I=
X-Google-Smtp-Source: AGHT+IFYOQf0XMxbFPIfedBBM7HkeqXfmxZxfrrO0N5qDru4vGMgon/mzhDz0iTJ56JiWncthXPOmg==
X-Received: by 2002:a05:620a:2953:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8b5e6d8a893mr127611085a.85.1764737450296;
        Tue, 02 Dec 2025 20:50:50 -0800 (PST)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1c90f4sm1242456285a.41.2025.12.02.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 20:50:49 -0800 (PST)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH] ext2: factor out ext2_fill_super() teardown path
Date: Wed,  3 Dec 2025 04:50:48 +0000
Message-Id: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path at the end of ext2_fill_super() open-codes the final
teardown of the ext2_sb_info structure and associated resources.
Centralize this into a small helper to make the control flow a bit
clearer and avoid repeating the same cleanup sequence in multiple
labels.

Behavior is unchanged.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 fs/ext2/super.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 121e634c792a..19d4ec95e5a7 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -874,6 +874,19 @@ static void ext2_set_options(struct fs_context *fc, struct ext2_sb_info *sbi)
 					   le16_to_cpu(es->s_def_resgid));
 }
 
+static void ext2_free_sbi(struct super_block *sb,
+			  struct ext2_sb_info *sbi,
+			  struct buffer_head *bh)
+{
+	if (bh)
+		brelse(bh);
+
+	fs_put_dax(sbi->s_daxdev, NULL);
+	sb->s_fs_info = NULL;
+	kfree(sbi->s_blockgroup_lock);
+	kfree(sbi);
+}
+
 static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ext2_fs_context *ctx = fc->fs_private;
@@ -1251,12 +1264,8 @@ static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
 	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 failed_mount:
-	brelse(bh);
 failed_sbi:
-	fs_put_dax(sbi->s_daxdev, NULL);
-	sb->s_fs_info = NULL;
-	kfree(sbi->s_blockgroup_lock);
-	kfree(sbi);
+	ext2_free_sbi(sb, sbi, bh);
 	return ret;
 }
 
-- 
2.34.1


