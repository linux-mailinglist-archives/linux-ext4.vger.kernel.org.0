Return-Path: <linux-ext4+bounces-1221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56631852DA7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8911F21703
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC848225D2;
	Tue, 13 Feb 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5ggBIkF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Brr2b7dj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5ggBIkF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Brr2b7dj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71871249F3
	for <linux-ext4@vger.kernel.org>; Tue, 13 Feb 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819374; cv=none; b=m7ZfJEm8xS/I5lRC0NyZOWDz/utMR7DEzrJ7oJ3Totbz+9636WF/TD/Tq9jYu9EZw1lytgS13on4OKOXOsH6yr9WBQIoKYAiR7P0cz6Qw+kDO0lm8FEq7w+SeKYiOpYbIq3Buni3yfSQKyXCGwCrLT8xK+w3vAfyJ9fgiZLopdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819374; c=relaxed/simple;
	bh=H5skab7GQRrpfw52hOvc7Xn/wPYxa66PWFHV6YS5lnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KjgPefY12a/pp+Yd0oBHZphmzN8QSbUZt5kep1bclGkFzIISR4yXQ8zeE7EbHLk9vspn8s3lPQ7vCmuzOfXiaou+B940OU/FxavCYUAVFSTrJkgeAheWhI+hqDYDfjtraiAoCRopKrBXHIFjuOCjfeav13flteNowrdK3LuiKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5ggBIkF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Brr2b7dj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5ggBIkF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Brr2b7dj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8484021AF9;
	Tue, 13 Feb 2024 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oEgrEd2qKlyEuUxaoLleV3eAi1dDAAVhh7sPEQQWhow=;
	b=J5ggBIkF3+7dSPzUr65ZSTuCUsTK2IKfbz22yh/z/Tnw7eD5fJ3faCjcEmgS06ZYp+UO3s
	ZBO47O7sZunaTlFa+8AJOn3SLMDeZAh2fMjjYyUBrbqLHJ9fOlmOLSgDBj6siEGSW3wpxo
	E9gzO5Roqq5wKWsjfc17a14Yo6liTQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oEgrEd2qKlyEuUxaoLleV3eAi1dDAAVhh7sPEQQWhow=;
	b=Brr2b7djkFMGdgCinVePyzkzndERR3S8/EgmdW0HyM55X3m+s1FaNztsTEPz+yEqV7htqd
	M10yDYgbsW8rRUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oEgrEd2qKlyEuUxaoLleV3eAi1dDAAVhh7sPEQQWhow=;
	b=J5ggBIkF3+7dSPzUr65ZSTuCUsTK2IKfbz22yh/z/Tnw7eD5fJ3faCjcEmgS06ZYp+UO3s
	ZBO47O7sZunaTlFa+8AJOn3SLMDeZAh2fMjjYyUBrbqLHJ9fOlmOLSgDBj6siEGSW3wpxo
	E9gzO5Roqq5wKWsjfc17a14Yo6liTQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oEgrEd2qKlyEuUxaoLleV3eAi1dDAAVhh7sPEQQWhow=;
	b=Brr2b7djkFMGdgCinVePyzkzndERR3S8/EgmdW0HyM55X3m+s1FaNztsTEPz+yEqV7htqd
	M10yDYgbsW8rRUCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C631329E;
	Tue, 13 Feb 2024 10:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SD64HWpBy2UaLwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 10:16:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14361A0809; Tue, 13 Feb 2024 11:16:06 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
Date: Tue, 13 Feb 2024 11:16:01 +0100
Message-Id: <20240213101601.17463-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=jack@suse.cz; h=from:subject; bh=H5skab7GQRrpfw52hOvc7Xn/wPYxa66PWFHV6YS5lnM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBly0FhBwwj3DMYe6CCf9CP/WA60ifc3CQ2g97NoEYx u276qoOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZctBYQAKCRCcnaoHP2RA2c3CCA CDHICRinfh/gHpm98pZQIzr/RV/GODEbht+qhn9cf1N+T0J5riXHtK/ijr0X5r2K61XrvKbZTB5lEv fDzC5KdqzzyMt9/jAT71ZStoKTZk41SpGBo/EmTUmXDLqAa3QlsPg0/r/HhWMbwnzlVsaz/aAxH0Bn wRP1kFCCgECt1Z97RMaydl1ZN8DYrXopfbrMfDmWIAZx/9AIBq/KdrR+014ttXev1l0netau5/g/El FJMTbmCIEybO2j4ATnC8m6ife2CdoVUhcinRmwKLIoOjkNbx6gk1Fx/HWtvMgJbHc2zCLHYUikKkyp fAjh/E+weseqVtlNQcfhMReiy8OPmO
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.06%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

When ext4 is mounted without journal, with discard mount option, and on
a device not supporting trim, we print error for each and every freed
extent. This is not only useless but actively harmful. Instead ignore
the EOPNOTSUPP error. Trim is only advisory anyway and when the
filesystem has journal we silently ignore trim error as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f7cf9d89c4..aed620cf4d40 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6488,7 +6488,13 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		if (test_opt(sb, DISCARD)) {
 			err = ext4_issue_discard(sb, block_group, bit,
 						 count_clusters, NULL);
-			if (err && err != -EOPNOTSUPP)
+			/*
+			 * Ignore EOPNOTSUPP error. This is consistent with
+			 * what happens when using journal.
+			 */
+			if (err == -EOPNOTSUPP)
+				err = 0;
+			if (err)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
-- 
2.35.3


