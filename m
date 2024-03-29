Return-Path: <linux-ext4+bounces-1784-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3581891E43
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A43CB3001E
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342FC1BD5D1;
	Fri, 29 Mar 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUy4sHBl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39C1BB75D;
	Fri, 29 Mar 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716277; cv=none; b=S+3ipiRyWsGgS+x2stc9Yjz4TC0JzO8IBNDWHFvEBhS+ZKFrJ/ahb8u/e0wj03HSyRILdLsZca7JFoTp4gMqJJTv523KMrML5kV6VZU3DkoXRYbNd6/zuozCLniwCSFpz484TJ10Y6VAuW0ba9Tz5tPhNdfTXl7l/0PrR0jioYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716277; c=relaxed/simple;
	bh=075H6LkyI0XGHa2vdB+z+ysbsTsHq8mzUz3WKn4nPCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBF9dRu2Wx14DHuCmQtIoaF8X4FgCuEgo+nnY9cNTJutY8ayg+zaldGXglBkdBdBIIsbpfnUKuWF5owg3AImIxRHqDC8j4IL73cRziEQ9fypZ0LlhVLafnnCa3QCrH5LKZJTswIa2mYcRvcnzpkk4GvK0a+GZypYBtVAwFw5iY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUy4sHBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC18C433F1;
	Fri, 29 Mar 2024 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716277;
	bh=075H6LkyI0XGHa2vdB+z+ysbsTsHq8mzUz3WKn4nPCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUy4sHBlxXhFCOLeZCsLI4TYk/OxplX2xciC7dH22NzWude64SuDbD2L5yBSKqBZf
	 7SmtSruTvWeuvJw9xiaUPdSOLxCoBr8Qy9nET2qUBH94ldJ79H4P5HejkiLPYzB5f8
	 U/XKkcsXnNFTqFHcOlWopgi1fR4UfO7RGhiOnW4IRe81UwnXmrUfLN3vMDiVGCu4NJ
	 PAiYYMd706srvkfI3VPpapWbprKT1gMgNM+2iwJsK57Jz/mmAA8kVkGJa8lQHRZxLD
	 BzVTiblOkis7z2oWXxL94GOgxKylh34fQtZ2ClFZFDpafk5kImQOj0fkrO6FJ4okJ6
	 Ovd4amIhW7dOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 36/75] ext4: forbid commit inconsistent quota data when errors=remount-ro
Date: Fri, 29 Mar 2024 08:42:17 -0400
Message-ID: <20240329124330.3089520-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit d8b945fa475f13d787df00c26a6dc45a3e2e1d1d ]

There's issue as follows When do IO fault injection test:
Quota error (device dm-3): find_block_dqentry: Quota for id 101 referenced but not present
Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 101
Quota error (device dm-3): do_check_range: Getting block 2021161007 out of range 1-186
Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 661

Now, ext4_write_dquot()/ext4_acquire_dquot()/ext4_release_dquot() may commit
inconsistent quota data even if process failed. This may lead to filesystem
corruption.
To ensure filesystem consistent when errors=remount-ro there is need to call
ext4_handle_error() to abort journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240119062908.3598806-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea50ef..fb4d4d320843b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6865,6 +6865,10 @@ static int ext4_write_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_commit(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to commit dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6881,6 +6885,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_acquire(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			      "Failed to acquire dquot type %d",
+			      dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6900,6 +6908,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to release dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
-- 
2.43.0


