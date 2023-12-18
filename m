Return-Path: <linux-ext4+bounces-484-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DD816F06
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807D41F24136
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A757996C;
	Mon, 18 Dec 2023 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm8sks3W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49D7AE95;
	Mon, 18 Dec 2023 12:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4884CC433CB;
	Mon, 18 Dec 2023 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903600;
	bh=gUB/iztuCMMhlTeESdK7stuMDqiRM9gHz+uS8p/NV/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm8sks3WigOwjDwjb3i0vDp9opK+Ojcg+LT9qFQg8NP3dWmXxgousLR7QjdNpxAku
	 uvYg6x0rbinSJaGj7OCHmRX7366A4uLIZlUJAJJf4GU1EGGg7KuzLxHd0sGAgFoTq6
	 iyUAXRVi7NCgJfuof7Oj78hu/qMpUP6I5Zz8LEX+N9ewHqKAHdurT12aXGtlZpYpSi
	 Olr3Pr8rSb11Cwa63xG9Y9rBiqyYx6ol6tPKpdzaZQwU3lHWqBShd/Dtr8konjN0UK
	 MYnIHof9Yg1ySKZu9NTmqLEtI/ySx/n8vpjzl7GnTyWJCFLw4uxYFBv/WWJTO6HlHg
	 2ThUUeYZ3dHqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/8] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Mon, 18 Dec 2023 07:46:23 -0500
Message-ID: <20231218124635.1381482-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124635.1381482-1-sashal@kernel.org>
References: <20231218124635.1381482-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.204
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
index fee325d62bfd9..effd837b8c1ff 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1568,9 +1568,11 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
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


