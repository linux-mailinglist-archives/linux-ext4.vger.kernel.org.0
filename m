Return-Path: <linux-ext4+bounces-13655-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HpCL5kUi2n5PQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13655-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16811A101
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742BE304994E
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156F3126C5;
	Tue, 10 Feb 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6CupUUv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RNLSGlBq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R6CupUUv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RNLSGlBq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D930C60D
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722440; cv=none; b=lumY97cnx07XJ9/krtlUpiH4OPmp9ITpcFGuZb6+1T9VbS/a1fWa0XD3YJSmcqfBhMzo+OCXYN8OSufHBtPjOftkk8BGgWhmzYBbesXTgLd6+mHPaZR4Es4aZHBojactEPKux3jIskPVYLjvD1epL3Hq6yc6ZwEToUNA63ipf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722440; c=relaxed/simple;
	bh=c782gc+6OZfd0uQudYyXxyFOT7+Bzqeb7g79s4I73Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAugAJ1RctyYjGKAeJjk3LhfgSIXOF/Zh8Kz6NuXVAbLRVfDFJzFOFJLUCY54mWnNaIW38UmlRGD+BVoFnzz6t7ZC88TPlPicJgxw7m4JLpP14nMCWRrA4ZSAYtMdkNgv9iSMowaUruVoRJYDGg2l7yCM01UQAFZcx0VT5TKfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6CupUUv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RNLSGlBq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R6CupUUv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RNLSGlBq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7646C3E717;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OsfhvcK7esczrvoFnsXRveEs6UesAd6DLxUWWAQqpw=;
	b=R6CupUUvGQOk9DqBYlF3lfw4ANOzKK4EUufZ0yXgcGfOMKdRR3CsZCF0+hZpbC2FC3T12i
	LXzocRUXVmQT1+O1r20XfkX5lH+S8r23Fr8UYy9YoDFTM/dx6+h8ZMnL1qFY5A5kLigtmr
	x3uPcXIGRkP5UfpRkjkMfP3yz4cxpcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OsfhvcK7esczrvoFnsXRveEs6UesAd6DLxUWWAQqpw=;
	b=RNLSGlBqcG11F5cvPrV4VrJWloLrQ9/MzWUfSCwo78RzshaTZjkToiyF581HTailj+BEG8
	esYVkjUTlCOPPDAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OsfhvcK7esczrvoFnsXRveEs6UesAd6DLxUWWAQqpw=;
	b=R6CupUUvGQOk9DqBYlF3lfw4ANOzKK4EUufZ0yXgcGfOMKdRR3CsZCF0+hZpbC2FC3T12i
	LXzocRUXVmQT1+O1r20XfkX5lH+S8r23Fr8UYy9YoDFTM/dx6+h8ZMnL1qFY5A5kLigtmr
	x3uPcXIGRkP5UfpRkjkMfP3yz4cxpcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OsfhvcK7esczrvoFnsXRveEs6UesAd6DLxUWWAQqpw=;
	b=RNLSGlBqcG11F5cvPrV4VrJWloLrQ9/MzWUfSCwo78RzshaTZjkToiyF581HTailj+BEG8
	esYVkjUTlCOPPDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 572153EA65;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bbTZFHoUi2kzLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 11:20:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFAB4A063A; Tue, 10 Feb 2026 12:20:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: fstests@vger.kernel.org
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] ext4/051: Fix failure in nojournal mode
Date: Tue, 10 Feb 2026 12:20:18 +0100
Message-ID: <20260210112025.28444-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210111707.17132-1-jack@suse.cz>
References: <20260210111707.17132-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13655-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B16811A101
X-Rspamd-Action: no action

The test uses fs shutdown. Without journalling the filesystem isn't
guaranteed to be consistent after shutdown so not much we can test
there.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/051 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/051 b/tests/ext4/051
index 728ad19bfcec..9fbf0404fec9 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -16,6 +16,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _require_command "$TUNE2FS_PROG" tune2fs
 
 echo "Silence is golden"
-- 
2.51.0


