Return-Path: <linux-ext4+bounces-3490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0593E68A
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C11C2125F
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1944132132;
	Sun, 28 Jul 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6/cUpQx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3079B96;
	Sun, 28 Jul 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181500; cv=none; b=c00tz85t/SYw7xpUy2J48COepAnIJPy8tr/9+tnDx3ECvp0/I/L7lFso6UWOyZu31K4/aSpK65PtoIS4vvAHBN59IEnR3NEvRsqONl5pial1d5vxwmTlk4CE2nZ2295Gq5hWdbMu2Rf3zowk/1zFdCnsaL58VC419fz6U0Pc3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181500; c=relaxed/simple;
	bh=sK186PS30/XxqNdSYLEpgwInVcCUBO/O9BODHrgo5+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgyCH6oYiHa14zql3XKE4DZ6i+hCc0r4X9o7IYd+pEluC0SAdwuU86GoyHibR+2Jpu0vHdNdSXZqmalUxZ08TGCyiDsHuF94/VO6u2IfhEwbiyIhYBy+HfMnUgq4C2JPXpBe52w7STf1zyEfQDJC0pid8W6zbQGrBjHfoCgwZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6/cUpQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE725C32782;
	Sun, 28 Jul 2024 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181500;
	bh=sK186PS30/XxqNdSYLEpgwInVcCUBO/O9BODHrgo5+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6/cUpQx1DODMHxpQcR0Wf9AVLW6fUYmXzBF/dCPh/8OeSef5u9FuVBOg9AS9nk+6
	 FjePWcpXDJdEqJV0VDKM0eCQj+iokJS3nqZgr8afyuYpgFPu2ZDbhAwouS1sBF5tQS
	 yHL85Z5UASJrCBfyLACsCxgGVywm4K0tnVE9V8erw/7LBN2DrCp8dlngmOf74qpcYX
	 pwUhacJoYO6oo6DQt/VDdEVeUo3cioQOvswkc0Xx9JgJBoEQEkXPkBtHg5wOoCFfF9
	 tOKOymknaB508oM7j4WUaExSuiUAjtQhEDB9Ymt0lCMgMTuA5xj9uKBf3giYZtjKS7
	 oqVXOtMLlS3xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 30/34] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:40:54 -0400
Message-ID: <20240728154230.2046786-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit cc102aa24638b90e04364d64e4f58a1fa91a1976 ]

The new_bh is from alloc_buffer_head, we should call free_buffer_head to
free it in error case.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240514112438.1269037-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 03c4b9214f564..5ad255ffb289c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.43.0


