Return-Path: <linux-ext4+bounces-7060-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BCA7ACAD
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C017A3335
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B6283680;
	Thu,  3 Apr 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLMdZpbD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F1281535;
	Thu,  3 Apr 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707304; cv=none; b=S/Qt8QzcD1rUBJpv/pFojgiIbNrpyeR5bjqhcB/AMMng/KTZuP+WKLBfG94uDcvCKt70cgTgzfRRGhXTxFYROcT4fDqQIjukpAKCMuDgm+tFxeB1XmXH+bveXmF7qEl1TTYaGtnuQYx1jRQD1Chv3Qz7ahSHFoVeELTeaRHdqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707304; c=relaxed/simple;
	bh=mnpJnS40cjWgCKmwywYGZ8atzlbrAkzFewKrRBNkayM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edK6cf3B1UZfZ5MwC2uQe25HqAhl0w/QptL5ibam+/G02gqdB/o/ILOCXwJUTOi1V9LMiqSpTWeVMsXqZf5lmkgbpafJKRSbCRQH0Lp4eZPirVEVpWwZoWpu0XZ5tW0RaS+nOoxYHn//CYdTkwDXqZwbi9McbtmzGRTJyaMvv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLMdZpbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEFCC4CEE8;
	Thu,  3 Apr 2025 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707304;
	bh=mnpJnS40cjWgCKmwywYGZ8atzlbrAkzFewKrRBNkayM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLMdZpbD2C98mNhklgDpB8VWmsaVB30TYsUPglnby/IZcOUMlifzqXpuUqYqAQnZ4
	 pJQDqw1KT24nq9U7j+19KJbTxq4GrqRASMrkLQAfYN4Y1aUJBrs5si3PhLYaaKvaqt
	 vZCB1kmsxH06Vo37M7X+VoHBdcSlGevOV9nmV52lKOtb8JY/7FjECBjZIANLY6BEg5
	 cymlFYahFcjy3/Wo3Clw0WPNY9qe86/HKmSUbZbCMogQjySGqXG6XOB87Isw9tbKff
	 GEf2xUOyw3bULYkeeHZjgg74b6/h86JD6NA9aEHJ+cwFxHjLufiT9D5qQzrlnyK3SR
	 3YOgjhYm8Nesg==
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
Subject: [PATCH AUTOSEL 6.6 17/26] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:07:36 -0400
Message-Id: <20250403190745.2677620-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index f019ce64eba48..26d693813a80f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6926,12 +6926,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6942,6 +6955,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


