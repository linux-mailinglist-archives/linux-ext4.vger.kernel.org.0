Return-Path: <linux-ext4+bounces-3424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D693B49E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796D11F22701
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CC15EFB9;
	Wed, 24 Jul 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9owXIbO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824215ECFA
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837505; cv=none; b=nbhkIzO+FzACZhm45R186rMXiNMQpyrdJnR3KH3x3PywkJ6FLbGuY8P8oGwdl7t53d59KELlbBwOfei6JoXWufFNfmpew9oRt6wTnsPoWEHi+sdJmLZjh2Qyjg6PfUljfZJPplU5Klzh3xb8lXAG4UV9oLxfqpE8nsNXOr6Nmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837505; c=relaxed/simple;
	bh=G+NetOiA07DsopKThDt7NVtlD4oyFoF/Xr+T8bHrr+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rui2nvYdnqt63EoL6rePRnvCj/7Hj6DOewZA/5DOAAsxK1dC+ZKxuEXcPNqKXqZd0/9zYDb86IAefeGfc6S4XhZLwnrnv5S9oQ1GCI6u7Ra0zCU0xJebJfCb1sudnMdoY/YGVMvYV9+juP75IJg9HEzBfNpt2uHYjFHEjj9p5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9owXIbO; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721837501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qW8LXRG/ucQNNYMkPNdCyzVM3kQHzkMXl1yju9gDpjA=;
	b=P9owXIbOD+23mcx9P1PUA3yiG/eZQ0Jr/PgZKYLYjOYkHe+P8LUEQlBGUOEfPffSxYyGkb
	CJFIs0eagDUMXtbx6yxQI1nVlUS8mvk0NU0yI4qE/Hi1LMDvhs5SJ5Hn0Czqqmd6HZCIef
	fx3LRsIGKIaiapDjy8MdbfRVkRre7Rw=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 3/4] ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
Date: Wed, 24 Jul 2024 17:11:17 +0100
Message-ID: <20240724161119.13448-4-luis.henriques@linux.dev>
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

Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
valid value for transaction IDs, which is incorrect.  Don't assume that and
use two extra boolean variables to control the loop iterations and keep
track of the first and last tid.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/jbd2/checkpoint.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 77bc522e6821..98a0b2eb84f5 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -410,6 +410,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
 	unsigned long freed;
+	bool first_set = false;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -429,8 +430,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	else
 		transaction = journal->j_checkpoint_transactions;
 
-	if (!first_tid)
+	if (!first_set) {
 		first_tid = transaction->t_tid;
+		first_set = true;
+	}
 	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
 	next_transaction = transaction;
 	last_tid = last_transaction->t_tid;
@@ -460,7 +463,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	spin_unlock(&journal->j_list_lock);
 	cond_resched();
 
-	if (*nr_to_scan && next_tid)
+	if (*nr_to_scan && journal->j_shrink_transaction)
 		goto again;
 out:
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,

