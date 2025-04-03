Return-Path: <linux-ext4+bounces-7064-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264AA7AD37
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7902189C2D6
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5229CB51;
	Thu,  3 Apr 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADd2nQch"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7629CB41;
	Thu,  3 Apr 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707389; cv=none; b=kQp+uNVxykhZpwoOtrH6+G9lEE2ddKeLHbzUn8iL+o7BZXjIdl9X+44XbyE8CnDkDEql0n26l1a4rpllX8FsuZJVj17iBWjeG0chdT4BDXA2EbHZd3IaJybcngwLjCKbCaGXhWLvddY1fWfXzJvQv48jOaG80JMSbeSfP8ycbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707389; c=relaxed/simple;
	bh=OMvFP08MYz046QYmu8uRdbrqCswcX8mZE4psl1cwlus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVwZJOJ9qdLwFwZa82SG2YORko5Py2AWt2mYaRPkpBm9Wr6PTcHum/+citBYgUzGU7M7SMw2Z3YpJSlGu4meZgfSqiqIaNWwrCB9rnsPXgmvIB0ewgs77yOmLLW2sI2ME/4v46/LUbj+FA2w7PjyzgZgBCec+KCi9my6Qsnk7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADd2nQch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF04C4CEE8;
	Thu,  3 Apr 2025 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707389;
	bh=OMvFP08MYz046QYmu8uRdbrqCswcX8mZE4psl1cwlus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADd2nQchvWZlgSemVcOyshTuRma+U0RahsRtZLxD8SEtSSo1FH5hA2qhFsT/IQMwS
	 W6gHgdHBtb384mv2opKHUeNwDXXewUELjFy8ZOkaEu/DVvGqpNdMUKleMrFekHV7Y4
	 +nQOGUt5/SDZmSRYcGJz64eVbtfFLT+LhAV3rwEs2l1Fp1gR8RY38MAc63tUfrEEu4
	 7m0WURvP3B5BFjp6o3MX2SKEYDqB91o586IL+ePnknn32wfa8oXNIJ7sR0ecsOU3kq
	 9cGpdiXg76NYQTByJ+u77zffKyK3V0AciFU7akjVQrb7S5MGCfR9Jg9WRCdJbhe+o9
	 EzToV8lwlxO+Q==
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
Subject: [PATCH AUTOSEL 5.15 10/16] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:09:18 -0400
Message-Id: <20250403190924.2678291-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 126b582d85fce..3a1f75f0b00ec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6205,12 +6205,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6221,6 +6234,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


