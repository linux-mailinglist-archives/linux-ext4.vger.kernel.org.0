Return-Path: <linux-ext4+bounces-946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E973A83E80F
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 01:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE071C20D7A
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F36FD2;
	Sat, 27 Jan 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YcY1xGHp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+3MLAQIu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DL29lvjE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lUykj0Lo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923579CD;
	Sat, 27 Jan 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314260; cv=none; b=iuWzLyyigywz25Vkyr/8JCuDlLgCFnd9ut20MS7gpng0C9lB+Kjf8AuxIW3gAoxGwMXztd9ZcERyztfJfk+NW7VfyUFr7DRi5F4nNo+RdUebUEI0aDbUM3d/KkZi/74riuyvJpLYqkrfdMTNuk7jVOSV1OOTgpZLhfq1EuCJYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314260; c=relaxed/simple;
	bh=xdvOyZCyetrCoFBK/1YJbxbSYOwB1nE+htEZH6Bvsf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv9olDYwfZSga8yQ6YlB6/gMpHrXBMpH7n+HRlXpliA1XsEfQPhswkVs6YPigau00XF1Wh65BrhLM6SVXG3rCSvXupbCOVIFJoahE5sCkXsckbRBOyuqdIKqn8CpbAi8Imi04zU4sVWBgocTZQrjuAtBjqYUCBY1LmxS+I7YI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YcY1xGHp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+3MLAQIu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DL29lvjE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lUykj0Lo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F20E4223A2;
	Sat, 27 Jan 2024 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlx4z3N508ykO+IPN4KGQgLY91vQLkOc0l8vpLCa86g=;
	b=YcY1xGHpTl9Vy8q3omzUUcUEfClzGE70Ta6rn+086a221j5iI5SWBVzrEoDqXYZ8Dud6a5
	ZxPK6uHn0jlZMIZ/i0VqSbJzno/GjXX5UMrKia1TWIqH1XcuuccegBqrNHcJCOIMK6haBb
	hqdzP4odjb+/UHyxOLxVmcspEmYZCZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlx4z3N508ykO+IPN4KGQgLY91vQLkOc0l8vpLCa86g=;
	b=+3MLAQIubavuuRim7BkW3oHAk217xznLyNLzcaIy8k+6pVLjBrkXHCqHNk+an6H6ewHKK9
	3XDmguXcjZ3siKDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlx4z3N508ykO+IPN4KGQgLY91vQLkOc0l8vpLCa86g=;
	b=DL29lvjES8MKtzC9/H5Hh210LiZwpdC1QzYI1J5hnPnz2hQPukfS6PT9koBHlz9+1V4Us4
	x2tUASE4Kpby/3Byr5BFzaFU752g5U4FJZZYBlQCAAOjleus3FHitgl7wB3TiyNnAOT3F0
	4LJuvuZYerbPv4o+GSNz5DIuo/k9jyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlx4z3N508ykO+IPN4KGQgLY91vQLkOc0l8vpLCa86g=;
	b=lUykj0Lo8ao0pKTz/joEtkFX/o7HStFWM56EhE6CZw9hi9pxFDK2yNMxfAtiwuv/dbhjtP
	IcUs4BZHLf7Rs6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C99D13998;
	Sat, 27 Jan 2024 00:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NFGBBBKtGWIEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:56 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v4 10/12] f2fs: Configure dentry operations at dentry-creation time
Date: Fri, 26 Jan 2024 21:10:10 -0300
Message-ID: <20240127001013.2845-11-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127001013.2845-1-krisman@suse.de>
References: <20240127001013.2845-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLzk7q5dcbbphp39zi8hi5jhbt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

This was already the case for case-insensitive before commit
bb9cd9106b22 ("fscrypt: Have filesystems handle their d_ops"), but it
was changed to set at lookup-time to facilitate the integration with
fscrypt.  But it's a problem because dentries that don't get created
through ->lookup() won't have any visibility of the operations.

Since fscrypt now also supports configuring dentry operations at
creation-time, do it for any encrypted and/or casefold volume,
simplifying the implementation across these features.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/f2fs/namei.c | 1 -
 fs/f2fs/super.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..b40c6c393bd6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -532,7 +532,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
-	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..abfdb6e25b1c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4663,6 +4663,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_node_inode;
 	}
 
+	generic_set_sb_d_ops(sb);
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
 		err = -ENOMEM;
-- 
2.43.0


