Return-Path: <linux-ext4+bounces-6344-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256EA2A4EA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078E9161202
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4816213224;
	Thu,  6 Feb 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmdsKblt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7qp+LkZ9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmdsKblt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7qp+LkZ9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007F376
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835127; cv=none; b=HPcocznOIr8KQGss2Y4rSbr4a4uslqlfKRFVOIwBX0TusvhGuQ8cXbC2gcjcCeE50k8fxXHfVC6gcl266g/zs1KmPbxlV2xntenw5HSGuUZhDg8e0tMaqgCbFmvkMbwzxejSlQSWnlBj8pX+mE/m932WQoOFJNmtJXod5Bi9Ukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835127; c=relaxed/simple;
	bh=ldH4oFnFwYY6FL4L5DSyJxwJBXzk8/t/Qj51E5FMMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPgZabhKH9eMnmOBm55nbDd5CabmdF/ygYVA6F0YQxMHrRNIXus4tfZ0Pj+XdhmlNdshC2QWTptkqLm47vBQEnLnjhj4upVYcIhmD5MnBWrkWFnph/f3wifwy97vbv05COQ+hQTiCssjpTs9jVXtZrZK6DCodY1efEyQsjlb6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mmdsKblt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7qp+LkZ9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mmdsKblt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7qp+LkZ9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5F5A21108;
	Thu,  6 Feb 2025 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Sw4MqwGQnGLzjqMLoOVF2kDZSSaBYtAMToaAlCVkdw=;
	b=mmdsKblt6y5s1q5QlDb/aK+B9iUslSh+P4htdrz12RTjg5f2hpfdlD1pioHTo21XkK/i66
	SdjReZU92Ahj1iy75tP6DqX3KJ+iIaJMyuzKvXXceVFcSnQNiFsW3y/9Qn+Y3N/75Dv3uX
	a3SM3RN0ueL7ub5C2S6xoDTnRAMPn1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Sw4MqwGQnGLzjqMLoOVF2kDZSSaBYtAMToaAlCVkdw=;
	b=7qp+LkZ93giogudCcLk8Jmzj6o0qIxirsXl0pGPMYXfvnEM92me2bwYGt4RBrKdawEjheL
	4OY5WlFEhMX458CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Sw4MqwGQnGLzjqMLoOVF2kDZSSaBYtAMToaAlCVkdw=;
	b=mmdsKblt6y5s1q5QlDb/aK+B9iUslSh+P4htdrz12RTjg5f2hpfdlD1pioHTo21XkK/i66
	SdjReZU92Ahj1iy75tP6DqX3KJ+iIaJMyuzKvXXceVFcSnQNiFsW3y/9Qn+Y3N/75Dv3uX
	a3SM3RN0ueL7ub5C2S6xoDTnRAMPn1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Sw4MqwGQnGLzjqMLoOVF2kDZSSaBYtAMToaAlCVkdw=;
	b=7qp+LkZ93giogudCcLk8Jmzj6o0qIxirsXl0pGPMYXfvnEM92me2bwYGt4RBrKdawEjheL
	4OY5WlFEhMX458CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C26F13697;
	Thu,  6 Feb 2025 09:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zIguIq2EpGeaSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:45:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D2D9A0889; Thu,  6 Feb 2025 10:45:17 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH] ext4: Verify fast symlink length
Date: Thu,  6 Feb 2025 10:44:55 +0100
Message-ID: <20250206094454.20522-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=jack@suse.cz; h=from:subject; bh=ldH4oFnFwYY6FL4L5DSyJxwJBXzk8/t/Qj51E5FMMSQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnpISWLhWpQ1oxnzvAWBDPqRnQgUQGOtREGv7TQbts C+B87H2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ6SElgAKCRCcnaoHP2RA2eiVB/ 9gWbXUOvHuN+zRbgkq83P+i/tZnbGY+PCG6Rxj20sz+3GFd0RgDnyvJPS97PzYaX1KFUFLcv/w339b ciCGG9a2RfyMRKN8xT2BEVws4RarI7VGFmcGS8hgXEaJuSOfz0G95/fk7jIJg22VJz892NuhkjpkCj W0QUjwJgAB9U+03lVSZjUG+GMFniAuDVQMq6fTl4H7f/eVYkqdHJ9yFPyIAqf0Gz9h6d1YREiPReXR lDQwHrTrwBn6oMky6SU7j3ZUv0Bin+ypwSrw+wS2bJRBZRqPmt7UNdc/OkMF+9GSEj2a9CnIDJkL1k nieR8F49fBkofd2EhDfGb5HjzcSXB2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[48a99e426f29859818c0];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Verify fast symlink length stored in inode->i_size matches the string
stored in the inode to avoid surprises from corrupted filesystems.

Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..64e280fed911 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 		} else if (ext4_inode_is_fast_symlink(inode)) {
 			inode->i_op = &ext4_fast_symlink_inode_operations;
-			nd_terminate_link(ei->i_data, inode->i_size,
-				sizeof(ei->i_data) - 1);
+			if (inode->i_size == 0 ||
+			    inode->i_size >= sizeof(ei->i_data) ||
+			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
+								inode->i_size) {
+				ext4_error_inode(inode, function, line, 0,
+					"invalid fast symlink length %llu",
+					 (unsigned long long)inode->i_size);
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			inode_set_cached_link(inode, (char *)ei->i_data,
 					      inode->i_size);
 		} else {
-- 
2.43.0


