Return-Path: <linux-ext4+bounces-234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF37FEC5F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AFF281DE0
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66553AC3A;
	Thu, 30 Nov 2023 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jCv+9t3g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U6mGxnKl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC261D54
	for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 01:57:13 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54A9D21ABA;
	Thu, 30 Nov 2023 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701338232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hjpNdxLYAdMoaZYxqMRck+7onxcscrXaPdZ0dPTX2x0=;
	b=jCv+9t3gMhfJzr/h716D6okz2+Dfx7HQq1v8TCYOF+nl7mqxOL1Ir0MYIwiorAgoPGvN+D
	DNrO4QH0NH0yc3Upv8pTxdvSstNmj5qgZUJAEebqhcjeQc3vLeKmfIfAvRfzulLcyPKWxK
	ZtbhqgNemoyPKIgGqDF+UJJzwwuGBcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701338232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hjpNdxLYAdMoaZYxqMRck+7onxcscrXaPdZ0dPTX2x0=;
	b=U6mGxnKlLlQSTeCmXqUIE9OREDIsU+7ckNnFoWuy2J/8iNstyhQT8GS8Oje6pooU/6/IIn
	IB9ZqLqcdc+0l4AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4954413A5C;
	Thu, 30 Nov 2023 09:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1dXlEXhcaGUHLQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:57:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2408A07E3; Thu, 30 Nov 2023 10:56:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: Fix warning in ext4_dio_write_end_io()
Date: Thu, 30 Nov 2023 10:56:53 +0100
Message-Id: <20231130095653.22679-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=jack@suse.cz; h=from:subject; bh=K75fumCFPxoHqTaGL2bHUGBe4g6XBByoQfGI2JOuI78=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlaFxgAiJnv2WU9cbPDWgjwsv+gQltR4ZkmsARAi1J sOscZ4+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZWhcYAAKCRCcnaoHP2RA2eDaB/ 9mvdeNwofYLqkXurZsF9C4cwEZd5pU4+AVYYPsnVnRCDsRPcr3TLBiep7+JNt0xCLK9InPVaL2Md+h JCK//XxB5PIVnVZQ7p8Ul+8SkDVtonl73cVo8J3OV9bhCST8wQPbMiFWVhJSPmIN/crpOTRFJoC/2b kdLa1fS5KlH0KdMeksVC24Eut/OwSHkE8wZq0TRpEn7gbE3iK84muXVBO4ZKlbISG/Y1vcnjElA5z+ JtEXpKHMEA7mQbNj/Dx5AUmUZzSeFFVEsiRM8AhCGkUZ4YdfX+GrqsJ6OqQH4u1LIC/rdPMqRNO02v Pu8a0gQuMb7axsFJSGJEP0/CfVaPft
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 5.40
X-Spamd-Result: default: False [5.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[47479b71cdfc78f56d30];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz,syzkaller.appspotmail.com];
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
 fs/ext4/file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Changes since v1:
* Expanded comment in ext4_inode_extension_cleanup()

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0166bb9ca160..6aa15dafc677 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -349,9 +349,10 @@ static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
 		return;
 	}
 	/*
-	 * If i_disksize got extended due to writeback of delalloc blocks while
-	 * the DIO was running we could fail to cleanup the orphan list in
-	 * ext4_handle_inode_extension(). Do it now.
+	 * If i_disksize got extended either due to writeback of delalloc
+	 * blocks or extending truncate while the DIO was running we could fail
+	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
+	 * now.
 	 */
 	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
 		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
@@ -386,10 +387,11 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
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


