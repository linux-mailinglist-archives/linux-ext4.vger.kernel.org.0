Return-Path: <linux-ext4+bounces-2893-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796290D613
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB5286993
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F015ECCA;
	Tue, 18 Jun 2024 14:43:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B715ECCD
	for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721824; cv=none; b=gcy6HkeEr0cVP5uKn5GSpurZIWcXSSdYb3t0mqkP0KSCkHc97vE82APvjEEsWeD6oUwEqk6WvpKMZOIzQYQzCLER0e1l4pcs2f+jxtZnQ/lHYGrpxRaA5CbRte9gDwk9a7tyXEYl6WlG59wKEa/SgOC1wpLsgTQJt7RZ4ScAl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721824; c=relaxed/simple;
	bh=2k/dEJy/1Pj3DpNxIGZD+y5f+G9zxZ8VI2FXHSMT044=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5sLplP8p/f0fvFbp54+cbQ150KoZlxSn+YQGlDq6CmQYaoT85f3kaMR0ZpvmK+l894Pg5eydLu6WQXEky1OlTG4FyOJ5inzHRS4kfXsXsxs9HJyWobMoHZVgwHeqEzWe25WtH65Lbs+6F+aJVTstuQCr2vV2YJ2J0aPGX2ScJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67A3E219E9;
	Tue, 18 Jun 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E7B1369F;
	Tue, 18 Jun 2024 14:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id InvbLxadcWYEfQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 18 Jun 2024 14:43:34 +0000
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ext4: don't track ranges in fast_commit if inode has inlined data
Date: Tue, 18 Jun 2024 15:43:12 +0100
Message-ID: <20240618144312.17786-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.40
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	FORGED_SENDER(0.30)[luis.henriques@linux.dev,lhenriques@suse.de];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_NEQ_ENVFROM(0.10)[luis.henriques@linux.dev,lhenriques@suse.de];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[decadent.org.uk,gmail.com,vger.kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

When fast-commit needs to track ranges, it has to handle inodes that have
inlined data in a different way because ext4_fc_write_inode_data(), in the
actual commit path, will attempt to map the required blocks for the range.
However, inodes that have inlined data will have it's data stored in
inode->i_block and, eventually, in the extended attribute space.

Unfortunately, because fast commit doesn't currently support extended
attributes, the solution is to mark this commit as ineligible.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1039883
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/fast_commit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..d3a67bc06d10 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -649,6 +649,12 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
+	if (ext4_has_inline_data(inode)) {
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
+		return;
+	}
+
 	args.start = start;
 	args.end = end;
 

