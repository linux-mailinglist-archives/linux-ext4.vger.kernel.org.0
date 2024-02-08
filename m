Return-Path: <linux-ext4+bounces-1175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D984E5B1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB3728D0E9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E580C05;
	Thu,  8 Feb 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bz/TewRj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nIQFLhzf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bz/TewRj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nIQFLhzf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919C73164;
	Thu,  8 Feb 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411494; cv=none; b=ThUeZzGSkjC3fyFQtejkMdnSuf65WK1YjdFfS3Gf8X4klrx4h0Y6QxCcc0CbtoWXmkoTVQQIL9Adm1rBuIH70aUvfwQeICERGv04weeRslbk7xiyBmYZc1AOMLvL4rvWJWNKzqs8ctkoQ2w4IHtkAnUkQ7fFr95185sDxza8iKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411494; c=relaxed/simple;
	bh=/H4JDepbabc9q49WGUHSfSWdZExqVMaCPHCVozpHu0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Di/ZTWIURKWOhDFtHEiVhjs9gSx0izrkX+LTvYkDqgpiPCJfZ17IutIso5bPnAzv26HeO1XBxpSD90Va6JCByF/GnDMuNMk73DuUbI3N8dPuY3oDug60kgWCc78ZwA4JpCoDdRuMSM8GFYzvkh//kfyDV9562itdTXN0x4TKoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bz/TewRj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nIQFLhzf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bz/TewRj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nIQFLhzf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E9D021F60;
	Thu,  8 Feb 2024 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707411490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ZgXjD6osKpD5V9BCXa39jxK5ZSPDcRIhG5CJmbbskg=;
	b=bz/TewRjkqpTmUZKQKCJP7eJSNDfp5FqxBpIpMxhQmVM4rpuvoBvXS2YhB79C/Cmw6+YqD
	G0AERVZHLw9Ozz9DoetzgMpEOLotRXUOWNSQKT0K0F4XZcCEPTaU9lIBOrKHjj6fqJNFTs
	p2XZk8DAxt3Ywpg1kAJiokZXagBgPOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707411490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ZgXjD6osKpD5V9BCXa39jxK5ZSPDcRIhG5CJmbbskg=;
	b=nIQFLhzfT80Hm9wpwCMZJQCuCM56tJTjzU4H6yRCztaPh0Kzt0ZQuzDsmE2UQiyQ0YPT3Y
	jEetek3XjewewQCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707411490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ZgXjD6osKpD5V9BCXa39jxK5ZSPDcRIhG5CJmbbskg=;
	b=bz/TewRjkqpTmUZKQKCJP7eJSNDfp5FqxBpIpMxhQmVM4rpuvoBvXS2YhB79C/Cmw6+YqD
	G0AERVZHLw9Ozz9DoetzgMpEOLotRXUOWNSQKT0K0F4XZcCEPTaU9lIBOrKHjj6fqJNFTs
	p2XZk8DAxt3Ywpg1kAJiokZXagBgPOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707411490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ZgXjD6osKpD5V9BCXa39jxK5ZSPDcRIhG5CJmbbskg=;
	b=nIQFLhzfT80Hm9wpwCMZJQCuCM56tJTjzU4H6yRCztaPh0Kzt0ZQuzDsmE2UQiyQ0YPT3Y
	jEetek3XjewewQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECFCA1326D;
	Thu,  8 Feb 2024 16:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9wqANiEIxWW2FAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 08 Feb 2024 16:58:09 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 5e47eb05;
	Thu, 8 Feb 2024 16:58:09 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>,
	Daniel Dawson <danielcdawson@gmail.com>
Subject: [RFC PATCH] ext4: destroy inline data immediately when converting to extent
Date: Thu,  8 Feb 2024 16:58:07 +0000
Message-ID: <20240208165808.5494-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

When writing to an inode that has inline data and the amount of data written
exceeds the maximum inline data length, that data is un-inlined, i.e. it is
converted into an extent.  However, when delayed allocation is enabled the
destruction of the data is postponed until the data writeback.  This causes
consistency problems.  Here's a very simple test case, run on a filesystem
with delayed allocation and inline data features enabled:

 $ dd if=/dev/zero of=test-file bs=64 count=3 status=none
 $ lsattr test-file
 ------------------N--- test-file

The 'lsattr' command shows that the file has data stored inline.  However,
that is not correct because writing 192 bytes (3 * 64) has forced the data
to be un-inlined.  Doing a 'sync' before running the 'lsattr' fixes it.

Note that this bug doesn't happen if the filesytems is mount using the
'nodelalloc' option.

(There's a similar test case using read() instead in the bugzilla linked
bellow.)

This patch fixes the issue in the delayed allocation path by destroying the
inline data immediately after converting it to an extent instead of delaying
that operation until the writeback.  This is done by invoking function
ext4_destroy_inline_data_nolock(), which is going to clean-up all the
missing data structures, including clearing ĨNLINE_DATA and setting the
EXTENTS inode flags.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200681
Cc: Daniel Dawson <danielcdawson@gmail.com>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Hi!

I'm sending this patch as an RFC because, although I've done a good amount
of testing, I'm still not convinced it is correct.  I.e. there may exist a
good reason for postponing the call to ext4_destroy_inline_data_nolock() and
that I'm failing to see it.  Please let me know what you think.

 fs/ext4/inline.c | 20 ++++++++++----------
 fs/ext4/inode.c  | 18 +-----------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..e19a176cfc93 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -830,11 +830,12 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
  *    update and dirty so that ext4_da_writepages can handle it. We don't
  *    need to start the journal since the file's metadata isn't changed now.
  */
-static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
+static int ext4_da_convert_inline_data_to_extent(handle_t *handle,
+						 struct address_space *mapping,
 						 struct inode *inode,
 						 void **fsdata)
 {
-	int ret = 0, inline_size;
+	int ret = 0, inline_size, no_expand;
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN,
@@ -842,7 +843,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	down_read(&EXT4_I(inode)->xattr_sem);
+	ext4_write_lock_xattr(inode, &no_expand);
 	if (!ext4_has_inline_data(inode)) {
 		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 		goto out;
@@ -859,20 +860,18 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	ret = __block_write_begin(&folio->page, 0, inline_size,
 				  ext4_da_get_block_prep);
 	if (ret) {
-		up_read(&EXT4_I(inode)->xattr_sem);
+		ext4_write_unlock_xattr(inode, &no_expand);
 		folio_unlock(folio);
 		folio_put(folio);
 		ext4_truncate_failed_write(inode);
 		return ret;
 	}
 
-	folio_mark_dirty(folio);
-	folio_mark_uptodate(folio);
-	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	ret = ext4_destroy_inline_data_nolock(handle, inode);
 	*fsdata = (void *)CONVERT_INLINE_DATA;
 
 out:
-	up_read(&EXT4_I(inode)->xattr_sem);
+	ext4_write_unlock_xattr(inode, &no_expand);
 	if (folio) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -916,10 +915,11 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_journal;
 
 	if (ret == -ENOSPC) {
-		ext4_journal_stop(handle);
-		ret = ext4_da_convert_inline_data_to_extent(mapping,
+		ret = ext4_da_convert_inline_data_to_extent(handle,
+							    mapping,
 							    inode,
 							    fsdata);
+		ext4_journal_stop(handle);
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ccf3b5e3a7c..43fa930fafa0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2548,23 +2548,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		goto out_writepages;
 	}
 
-	/*
-	 * If we have inline data and arrive here, it means that
-	 * we will soon create the block for the 1st page, so
-	 * we'd better clear the inline data here.
-	 */
-	if (ext4_has_inline_data(inode)) {
-		/* Just inode will be modified... */
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
-			goto out_writepages;
-		}
-		BUG_ON(ext4_test_inode_state(inode,
-				EXT4_STATE_MAY_INLINE_DATA));
-		ext4_destroy_inline_data(handle, inode);
-		ext4_journal_stop(handle);
-	}
+	WARN_ON_ONCE(ext4_has_inline_data(inode));
 
 	/*
 	 * data=journal mode does not do delalloc so we just need to writeout /

