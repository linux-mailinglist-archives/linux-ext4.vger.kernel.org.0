Return-Path: <linux-ext4+bounces-13705-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPwdLpJKk2mi3AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13705-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 17:49:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EB14665A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52E2F3004604
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D084A35;
	Mon, 16 Feb 2026 16:49:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DE242D6C
	for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260555; cv=none; b=Ub9DWiAyg5V7yHWtV25y91YbXwZmO8UNRhlD694Faki0xMfYw1Zhnp6XCeb/mzjwkicUG0euFYmPRgxitfyE2YH3tslGbxXgkSp+mf/6bGJUlfc+quciaET7JhI/mRfVuDFlx93OAKlMNophJ1Ez6xLAaojfosG9e4MGArEyeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260555; c=relaxed/simple;
	bh=dyj19ZhdVKL7uG64tncRok+1Kd5QGtnLKMX3tiEjlJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oinDz6Bu1rbquKmMsCN/qZ6KMmcw0IYX5UIpXDQvmtz4lyuLByrsT+2yEUfGMR8gc2gR6DFN1gXuI/tORMWi3tEEAaesoGATJvZisw6wr9/K5FxAIM713RKIQevXPdJBRjY2uba1BGOvQa84RexfUn23KHIwmEAYQMynqBqV2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14EA33E890;
	Mon, 16 Feb 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7137A3EA65;
	Mon, 16 Feb 2026 16:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BXSgG4FKk2n5OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 16:49:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E710A0B4F; Mon, 16 Feb 2026 17:48:53 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Free Ekanayaka <free.ekanayaka@gmail.com>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ext4: Fix fsync(2) for nojournal mode
Date: Mon, 16 Feb 2026 17:48:44 +0100
Message-ID: <20260216164848.3074-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211140209.30337-1-jack@suse.cz>
References: <20260211140209.30337-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=jack@suse.cz; h=from:subject; bh=dyj19ZhdVKL7uG64tncRok+1Kd5QGtnLKMX3tiEjlJ4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpk0pxRoVGS5mxBEC8M5uXJVA0s1krWTiN9KCb2 YJ0qWNuClSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaZNKcQAKCRCcnaoHP2RA 2Rk0CACoX3ZjS3BgykyREh6EExIEAyXRISkj31B3IkDJhDsl38t14QyrMTdEttwLtJyQv9u8vmq qcHSGi8e79g9X6ZAImRyiOgM2hKPyM8CFlPLJJ4xCS+cS255mi8n0YKvGpJIuZZ7b36eQnEG+Qx ggMOBIGgBhwnDMu14ShTe/EY+qFV1UcC6EGbiz9RPgazxvkaFs0KiBkXO/09asddNpp0401l4Fh cAi1LbEjubCEajBGQfrIJT0vWiSMGDzYed+pIvyMBBMfOOmg5gWPTAN2jaVUfGTEaThs313D6FA SY0X7Nxifdc+ibShtPqt4wlsRRXDxZuujelh3IUwFd1ueQrw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13705-lists,linux-ext4=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:mid,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD8EB14665A
X-Rspamd-Action: no action

When inode metadata is changed, we sometimes just call
ext4_mark_inode_dirty() to track modified metadata. This copies inode
metadata into block buffer which is enough when we are journalling
metadata. However when we are running in nojournal mode we currently
fail to write the dirtied inode buffer during fsync(2) because the inode
is not marked as dirty. Use explicit ext4_write_inode() call to make
sure the inode table buffer is written to the disk. This is a band aid
solution but proper solution requires a much larger rewrite including
changes in metadata bh tracking infrastructure.

Reported-by: Free Ekanayaka <free.ekanayaka@gmail.com>
Link: https://lore.kernel.org/all/87il8nhxdm.fsf@x1.mail-host-address-is-not-set/
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fsync.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index e476c6de3074..bd8f230fa507 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -83,11 +83,23 @@ static int ext4_fsync_nojournal(struct file *file, loff_t start, loff_t end,
 				int datasync, bool *needs_barrier)
 {
 	struct inode *inode = file->f_inode;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 0,
+	};
 	int ret;
 
 	ret = generic_buffers_fsync_noflush(file, start, end, datasync);
-	if (!ret)
-		ret = ext4_sync_parent(inode);
+	if (ret)
+		return ret;
+
+	/* Force writeout of inode table buffer to disk */
+	ret = ext4_write_inode(inode, &wbc);
+	if (ret)
+		return ret;
+
+	ret = ext4_sync_parent(inode);
+
 	if (test_opt(inode->i_sb, BARRIER))
 		*needs_barrier = true;
 
-- 
2.51.0


