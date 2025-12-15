Return-Path: <linux-ext4+bounces-12366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46895CBE1CE
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA2930275E8
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDDF331A5C;
	Mon, 15 Dec 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUiRiEQx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87561331A40
	for <linux-ext4@vger.kernel.org>; Mon, 15 Dec 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806032; cv=none; b=XCAod7pyE8iuoE5j9+QFOmGurS6WTcWTyZnA3+s67ZK444p5Loet2rCOeeTEVdGcvSYcFEdUobxreThzG/WwF6PRwdZX8zG2lhhvqiEjtgZr2ajQfEUK/vDaXiPIeujy3HkVIAaTU0YiQAJnQwELXXMvDStijMNV9DJrTbrf+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806032; c=relaxed/simple;
	bh=ovJ0zyP/g9aXNafbNuG+hd9K81V+Lc2R0S5fghONlE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3LsFafn3TABttbT6axeoiFT21QpsNzrwD+SuD3QCLg8fqvVVCz7pVmzB8Xyuu/7fgYZrY9icO6X6B/yG0xc2UDUaIM+Fl/FMwmR2L1ssOy15fqpkNF5TUxNEtJ6jdEEyni+Bc88poixkgIziQfKWGUsMAwx6kfRc/LAuj+/kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUiRiEQx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so435708a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 15 Dec 2025 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765806030; x=1766410830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaqS3RSpbqvlmpnasR8sVbhgvyTt7K1QiH94F/Yk+ag=;
        b=AUiRiEQxLuCnCn4UvC6L0IGf4UaG14j0GjMP0840DN3Feo3g+wSu8roOSpybYlZYK2
         RS4lyRJe2T4PK+vpHXMKORukcVLOaD7Aw/AdE/KO/ihSPMlwtVrJGjpg3lSUKmOZ0MTM
         J9UNIsj7/5cg9YH6ihQ5MJmnqfLgQmfLl+OZ6EG10+zbYwzKsd0rFVM/K6M090Jh5unq
         lX/02gAim4mCxLV/NphAIhGYmqKoY6qJO/1S0Z8nG0rTrt1ZeqG7SpYTjYmbnCcOXp4m
         VzveZmKcHDA5gCbrBGvNGsYcDbus4sSDlwnk4eTrxsrnnqMd5loWmqBWo/y4gDBlmte7
         8hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765806030; x=1766410830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaqS3RSpbqvlmpnasR8sVbhgvyTt7K1QiH94F/Yk+ag=;
        b=K6oegKFqKfKFVfN3UaPBnx9Vvt5HAYFf/+FB7zvSWdXsZoR7vLaU4DCPrLb6Wykv9E
         nTfXNbiojkU7qr9pRBUopCFp3fBTs6BSp8ciowrfaCfnkvZHiQv/IsIl+gCr+w4LSF5p
         mFTG86B3unosm2RSfYLQ+28k2MNgQ9EqOZFK1GhSED1JRst3oxJ2ADzfWqh4Zs0WVB+f
         pdJtfI974eMk+aeuaZt4VNnFsc3vivpuLE2b4zl3k/GhSEVN8RKNIZQH5UmJng6QI+pJ
         n8DdaOne1L558/AkK35G+Ek9YCq3u69DLzSCVNX2I75Nh9oF7eAbHf3Mnc2DP8xiogZc
         0FOw==
X-Forwarded-Encrypted: i=1; AJvYcCV3UoRTACVvELMkcpEIGkYTQ5oXaba3wqB2GKP1yQ8PHqhGB/fX3jDdo3ZBfnrhVMiRxdVdMLxEzWlP@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6Xre4V2ZhM6qDKfVzWwZcJzX70q8L0unUBQSjF3Vvv8eo30Y
	7shH6gFG8v3sR1oUMdw1gglbE5tBPs1Ijxdqh6f6Q5BwdS2w/15cr1Qb
X-Gm-Gg: AY/fxX6erKPTt//RsvMJPCslykL8QkpQ9RsMXXJbBCKErlEUGWtVv6EYTx9kC23eflW
	uLT0AXnZJiCYd29Fuc68/2ET7Uy5llpJyeQcJ85wRQvpkadVF6CKF7lJ/GZznKqRK841DZe0syE
	ozrxtXRDD84QKvSD7xnR8DBqnkAa916ml9WVon3pvznbUNQdZpCzFvvrpHFJIbdUzJEkvWWQppT
	ugVljMzer9WzZNAjD8eZK8D15KRN9pZ8RQe4dBJtzePN6qdRkQdRDCUh/H5XsaQJS1BECfRQmrn
	9KmHimvapUkZ/4XVq/84G9PgQG01aaJmCzgqrilGTcanS8vCSASplchY/qa4ElvzDD++Uvj3FBc
	LA7rB6+qxCHtRSTZWsXljwrV5Pj6U1h87FegyIv2N/+o9by12DlSa1DaQxDHfu4MJFIr/73Mp+E
	yzfzt7Qqa3
X-Google-Smtp-Source: AGHT+IH2HoaWsKGvvyPNwy/LERBF8rplt9/OpANYZBDCCXD3Qj0LMKNYm+cH2U/UH7qnjgbQwYK/ig==
X-Received: by 2002:a17:90b:3949:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34abe478148mr9019359a91.21.1765806029815;
        Mon, 15 Dec 2025 05:40:29 -0800 (PST)
Received: from fly.nay.do ([49.37.35.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a21d1sm9259498a91.4.2025.12.15.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:40:29 -0800 (PST)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH 6.6.y] ext4: fix error message when rejecting the default hash
Date: Mon, 15 Dec 2025 19:09:57 +0530
Message-ID: <20251215133957.4236-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit a2187431c395cdfbf144e3536f25468c64fc7cfa ]

Commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash") properly rejects volumes where
s_def_hash_version is set to DX_HASH_SIPHASH, but the check and the
error message should not look into casefold setup - a filesystem should
never have DX_HASH_SIPHASH as the default hash.  Fix it and, since we
are there, move the check to ext4_hash_info_init.

Fixes:985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash")

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/87jzg1en6j.fsf_-_@mailhost.krisman.be
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ The commit a2187431c395 intended to remove the if-block which was used
  for an old SIPHASH rejection check. ]
Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7afce7b744c0..85ba12a48f26 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2459,6 +2459,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
 #define DX_HASH_SIPHASH			6
+#define DX_HASH_LAST 			DX_HASH_SIPHASH
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a6c249580e..613f2bac439d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5138,16 +5138,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	return ret;
 }
 
-static void ext4_hash_info_init(struct super_block *sb)
+static int ext4_hash_info_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	unsigned int i;
 
+	sbi->s_def_hash_version = es->s_def_hash_version;
+
+	if (sbi->s_def_hash_version > DX_HASH_LAST) {
+		ext4_msg(sb, KERN_ERR,
+			 "Invalid default hash set in the superblock");
+		return -EINVAL;
+	} else if (sbi->s_def_hash_version == DX_HASH_SIPHASH) {
+		ext4_msg(sb, KERN_ERR,
+			 "SIPHASH is not a valid default hash value");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 
-	sbi->s_def_hash_version = es->s_def_hash_version;
 	if (ext4_has_feature_dir_index(sb)) {
 		i = le32_to_cpu(es->s_flags);
 		if (i & EXT2_FLAGS_UNSIGNED_HASH)
@@ -5165,6 +5176,7 @@ static void ext4_hash_info_init(struct super_block *sb)
 #endif
 		}
 	}
+	return 0;
 }
 
 static int ext4_block_group_meta_init(struct super_block *sb, int silent)
@@ -5309,7 +5321,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount;
 
-	ext4_hash_info_init(sb);
+	err = ext4_hash_info_init(sb);
+	if (err)
+		goto failed_mount;
 
 	err = ext4_handle_clustersize(sb);
 	if (err)
-- 
2.52.0


