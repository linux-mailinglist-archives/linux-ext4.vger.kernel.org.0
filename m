Return-Path: <linux-ext4+bounces-6345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BEA2A501
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 10:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3AE18882D1
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB1226874;
	Thu,  6 Feb 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DpjbE4Fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyTpX8cX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DpjbE4Fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyTpX8cX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB2226546
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835235; cv=none; b=NqGAhD0JsJGN/W7WCyljCwfDbZDpJW90IAfotSg/WrIyBFqSF/RKaf5fiXCE+Zzuq61pagZO6PyMXZYNyG/W5JPCTSmMD/W5TpJI8hKt4GOorh95RQyYlwSnXOj3AILK3dXJcCjnlliaoqP6M/6Yn9ZhBOz+8eMkSbVsYQTAvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835235; c=relaxed/simple;
	bh=bE2dOoEFCvhgs8R6FC+XZrKbZugrVdiYS+C6qSgZgVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqrN7iN83zPiIUSH4zyENDLR3e/OFH3ZOg6tUMtM+t3Ganyayd7Tw+9R+DF0QPizlAG3M1GzjZx5Zny4CASZB1RZEIuidw5HFnGKf0fdLr2Jk01u3RpE/4Wb7WOXaoQ3b/Xg9gzFLB7R+9EFoI8fuo0J2vxpyXNDotXMdUxLwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DpjbE4Fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyTpX8cX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DpjbE4Fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyTpX8cX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B21721108;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JNIkXQbvCNDsaYE6OvBUMH9ssmAUauYYrM+NReBEhD4=;
	b=DpjbE4FqWR3UQySuChyFS2DF3St8CF42ErpN6Hgv64QNY+eNm8duYdC6TpJwqLdUXAX6lP
	q/RcnSU3V7lPU5W8GKUONws0yAklqnrl1N0HzAcPFisFLhW2E0bAksdtDxN/jZl0P0tEi2
	5XQf9LutUPG7AmDpg3IGGFEiHpr1dLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JNIkXQbvCNDsaYE6OvBUMH9ssmAUauYYrM+NReBEhD4=;
	b=eyTpX8cXGsWKU/9I/FieLmDbqKRW1n0AN8rIhEKaW8J3ABR5IkHUG9TS2PDIONJVIsuu/w
	IC4qWwOHdn6e0rDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JNIkXQbvCNDsaYE6OvBUMH9ssmAUauYYrM+NReBEhD4=;
	b=DpjbE4FqWR3UQySuChyFS2DF3St8CF42ErpN6Hgv64QNY+eNm8duYdC6TpJwqLdUXAX6lP
	q/RcnSU3V7lPU5W8GKUONws0yAklqnrl1N0HzAcPFisFLhW2E0bAksdtDxN/jZl0P0tEi2
	5XQf9LutUPG7AmDpg3IGGFEiHpr1dLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JNIkXQbvCNDsaYE6OvBUMH9ssmAUauYYrM+NReBEhD4=;
	b=eyTpX8cXGsWKU/9I/FieLmDbqKRW1n0AN8rIhEKaW8J3ABR5IkHUG9TS2PDIONJVIsuu/w
	IC4qWwOHdn6e0rDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD5113697;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mkhsFh+FpGcoTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 04516A0889; Thu,  6 Feb 2025 10:47:10 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] jbd2: Fix two annoyances in jbd2
Date: Thu,  6 Feb 2025 10:46:57 +0100
Message-ID: <20250205183930.12787-1-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=327; i=jack@suse.cz; h=from:subject:message-id; bh=bE2dOoEFCvhgs8R6FC+XZrKbZugrVdiYS+C6qSgZgVA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnpIUQIhOvH6b1kmDPpRrpMdlKpdMurJXepJLiGjT0 1P/ztfyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ6SFEAAKCRCcnaoHP2RA2cjAB/ 9qGQ5nbluXUnjQJ8KJFRye8YPKOfw13Yzl+aescZ1z6OGlUx1nKGC5+OsWn6JF4a/+S37uKUnH9GV2 fuaVGyQSiq7nmtXGxG5WViJlVnLnmLDz7k8Iu+27WOiGoOGLDo9y3k3ID37UksWBKklkQDqq2b80NS SXIfsXEMYEaYQhxaFc2Ls3/gSdZ6kSmrRk5T6rLlSvgvgqrS4jaLC1DGPhZWbHdvpGUFT4tWVOpz4+ 9aG2Juu+BRGQIq3yBph3sZjqjz29xr6PRM88nxFuLHbMFHF5C8mJ0Um2zLpmydnLhIonFEnHnEYLO6 eSSA5GUPoTNPLdQZbp8Uue2AS0GOvv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.55
X-Spamd-Result: default: False [-2.55 / 50.00];
	BAYES_HAM(-2.75)[98.91%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

filesystem fuzzing of ocfs2 has revealed some issues in jbd2 where suitably
corrupted fs can trigger issues in jbd2 - most notably a complaint about
sb->s_sequence being 0 (which is actually correct after recent changes) and
also attempt to replay the journal after it has been wiped. Fix them.

									Honza

