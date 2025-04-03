Return-Path: <linux-ext4+bounces-7056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E209FA7ABB2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C44189B4BE
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FE26659A;
	Thu,  3 Apr 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Bu/iOt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D02566E7;
	Thu,  3 Apr 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707120; cv=none; b=MSdkxpjdHWTyvc6/gfDrfq1UyIlAPHnZggVCM0uvYklxOmiwY2YaeFJQJsc2vzd63mF+AWwLExQ3URs5nECUO5bwHqNPkYCgh+NjsU7gVai4Edt94mMrDuO3Y9N++1y4WP8upqYwjuPTaPKnzoU9mnUBnc5b4M5pDhm4uOjWafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707120; c=relaxed/simple;
	bh=2tmumVYIOJWwdGA2RzlQ7fKN0rDVc/DJACq3Q0Db6No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Axn151CZfedgXYqAmGFspilfKTJq8kEO1PUbh7Cb6k5iJkRwnIAMqhdCR/sCYSp/06bdPZf1VAO6qTY8cA3XVS00LsxGNqHG1L29xXSJz7l4+oSWfX1aLzWjR2QSTZeKxVET15x7nHRkJkp/aq1j4kRhXNzaVIMUHqIOdg6mkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Bu/iOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A194AC4CEE9;
	Thu,  3 Apr 2025 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707117;
	bh=2tmumVYIOJWwdGA2RzlQ7fKN0rDVc/DJACq3Q0Db6No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4Bu/iOtL1R7bpWbwBshB6An3n3vynLB50I/WOOf0c3g8/iD70c94gg1svc0hEqwc
	 9qOSDSnw5p7o8byJZArvsfGg+qsQMVAF5CrWbbCzLWTtsCHQnMkkcWErV7K2QzZR36
	 EaRTAFr3RdbHsIu25QOyczBRGGJYxToC+59BRWfI+OGDBoebuc+dEJ48QYX/tblree
	 7ztx/rC4nV+mZbk/5uxABuAQIJQAKQsC8Wiuf2At1RL/n2IhLWp5M9mBbxq09Q/nzk
	 FTE/BbXjp//CyPxJGQz+BiRWIFuNUUlxYAOrKRpd9icu9sNH0CCP9nO2B77w/RLOWH
	 UJ61VgsraAR+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 30/49] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:03:49 -0400
Message-Id: <20250403190408.2676344-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 530fea29ef82e169cd7fe048c2b7baaeb85a0028 ]

Protect ext4_release_dquot against freezing so that we
don't try to start a transaction when FS is frozen, leading
to warnings.

Further, avoid taking the freeze protection if a transaction
is already running so that we don't need end up in a deadlock
as described in

  46e294efc355 ext4: fix deadlock with fs freezing and EA inodes

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241121123855.645335-3-ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 785809f33ff4a..b777257f95890 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6946,12 +6946,25 @@ static int ext4_release_dquot(struct dquot *dquot)
 {
 	int ret, err;
 	handle_t *handle;
+	bool freeze_protected = false;
+
+	/*
+	 * Trying to sb_start_intwrite() in a running transaction
+	 * can result in a deadlock. Further, running transactions
+	 * are already protected from freezing.
+	 */
+	if (!ext4_journal_current_handle()) {
+		sb_start_intwrite(dquot->dq_sb);
+		freeze_protected = true;
+	}
 
 	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
 				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
 	if (IS_ERR(handle)) {
 		/* Release dquot anyway to avoid endless cycle in dqput() */
 		dquot_release(dquot);
+		if (freeze_protected)
+			sb_end_intwrite(dquot->dq_sb);
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
@@ -6962,6 +6975,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
+
+	if (freeze_protected)
+		sb_end_intwrite(dquot->dq_sb);
+
 	return ret;
 }
 
-- 
2.39.5


