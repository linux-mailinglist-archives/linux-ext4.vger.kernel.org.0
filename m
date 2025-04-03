Return-Path: <linux-ext4+bounces-7062-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5AA7AD03
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 21:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76984189DC78
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 19:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA6293B44;
	Thu,  3 Apr 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3nzrdhh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C83293472;
	Thu,  3 Apr 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707351; cv=none; b=mFO0k4CkJNSRHb9XncOfnrjbOgEVlJb8JkdQzet/WFC1lVt6emGnPhT4PbRItbAAspe0ybU24jdketIU5Na/62SWGoCpaQmOo9Ao0JVwMh6hrxLDW5YQRbeb9nrHpPuq5bz3KUtjSH1z7GqgqeWlkXJvwY5bDm3wVsfD4JbfC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707351; c=relaxed/simple;
	bh=ZS7M7N2IQeYHPQp+JnKBoxVs27nXGw/71AJZZjUtL10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1v/t3WJiS/f3Zezf4wHICp6rSZ80zpHeQrx/qyc/0mJhzPHGW/lOuzEidposg5ccPJjBnvodEfCRVcSF4Rjp9TwrKeFk5tVJSvVcx+A8AQKq13OLtfsFxLDc5ltfBrvT5s5pfA8cKGlt+R4HWyel/i1QVqpwctoypDtSxoild8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3nzrdhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91F3C4CEE9;
	Thu,  3 Apr 2025 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707350;
	bh=ZS7M7N2IQeYHPQp+JnKBoxVs27nXGw/71AJZZjUtL10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3nzrdhhV6LFLY9Qcao7+rUuyA90M8XYn23rcIgeD+H/0rmbkQGcQza75W/um2l8Y
	 rlM0NGwGUx9x9uqlu/5AEhP8LTESP/9hA4ryLlMGnkjmovf+lLosDgb4P6etW8ur09
	 bii9yg5rZiOW+gR0e2POD9OnGoMlXyayRjvcsp8LnFKsstuO0I+3XGWvkPfDH4AvxW
	 /hZrVpdsek7OFeaYq0PeQFIyv46kaDOvbRW/9m1kMR4OA7Yk1XKb+cD2VsHo0ZjI3J
	 1Xvz3aGIXvcPxzAnJsQcwxqhQ/awNVckjbCn/P6M3EGuDGGVOqV1WnIxmolKCPUIUv
	 +rVEtYyU1/i1A==
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
Subject: [PATCH AUTOSEL 6.1 11/18] ext4: protect ext4_release_dquot against freezing
Date: Thu,  3 Apr 2025 15:08:37 -0400
Message-Id: <20250403190845.2678025-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 53f1deb049ec1..7bd672f8cc995 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6803,12 +6803,25 @@ static int ext4_release_dquot(struct dquot *dquot)
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
@@ -6819,6 +6832,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


