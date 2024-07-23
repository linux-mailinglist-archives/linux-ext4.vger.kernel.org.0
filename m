Return-Path: <linux-ext4+bounces-3386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6805193A3E4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902E61C22E06
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A80157A6B;
	Tue, 23 Jul 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dreQwsXf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31751581EA
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749468; cv=none; b=VnsDbUQtIFdwwqZwtW+AtFkbYYd1arEDTYfFD2a5XfOcan82jBk8heciMXPIvrWHWkNa/yBC9T5VAZ6xnFOByHxqB7SnZznE9o2PrghIyHJDFdfU7rgK5ixEuGAdi7+Ofo47hs1k1tS0+6mBIVyv1E7MtfzdqWhTZW9abbZU5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749468; c=relaxed/simple;
	bh=Bxkl0Hsq/C8M5vztSXAU7ypBDTyy8EAXeWXTtS31tww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPTpxn0NDTGo9ssB570aHadasqT8bRrNyZNn571yH8tYRFzRrN+g00ncVlPfE/24NvnLc5mU8ikFxiPwjQJB9aGrEsTr677PFymBVrjpz5UkS9n0dI+uDjV2UhAwDHYA4oRlBH8xOaolmk/SYoztAsJoWb3zOiQOPX+2qvDX0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dreQwsXf; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721749465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rz9lvD/QnXWNWbo/BvxmhM9orJ0FJCtlryAD6j/pNsA=;
	b=dreQwsXfs96IstFiRI1hPoQfQqqUhB116zeyx2xnP7tnJ+ZGwLcg0kgvZTqiwmRqvA+869
	AQJTft3iLRrg23gf3XUyPXGVFdp8pm34oQaDS1lN01fHTwHojAwhsMUaEkb2QiO3WNuCMD
	heAKdE44lTrFIu/gGUNqjzJQGBPLLoM=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 3/4] ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
Date: Tue, 23 Jul 2024 16:44:01 +0100
Message-ID: <20240723154402.21125-4-luis.henriques@linux.dev>
In-Reply-To: <20240723154402.21125-1-luis.henriques@linux.dev>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
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
 fs/jbd2/checkpoint.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 77bc522e6821..f5a594237b7a 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -410,6 +410,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
 	unsigned long freed;
+	bool is_first = true, is_last = false;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -429,8 +430,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	else
 		transaction = journal->j_checkpoint_transactions;
 
-	if (!first_tid)
+	if (is_first) {
 		first_tid = transaction->t_tid;
+		is_first = false;
+	}
 	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
 	next_transaction = transaction;
 	last_tid = last_transaction->t_tid;
@@ -455,12 +458,13 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	} else {
 		journal->j_shrink_transaction = NULL;
 		next_tid = 0;
+		is_last = true;
 	}
 
 	spin_unlock(&journal->j_list_lock);
 	cond_resched();
 
-	if (*nr_to_scan && next_tid)
+	if (*nr_to_scan && !is_last)
 		goto again;
 out:
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,

