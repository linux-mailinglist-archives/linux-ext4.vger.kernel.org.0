Return-Path: <linux-ext4+bounces-1157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8884D4CD
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173D61F2176F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F71350FA;
	Wed,  7 Feb 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roxxCAPi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA8164151;
	Wed,  7 Feb 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341174; cv=none; b=oHmSPcKvsLh6kYCi8XATiQ3BlOAsFMfYPIuZD1Ukw3FwC+dXjiaJ/kgyhVBoH6LXCv27ieFMDx+Q4dsebMbu2MFOt5n58K1sV/nROy7tvolhwIULeenbK9H6KNSV0PsKhqIU5JtIizbw7KeVl63LtMqDJ3UsE9tT9aa0Cz2fNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341174; c=relaxed/simple;
	bh=ORX43V3TFChGeVJVBXVNJK5e24agEHtEdt7guGraZi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkJZSwFRvZrWbOB/ufYqeX3KDAeecvqTKR8JD/Ny1zOZv+aexMeFOkKeVAsrfNXG4D6e+EiFSL3ytHSqF0VPKY5Ks9PxmoOr8s1mlJ6mr1+gjLMtC1EgiTevgnGJyiTBLDYhIyYX3xYKHZR36UFo7JWuhIlLUnwYZ1BGtUIm/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roxxCAPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F368C433F1;
	Wed,  7 Feb 2024 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341174;
	bh=ORX43V3TFChGeVJVBXVNJK5e24agEHtEdt7guGraZi4=;
	h=From:To:Cc:Subject:Date:From;
	b=roxxCAPiXbnU7ipGqKjaONhBjuzZou4PSRxnWUR4XQCpMXNsfswof0zUxma7j6uJ6
	 sU221J3UOO6Zju0qaS9E8R2KbFWPS0f63vSJ10u05TD885UMbOxLULBGZ04YfFyR7p
	 1LKUBLBgUqScX1V4S1VhDPMXTfI0LjpOCBsKSyIcFLfBBmpW2eHtXjI1xPUFeXj5gQ
	 OgnWbZ0xCQghGzFEME0OQG3inbOwutOglpUVTnAVEAyFK+73MIMqbGZYhpZjqBLLQn
	 rVSRvt+7ncQYaUkWvA1ChZINJgjB80qLtzFCCKGldxZhFM9mph7WArSEbz+Rnxui9L
	 Vd072YBfU8uhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/23] ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
Date: Wed,  7 Feb 2024 16:25:42 -0500
Message-ID: <20240207212611.3793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index e44c28ceb9cd..3df3c3894f7b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -853,7 +853,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
 		return;
 
 	write_lock(&sbi->s_mb_rb_lock);
-- 
2.43.0


