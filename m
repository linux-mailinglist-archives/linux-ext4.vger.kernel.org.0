Return-Path: <linux-ext4+bounces-479-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C58816E92
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E161C24736
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439C138742;
	Mon, 18 Dec 2023 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbwc3kgM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317883B16;
	Mon, 18 Dec 2023 12:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2210AC433CB;
	Mon, 18 Dec 2023 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903519;
	bh=kOzFDxZL1niKTfiVqC1WmaVmAQy4mFwSfUWZijM/nus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vbwc3kgMJIOHU14dHxNi/Y57KpYYjHPUrG7DU7KNiBPMOQxusomAOgKqQvESll+3l
	 JlhKN/LDT24NAL61MQNjQgZ5HJlHUQACEv1pxZoUM9nMJIps7IE1vFrn+cVtWGJxPm
	 nDbU6DNre/vhXv6iUlWNbaSBesVXYzytK6gMnCku9PjuvwSOu0DFpCMT9dYHBVsC72
	 noxIu4CtPFB1XywszObhxJGSXDah7DIfLY7jHZ559GpRwBT7ygMvBuUnWf63zdqnxF
	 iP9eubmqBYnGwXKmHYy2qUe94DF+elc5b/H5r9gzug8e10ncCxOi7dXhWPsq77/UWc
	 isTlYisVjuTYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/15] jbd2: correct the printing of write_flags in jbd2_write_superblock()
Date: Mon, 18 Dec 2023 07:44:50 -0500
Message-ID: <20231218124513.1380056-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124513.1380056-1-sashal@kernel.org>
References: <20231218124513.1380056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.68
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
index 2696f43e7239f..611337b0b5ad4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1620,9 +1620,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
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


