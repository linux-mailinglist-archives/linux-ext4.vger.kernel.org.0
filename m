Return-Path: <linux-ext4+bounces-476-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4106816E50
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7487D1F214A9
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED480DFB;
	Mon, 18 Dec 2023 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOjJObjH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4006138D3F;
	Mon, 18 Dec 2023 12:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A5CC433D9;
	Mon, 18 Dec 2023 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903463;
	bh=rlDckHg1oXaMhXQd1EujW6dU1WMOGuY7YxzvwEyHHww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOjJObjHQI4qNFi8wPLuzp2lHyK65zYjNKTaay8CZBGyu6sg5F5VgKKQ1jAjZi5so
	 bXkoHl2xwSHmTrDgKG/2TXi099lV2sOIZ2MODhRFeiWwNVFfIir6ubVWjDINnj2TEG
	 mp0lR0IVC4xU9QLijs1e5a9NOjy+zFB8bh+yeZIwMyIOitqIII5JllGvJHUUhWRBww
	 Jh0BMi8rU+Uh4NX5/Uqou+9Lc7kJuRAulEIvB2Wai0DvJf3J2ZeHz3dOp0vY05tFzd
	 H4FZmElyIEaqJZXNiwKJCYYaWMvItxOB35G6irgpopC+MH3AY+SCXzsZDy+pDLdYRy
	 PYc2GkoSRbIaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/18] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Mon, 18 Dec 2023 07:43:38 -0500
Message-ID: <20231218124415.1379060-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 85559227211020b270728104c3b89918f7af27ac ]

The write_flags print in the trace of jbd2_write_superblock() is not
real, so move the modification before the trace.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231129114740.2686201-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 30dec2bd2ecc2..e7aa47a02d4d6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1791,9 +1791,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		return -EIO;
 	}
 
-	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
+
+	trace_jbd2_write_superblock(journal, write_flags);
+
 	if (buffer_write_io_error(bh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the journal
-- 
2.43.0


