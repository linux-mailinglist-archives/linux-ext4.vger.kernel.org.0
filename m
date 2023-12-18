Return-Path: <linux-ext4+bounces-482-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F26816EC5
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF31C238A5
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7C73475;
	Mon, 18 Dec 2023 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW8WU2m1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0C73499;
	Mon, 18 Dec 2023 12:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB61C433C8;
	Mon, 18 Dec 2023 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903561;
	bh=gst2YEKb5IQHmbooikq1WLmLsIAiamHXnD2ZK4xDfnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PW8WU2m1v3K9Dvj8ey40Uc8X+NkZrJNV5HVC/wAYro+zMmpRuD8mSPxNcg9YebnnG
	 Vml5EvKZ7zNDfhQdYLo5ibyBRWKWPG6ptP0pSBPgMSKnJoByn33r+QcHRHEdVnJSjI
	 1oAdgVMTuJ97HuEOCgdnciOtyzv/l3HZaR6g6LGwTm0kWmN6YgqCIKBjMzRLuHpMw+
	 /fKQlcP2L0WXzR+0iYgRr+H71wbzPNXGY9JCtnpMNc8dbNjlJvB3yU6eLXjzz6t6Lz
	 s99X0R1CJVzzziMNZw7+2mL8DsybhJnuFK5+3IDpSEpAZE0ADxN1CMFT9xJjYKtLsf
	 GFS62hL9FeerQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/13] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Mon, 18 Dec 2023 07:45:35 -0500
Message-ID: <20231218124557.1380724-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124557.1380724-1-sashal@kernel.org>
References: <20231218124557.1380724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.143
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
index 11fbc9b6ec5cb..b7af1727a0160 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1616,9 +1616,11 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
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


