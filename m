Return-Path: <linux-ext4+bounces-7706-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E314AAB73D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 08:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864843AFF6E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697137E6AF;
	Tue,  6 May 2025 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIxMDgOY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DCF2ECFDE;
	Mon,  5 May 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486503; cv=none; b=tc2f20vsKT0ED9qxvuchhUbFWbe38Gsj4ohicAGVw+gO6xG4WkRwIvsG5QRyHl09c3Kyiw42Wc8xBP2ZVk6+0RtxHWVVJHKbcWfAhi6yCAY5M4rLNspWkFFD8rD+IhwQRHI4YEgPxfKTEOBqTTWdKGzebnKHyPojFfmI6w7lESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486503; c=relaxed/simple;
	bh=QaeO5+EedxfnKY00NP1qaHHaC2Fbe8mCW3AnLeOwdCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiA0dODXhbNrdECa9CEZ/Y01NWgddvEnY7aO3Osn46JCZXueq+YXryXiiBko/oQZNJox1fsbqSpzOdkDnieqnArtXfQkrh3gTQwgbNE5yAGaFceWH9iSRDMZsFW3Nvbb9SkrY2Y4y6H3E+2zXtW5/1SYMT+YPzQlk6DfKx1mbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIxMDgOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFC2C4CEEF;
	Mon,  5 May 2025 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486502;
	bh=QaeO5+EedxfnKY00NP1qaHHaC2Fbe8mCW3AnLeOwdCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIxMDgOYDYaMWvBAp9rfPZt0s+UW2nM9mheb4PExKnR+6MIuvjxHosUqppA3H7R4W
	 6KebVg7fuqUqk3ZTTS+0xNgaWx+TO25kmUUELnj7QGrIqSzQqY22SsaRoGVI85A6NU
	 ILcmeXMDISDBo5G45UMH4A5APR6f/bFhDw2i4P/DpTR/BRNcNluu3A2k2/Ljj4v/2G
	 kgzwWk2l7JiOv70NKHmhKrIYiss4a/sd1eoQsG5LmXMrZsns8UwEtFNQRsnUoKAtI5
	 NvtMODtYdmuaaB6YZB2M3ZEOQPZByCQI6abCg5ezGqIaSrS4WnZ36A5TEFzxprYd5t
	 8OB7nR17142pA==
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
Subject: [PATCH AUTOSEL 6.1 063/212] ext4: reject the 'data_err=abort' option in nojournal mode
Date: Mon,  5 May 2025 19:03:55 -0400
Message-Id: <20250505230624.2692522-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 7f0231b349057..f829f989f2b59 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2741,6 +2741,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
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
@@ -5318,6 +5325,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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


