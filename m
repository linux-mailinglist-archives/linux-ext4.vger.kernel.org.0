Return-Path: <linux-ext4+bounces-1145-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626084D39E
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17792B235B1
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9112880B;
	Wed,  7 Feb 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0oCBi/M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED2127B6C;
	Wed,  7 Feb 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340906; cv=none; b=h5jd2gu2DDZgXSfNHFGJBXpKCq59+PLQz8JzFblEOpwHJY8mSSA/QTgJ7iXTOKvE1U6MzfFhH3vTbGxMznJG9K+MNSyYItK+wChL9AVrDNJGkTsnKqfWcsCZLUn2K3wJJRYXc/8rFlCWEn+qp+Ow+R3Z5hs5ISAnKebwYL7OJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340906; c=relaxed/simple;
	bh=QEQla7/E0WGVlzTVcKJms8qCBSJAPwsPNjB7NzxVYtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaGhdnB1DwERehefZExCJMmXHUk0hM1oYier/hDeuJo4DvAUxuu7N9WqUJnP5J2++Hi/ynmVZ/IaF2bK4/UthPDR6O3+gZmAU9XoO1ebnusZ7fliPbPthkPnrFm7YKu8vQt5ZwfZOVmycWyYZPd0BH7gtlWqi1qOz4dEPRufWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0oCBi/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFCDC43390;
	Wed,  7 Feb 2024 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340905;
	bh=QEQla7/E0WGVlzTVcKJms8qCBSJAPwsPNjB7NzxVYtY=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0oCBi/MObR6R+EF8IdoYsWhzDpq4I/4Idh76nFl0uzXNgU2yf0Mb4U1b2gaDT8/u
	 4UUP4G+CfJ3eUdXaYGPj+ODhNQd6d1//l9OAOFye5xFA3/76boF3n8LmtYUWtYKdT8
	 fUOa46KIxX6iBpnwe1IDuTts5RxRbYv3gTudtzYb2Ae9eK/dN34zunr0e++2JBTAx9
	 c89t0FdSSzR71QY/jA6s7Biv+m3CsyrFIM54ZsIzQk/d8W34G6WJ0fx/0o4RtQn6Jh
	 pIlJ5fNBizF7g5SO0C+5//7d77eTsZpdoxON1Dy/c7c5v30YkACNu1JwQJhqM6hTkQ
	 8/HnOau49j8Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 01/44] ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
Date: Wed,  7 Feb 2024 16:20:28 -0500
Message-ID: <20240207212142.1399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 993bf0f4c393b3667830918f9247438a8f6fdb5b ]

Determine if bb_fragments is 0 instead of determining bb_free to eliminate
the risk of dividing by zero when the block bitmap is corrupted.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-6-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ab023d709f72..a85017a78fc8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -842,7 +842,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int new_order;
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
 		return;
 
 	new_order = mb_avg_fragment_size_order(sb,
-- 
2.43.0


