Return-Path: <linux-ext4+bounces-10424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E04DB9F444
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 150F24E34E4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBF258CE9;
	Thu, 25 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVV8+dXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAEKwnfB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVV8+dXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAEKwnfB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93026058D
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803454; cv=none; b=d3rTpiKKfnpUvOeCqwal/gMgkEs3/P8ieBcqgGJ/ULfaY5HOBoAw3n6EEd11RX4/TAsWVnfxEMrweoayxJuS7wVO1hkVTPN8Sq4SFf5aHb2zthKzHZ5WxETqHodOxUwqeSq2fwYbnWyRJpH3qqmrcsWwzFHntdnBKYKvwyI7zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803454; c=relaxed/simple;
	bh=4nPyTqeASVyIQ9VM3Ek0RSokngndHqpgt8EU8AdOa8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrED9KYiWP2OpFejHRdIAdlF6vho+cv51O2pXlLnr13WOdS0zOGhZA3W68czfFggjcDvbc30+1nswzIfdmPk7GHn2WfTONEIDIL160VhKqevgVpYLstNtgLGSjXhdcd+zaBLpStJ3Cd6kvP/wWB7ITjMmcCweJ2YZX5EwIPWRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVV8+dXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAEKwnfB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVV8+dXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAEKwnfB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95D096AF5E;
	Thu, 25 Sep 2025 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758803450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=861HtjCeriXon+IFD5odf/raNmoy/kwYB29bWJCzZ3E=;
	b=VVV8+dXFqomGCX4n3Y+DzLtbZq/Qv4hZSAzbcqNq+UyGROwtJHGkbmaXcimyBKwqIF53iM
	O59rRIkxqh69TVTHtbCm5C+a5IUrqKfg2hQWWu9tPBpXSLd11P7M3XsgiWmF7BfmULcsWh
	Boe1On0x47wppaneW0dOl69R5iZJT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758803450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=861HtjCeriXon+IFD5odf/raNmoy/kwYB29bWJCzZ3E=;
	b=SAEKwnfB2f+W3CWH+8SoG7R1bDU1cvQxGs3wmi0gIK0JzSqwPmQP+nlK+kBb8J/vzJz4JT
	EF4QVYW5s/VLzRCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758803450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=861HtjCeriXon+IFD5odf/raNmoy/kwYB29bWJCzZ3E=;
	b=VVV8+dXFqomGCX4n3Y+DzLtbZq/Qv4hZSAzbcqNq+UyGROwtJHGkbmaXcimyBKwqIF53iM
	O59rRIkxqh69TVTHtbCm5C+a5IUrqKfg2hQWWu9tPBpXSLd11P7M3XsgiWmF7BfmULcsWh
	Boe1On0x47wppaneW0dOl69R5iZJT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758803450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=861HtjCeriXon+IFD5odf/raNmoy/kwYB29bWJCzZ3E=;
	b=SAEKwnfB2f+W3CWH+8SoG7R1bDU1cvQxGs3wmi0gIK0JzSqwPmQP+nlK+kBb8J/vzJz4JT
	EF4QVYW5s/VLzRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B76E132C9;
	Thu, 25 Sep 2025 12:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tTH/Ifo11WhDGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 12:30:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 136B0A0AA0; Thu, 25 Sep 2025 14:30:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix checks for orphan inodes
Date: Thu, 25 Sep 2025 14:30:39 +0200
Message-ID: <20250925123038.20264-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981; i=jack@suse.cz; h=from:subject; bh=4nPyTqeASVyIQ9VM3Ek0RSokngndHqpgt8EU8AdOa8M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo1TXueeUCTkZiTZWCsUW/Tbwd5h5R4vu8a3icr i3OdRdwzDWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaNU17gAKCRCcnaoHP2RA 2bHjB/47/60TqywJkNsltKVNRychJ4wf8c+GgRcgoLddQsfuxBpc+QlY4xXvHzYkIxtX6KNKKTz AA/X7UAH47UxWAS+yf1JqdIfSmLAviZNLCwUySJIg/C0Axr9iFaEdNSmkYHbNfhwubbIon0VfSS HaCuNmtPrDASuASAjbYs7DGPURzvhDKSQB+QH4GzqtgHMoM0RowmBIMqFxpbJXK1eYV2fLD3P+u 1/wlBKURrOVbMScvPK1xw+V9jXjZJqFUPYSoNJIhJhX/pZ1vpu727PdXmh9heofEMateEKxvD7q W9lvL9Rotxn9t3Kk/nN5x1V6vTTDaM8gx/0b/MLbHGjsAB+k
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

When orphan file feature is enabled, inode can be tracked as orphan
either in the standard orphan list or in the orphan file. The first can
be tested by checking ei->i_orphan list head, the second is recorded by
EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
we want to check whether inode is tracked as orphan and only some of
them properly check for both possibilities. Luckily the consequences are
mostly minor, the worst that can happen is that we track an inode as
orphan although we don't need to and e2fsck then complains (resulting in
occasional ext4/307 xfstest failures). Fix the problem by introducing a
helper for checking whether an inode is tracked as orphan and use it in
appropriate places.

Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h   | 10 ++++++++++
 fs/ext4/file.c   |  2 +-
 fs/ext4/inode.c  |  2 +-
 fs/ext4/orphan.c |  6 +-----
 fs/ext4/super.c  |  4 ++--
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 01a6e2de7fc3..72e02df72c4c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1981,6 +1981,16 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 
 #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
 
+/*
+ * Check whether the inode is tracked as orphan (either in orphan file or
+ * orphan list).
+ */
+static inline bool ext4_inode_orphan_tracked(struct inode *inode)
+{
+	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
+		!list_empty(&EXT4_I(inode)->i_orphan);
+}
+
 /*
  * Codes for operating systems
  */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 93240e35ee36..7a8b30932189 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
 	 * now.
 	 */
-	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
 		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 
 		if (IS_ERR(handle)) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..5230452e29dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4748,7 +4748,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 		 * old inodes get re-used with the upper 16 bits of the
 		 * uid/gid intact.
 		 */
-		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
+		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
 			raw_inode->i_uid_high = 0;
 			raw_inode->i_gid_high = 0;
 		} else {
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..0fbcce67ffd4 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 
 	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
-	/*
-	 * Inode orphaned in orphan file or in orphan list?
-	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
-	    !list_empty(&EXT4_I(inode)->i_orphan))
+	if (ext4_inode_orphan_tracked(inode))
 		return 0;
 
 	/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a8..ba497387b9c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1438,9 +1438,9 @@ static void ext4_free_in_core_inode(struct inode *inode)
 
 static void ext4_destroy_inode(struct inode *inode)
 {
-	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
+	if (ext4_inode_orphan_tracked(inode)) {
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): orphan list check failed!",
+			 "Inode %lu (%p): inode tracked as orphan!",
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
 				EXT4_I(inode), sizeof(struct ext4_inode_info),
-- 
2.51.0


