Return-Path: <linux-ext4+bounces-488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460D816F5E
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7D287943
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242012910A;
	Mon, 18 Dec 2023 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bql5AIxo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86981290F8;
	Mon, 18 Dec 2023 12:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B764C433C9;
	Mon, 18 Dec 2023 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903651;
	bh=YrNtWmGFvHudnl0Cq8XWa6dPcoA4w6CpaZBG6fdgB5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bql5AIxovyrCuFx9tbbYtlyei2CiuhHtJGuZqTF2D/bi08i75+5UHyBQBkXnt3Nta
	 86ZjRDWrVVpVp5einMGNdbRjkCTkYU+uoCMVi2a+Y3QAMX4IMeYx2vKnI/YsxyBxdB
	 mH8krb80zGkssTym+CqFcCFACrIeLsoHPPhWGMnErDSgPP68OL31VPUEXHrhEhvluM
	 GuwZgI5v6EAqQzQjh/du58jTES29X39mCdMQFx9osjtQucOjoPNwIWnXePjBj1qLFc
	 ePhKC4Jd2cJ8n47VqafOrtQYNt5pWJN3spLNn5bYFylNkWUqQZw57r78fPnskPITs9
	 1US2OKSbNV5oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/6] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Mon, 18 Dec 2023 07:47:19 -0500
Message-ID: <20231218124725.1382738-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124725.1382738-1-sashal@kernel.org>
References: <20231218124725.1382738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.333
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
index 93a466cf58ba7..ee114f0b625a6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1361,9 +1361,11 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
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


