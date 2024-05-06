Return-Path: <linux-ext4+bounces-2330-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1578BD3F4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6393C285839
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70715749B;
	Mon,  6 May 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pwMW4NQF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wX+rs6/e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IAqWmqlg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8x8TTgk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C099157491
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017297; cv=none; b=iXwg6/KX5t9nTdlDqLvm4JZdSnSpRHFlHB7SelFzoyZmxwJqLqmKOYurkK4f/qS+/o6S1f7dUW5HhdB2H2PmYy+Jry1drwDQ4ACrSPgcr4cHFUg6mqUlTVIxftbo1IeAR5XxT4V3XYzwc/dwpGI47hx3gwMNBf2T6CNJQYXcB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017297; c=relaxed/simple;
	bh=y52j4R/GPEYz24dcxb3XVqxcXnNqKiE67FCrk9waW00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVfGLFqktTqmmur4eJ28f1Vd8raypBCBiob80Qt/mvrq9PMhS2qc0nTIsdzEaPZOri58ycdNY3cW+Z/eFmn0V+1Za2LjnyEdBnPinN37XORdV2MrBwkKK8EHTzQGVM+QKzL1AStWib0FxwUe8cyFc78wMS5fBtgdqA8Dbej0mKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pwMW4NQF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wX+rs6/e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IAqWmqlg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8x8TTgk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E049921978;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX1QA25IrEoy+iBSyvWKwERrxJ2RuiCVgQz8xSqeWLI=;
	b=pwMW4NQFfyuFM+B/X4TbIDp3/te3pE6IsxMKLQXfTK22dyRIw/h/hNnYuxudCMYiYKZe7Z
	sAxVkCxzrN+IPNbuUeH/410xbE5wVc+SOFLyy2RBRMWJMZum+YLX+FQ059lU9f9SBibw5M
	1d8IvEK9mCMTLJYPlwZyhJ3baCBPiJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX1QA25IrEoy+iBSyvWKwERrxJ2RuiCVgQz8xSqeWLI=;
	b=wX+rs6/eXlnwRh0fKyIZZaUW0J/OcIsnqETa/m6XERYyAYcc/qdADT/Qwxv/PeQdhg2w7Y
	Opcd9MWlBRFD2GBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IAqWmqlg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k8x8TTgk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX1QA25IrEoy+iBSyvWKwERrxJ2RuiCVgQz8xSqeWLI=;
	b=IAqWmqlgNpSe3/C/lUJVqi65P8PfmpauSt0Vy4sm7TrNJwr2ng0+p8efJJl+q7eUCrZBTn
	pkoIaMhvy7GPqprJCj9X+pb/YrPDnb3D4J7o0bIFd01CTdjaPaNaxt+aad06YhzvGlOd7n
	nUJMlIMOd/pOaxHgMPb7Qvp0DRhG2LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX1QA25IrEoy+iBSyvWKwERrxJ2RuiCVgQz8xSqeWLI=;
	b=k8x8TTgkZqD3RduGRptW/f83wKxfZwUnl6QWh7GvCHkcpgFas8F7U4t6mMGY03/2QXjFZ2
	g6CSemWfMLCd7rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C821A13A31;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4xSHMEwWOWbwMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 17:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18C2DA4DF9; Mon,  6 May 2024 19:41:32 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] e2fsck: fix golden output of several tests
Date: Mon,  6 May 2024 19:41:19 +0200
Message-Id: <20240506174132.12883-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240506173704.24995-1-jack@suse.cz>
References: <20240506173704.24995-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jack@suse.cz; h=from:subject; bh=y52j4R/GPEYz24dcxb3XVqxcXnNqKiE67FCrk9waW00=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmORY+Fk0rSSwm6j2tqmq7Ll/KMSHmgbZwsORdLFjj M+ofKEeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZjkWPgAKCRCcnaoHP2RA2fRqCA C0KDAh5+W0nT46hIiRcI12tR8C9VJYUnjhMZ/70FztTV/58qGlSSj6KgqlIF3dkqTDxUAZXqmkUdJY kHvIc14XG4Cv8VP8fbLpeo9D8m0WkttQMWJqkxtAVdpRb1IEYgMdLciZ8x2GcY/NyxEkMODxe54XZE SxxYfmslbXho0wFOJR9CEI7uTLjze3V/5ODnr5cGjh2sYhbaneD7MgA0bvw1QocCKWNr1UD3wbtX02 /A5YDMZXq9q4DqR3NPeOWvU3VPdv+M3Y22Sbmx7CRTe4wo6SX9ScuR0bNEF8p/CixITg7vrUNhD3om 65VZC1WHhQFLFu4EhPPCoHSwcQQTox
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E049921978
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Some old tests of EA inodes were not in fact completely fixing the
filesystem (like they were leaving directories with EA_INODE_FL set or
EA inodes referenced from directory hierarchy). New e2fsck checks fix
these so golden output changes. Update it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/f_bad_disconnected_inode/expect.1 | 8 ++++++++
 tests/f_bad_fname/expect.1              | 2 ++
 tests/f_ea_inode_self_ref/expect.1      | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/tests/f_bad_disconnected_inode/expect.1 b/tests/f_bad_disconnected_inode/expect.1
index d1479cef2880..39c6958cfa8d 100644
--- a/tests/f_bad_disconnected_inode/expect.1
+++ b/tests/f_bad_disconnected_inode/expect.1
@@ -1,11 +1,17 @@
 Pass 1: Checking inodes, blocks, and sizes
+Inode 1 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
 Inode 1 has EXTENTS_FL flag set on filesystem without extents support.
 Clear? yes
 
 Inode 9 has the casefold flag set but is not a directory.  Clear flag? yes
 
+Inode 10 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
 Inode 14 has the casefold flag set but is not a directory.  Clear flag? yes
 
+Inode 14 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
 Inode 14 has INLINE_DATA_FL flag on filesystem without inline data support.
 Clear? yes
 
@@ -14,6 +20,8 @@ Clear? yes
 
 Inode 16 has the casefold flag set but is not a directory.  Clear flag? yes
 
+Inode 16 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
 Inode 16 has INLINE_DATA_FL flag on filesystem without inline data support.
 Clear? yes
 
diff --git a/tests/f_bad_fname/expect.1 b/tests/f_bad_fname/expect.1
index 66f87df2b810..60f64f67d462 100644
--- a/tests/f_bad_fname/expect.1
+++ b/tests/f_bad_fname/expect.1
@@ -1,4 +1,6 @@
 Pass 1: Checking inodes, blocks, and sizes
+Inode 12 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
 Pass 2: Checking directory structure
 Entry 'AM-^?' in /ci_dir (12) has illegal UTF-8 characters in its name.
 Fix? yes
diff --git a/tests/f_ea_inode_self_ref/expect.1 b/tests/f_ea_inode_self_ref/expect.1
index f94c04d966e5..35bea1417405 100644
--- a/tests/f_ea_inode_self_ref/expect.1
+++ b/tests/f_ea_inode_self_ref/expect.1
@@ -7,6 +7,8 @@ Clear? yes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
+Regular filesystem inode 16 has EA_INODE flag set. Clear? yes
+
 Pass 5: Checking group summary information
 Block bitmap differences:  -20
 Fix? yes
-- 
2.35.3


