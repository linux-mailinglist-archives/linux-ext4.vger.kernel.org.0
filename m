Return-Path: <linux-ext4+bounces-3422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6A93B499
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F591C22912
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A515E5D1;
	Wed, 24 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOYmxGl0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52615B97D
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837494; cv=none; b=OwB1qD6Qq1DRnTP7OpIJHDHr5i0CPqq9XkS97eredHqgXOChHTqmSCoJd+8Ejy3B5R2RlyY7mu4W2b3yzz6+Di36vlC9aoZE9E5IeKOPIbJTvf/3y14MBDFoW7cfgiL7V4s5CDYp3z71nZHnpdNamd6LkMSyiqJqh7+9vjTnRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837494; c=relaxed/simple;
	bh=PZMSdd5O+wZR6bDKU7Sz+d5ZYUTuW61Rr7dJPfO1bYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSU0ER3ldJyZYyqUH46sQbY1Ny6CkwGPx6/NoSl94kkaTxXKjXgvD6IViGADBe4yTC82x9jVJgknE+jEsmePiNlR6ooKtVukPeUTXDtJf60Sium5PSbl6Di8dYvRhcOSr/dPxZxXfFCX98NM9Yudtq3q11tqcI0bgUiRLWO3fFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOYmxGl0; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721837490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8eUEiMtXmowiLjgwuyQYnrkesxiYhQ4jTAv0qVnggo=;
	b=AOYmxGl00clGEmPjqA5s+BtPbn28FSWxU68Z2zn7ZT9XTY4Z26jgw0F+nDEm4T4FO4yGEr
	zp3UXmvp87pRuokHlN+9blxP5WqiZiGs2XDHut6wVwqRSzJjx50kOlBhUyyqU/Odt0CybQ
	+TtAGxzI8KNB6x7kLAmfPeIlf/YoWqs=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 1/4] ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
Date: Wed, 24 Jul 2024 17:11:15 +0100
Message-ID: <20240724161119.13448-2-luis.henriques@linux.dev>
In-Reply-To: <20240724161119.13448-1-luis.henriques@linux.dev>
References: <20240724161119.13448-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
value for transaction IDs, which is incorrect.  Don't assume that and invoke
jbd2_log_wait_commit() if the journal had a committing transaction instead.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..a0fa5192db8e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5279,8 +5279,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 {
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-	tid_t commit_tid = 0;
+	tid_t commit_tid;
 	int ret;
+	bool has_transaction;
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
@@ -5305,12 +5306,14 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 		folio_put(folio);
 		if (ret != -EBUSY)
 			return;
-		commit_tid = 0;
+		has_transaction = false;
 		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
+		if (journal->j_committing_transaction) {
 			commit_tid = journal->j_committing_transaction->t_tid;
+			has_transaction = true;
+		}
 		read_unlock(&journal->j_state_lock);
-		if (commit_tid)
+		if (has_transaction)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
 }

