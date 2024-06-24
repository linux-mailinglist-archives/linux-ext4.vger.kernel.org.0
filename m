Return-Path: <linux-ext4+bounces-2939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98B9154EE
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA18B1C21164
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0319E837;
	Mon, 24 Jun 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Joz6ekNa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DFQTi1/1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Joz6ekNa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DFQTi1/1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC413D539
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248491; cv=none; b=Sjl5ArivuKQqWQB0CCjnyU1BPeiN8AN+DvqyhZASprL0Jp2bv6xm304a3l5uN8zFZS4x4t6Mc0w6dMfVDSQHYT+mh4MxrbpXdARj3m9EmKDIGRIEtGyYbxfhqwbN3Lf0LK3I48Sr70iA+qxoFp3IFsh2UwIWJRMYU5nCUsmroh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248491; c=relaxed/simple;
	bh=P6evGZXLuehID/EfUdWutniFVl3nsabt5OFqBApHpWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQ2TlLcfC9pvaCKCS1u8fNuUtpID3ipMZ8P246vhdVQvphTxfjXYaRYu+CqKEhFI7dgolIn3IVZPnKjvtr768QSdytgENOxXF8zxFJYBe1qnUwSG8d34Uh2LNkGmBnzSp6KWnJfMjAJvCMQBz/Mx/svsx/p3IduKn5xv/fzi6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Joz6ekNa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DFQTi1/1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Joz6ekNa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DFQTi1/1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE9F1F83A;
	Mon, 24 Jun 2024 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIdnV3IOS/q0gAV3tggu7MFBuM7TYy3fjRe5J7zUf0E=;
	b=Joz6ekNaHoUZfDTHXrHdA55PxB5WQvYagRGXktGM8xe4K/iuwiHnQ4At7RgRea8BfJrh07
	ZMqM5zJ2x3dYUn/9P7kepmzgTxQnydsrJWox5tO/wMOWfkzus0cAnEfhimhvNoUXrQMtkd
	IypdSjnxbM0Gv26Ry/2dUDwHX7dNO7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIdnV3IOS/q0gAV3tggu7MFBuM7TYy3fjRe5J7zUf0E=;
	b=DFQTi1/1eB9KCzBk0wRsrrwFPS1RDaylz6MAC1SYB0VmREl8PNqB+bf3W8TZFLtzIkhRuh
	DPC06EEsVEEQLZAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIdnV3IOS/q0gAV3tggu7MFBuM7TYy3fjRe5J7zUf0E=;
	b=Joz6ekNaHoUZfDTHXrHdA55PxB5WQvYagRGXktGM8xe4K/iuwiHnQ4At7RgRea8BfJrh07
	ZMqM5zJ2x3dYUn/9P7kepmzgTxQnydsrJWox5tO/wMOWfkzus0cAnEfhimhvNoUXrQMtkd
	IypdSjnxbM0Gv26Ry/2dUDwHX7dNO7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIdnV3IOS/q0gAV3tggu7MFBuM7TYy3fjRe5J7zUf0E=;
	b=DFQTi1/1eB9KCzBk0wRsrrwFPS1RDaylz6MAC1SYB0VmREl8PNqB+bf3W8TZFLtzIkhRuh
	DPC06EEsVEEQLZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFCCA13AD7;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5vGKOmemeWbROAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97349A091E; Mon, 24 Jun 2024 19:01:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 4/4] jbd2: Drop pointless shrinker batch initialization
Date: Mon, 24 Jun 2024 19:01:20 +0200
Message-Id: <20240624170127.3253-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624165406.12784-1-jack@suse.cz>
References: <20240624165406.12784-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=jack@suse.cz; h=from:subject; bh=P6evGZXLuehID/EfUdWutniFVl3nsabt5OFqBApHpWo=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNIql8UHFV0yW6PCFv9udeDuqmKVhR/v3OtXjJdfxvgoQsdy 3ezkTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMZM8X9v9hl65onNKcWVC69jaHrE q8QzKb9v0b3X6Bs977r+SbcujvbA3m6IPOf26JRSXkVgXtqpS+prD7iIDO3Jiij5bLn+y2M3Xr6Dlh qPOB7XyjgYPMnMkH2uVDTl3iLm/8nG0gpqnA1GEjxV947nqr4SL/ax8tVJPconoZq/ZOSHnnkG4iwX h04yKOG50feK7qcztcuSWvXL3/Du8K4ZYN724b1D+8F1Imnh7RsJgvKMr5Ubht4JbY8w6tcZuXxaxO y2aIvMWrNMteJ3tib6kdV/TM/nNvCi62dotyz89XKVv+1yxL4dVDo2ePXiVn2FdGPZWoZnioVMKpfz Zuebgxf9Virfil4Vekvj6Pr1QAAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

In jbd2_journal_init_common() we set batch size of a shrinker shrinking
checkpointed buffers to journal->j_max_transaction_buffers. But that is
guaranteed to be 0 at that point so we effectively stay with the default
shrinker batch size of 128. It has been like this since introduction of
jbd2 shrinkers so just drop the pointless initialization.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ae5b544ed0cc..c356cc027ed7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1641,7 +1641,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
 	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
 	journal->j_shrinker->private_data = journal;
 
 	shrinker_register(journal->j_shrinker);
-- 
2.35.3


