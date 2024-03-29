Return-Path: <linux-ext4+bounces-1785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C362891DAA
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0414B283D12
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00929CBCD;
	Fri, 29 Mar 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcCZr4ZL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFA27BBDD;
	Fri, 29 Mar 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716406; cv=none; b=YJv6J/0eqJHSpYxGJp2I7an9oh5bgrXrlYE4G2jv9O39PYQ5p0Bt0500CezBc8tvFvgvnPlYloEyM/dUkT4dvvY4M/SQeJcMwR9pACJWRUDtEqoDE0nL1a/XVKumVsIZiYgnB0pJDfoRZ5ibo+mSXY4GkE1Sm0t1wpYvwxwEJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716406; c=relaxed/simple;
	bh=49nvPWEf6dsNsBY8pMX1qZko0jdBwOudJbNDf6HgQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN+H2BgYC6j296wg6V2TEWeDdzfZLV2jgVv6AvBqeXvxAlzB2dYFjmIdTHZGzUqT7iQJ0LR5Y9G6DMAfpPBrDk6ekc9Tbf8pU0+ZhfDTa9PO+kWqYbqmEKFPDRTtyV512IE0CmLf8KygoC53nJ2AoktxOZgG9YUSqeTJ4/laYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcCZr4ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E91C433F1;
	Fri, 29 Mar 2024 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716406;
	bh=49nvPWEf6dsNsBY8pMX1qZko0jdBwOudJbNDf6HgQe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcCZr4ZL19p0XJZEVAI8wrE2JMobbBb0+A5saOComeYtRJA3iC7HDOGW/LUg01mLb
	 L91z8K8ZwzsIwsOw/d2y2s8mksNCFblkwCoegquxWPfEAc8GvtqOyCLw/0sSgbcXl4
	 oYmCzzARoZdbuGSfKj8IAq298FCnKFDR4q53u79cKr7PHaNTjCp+PMrwksxS9tk8mD
	 i5D0voEpZwS9svYTZIfryVrK6JdMfSNcqvw8x7z+z/6i5k0+j6aiScDOzIRO5O9dJY
	 GTqxa5msi+bHt5gU++U0U69Hqt2L4LT7PMshNzfEPvfucnZ4ZUyxxZ79WF05nj74z1
	 /xiemfZ81CMYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/52] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Fri, 29 Mar 2024 08:45:16 -0400
Message-ID: <20240329124605.3091273-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 68ee261fb15457ecb17e3683cb4e6a4792ca5b71 ]

If one group is marked as block bitmap corrupted, its free blocks cannot
be used and its free count is also deducted from the global
sbi->s_freeclusters_counter. User might be confused about the absent
free space because we can't query the information about corrupted block
groups except unreliable error messages in syslog. So add a hint to show
block bitmap corrupted groups in mb_groups.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240119061154.1525781-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6a3e27771df73..1212559236cc5 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2905,7 +2905,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	for (i = 0; i <= 13; i++)
 		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
 				sg.info.bb_counters[i] : 0);
-	seq_puts(seq, " ]\n");
+	seq_puts(seq, " ]");
+	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
+		seq_puts(seq, " Block bitmap corrupted!");
+	seq_puts(seq, "\n");
 
 	return 0;
 }
-- 
2.43.0


