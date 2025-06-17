Return-Path: <linux-ext4+bounces-8504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F2ADDDA3
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A527AC2CB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393372F0037;
	Tue, 17 Jun 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyZp49jK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5D2E719C;
	Tue, 17 Jun 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194604; cv=none; b=ICCmxsLz4MtvonRTW8yWRwYtqDMGYwoaJ1qxmPM8Q2vNoK7WESr9j8pi70VY+dCTjqx8ORWTDlczQXiMIK+aevEGFHhXlUvCs6aTdAP+aPneYWK8iOfFp97ci2SfeKAorHBYXsobYoDFD1FLtaJkxXrQBYZuKzz8M6tpcsaJN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194604; c=relaxed/simple;
	bh=3pROmvqeZxrojUVtYMiw8Ry8cQoSm1tYkA+iOZpxGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHeQ0GuBWKB9cfkv5tuDijz6i+vGGTPxHJIfDcljGgM21SItGVmtCOtfB6BZTr8fQ9Sakw84x80gSnz0LFzYrXX2tlXf85jJE2KUnD1KhD8vnmyRKkTDq8zKwrGlnCE5MbZBvCLm4nFCz+/84BXj8rc1jfVg1ls0uaz88MY9pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyZp49jK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso10967406a12.0;
        Tue, 17 Jun 2025 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194601; x=1750799401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mUZ5Uu+ZqGu4Fg5dzwdy5KHEGUFhLXXBrcjghCCS0o=;
        b=AyZp49jKxEf7MlLCTbHuKsdhe/EGwa2nFk2PmRHGOmQsfOzmBj7QBe4mTzoTpU1HYF
         yBzdTDrdELKP9Um5b6ec7VPqb2b9pw9m4nLvSjEEgI0dp6oPp32O2sJWT+CV8HqJVjn+
         SgZ5iR5w7Dn48W73NvHEsOI2NMf1UhMjg1YNq/tLEK9iffLy6QuO5Prh2pyMYBOjOSn8
         OnjTSFHRs/04mOEG8uqMxZiCITGDOjLS0gWgCCnN0SxDkZIvBhCAx65UVcwTj22hxVSN
         B019XhTUlVWxt4qYPEn+rt3cmU2ZpTWgSOaKzbYZ6EN6azXcmJzoCq3bz/L0BaNv2Og8
         5Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194601; x=1750799401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mUZ5Uu+ZqGu4Fg5dzwdy5KHEGUFhLXXBrcjghCCS0o=;
        b=Vam6MC+3M52VexmUzMkUGojZ5XWaTUrNQCZSP+q/Fx8VUL+ZBZgiH/jV8Gq+aAzrcP
         T0GKSn5T2ThIbi6JPcSGkHfCEJpVibfY3sDA8QbYFvlH1VkoKRLDefBUJ1xOYBwJ+Tqg
         f7Jmg7aV7oGCjBaBCQUrxVtqofPi+5ICZMKa5y5RrI3RzBiLgyzaHDUa3DgYfUA8YZh1
         JP9xac76YYQtBwxCGe21g8vkEFvDjPqEb1VI5x/Zzjmaj7CNeOntlz9ECg3YizjCMX2t
         U7LaaKFBp/efL3Bh5/YDaAVSJHT44nXff98F8by1h2PK+p/6O9Ibd6U0BsMIBSt9l5Ty
         5qjg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJb04Kikm/mI9aZetkCZxzl+kaEHFImhhIJRCR4GzsVDNUA1xyNhqw35C1goTL8B/i9Rg@vger.kernel.org, AJvYcCXr+kqvxBVd0r2+Ko4Uh7DJ5/Pt/4LfPRZDGvI/Dnef8iTL0tsJQY7s08XF3CVrVqXgJDpYFf9R@vger.kernel.org, AJvYcCXyKu0W8BBV4PWAyiW0XczzWxziIhXN/usO8+z07dzVzo93etpwenrUr+OvrfcAVTrt/yykm2c35jCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzWn6H1JOo57K3Ms5KS8cZGeldvcEhCYZoxnHqmx2QVz8dvObWN
	RsHAQ1o8Z4aJ2PBPmfVk24wUxgTN81oeQqogzRo0R0guxHLe64SsZ7YP
X-Gm-Gg: ASbGncvhg99qDCpmQ9FwhD9sNanBVnthgSvQuJkIFoiJ0knXLiPUINOu+AbBoaOUu6G
	dH2sD1YRJVlT6WH41kkxOTZJOUvlHMTbm5odm3xTEyBgPv5URDbCDcrGjW/50jvIgQwMqB9p7K1
	td8oaeg9gDMQqjCzoiLy8HivUyBBDdru3LZNDetFQD4jjenXbdzNXdzhnX5M2sKHRablBtTyH+o
	pN8pVdrYsCwXkSS/hNakoCgImue629vx4BKohXt2CJUd2pbG9hfaCKDrCVPFQg+mLvBJgWPc4ad
	u8HJlvHMvzmDmn28Je1sO37RWUjQ/2ZZmUyGglbNnGQJ+4PaMNx3yWRYnUWvgUkDN06LUGrUm52
	pxe4PAxZ0flJyTywgLLwwScmDOkAlXOaIB+ke18tZA10Fsfs5qIMof42pebE=
X-Google-Smtp-Source: AGHT+IHcHBYqSnvSfF9j/XWUSX83W19K7+LrVLAVucW0fSP/ziXW65yxwpxKzbvGlnAKiLTwFy8LLA==
X-Received: by 2002:a05:6402:d0b:b0:608:a7a0:48 with SMTP id 4fb4d7f45d1cf-608d097b3d4mr14428889a12.28.1750194601134;
        Tue, 17 Jun 2025 14:10:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a93a01sm8506711a12.65.2025.06.17.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:10:00 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-ext4@vger.kernel.org,
	ltp@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15 1/2] ext4: make 'abort' mount option handling standard
Date: Tue, 17 Jun 2025 23:09:55 +0200
Message-ID: <20250617210956.146158-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617210956.146158-1-amir73il@gmail.com>
References: <20250617210956.146158-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 22b8d707b07e6e06f50fe1d9ca8756e1f894eb0d ]

[amir: partial backport to 5.15.y without removing s_mount_flags]

'abort' mount option is the only mount option that has special handling
and sets a bit in sbi->s_mount_flags. There is not strong reason for
that so just simplify the code and make 'abort' set a bit in
sbi->s_mount_opt2 as any other mount option. This simplifies the code
and will allow us to drop EXT4_MF_FS_ABORTED completely in the following
patch.

Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230616165109.21695-4-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 76486b104168 ("ext4: avoid remount errors with 'abort' mount option")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ext4/ext4.h  | 1 +
 fs/ext4/super.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e1a5ec7362ad..2ee8c3dc25f5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1255,6 +1255,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
 						    * scanning in mballoc
 						    */
+#define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 01fad4554255..7ce25cdf9334 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2023,6 +2023,7 @@ static const struct mount_opts {
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
 #endif
+	{Opt_abort, EXT4_MOUNT2_ABORT, MOPT_SET | MOPT_2},
 	{Opt_err, 0, 0}
 };
 
@@ -2143,9 +2144,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 	case Opt_removed:
 		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option", opt);
 		return 1;
-	case Opt_abort:
-		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
-		return 1;
 	case Opt_i_version:
 		sb->s_flags |= SB_I_VERSION;
 		return 1;
@@ -5851,7 +5849,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
-	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
+	if (test_opt2(sb, ABORT))
 		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
-- 
2.47.1


