Return-Path: <linux-ext4+bounces-1789-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DA891ED5
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A08B316B2
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A481AEE22;
	Fri, 29 Mar 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URHnPX3b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D351509AE;
	Fri, 29 Mar 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716565; cv=none; b=NhtID47pJjW2UZJ6x4rkUdBlDGc7dPTdDdlZbKsaLdzfM2GyuJQW370dRSSt2IWjgUUNyedLNgGwTks7VqC37qAWNGdI0DT5Iy+AXsxmnmYMGRYo/xQxOb3a8H5WO7TCBlMv77AWgjV6gN8mG3yqSORmVJ+jaWBRDyJ/yUJnnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716565; c=relaxed/simple;
	bh=Ldw/Jr0Rp6CMECGFlRRAVxq0+27Oh8758I6LOt3oF0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfFVIiTV/nyOaDgJB66SExBessJxt5sc5AQWp20TyikB2832uOsZoEd98+cxX8OwLSGbcwqsWHKuwfxkevtUmDv+KP95PELDtp7171GCMyRlAyaRwY70txm9nTZZp3DkoJfl9ZPvTVlAslub9IAF+eFfN358AGVn1wCtfLWY+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URHnPX3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6296C433C7;
	Fri, 29 Mar 2024 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716564;
	bh=Ldw/Jr0Rp6CMECGFlRRAVxq0+27Oh8758I6LOt3oF0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URHnPX3beId/yH/uJZnHCuoIm+q+vSc0hCFELKkXSBz9KsrV941DrgvaKEavvjlBj
	 F41P9q/Z1h685/1p79NXsgrHVDnCowsc3ukXO/Tm1uGNY/zh67gVogF0iW1xJI8EYA
	 hcC5UOB/pX6uBnsPWaLf+KxWDBa6JT5BGOoX+Louesw0szFctPqX+g3a1BWFSjmthP
	 ufP7b62CdDrgWTZp0PZc9hVe/Z8ww5P06oD7hOy6WxabDrhZlrQ0BlbK6DIYobgEHE
	 xc6r8QcE24u1RY58cGsGd7L4vURWbvwaJtgLvpn9/+KMlt1fcosfmAOH5yfgmardp5
	 SLtQP+ei8JwIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/31] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Fri, 29 Mar 2024 08:48:29 -0400
Message-ID: <20240329124903.3093161-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 61988b7b5be77..85f12e8dc96d7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2591,7 +2591,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
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


