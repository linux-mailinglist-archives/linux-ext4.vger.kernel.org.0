Return-Path: <linux-ext4+bounces-85-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9877F4F11
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9539B28151C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476914F5E7;
	Wed, 22 Nov 2023 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrt35/q6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lX6lNLBS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C19D5C
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 10:14:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B317B21986;
	Wed, 22 Nov 2023 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700676884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=32ogQONtirnCiptMOLFBjwJofkD4p6shWQ5jE2GnIVQ=;
	b=yrt35/q6zrxmaFzpR96Nkx+Cdf62gtQfVsSUsXWpiFBKsn6p+Aoc+Ax4hFI/Q9mkQJOODM
	OHUKc0gJ1xuAKJxlivITdHIUAB/KDJQuxXcmp55nXFj+y9YA1/dDnL5//XFzSR4CC1QEzl
	k/oHh3MsgsT2T0T2z5bZQFyqReL6onw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700676884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=32ogQONtirnCiptMOLFBjwJofkD4p6shWQ5jE2GnIVQ=;
	b=lX6lNLBSDUEwD2AFVVNafBgkfegL2w7ECeH910ZC4E21gsBCmA0YdyVvxRbX8tRvRmEPl7
	KleIj+wjxHo8AvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 944D213467;
	Wed, 22 Nov 2023 18:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2c8vJBRFXmXXawAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 22 Nov 2023 18:14:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EE9CA07D9; Wed, 22 Nov 2023 19:14:44 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Fix warning in ext4_dio_write_end_io()
Date: Wed, 22 Nov 2023 19:14:40 +0100
Message-Id: <20231122181440.12043-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=jack@suse.cz; h=from:subject; bh=lqHZ97ugQA4CzHVpJQYGt7K2fB28NZrBquiAZO2ZxS0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlXkUKgfbs4P963M0xoftvEXV70S5Ohxwg1Lx0JdSs NQ7MJIWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZV5FCgAKCRCcnaoHP2RA2ZGcB/ 0aw+XodgNRllSGx4Lx1YxY4ZJGi25CCNEvHUH96LgTqYTRkCl6tPRlJa2rhxkP5l7ZoGyxtXgWhh8x 2FqUzS5p0bzAK1gjMhzwZgjOGh++mih7UDxJM/kp8bIIXup5BR4+eiVULd6y8ANGVF0c/rPjWy+Ke4 wO81ebZ3/bFo7DPgNwthdnLtuuZP7Dc6XYyWBTIGPCmIMOKq0JjXRD4SzzQ8DE27XMbpJ0Ept5Jh0C r3AK+1MP2TEsgnCuVvrb8XDXSudtYwYhnEv0es//pdu0P6DjirzLLv9ZSjS2apxdhxzO860y7/ZSc+ m5MEINnwIzDPI7B6tZBKyCmluQzJok
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 5.19
X-Spamd-Result: default: False [5.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[47.70%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[47479b71cdfc78f56d30];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

The syzbot has reported that it can hit the warning in
ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
reproducer creates a race between DIO IO completion and truncate
expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
inode state where i_disksize is already updated but i_size is not
updated yet. Since we are careful when setting up DIO write and consider
it extending (and thus performing the IO synchronously with i_rwsem held
exclusively) whenever it goes past either of i_size or i_disksize, we
can use the same test during IO completion without risking entering
ext4_handle_inode_extension() without i_rwsem held. This way we make it
obvious both i_size and i_disksize are large enough when we report DIO
completion without relying on unreliable WARN_ON.

Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0166bb9ca160..ba497aabdd1e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -386,10 +386,11 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	 * blocks. But the code in ext4_iomap_alloc() is careful to use
 	 * zeroed/unwritten extents if this is possible; thus we won't leave
 	 * uninitialized blocks in a file even if we didn't succeed in writing
-	 * as much as we intended.
+	 * as much as we intended. Also we can race with truncate or write
+	 * expanding the file so we have to be a bit careful here.
 	 */
-	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
-	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
+	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
+	    pos + size <= i_size_read(inode))
 		return size;
 	return ext4_handle_inode_extension(inode, pos, size);
 }
-- 
2.35.3


