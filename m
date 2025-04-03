Return-Path: <linux-ext4+bounces-7066-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E89A7AD65
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132F817E27B
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7A2D1F6D;
	Thu,  3 Apr 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTB+Gp7p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31732C3764;
	Thu,  3 Apr 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707424; cv=none; b=lx0hVwigwPO2sVPAv9YllG28iLAoqohsqnrBrIYRetahtYL60+yQ4YLmLeKfzvjqU3+NX6w6SRns9ig+Vi6H7n0NHOj01yrMoaUVWsOOPPyxp4dC4YhuFzcYJXB+RCt1mF6aOm6oxlCjfHzMEPVsdm3LNZDYldef7U415ODH4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707424; c=relaxed/simple;
	bh=Ep19BT1sbAcJkmluNO0sTBTJ06RQbcpAjpGYq92/yEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOBF7WVQBmPkdo5RjJRkQDXUI4gq6ZXOYRUL7CDBxpjVuV5tD2NhrIYJLh7d7LcZhgLSTuJAGzDMwZN3RPjlSqmAmo4uFsv3pfkBMOmYGcHu8LYceyYrT6/YIrC0hhXNqf3qJo1L+PXy4Dx2Wfu7tkpIXEs+fSUw1pRXoZUdgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTB+Gp7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA97C4CEE3;
	Thu,  3 Apr 2025 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707424;
	bh=Ep19BT1sbAcJkmluNO0sTBTJ06RQbcpAjpGYq92/yEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTB+Gp7pYP1+XEygIRoQK40+8PekqME7jAIt0oU4PEJ24O8bTV+OgSKU8kp32NRU4
	 wvdfWCMkQdkuI03HV1cJnBd219+SR9Apcqr3m/wANQ/tZ4cbjWUKOvbXbyPPsnvpqr
	 ICKO1YO+BUzG9/yjTI62rHOryemPtAs3jgHXvFWnUW/LD7xKuNP6Ax1ehzrmWae5fu
	 u8Exl1lftI4leux2bYqYt6uDwrlZ2QIu63owGMYjS7Eg1Al5B0dkClm39IeTASvuWv
	 rcNwGDniU1uAEB/LdDyCOMxiKOwi9HO8ZXMp8dv2dizms/bQMzRgM3IMVyOwQKwlOS
	 2kPIduRb3MTNA==
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
Subject: [PATCH AUTOSEL 5.10 09/15] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:09:56 -0400
Message-Id: <20250403191002.2678588-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 9d7800d66200e..be4d863da0ebc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6244,12 +6244,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6260,6 +6273,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


