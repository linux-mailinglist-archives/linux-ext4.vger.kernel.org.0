Return-Path: <linux-ext4+bounces-7054-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBCA7AA77
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8A0175C88
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1D25A334;
	Thu,  3 Apr 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv0dqA0h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5225A328;
	Thu,  3 Apr 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707008; cv=none; b=OGG1rDQ+XH0OGmYUQ7dWy8HhEux2j8l1DTii0HE7id9osEwUXABnJAEoAlvsexdMb1PSj8ZxrnOAbhvGw1ZCXiir0Pc413ylRBXaAxFzLcj+pSZhY18wGu8yk0A9feGeNZuXQGf6Pi7BY/TNG8F2qjUEp3KBxnnNLvNhYsDzxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707008; c=relaxed/simple;
	bh=AVFPqrvCtjaJEIsbr+lDl8F+WtNS9uohUYPwSzmaP3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbjyeX+NSgzxF/G3LkReqIfLP6jxftWmMCf31Vd6RQ9sIHjcgUBecIV4S4pf9TTyh+7DASp8jmJ5siNCX2eyLRA8ifpgWqErnf5qeO+m7Ob4l4VhEhNcKjzpUbfP4LF/r8gcumb3dL/bBz0lAQ8jwHmlT6hp1VnFEYaupoyitrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv0dqA0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2983FC4CEE9;
	Thu,  3 Apr 2025 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707008;
	bh=AVFPqrvCtjaJEIsbr+lDl8F+WtNS9uohUYPwSzmaP3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tv0dqA0hXmfEQkJo0Ck+WfpRNhvqP/qFaFi8Pq2chYftpZfk+9GPyKPtfnmuvHHKO
	 2T/oPTloIY0MQ+9wno5BiVQfVOOD07ppl7ls+BxoYROtW86YgI1oHZyJ6hppPoiyNm
	 ePrclUM8JHIPmcIK12qT0PZNTVYqLkDIt7dzB8UvOZnVHGjDfqM7uk9X89V+aKcphE
	 +fzXDQMIJk6n6uCFVtbAo/xlk3PmB1P++WHsjdB1MF1ddwI8aLh0u+UnfGyB4OuTRa
	 mRkbV3uh1JFZacwMjmsB23rP0QPqJ5LHI9jxcU7F8XlFSA8A3QxYm7TbAWkSQ3eHzX
	 Rfw+FpKZi9/Yw==
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
Subject: [PATCH AUTOSEL 6.14 33/54] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:01:48 -0400
Message-Id: <20250403190209.2675485-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index a50e5c31b9378..8e5cf68a82a17 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6935,12 +6935,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6951,6 +6964,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


