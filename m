Return-Path: <linux-ext4+bounces-798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099D82E6CD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE13284FC6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9B1F934;
	Tue, 16 Jan 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIl94zSn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78847200B6;
	Tue, 16 Jan 2024 01:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9AFC43601;
	Tue, 16 Jan 2024 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367161;
	bh=slCWQua5Ofr/CDphaEtI0JKb5XW9EN4uTZ0kQljgZuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIl94zSnLeWcFR6ojY4YsTY8SNiPEbCJMWmDEFLGPTCbxr+FdZTXRRxExGbVSvhtA
	 zxGhYv1SyXY4gjrjFSpqFZ9PdnyWMDfMwlqU3Ir5c3zCMhEeEJqJLBJolPounzz2SH
	 UjZRwrdvTYBhkW96mbqWUEcZ7AWf6q5WCtRGDxWPXw9/iAkDf3eDZXXRnkw58XAJrr
	 E+wOslSPxIG3jVehid8njmK5smad8UCf59FUTOzJrSZEEABVvxyWv1XsZh5FOdDoNc
	 bHgUAs1kJO4mZr+k5V5qGGCcK5B2DPmZgo3IYCm7HzIKHLUT5B04XbcZXS1sa9CAPX
	 oeCGa/i/iNnjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/19] ext4: enable dioread_nolock as default for bs < ps case
Date: Mon, 15 Jan 2024 20:05:05 -0500
Message-ID: <20240116010532.218428-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit e89fdcc425b6feea4dfb33877e9256757905d763 ]

dioread_nolock was originally disabled as a default option for bs < ps
scenarios due to a data corruption issue. Since then, we've had some
fixes in this area which address such issues. Enable dioread_nolock by
default and remove the experimental warning message for bs < ps path.

dioread for bs < ps has been tested on a 64k pagesize machine using:

kvm-xfstest -C 3 -g auto

with the following configs:

64k adv bigalloc_4k bigalloc_64k data_journal encrypt
dioread_nolock dioread_nolock_4k ext3 ext3conv nojournal

And no new regressions were seen compared to baseline kernel.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20231101154717.531865-1-ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea50e..99c8ae97112c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2785,15 +2785,6 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 		return -EINVAL;
 	}
 
-	if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DIOREAD_NOLOCK)) {
-		int blocksize =
-			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-		if (blocksize < PAGE_SIZE)
-			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
-				 "experimental mount option 'dioread_nolock' "
-				 "for blocksize < PAGE_SIZE");
-	}
-
 	err = ext4_check_test_dummy_encryption(fc, sb);
 	if (err)
 		return err;
@@ -4402,7 +4393,7 @@ static void ext4_set_def_opts(struct super_block *sb,
 	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
 		set_opt(sb, DELALLOC);
 
-	if (sb->s_blocksize == PAGE_SIZE)
+	if (sb->s_blocksize <= PAGE_SIZE)
 		set_opt(sb, DIOREAD_NOLOCK);
 }
 
-- 
2.43.0


