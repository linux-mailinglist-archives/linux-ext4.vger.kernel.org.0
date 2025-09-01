Return-Path: <linux-ext4+bounces-9775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE053B3E183
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB41A81B8E
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FC31281C;
	Mon,  1 Sep 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2HbHfnV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8x3rNgT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2HbHfnV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8x3rNgT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2625F7A5
	for <linux-ext4@vger.kernel.org>; Mon,  1 Sep 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726075; cv=none; b=khL/FunjQG3MkPQGaU0TFTNKq6TmtwxE/RbQO5FYg6A4Rs2nnuqIxW1TvV5Oj7+fuk9vv4Tot2hsXeBuwTlIG6s9rA+QmhQVPUZMsfuloJONoIJJKlGk280kXPddj7HnqPJ29I7tcNYBCuAk5GQfKZefVYF5imy1ypDIWxH+cwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726075; c=relaxed/simple;
	bh=XMPLwUFUb9KTunyaocdCCCa79goROCxpi1AzE2OTkEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CO+JykfodZaNeX8mv0Y7rihskpklYSjl2aDyTZvFl51sYFZJZF/mBpyh9TbCIKyJCt5jXG9AXyhtWaNcJqAI+wMf2Qh1IaJ04s1V5fzgDhPsyEy5/1d2dRGXxIgfA8Q8r7N2mVwKkJDbTp+/AxWxh+0Hgwr1DDCIWLZI+M4Nzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2HbHfnV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8x3rNgT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2HbHfnV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8x3rNgT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48CAD1F387;
	Mon,  1 Sep 2025 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756726072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wyb/h4d85zv60bJLMC1MZOtG/xfG+YzWJPuMfazOhv4=;
	b=J2HbHfnVVxF38JMyeSyz2f3Ko3wk7gI7lWDIPZSjnzHsBSny8oLKbBlvVvjbf/q9eRgjXC
	FW7o/e9Xz+V8FtiqTL6ivwWDXssLUmo7EK183VG2JwNDUlEOEol9e7h0XScj1sOgITtuFf
	vPdfJdxOFJ7I2E8hGStUxoLo9ympeGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756726072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wyb/h4d85zv60bJLMC1MZOtG/xfG+YzWJPuMfazOhv4=;
	b=h8x3rNgTWmNqF3gErbB8OJVFIEG/CA3YjEJI6pGuoOKRBk1VyDu2AAlZFj5H10DHrUIyQl
	HviTCXDACNR0meCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756726072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wyb/h4d85zv60bJLMC1MZOtG/xfG+YzWJPuMfazOhv4=;
	b=J2HbHfnVVxF38JMyeSyz2f3Ko3wk7gI7lWDIPZSjnzHsBSny8oLKbBlvVvjbf/q9eRgjXC
	FW7o/e9Xz+V8FtiqTL6ivwWDXssLUmo7EK183VG2JwNDUlEOEol9e7h0XScj1sOgITtuFf
	vPdfJdxOFJ7I2E8hGStUxoLo9ympeGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756726072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wyb/h4d85zv60bJLMC1MZOtG/xfG+YzWJPuMfazOhv4=;
	b=h8x3rNgTWmNqF3gErbB8OJVFIEG/CA3YjEJI6pGuoOKRBk1VyDu2AAlZFj5H10DHrUIyQl
	HviTCXDACNR0meCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38D1D1378C;
	Mon,  1 Sep 2025 11:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pemcDTiDtWjlFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 11:27:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7947A099B; Mon,  1 Sep 2025 13:27:47 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
Date: Mon,  1 Sep 2025 13:27:40 +0200
Message-ID: <20250901112739.32484-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=jack@suse.cz; h=from:subject; bh=XMPLwUFUb9KTunyaocdCCCa79goROCxpi1AzE2OTkEo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBotYMrWvIvsGa5XXrqEn9OWZMnzlYlAPhplJYd570q MJN+dwaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaLWDKwAKCRCcnaoHP2RA2cokCA DDUI6Y6YahfV8ffIFruF/IByMhKwSszVPgpDilJtoDn++0me+vvcijXCXLq9mzLFbQKSedDf5FgWKW tDcgk/evkfdFeTreWAWYJGUGjuoxEPzoBozPf278mLMTkEU4D1u2Viorz6N2pz8UDhG1QUnCnj/5No jeVt0b13ZD2QfNPpwb2NH4SlFnKr1uDXVx2GKvqUizzky9xDF/V3B9JQi4VYJTOQRcVeVrR4hZCOYW 0vw3p9Gh+tKf2gbTfL3eOcOUMWzSdwf2TjK1+koeJawfkaLC0yaSScsNHpYhmMQdU/OIggPCUpAn3H jrlNFBp9AiCDCvpi2YBUe1JJowQOSF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
changed the error handling logic in iomap_iter(). Previously any error
from iomap_dio_bio_iter() got propagated to userspace, after this commit
if ->iomap_end returns error, it gets propagated to userspace instead of
an error from iomap_dio_bio_iter(). This results in unaligned writes to
ext4 to silently fallback to buffered IO instead of erroring out.

Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
unnecessary these days. It is enough to return ENOTBLK from
ext4_iomap_begin() when we don't support DIO write for that particular
file offset (due to hole).

Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..c3b23c90fd11 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
-{
-	/* must be a directio to fall back to buffered */
-	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
-		    (IOMAP_WRITE | IOMAP_DIRECT))
-		return false;
-
-	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC)
-		return false;
-
-	/* can only try again if we wrote nothing */
-	return written == 0;
-}
-
-static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-			  ssize_t written, unsigned flags, struct iomap *iomap)
-{
-	/*
-	 * Check to see whether an error occurred while writing out the data to
-	 * the allocated blocks. If so, return the magic error code for
-	 * non-atomic write so that we fallback to buffered I/O and attempt to
-	 * complete the remainder of the I/O.
-	 * For non-atomic writes, any blocks that may have been
-	 * allocated in preparation for the direct I/O will be reused during
-	 * buffered I/O. For atomic write, we never fallback to buffered-io.
-	 */
-	if (ext4_want_directio_fallback(flags, written))
-		return -ENOTBLK;
-
-	return 0;
-}
-
 const struct iomap_ops ext4_iomap_ops = {
 	.iomap_begin		= ext4_iomap_begin,
-	.iomap_end		= ext4_iomap_end,
 };
 
 const struct iomap_ops ext4_iomap_overwrite_ops = {
 	.iomap_begin		= ext4_iomap_overwrite_begin,
-	.iomap_end		= ext4_iomap_end,
 };
 
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
-- 
2.43.0


