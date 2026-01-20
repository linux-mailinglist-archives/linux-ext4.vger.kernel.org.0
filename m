Return-Path: <linux-ext4+bounces-13107-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPnwLCqFcGktYAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13107-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 08:50:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA8530B6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C94E086AB12
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE174425CD4;
	Tue, 20 Jan 2026 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nre0BZut"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B93E8C7D;
	Tue, 20 Jan 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911597; cv=pass; b=KX156tcyOD8RCJIC1rB4zxlnQqvOjFdKn6vyVmcTBKH5rYjrc3jZ4LmEosMV0kwEA4LzkiMEWWt+J7TFAtkTKVlBEa4BpQg68/at1Lk6XrujqFiqGZwSFrZF6O/gnUcrtknE2C0tWBcw2qBh/UIPVWDznkQSxGVYnov2C5teDfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911597; c=relaxed/simple;
	bh=+58EA+5rTiqFISG/+u15a4aXDLAhhjImKcaYGkRv24c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldl6uHOu2WmNSiljLWukPzEWoevHG9cShhXOTYY4CMopP7nMBv/mrgIRRhb5q2CDgjBR5cs0nZ10baRZca6zYw+2r8knS4/pf7iTI0uN9MR9cGYVsXALDUv/NH7RcB4TjXIdZjxy04VaNDQsJUNtJtIlb9x0H4WW/JKGy/Exznw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nre0BZut; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768911593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CDGtIqfIb7gXi48/MecBqM1QQtmS/wCgRbRcfW6bR3CyP5hn+HuE4UNrQykpoXZpzyhmSxhjB+Ye+CN8eU7dmwbRL/XMqLRPi+iEpLkYIpmIl4x+aTrkp8BgGe1mooLO0/pT7++eSbTXhpKg7XuZQGDS852Lt7DRRvO9hUQCIqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768911593; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hn7mcZHJm7rR7ck8/klgfC/2LZfcYV/ORhUX+AM01oA=; 
	b=UJrD1TqKEy1992tqHnntV9MpOW5HVGG+2BTjWUvm6NaapwcByo1SxYYCBjdVUCwwCY9KNOU8KuHLtysD4SfNBDIYHnxGWwE3u1FrtEpz8cfLQfdFgu58aivnR8JaCwe4HZneqfQNDp9fI+YmWu/IQaAG0cFLhxriV0kcgonGw2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768911593;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hn7mcZHJm7rR7ck8/klgfC/2LZfcYV/ORhUX+AM01oA=;
	b=nre0BZutToaEFRrbVgWE6XN05Mr0rZAdsJOk1jT/1Ep+/hm9t9f+aHs6n0Ie3CYy
	JugsOz/Wv5s9nB+qT7jF7KYb8nIkw5i6I/M3YCdQhoTFiD64Lyx9Ssdse9W9o5XXZSs
	a/1pLPs59naFrQgYwBF4Ds9GkKPQah1C9M5vGLgE=
Received: by mx.zohomail.com with SMTPS id 1768911589726845.7817343363002;
	Tue, 20 Jan 2026 04:19:49 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] ext4: remove unused i_fc_wait
Date: Tue, 20 Jan 2026 20:19:41 +0800
Message-ID: <20260120121941.144192-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13107-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 25BA8530B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

i_fc_wait is only initialized in ext4_fc_init_inode() and never used for
waiting or wakeups. Drop it.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4.h        | 4 ----
 fs/ext4/fast_commit.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..dc3a5a926eff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -28,7 +28,6 @@
 #include <linux/seqlock.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
-#include <linux/wait.h>
 #include <linux/sched/signal.h>
 #include <linux/blockgroup_lock.h>
 #include <linux/percpu_counter.h>
@@ -1091,9 +1090,6 @@ struct ext4_inode_info {
 
 	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
 
-	/* Fast commit wait queue for this inode */
-	wait_queue_head_t i_fc_wait;
-
 	/*
 	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
 	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fa66b08de999..86789989b3f4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -13,6 +13,7 @@
 #include "mballoc.h"
 
 #include <linux/lockdep.h>
+#include <linux/wait_bit.h>
 /*
  * Ext4 Fast Commits
  * -----------------
@@ -215,7 +216,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
-	init_waitqueue_head(&ei->i_fc_wait);
 }
 
 static bool ext4_fc_disabled(struct super_block *sb)
-- 
2.52.0


