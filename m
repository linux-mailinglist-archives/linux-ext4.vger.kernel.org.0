Return-Path: <linux-ext4+bounces-12843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A561FD20D97
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 19:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA55F30AB487
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43B3358CF;
	Wed, 14 Jan 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZeeyVnwq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deHj3wrA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZeeyVnwq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deHj3wrA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0AE335064
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415331; cv=none; b=ROpcoRwEmCBavbS/BePu6zOoC4ofs/lCd0UTdyfKDf2hxLPMO8fJ/VODrUWVzvh1Se1BSw1IqYFfJ3JDmqe9MDspO3ewULpzYG6PnhMCb+VcNgPihxLDfeNh3bCgMsWKvofGeBtuX/c3iRJ8ifE1T20gfy4QBLIUJ359fPPI2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415331; c=relaxed/simple;
	bh=kWLBBMhyxpmqlFixj2koNXjjGzX/guJT63TOfxsxWlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udj1SKxessyGADMOee+pJ3+wZH6AM9g20smOxxeAV48gmoCPbLWwgggcJRkNbONYtuJpIRl6Sz78kwahC8pwiyTbmvTitSfqQUB9WtSxjMjPbFIo1oPkJ5RMtsZJYRWSEVFDrTjPaHjXN9xGpxHo84wHvVP7hXBf5py8wtNYbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZeeyVnwq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deHj3wrA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZeeyVnwq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deHj3wrA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 146BF34AA0;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+pDzqAmCr641w4vtCaVe4Woe8oFc6VOdHrlAwxPeNo=;
	b=ZeeyVnwqJQueP6JAtfp/QOJz/jJzD5W0nPCDx1DAvAMZvrztV0uQUhXJ1Av0DGgTcleUGD
	Txq4XJe6AnM3DW1yiqNAPKdF+We9D1jWQIlImzf43VAAvq+FrB8kYeH2BrQZeQN8DCuZQP
	Jqt+JUzBFb8BgLUp41ETCDVVOSxduHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+pDzqAmCr641w4vtCaVe4Woe8oFc6VOdHrlAwxPeNo=;
	b=deHj3wrAlOa2CAe/LcTwM7QYjQD/K012Xl6snbPyYwOMUzlIO3wxtLJ1seDovZ9Hjw39iB
	Ukc59EV/CLQ191AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZeeyVnwq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=deHj3wrA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+pDzqAmCr641w4vtCaVe4Woe8oFc6VOdHrlAwxPeNo=;
	b=ZeeyVnwqJQueP6JAtfp/QOJz/jJzD5W0nPCDx1DAvAMZvrztV0uQUhXJ1Av0DGgTcleUGD
	Txq4XJe6AnM3DW1yiqNAPKdF+We9D1jWQIlImzf43VAAvq+FrB8kYeH2BrQZeQN8DCuZQP
	Jqt+JUzBFb8BgLUp41ETCDVVOSxduHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+pDzqAmCr641w4vtCaVe4Woe8oFc6VOdHrlAwxPeNo=;
	b=deHj3wrAlOa2CAe/LcTwM7QYjQD/K012Xl6snbPyYwOMUzlIO3wxtLJ1seDovZ9Hjw39iB
	Ukc59EV/CLQ191AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B77C3EA63;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v6TfAmDgZ2k5QAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 18:28:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD538A0BFB; Wed, 14 Jan 2026 19:28:43 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v3] ext4: use mb_optimize_scan regardless of inode format
Date: Wed, 14 Jan 2026 19:28:17 +0100
Message-ID: <20260114182333.7287-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=608; i=jack@suse.cz; h=from:subject:message-id; bh=kWLBBMhyxpmqlFixj2koNXjjGzX/guJT63TOfxsxWlM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpZ+BAlK39vuliDJd1WBO9R7tH6h+hhBtTciLOd RS7j8e2KmWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaWfgQAAKCRCcnaoHP2RA 2TAKCADxLvurypgU0UIFGUpfhjWNFHBOIf47ChCphtBvjlSO+xUWJtogBnRP6P1U0YkdmxNSeFu 2TpoDtBWNzQpdKuO+mucyWNWBhzdTfR1sf0V/PXJES6d+xCJcBFJhcUB2qlFN2xBf9VCuFHqtnH okB3oOHblvauPYeBNLE8ML32dZPjf30tvjHeb/M+7OJRnbwlmeKdaxa0UMrMEghZRmbKSiQ5Grh aFKNYo1gx7BvG4cgeGmynmxhCfsaUtmioqoxV17dWbp61KuDKyHGZAY6FuYHrReODx50tX6wCmW PMix2SEwY8YGf5kdZJrefqVL/P8r5U/S0DS+NuSskNz1CJir
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 146BF34AA0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Hello,

this patch series enables use of mballoc optimizations regardless of the inode
format. See patch 2 for details.

Changes since v2:
* Added barrier into ext4_get_allocation_groups_count() as suggested by Pedro
  Falcato
* Collected reviewed-by tags

Changes since v1:
* Added patch to make sure mballoc doesn't select group with block numbers
  greater than 2^32 for indirect block based inodes


								Honza

Previous versions:
Link: https://lore.kernel.org/all/20260108160907.24892-2-jack@suse.cz # v1
Link: https://lore.kernel.org/all/20260109105007.27673-1-jack@suse.cz # v2

