Return-Path: <linux-ext4+bounces-1790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A68891E80
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FBA282D1B
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3321AEE52;
	Fri, 29 Mar 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiZs6MF7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EA1AEE40;
	Fri, 29 Mar 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716567; cv=none; b=MoMdHii7oeszpVqs8/mQYRyQ+UQuWblFxDQvu6/57iT0IyNDOW0t04FhKv8CBqUd6GmLJZmo2xgxAjA+Hp8+eM3UmdJQpEzwv34ZDsf9yyKfJHIoNJ3QV7MlB6L6U/3gh7YWQl+95HZfUF6fU94sfm5JMY9JwEzotbZud3/3MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716567; c=relaxed/simple;
	bh=QTV8ZOtMj+ZLQjZZP/lq9LxENK231l33h7fiMqhox9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyQj04Wyz16x94G8W4zwD0XSSZ3cr4IxVPHIUNXl4ZxxN5Rpd82Zpfd1TafYe2/zZzc1C8MLllCEYs3hDaHAVXWFduJlTxLDZ3/FuQQOPuDQ1zCjenHW1S4nhKUsv/4cVjsPD57xcAURF6G+1pVhEPXuq1YpKSgfT0BCsoFt7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiZs6MF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11320C43394;
	Fri, 29 Mar 2024 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716566;
	bh=QTV8ZOtMj+ZLQjZZP/lq9LxENK231l33h7fiMqhox9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiZs6MF7y9VrtQEbujJJuuVKl93GcLFIU4iLgifG1xuHSqUOssX7PL1m5Iq49EmDD
	 Wfg6RwMHPz40zxjiueo1YB5KQS3W+2J5HJgYFmfSX+1J3Y/IisVK5acWdruyEm7nln
	 8T+1wiRqJTxOCB25r8wi3eEBIdOEURfWCpgkPZaMtiUZEcucnMpgGIV3Bw5X+yopGe
	 /SqyA/yErhkhrwjmDwx2SGFsj2v6b7JHpYPoDxBEmXN97+sm+ghOkFZaaId+Oj1jQ7
	 N4SlSL3fSjoRDJwVTR9TSzvCJP14abQeSVSrd3pAiYo4rMl2hrbcsQrIURM3D929+6
	 f4X1EZQUadZBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/31] ext4: forbid commit inconsistent quota data when errors=remount-ro
Date: Fri, 29 Mar 2024 08:48:30 -0400
Message-ID: <20240329124903.3093161-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index e386d67cff9d1..0149d3c2cfd78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6205,6 +6205,10 @@ static int ext4_write_dquot(struct dquot *dquot)
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
@@ -6221,6 +6225,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
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
@@ -6240,6 +6248,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


