Return-Path: <linux-ext4+bounces-12646-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8751D04C18
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7141035DE712
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B882459DD;
	Thu,  8 Jan 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCF13Hou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qRXs7w3a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCF13Hou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qRXs7w3a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2B22F74D
	for <linux-ext4@vger.kernel.org>; Thu,  8 Jan 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888569; cv=none; b=DxsAwg9FA4/HNqtZqa1fSj2PmcP27uL7BZrGH4XXy/kOmIPkm0Y9KZ1hWDfOX/Jls13vFeWKFeurFTyPGApJGT4Gj6dDIVGbTgGQ3B3Z1622yVbNZW0dqXAdqKE/R8T+Om160H0XA72RgkF3fPVWo4F44iJqus3reqqG0tExTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888569; c=relaxed/simple;
	bh=wV+ZaLrTVBnFLw5pOQk7v18EV2A1SHoW4uTEf6zfdjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJJWjeXeYRhA/Zv9nVI9zOcTuth93DbtP9Hq0tWITIFgrnWO/DxbvUq2qGOk6vuItj9znUSEXQvaoNWSggeUFFFH9hSUbVxCDPujsIiGJz5CMDFE4kDYZ+ev/pScYHv83jJXtBaBpdxJ0EghY+EK/uQiEGA/y/tvShZ+tJZX7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCF13Hou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qRXs7w3a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCF13Hou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qRXs7w3a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72649345AC;
	Thu,  8 Jan 2026 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767888566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CD3HGqhYgBgy2AhamyTL7IlhMwH0DUmLhs+7+UVmnRo=;
	b=wCF13HoutIZRim0FciNJL/yc8bY7cDeay1z8GwZWhTXxnNZlRRfpNvDjsV3TzPzdKp4I4F
	wMtLzHEjDkBBPWAWrjzyiTLvw339pzOtdUl/UDB78sVuqc6Bm28iD5d1mW6CcdpOxH8aAs
	OR+9Je8GFenV13jNMRg+A71krc2Js0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767888566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CD3HGqhYgBgy2AhamyTL7IlhMwH0DUmLhs+7+UVmnRo=;
	b=qRXs7w3aAOz1RrXByJAmFm0pL3k3niCBxGcR7gvIBa0HIz3LtSnGKuG//WF4NKs6QTMamn
	3io8zwK1XrjyZHDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wCF13Hou;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qRXs7w3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767888566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CD3HGqhYgBgy2AhamyTL7IlhMwH0DUmLhs+7+UVmnRo=;
	b=wCF13HoutIZRim0FciNJL/yc8bY7cDeay1z8GwZWhTXxnNZlRRfpNvDjsV3TzPzdKp4I4F
	wMtLzHEjDkBBPWAWrjzyiTLvw339pzOtdUl/UDB78sVuqc6Bm28iD5d1mW6CcdpOxH8aAs
	OR+9Je8GFenV13jNMRg+A71krc2Js0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767888566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CD3HGqhYgBgy2AhamyTL7IlhMwH0DUmLhs+7+UVmnRo=;
	b=qRXs7w3aAOz1RrXByJAmFm0pL3k3niCBxGcR7gvIBa0HIz3LtSnGKuG//WF4NKs6QTMamn
	3io8zwK1XrjyZHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 659D43EA63;
	Thu,  8 Jan 2026 16:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xPrHGLbWX2nyKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 16:09:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CC16A0CB1; Thu,  8 Jan 2026 17:09:26 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Use optimized mballoc scanning regardless of inode format
Date: Thu,  8 Jan 2026 17:09:08 +0100
Message-ID: <20260108160907.24892-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=jack@suse.cz; h=from:subject; bh=wV+ZaLrTVBnFLw5pOQk7v18EV2A1SHoW4uTEf6zfdjI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpX9aj3/vOllegvHYaMfYG8NbE1sPk7y6jkKDLQ GEySZAL9muJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaV/WowAKCRCcnaoHP2RA 2esDB/4l+IB02+7yPxRqch2RzQzNUAy1huQ24DQmBG1aRWTMzAF98mxNlrf8AMHZpM3hp6aoHTw stEwGY6Bu1J3EAhmHqsHC0ifCG7Mod9MR7NNY4uHKoLpT+uz/ZBPRmDNtqHSch00kppHdCCH7EJ BItLBduDDdivI248Es8/aI+cLWmNBtLtkR0KnvrBgHv2Bcu1sxzh+HuJVlUWtGi9cAi36/zgXNK GZaP2Mu2nI7uJjseNHtHrFaHVYeEGFRrIkaFsnPCS3w/5gQwMijxeckrw2iMMRo0QD9XRex4a1s TLXVYqb3C/lp/a1Wrp1j2Za3IQtJ5S2kup84ssq2cDTX+/Y+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 72649345AC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Currently we don't used mballoc optimized scanning (using max free
extent order and avg free extent order group lists) for inodes with
indirect block based format. This is confusing for users and I don't see
a good reason for that. Even with indirect block based inode format we
can spend big amount of time searching for free blocks for large
filesystems with fragmented free space. To add to the confusion before
commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
option work with extents") optimized scanning was applied *only* to
indirect block based inodes so that commit appears as a performance
regression to some users. Just use optimized scanning whenever it is
enabled by mount options.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..4ee7ab4ce86e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1133,8 +1133,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 		return 0;
 	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
-	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
-		return 0;
 	return 1;
 }
 
-- 
2.51.0


