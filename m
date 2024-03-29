Return-Path: <linux-ext4+bounces-1787-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D3891E26
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8399287525
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37F1A8AEF;
	Fri, 29 Mar 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1deteBt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766D1A8ADD;
	Fri, 29 Mar 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716495; cv=none; b=F00UlhUpqJRe84FCY2u9Eqipf72whkF8mK8lgIIRFlQVIGR9TySORVpfCeoph1wEZ9+0jR/o+jFlPJYZxt7vsrnl0855lVVrqzv22KMgfNNdgF8F2RHcJzbuBRqsPJecw5RDLNVHAzZmUGdjB5oU8Aa0SuQ6buTqXA5yAXJGvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716495; c=relaxed/simple;
	bh=790L5DcyYpXic9NyR2FrfOdsWnJbrgJGrM1mO+umhWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BITDzz7PUurxH4zHPl30pngaGcZ2Wd2u1BKhHfa0Vcg9rVmUao0eKC4q77LMCasVApYbmeHSUwtp7ulpFvx4rWzaCHROUXLWl3msL5vysSmoIyYmZGJkP8nsYB/5dyXQ0Xx2fiyDD2LxzOyjamHVgl/zfMczgnkdT4eHPU9Yibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1deteBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7654EC43390;
	Fri, 29 Mar 2024 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716495;
	bh=790L5DcyYpXic9NyR2FrfOdsWnJbrgJGrM1mO+umhWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1deteBtSoRFwczbP3qQ+xoO09TWM29HbzrKgQf153t8K0HuUYUaprXNPhRGraicq
	 GCiKQDZVMzu8e/3H/Ib9c++TiRev6byrBgoNe/k9EVRoIl70WQYUI7bAJgNN+hA+GX
	 Yg2lTBZXjEhapVkRXJJeoWws+/JaDMS54NlXygiMM6ogw0izQN7ZatTtLq6/QT3xWh
	 15UySqtkmJua9J2yNau+SHqJeV5s8+LatSId8yna5Lw2qnaatbv7LP7kIfoA/lW6Ok
	 cj8jr7w/CeEDQ7Fdhmk/PCipFmZyL0tIzM+UabZ3ksDPocXj5PKGrWZrIcdPBbszl+
	 cfh81WBludSXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/34] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Fri, 29 Mar 2024 08:47:15 -0400
Message-ID: <20240329124750.3092394-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index a254c2ba03576..e670b5628ddfa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2950,7 +2950,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
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


