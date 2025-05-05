Return-Path: <linux-ext4+bounces-7685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281DAAA20E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 00:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027351884119
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33E2D47C7;
	Mon,  5 May 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ8svbjT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F972D47B9;
	Mon,  5 May 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483647; cv=none; b=JjMnWR0ueOOLYpNY7YFUw6iK5oAleqPFFQDU54fsxq/7DyA0T4jndX+2lE0E5seWswGaqAI9D/309ikypdPy/PXEcaUzqYN6hDiVYbeAjUvdrcX/8fsWoOnkN9Y+6ZUuMv92QmS7XfL0iaghHFTbK8a4EPmCKBvTL59alLXJxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483647; c=relaxed/simple;
	bh=ToCSZrIFppiSThaLQyWf32m0rR7l7NXfN05e9FhqSpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnUgwuhi3eEaP9CXNIuubqqn5ZbSfeIMDc+ts6Bd/ar0ZiG+nX274HVPg7auWXZbeSqrKx9OV2vUYbIBgrGsDV/Qu666Emp0BtPO86kGQaaOIi0FiaKkMzXQtp4h8YsjTrZ+J5DvMT3HHYf+wE+xNvi/LTvTUShp/B1itymKRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ8svbjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C74C4CEEE;
	Mon,  5 May 2025 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483647;
	bh=ToCSZrIFppiSThaLQyWf32m0rR7l7NXfN05e9FhqSpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJ8svbjTBeU9DAKrg9gwrjeMXwDuJ3sGadAUqLBGM/FDPVG2TMqGFWWD/CdiJQvoi
	 vR5hVVteqbKTlGzy/JYRQG9mhpqNPIpTFtdHwusoVqrOiZHuJikoj8Ni4P8lruEBJN
	 7DXaiA3VVuslDLLSnWBfdeHN6UDLll4FCP5uzcZvOF6MdzbTGH6CROHQFZfI5wiy1H
	 mp6LIz9/JY1n3d7qU6tBAfLnmUPbpuhd+frqhi96w5ImIKu3/MCygRLUNENhb+sKV3
	 xa6GRH9BiBgJXVZQFcc1uB1jOKWc07KzyXaEd6XtkRokM58DzhBA1EIt696Fx4wsHG
	 JcWGI70VGDg4g==
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
Subject: [PATCH AUTOSEL 6.14 159/642] ext4: reject the 'data_err=abort' option in nojournal mode
Date: Mon,  5 May 2025 18:06:15 -0400
Message-Id: <20250505221419.2672473-159-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index b4a02be2eacf6..b956e1ee98290 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2785,6 +2785,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
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
@@ -5428,6 +5435,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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


