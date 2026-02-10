Return-Path: <linux-ext4+bounces-13653-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIUzOo4Ui2n5PQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13653-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:46 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789011A0F3
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A12304501A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80949318EDA;
	Tue, 10 Feb 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rmPNWUCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3Mn5SHS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rmPNWUCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3Mn5SHS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F02E764D
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722435; cv=none; b=Fv/ugVcGRgfl8nV61BzImIM45u9lnOSdfOc7P207ADEoCQGfyfc/ChY/YVjsMM9hi/z2tceXGitAyhKcvr6eQ7vAelZ0eumuSJ+T+6IIAwPjkY66xAXmUN5DJMWPE7IlXB0j4MkAK8IkaWNeQ8CjipQZHK08XEqB3fXD8L3zkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722435; c=relaxed/simple;
	bh=Sl/4PxVJbNd91Ba66ukzYJu/o094UCC3oOLXeDShRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj/CoWORfecMDnXbkYQQuRnpidIg9c+Xn49rv7uNJfvMv1P4wvvVQzJOfqmKBEbZTlJhhZcpo4UOUwUgtAwmWeKo6lXgfkKDCGxMCx8JnWwq4bY71sjLiyDsjHEJzbULYVf7pTLYRpkuGlz5T7wTrfW0AUJXPYwf6xzDKaUBouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rmPNWUCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3Mn5SHS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rmPNWUCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3Mn5SHS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 759A63E6F2;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIYEpcf36Pz4ierj/RBCMML/o9AreFS4DBdgDtqn+Hc=;
	b=rmPNWUCI7EoCEVQj7OdVb2tbL7i3M0nIkOOn+MGb8hC4WX76zGKKepd3GoeoWj284DPs2M
	bt7UnfiMcXFnC+/uW49zze/xEkoRFBtHHVS4UJOHXJfbY+U78YQ/P7aULvoE8uYU/L8cvn
	/VAW5dMlwXI7MF4SFTuudygxDS6yT1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIYEpcf36Pz4ierj/RBCMML/o9AreFS4DBdgDtqn+Hc=;
	b=d3Mn5SHSdyNnDT6Mj/NhBFTilvaFUd9ok90yRx09kJc8VwIT8YbYQ2Z9aPBLbbIan2EVtW
	7g7f8NdnKtLAjbAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIYEpcf36Pz4ierj/RBCMML/o9AreFS4DBdgDtqn+Hc=;
	b=rmPNWUCI7EoCEVQj7OdVb2tbL7i3M0nIkOOn+MGb8hC4WX76zGKKepd3GoeoWj284DPs2M
	bt7UnfiMcXFnC+/uW49zze/xEkoRFBtHHVS4UJOHXJfbY+U78YQ/P7aULvoE8uYU/L8cvn
	/VAW5dMlwXI7MF4SFTuudygxDS6yT1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIYEpcf36Pz4ierj/RBCMML/o9AreFS4DBdgDtqn+Hc=;
	b=d3Mn5SHSdyNnDT6Mj/NhBFTilvaFUd9ok90yRx09kJc8VwIT8YbYQ2Z9aPBLbbIan2EVtW
	7g7f8NdnKtLAjbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4AE3EA67;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tJ2HFnoUi2k2LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 11:20:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03225A0B3F; Tue, 10 Feb 2026 12:20:26 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: fstests@vger.kernel.org
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] generic/635: Fix failure without a journal
Date: Tue, 10 Feb 2026 12:20:19 +0100
Message-ID: <20260210112025.28444-2-jack@suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13653-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4789011A0F3
X-Rspamd-Action: no action

The test uses fs shutdown. Without journalling the filesystem isn't
guaranteed to be consistent after shutdown so not much we can test
there.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/635 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/635 b/tests/generic/635
index 4a811630a621..018b868cb6ce 100755
--- a/tests/generic/635
+++ b/tests/generic/635
@@ -26,6 +26,7 @@ _begin_fstest auto quick atime bigtime shutdown
 
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 
 _scratch_mkfs > $seqres.full
 _scratch_mount
-- 
2.51.0


