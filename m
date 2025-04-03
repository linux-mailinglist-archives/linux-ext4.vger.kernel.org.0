Return-Path: <linux-ext4+bounces-7058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64BA7AC69
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7BB7A3A86
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E8276030;
	Thu,  3 Apr 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuZYC584"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E72276025;
	Thu,  3 Apr 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707231; cv=none; b=EC9j1c8gKS68DIU/O9d2ThvTyKCP8oPRbtEuOPVzB9Vf/zd3HJDBAS+6RClTq8yOuSfyYHtGH4KqAo1P1SZw4T7gxvX09UG2LiGqSHtPWgFWWo1K+fDGSF7wOvOTOb+/yx751VGNMLfPqOUIwPEyi1rwqvgTT5qN2qK1vYoAO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707231; c=relaxed/simple;
	bh=KUESLHpdvsTDISRrGVWUPUkjoaolxByL1BtSVMWAOtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlzVW2OwuG2+O5p36PVTer5nxLf4faYy5S2zD5hLUCntDSBFwZFMqqc408T2j0+/jsx/FlpUGXDGG6y4CMtkWA0xhi4xl9xllev+fAjehwtvC9YSH11YoAUJkKsWfyDfyX2gNJ0qw2aTogLfauQGd/dpX5Ki9w8hRDiutkOtYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuZYC584; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9E7C4CEE8;
	Thu,  3 Apr 2025 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707230;
	bh=KUESLHpdvsTDISRrGVWUPUkjoaolxByL1BtSVMWAOtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuZYC584eXChUB75aDTnWEtsJiCbSLxAiwaTp7s6odWq0omYdAo4UERb2ZUdk7w2M
	 5FHVPP6euHqW1fylZmHjXaTLZHKgO3QQaCmefHfAFQT2WpKzoZwRcOh7OJ+dPnvbcq
	 iCn9DmLjEzEXUCDJyJG0mwm5HoMHN/nansdoyDi2tBZ6aEv+oWLENRGJBTCBoFCF+y
	 zeOAEarDJyoQyjHnQpajEYJXBuww9kgufzud8cU9HjKC6liHIJdKbv0FcawB11B1c4
	 a0fo2/dTJ/km89DMdC9Div1nHCPA2V6atk9LnAuIVWsh2c8L5Bo9rHmbsbcyTU503t
	 mZT/f8wo7jD9g==
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
Subject: [PATCH AUTOSEL 6.12 30/47] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:05:38 -0400
Message-Id: <20250403190555.2677001-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 940ac1a49b729..517370d1f6606 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6899,12 +6899,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6915,6 +6928,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


