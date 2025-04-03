Return-Path: <linux-ext4+bounces-7068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F593A7AD4D
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 22:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C767A280B
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B3428BF71;
	Thu,  3 Apr 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOIrsHQF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDA28BF60;
	Thu,  3 Apr 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707457; cv=none; b=U5deM2njokQjZWGu7U96gEHKr4DwRWg/xVOkesSowF5OBTQQuHhnuxIYvvTN/Sz69mettXz7tInXNwUZS7voNDVEcSujJ+DxJUlSpbpJZ2RPm7YM4QDk8/UbSxYgAWtyPmGJmjv5cGDB/ZypFBx3pDrMEKwVBC0Q7hY+Snflyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707457; c=relaxed/simple;
	bh=aZWtixBBRUHPvIJwDtV6buL8ro60LL9Ywxs2nYygdLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZZJp+VmlEp4um6L5+tK8OKFFBCJdiFBxLFYF+YWSLKwSYdDXngWVr1Q9uJNcXWB0A6KgVww5Bxr0S2wYSI9/lk/OLJO33CO2U+S5dGovt//1fDRxy4dbRF5FaTfRWljvA96ZTUNL+3/fhpXaurDaSSuBLgWYEEi8m2q46re8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOIrsHQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65C2C4CEE3;
	Thu,  3 Apr 2025 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707456;
	bh=aZWtixBBRUHPvIJwDtV6buL8ro60LL9Ywxs2nYygdLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOIrsHQFEeyFe0+DrzjExcqj+I/oXOSLS1cLeP2poKTUdzsJ0qK6FFOiS87Rg2T+j
	 UedFRJoFGm6tXYRPj417CCfPPDEsVsVO/86iBbdbXH1XAT6b02lavqR1E19aLbUL5A
	 h9r2fo/M9dbTD7UaQGIdqoBTV4qtAVQEmMntv9bHRJmrYHwNkEIxINPlKs/aCFrOPH
	 L2dXGCq3Uiyqav67Na8No2Z+Knu2We1ySiys8qh4zWr3LKRNEcIuS35mYW/n8yUfhD
	 puPO6mXGzUbtHwoJFE+Xk4QZ2DHWkt6UIe2OM41IQvfP8SlColyj80N1v8ezoMmEIC
	 EfIOQP4wp743A==
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
Subject: [PATCH AUTOSEL 5.4 08/14] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:10:30 -0400
Message-Id: <20250403191036.2678799-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 6307adb16621a..0d4d50c8038fd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5809,18 +5809,35 @@ static int ext4_release_dquot(struct dquot *dquot)
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


