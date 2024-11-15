Return-Path: <linux-ext4+bounces-5193-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A79CDEC4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43080B24FB0
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645341BBBF1;
	Fri, 15 Nov 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRBkJGRs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/9WwUNM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GuX7CFBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2XOQ4fV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08642AE77
	for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675491; cv=none; b=SE6esgYkCigr4Ft3q46whtti5a/o1BKU5JSyv1VBGzud0Kb/7BC6Ai8Hqe8sA1c7qz2O09+WmtEMADm7aKXtNcy22QqkQ2dWhhhO1zQJBVLi7eW8UV6AGNwVxM9W6dHipeodBiJNariPx7sET+KXeN5Cp5la6pUXP6hXYboHgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675491; c=relaxed/simple;
	bh=ao8Dd1DTiWzz+2/XF3H+pf+m+lu8wlr+t81Tsuv+7Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCl0SYTb4cPBXTexb3UQPOOyVfe6z6D0NIS6qmohj5kT4vV+n5d+mwfucA/bJZ8+p/J1G4rAM4yATvDsek0CLNxarJDHepMWQI8L1gT13NyO7uehBzRS+19oTH4izrfUjmbfjgkBcl4c1q88b6s/x6UZz3S5CSjZ1mqvWEg5mYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRBkJGRs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/9WwUNM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GuX7CFBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2XOQ4fV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AE8A21172;
	Fri, 15 Nov 2024 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731675487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0vqAYKmYoiqarr1MC2N1P2kIM97vv6uC9EneQfmqSAo=;
	b=MRBkJGRsvpFAtGdytxvWae9aJDAgFtouHrlydQU2nu6BpAtChlxhGuVhmAAY9wrlbgu9Wk
	6P2IwebzVUPJjwfhKsvR5s4XokTr7v0CC/v/ciqkLDZJe4UWMhDeKM/qYzbOkHjKxw8Zft
	rPtN60fASqCigb1MDOEqPaMWfMfkroU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731675487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0vqAYKmYoiqarr1MC2N1P2kIM97vv6uC9EneQfmqSAo=;
	b=B/9WwUNMrX1ftn31myg78p5QK6IF1Pdb3tTEm99mL7LPCn7QVmdpURYY0itHh8tLfgWP9y
	ZN+mF44e6MCiNPAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731675486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0vqAYKmYoiqarr1MC2N1P2kIM97vv6uC9EneQfmqSAo=;
	b=GuX7CFBzHM42+i2LqeD46ny+RXg7V6F+2UnjWStnFOb6zDBB3lb5XguNygrTLlj/ebgxb2
	HRieHPCrzrNXOcu2KuByEeH+Rgz/vweoamFGofjMq33Y7fIQMvqwo6POlSR7zC76TPcxrR
	UaUIKi2JLnRTHve8NE7rITsP8vzfo4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731675486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0vqAYKmYoiqarr1MC2N1P2kIM97vv6uC9EneQfmqSAo=;
	b=i2XOQ4fVMWVP6F3lnI6OK0BhIeO5NVyfUkWLWL0KcLNb4TXxgKPwU37tW4VvHBYQJve2th
	7EUT4HchTJ8aLwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3A7513485;
	Fri, 15 Nov 2024 12:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gfd6O11FN2dLCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Nov 2024 12:58:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9AB48A0986; Fri, 15 Nov 2024 13:58:05 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Liu <liubaolin12138@163.com>,
	Zhi Long <longzhi@sangfor.com.cn>
Subject: [PATCH v4] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Fri, 15 Nov 2024 13:58:00 +0100
Message-Id: <20241115125800.7709-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=jack@suse.cz; h=from:subject; bh=ao8Dd1DTiWzz+2/XF3H+pf+m+lu8wlr+t81Tsuv+7Yk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnN0VTML7RltUKoqH0Po7+8Z/hhjrZKVFRzZ9BbxuK sKSs+wCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZzdFUwAKCRCcnaoHP2RA2QNCB/ 9/HzS9en/CosNs0sKEEMP6L+QN/unZ6SG+LmQTZxVBWPVgxivii5sPij9LNY2/fwFIxYPO6+ssUj6T u/LB0NPhZ1qoq7VFomV+IPRNV7n6sAwWc88IMscKvycM0BvxEnXBS/w5st5ltE5etTCAA1yiDaVGcA b70TWBCXprMPTKbGmzYMWqnUVBwXhB+CFv1tyLIEsEm5cc8F6dqxXasukd2qzKgfXjiZaenkRTZBac fX8R3lt1Oq//FCfpDCYLWazMXyCtvyK4DdUiETy21m7Y3I0GWCB/0cpCoJanKPcwDifYiQHURww0lP croLZgyDzyFtTrXTQvQrxjd1x5xemE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,163.com,sangfor.com.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,sangfor.com.cn:email];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently we clear BH_New bit in case of error and also in the standard
ext4_write_end() handler (in block_commit_write()). However
ext4_journalled_write_end() misses this clearing and thus we are leaving
stale BH_New bits behind. Generally ext4_block_write_begin() clears
these bits before any harm can be done but in case blocksize < pagesize
and we hit some error when processing a page with these stale bits,
we'll try to zero buffers with these stale BH_New bits and jbd2 will
complain (as buffers were not prepared for writing in this transaction).
Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
and WARN if ext4_block_write_begin() sees stale BH_New bits.

Reported-by: Baolin Liu <liubaolin12138@163.com>
Reported-by: Zhi Long <longzhi@sangfor.com.cn>
Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 2 ++
 fs/ext4/inode.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Changes since v3 (https://lore.kernel.org/all/20241113175550.GA462442@mit.edu):
  * Clear stale BH_New flags resulting from inline->extent data conversion

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..0d3cf0ca5c2a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -606,6 +606,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	} else
 		ret = ext4_block_write_begin(handle, folio, from, to,
 					     ext4_get_block);
+	clear_buffer_new(folio_buffers(folio));
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -867,6 +868,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 		return ret;
 	}
 
+	clear_buffer_new(folio_buffers(folio));
 	folio_mark_dirty(folio);
 	folio_mark_uptodate(folio);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..aa56af4a92ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1049,7 +1049,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			}
 			continue;
 		}
-		if (buffer_new(bh))
+		if (WARN_ON_ONCE(buffer_new(bh)))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
@@ -1265,6 +1265,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 	ret = ext4_dirty_journalled_data(handle, bh);
 	clear_buffer_meta(bh);
 	clear_buffer_prio(bh);
+	clear_buffer_new(bh);
 	return ret;
 }
 
-- 
2.35.3


