Return-Path: <linux-ext4+bounces-13147-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEbiMr10cGktYAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13147-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 07:39:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1A522C7
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 07:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFA404C526D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9B35E530;
	Wed, 21 Jan 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZhqE6mw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3F44A72E
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977506; cv=none; b=nbtQjQ4rhUamqf6Nx2fpftlLXM3J4gz6nFYEnq4qgpfbm6zPovtDhqssw11EujLEYF8QElLZnU+5T01HG1sgZDyzxMBCs2v8kLHZINuMpWQQxKemAXMq0pO1W3QLFhyDi2CIovMlOEyc/UqQCdCTeTy3gKx0/UZS1516pZ1RWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977506; c=relaxed/simple;
	bh=aIhBjmg4pZQBN4SFcfuzZxK1cHfCJigb8iFf5F3uDeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etwp9NUctYUjDYhB0lx1dQWoxno6qPkzRBWoVw9RBmekyKX14dJACH17IH/EL0kVv/yYuDEZO+9Q3Qq4VkLvhElBHZCxd8qFsONGX26eZ5p5v7lDQSy4SJeCcbdXHInqXO9ckzlOq2McokBZ56JV/b0KD6B9nangTOmJlu49p/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZhqE6mw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768977499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfgGrz7uzf3Ctc87xl5PASCmzX0Cq61qmfqTiPlFtwI=;
	b=rZhqE6mwZrkiiPBEwOFcRlJlOA/CN8AiCGlOf/yGvlJmAMjPAYKKHLtH0SOiKL+pfkU89R
	KVlN8jVl2rAbSqw87ZmtUpy6nXoe5JOSVxHqQlsQAWmGMFDYY6WRvZ9sTDzHWfsgXKuId3
	qmE1n5zqvA09qsL3CQNU/pyzaxgJazU=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: remove tl argument from ext4_fc_replay_{add,del}_range
Date: Wed, 21 Jan 2026 14:38:05 +0800
Message-Id: <20260121063805.19863-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TAGGED_FROM(0.00)[bounces-13147-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoqing.jiang@linux.dev,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4BF1A522C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit a7ba36bc94f2 ("ext4: fix fast commit alignment issues"),
both ext4_fc_replay_add_range and ext4_fc_replay_del_range get
ex based on 'val' instead of 'tl'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/ext4/fast_commit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fa66b08de999..8474ae52f8dd 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1751,8 +1751,7 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
 }
 
 /* Replay add range tag */
-static int ext4_fc_replay_add_range(struct super_block *sb,
-				    struct ext4_fc_tl_mem *tl, u8 *val)
+static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 {
 	struct ext4_fc_add_range fc_add_ex;
 	struct ext4_extent newex, *ex;
@@ -1872,8 +1871,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 /* Replay DEL_RANGE tag */
 static int
-ext4_fc_replay_del_range(struct super_block *sb,
-			 struct ext4_fc_tl_mem *tl, u8 *val)
+ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
 {
 	struct inode *inode;
 	struct ext4_fc_del_range lrange;
@@ -2243,13 +2241,13 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ret = ext4_fc_replay_unlink(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_ADD_RANGE:
-			ret = ext4_fc_replay_add_range(sb, &tl, val);
+			ret = ext4_fc_replay_add_range(sb, val);
 			break;
 		case EXT4_FC_TAG_CREAT:
 			ret = ext4_fc_replay_create(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_DEL_RANGE:
-			ret = ext4_fc_replay_del_range(sb, &tl, val);
+			ret = ext4_fc_replay_del_range(sb, val);
 			break;
 		case EXT4_FC_TAG_INODE:
 			ret = ext4_fc_replay_inode(sb, &tl, val);
-- 
2.43.0


