Return-Path: <linux-ext4+bounces-1788-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF38892025
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 16:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDBDEB2E995
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3016C843;
	Fri, 29 Mar 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ8Z+A41"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A214D2A9;
	Fri, 29 Mar 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716497; cv=none; b=HNOyXddFS3PBtLvWAKSNE9pk8o9Qw6Wun1XqEeWOr/bCZqHEoJRSiRLsc/0N1ZZOPPY0oW+sV4sKX+gu1tvVi5+joXswt1auzhbkslnebYOvxcc9WPtfBaQenVXbk3atIUDXVQtStVDhIbxpdUY7ASRdNiBmHX4Ak8nQQXfzmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716497; c=relaxed/simple;
	bh=PNnQIu4sQmiRNsOjKa9qObJuWT1p42oVoTp1SKk+974=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZPz08E06PrBbGSowYoV25jNZyxsfwEElUA7WY2qym65GV45fG5FHAXm6vyd+rnji6paLs8g8EXEoRe/FYPXNNla6E8wqOlWkeQLe5VPc4ffdu0wpGY1pR95VMcDKqb4LoKaSKdi3ggNKvtfZmGftXmkZqm9j/C56xScTLmg20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ8Z+A41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E05C43390;
	Fri, 29 Mar 2024 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716496;
	bh=PNnQIu4sQmiRNsOjKa9qObJuWT1p42oVoTp1SKk+974=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZ8Z+A41ZIdDI/fge9K4UQoN+1zK71p0RyOVEX0gv7ydTLUYE3XTiLcoSlPW6INus
	 fVL8oSumbYyzNz1rmY5xY71GDJtBPGNVxQzHrsPAoq1ojYfhJW2xfX+1J7v3wRoU2h
	 1RDWb4sC8gA4nRhUp+YDBtCSfnVwLMzeDYaB+Ppz6UtNUHEJYLgKHWWIhj/UXw2FLw
	 Ov1ehtc3qOuhxX641XGP+AOzXK8HPXCbrP+oVfOWI/s89zxHZpCudvPGRcNzK0HdZx
	 mL9eA3iHXilglpwSV5wWxqmik4OrKhvXmTuOVR7cKtAGrH4dfhxFIKG3WWFophp2oI
	 gXGGkbm18GcLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/34] ext4: forbid commit inconsistent quota data when errors=remount-ro
Date: Fri, 29 Mar 2024 08:47:16 -0400
Message-ID: <20240329124750.3092394-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 65716a17059d0..a77a8cd75cd9e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6162,6 +6162,10 @@ static int ext4_write_dquot(struct dquot *dquot)
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
@@ -6178,6 +6182,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
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
@@ -6197,6 +6205,10 @@ static int ext4_release_dquot(struct dquot *dquot)
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


