Return-Path: <linux-ext4+bounces-7693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3DAAA963
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 03:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1167C4A6E01
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CE827E7E0;
	Mon,  5 May 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFB0L4bq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9E299AB8;
	Mon,  5 May 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485019; cv=none; b=XyARDDqfGk5yIN5CUtqLJIihTtGZrlBpTi1arVa9yq412yIFclRcrKVwvbOSxi4QQYWmHdmdo5SJxle3AnoFwxPemWuGBB+WQP3raqYeWoelHVcHukKyTSPARCn+2vbKkIyrvIuIcPrQ5VMAbEw3JM8KaAIYgFxU0GWLTYLP5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485019; c=relaxed/simple;
	bh=mNizyBHEqzGkqfgDLGQAmXEhASDrcixoR3L/C9cPoqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/u6GQYrSOv5pcdOoJhSXmYFmTAbnUSQckst51mzuc2UVny3j01wSnh/veN1yf1xbr+HuFxtt7fpG4lPf/oI4l6k69Ij4pHhTFnNaQ6iP4OI3iSZ+8RhPnc09oVwitYRUgIgb+9XE4taTM6d3kfeOkPqV/027bD2Fzeb72FwBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFB0L4bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B37EC4CEEF;
	Mon,  5 May 2025 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485019;
	bh=mNizyBHEqzGkqfgDLGQAmXEhASDrcixoR3L/C9cPoqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFB0L4bqVish0svffp5AcXrk8fESxhsUSoIME1Vw27jKb8gxc8A3fG8iPlJq3Szze
	 WAaOJQ1LRJZKsEGkut2O5V80wsU0aLWmXuCyf7kAeQpYugN/UO0TUpMy9pV1JdmjzV
	 HEvlqhuC5ALhem8DZdeGWfrq9ozhNZuEtk5AOIXisbRrLFwF9yTGXPwY/bSo8E0YP8
	 vuG/CG1hMzPYvcoIyJmr6rq2MRVZ35B/TVXU/8i5F539/r6xiyvJcAKSP6ia5SJ56/
	 gRvcUcANiMd/FsT7nu0YVepr8jnc5slcGQRb6cuEqkAH7ew4S0gO73OmDtCxd70Tw8
	 ZqMEnSo/FyCog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 126/486] ext4: reject the 'data_err=abort' option in nojournal mode
Date: Mon,  5 May 2025 18:33:22 -0400
Message-Id: <20250505223922.2682012-126-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 26343ca0df715097065b02a6cddb4a029d5b9327 ]

data_err=abort aborts the journal on I/O errors. However, this option is
meaningless if journal is disabled, so it is rejected in nojournal mode
to reduce unnecessary checks. Also, this option is ignored upon remount.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250122110533.4116662-4-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 473909c4a3784..99117d1e1bdd5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2787,6 +2787,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (is_remount) {
+		if (!sbi->s_journal &&
+		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Remounting fs w/o journal so ignoring data_err option");
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT);
+		}
+
 		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
 		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
 			ext4_msg(NULL, KERN_ERR, "can't mount with "
@@ -5396,6 +5403,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 				 "data=, fs mounted w/o journal");
 			goto failed_mount3a;
 		}
+		if (test_opt(sb, DATA_ERR_ABORT)) {
+			ext4_msg(sb, KERN_ERR,
+				 "can't mount with data_err=abort, fs mounted w/o journal");
+			goto failed_mount3a;
+		}
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
-- 
2.39.5


