Return-Path: <linux-ext4+bounces-7548-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95160AA183D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E982B1768CC
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB125393E;
	Tue, 29 Apr 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="djLTUPYo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4fqZReFL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c3CEtON6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uacpdQiS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCB253952
	for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949363; cv=none; b=qHiZcVQa42uHUwaUJUHEzh4oBR6LZZ+p6jbJN6ZYB4l1t+Kl8OtHIc+YRNnyXtRaMKtBMSmILLvGL2gcjb7GeR99R5u+pp53DR/aZ1u8kZvIt1Ln26Ja1cB1DKpgv66y7M8PvZ/xzsf5CQ5yiispgllRkeOVSgkek4zmh8ec5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949363; c=relaxed/simple;
	bh=jA2qO5eqIGz9arPGyR85It5UHj0EE/YavoTPQoru4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMuCiG2c1xM09FTYotH5z0p4yeUCT8bErb3tfT8c2MPL6W5hXsX7vDAwWXQKbtC7I+lkAsFUXfD7NuZtVP1GveSP23ek3Oyk7iemW9+/GXMhBMgcEoZB0aBHvBp95qyl0aIqTm/YUiGuHnKLcohRIK6aa23bhJC6rpejIGOMoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=djLTUPYo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4fqZReFL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c3CEtON6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uacpdQiS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E28F9211F6;
	Tue, 29 Apr 2025 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745949360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ioVwCftCUHocnsxsnpEGHbLKEi5Hz52PwDhzREhNeY=;
	b=djLTUPYouDIRvkICq3vjDiRZb831X39EB8eNRgKuiQ4MAMpHxj5g4WGNQRsZugGaLOW2Fq
	tbqToPJBqrwqTwkAETM36QrXXBhluXKU8pYssXsHQSVdoE8lo83VW47FwNNfJn1GGgeXO0
	B4Qz0hXnSz5jODOY1k9aKZMWzm76GtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745949360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ioVwCftCUHocnsxsnpEGHbLKEi5Hz52PwDhzREhNeY=;
	b=4fqZReFLiKckjAApYwIENBi3jEndA9FFpsA8U0xwFN+S+okWW8mlsYY6udj4Rt8xY1OKG6
	xi1RowFZ8mUJLTBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745949359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ioVwCftCUHocnsxsnpEGHbLKEi5Hz52PwDhzREhNeY=;
	b=c3CEtON6m0xFAHmEsBtch51XQx8Aj27PKGifMI6lfO/7JBowPp/+JkHS0Ve3Bm1rkgCxqe
	YDXkKggDuEgcQ94Rq0Ao0SVRGzO/9PZSs7VmeB1C6UeZKvo4Ea05xIis/wxqVdcZeiBXck
	xKA1we85SGH10OwJJOLn0Tx5jCtt5UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745949359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1ioVwCftCUHocnsxsnpEGHbLKEi5Hz52PwDhzREhNeY=;
	b=uacpdQiS9qE4jnHNRclLIiwbPQiVYPcGbAmJ1Da1fv9cYFrq/TVQXLW2gKujuOlMDbn7Vo
	iBNp12v/K3g1m5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0CBA1340C;
	Tue, 29 Apr 2025 17:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2lknK68SEWj+NwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 17:55:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA325A0952; Tue, 29 Apr 2025 19:55:54 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev
Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification
Date: Tue, 29 Apr 2025 19:55:36 +0200
Message-ID: <20250429175535.23125-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113; i=jack@suse.cz; h=from:subject; bh=jA2qO5eqIGz9arPGyR85It5UHj0EE/YavoTPQoru4p0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoERKXViCTZih9oOA86qBmFulf4+cbpLIJu6I2fIQS HzdX2nyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaBESlwAKCRCcnaoHP2RA2d3HB/ 9rRWoQHVfeAwDGuDGXrGCuc0/udOGN9xEioH7tzi1qh/ZXQcJrnlo1LEfga9kp/QIOM3yHGRL5ucIh 83bB6RaV5+23bhfT/wbgeDKHd6ZSXBhT/xQacVW10lyUaHyG3rvcBhEQXqNUq69YkJD0CeeCROkcjW +ck7/VHBLzN2ZYAq445t4x0hBIuHxN3GzSkozmqEuz+iNUpADSYZPJhql+xExgh64rC39QFS4mUMG4 QQubDpWO3GSfeudw70jw00n93W6zuwSUtIW1Me2Fkd09mE/4uRG4P81Hw3j+uko1Ho35JZ6djvmtKy Z49d+K+3v6dAKDn+Tmq0a5V4vvIqq2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[linux.dev:email,stgolabs.net:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Luis and David are reporting that after running generic/750 test for 90+
hours on 2k ext4 filesystem, they are able to trigger a warning in
jbd2_journal_dirty_metadata() complaining that there are not enough
credits in the running transaction started in ext4_do_writepages().

Indeed the code in ext4_do_writepages() is racy and the extent tree can
change between the time we compute credits necessary for extent tree
computation and the time we actually modify the extent tree. Thus it may
happen that the number of credits actually needed is higher. Modify
ext4_ext_index_trans_blocks() to count with the worst case of maximum
tree depth. This can reduce the possible number of writers that can
operate in the system in parallel (because the credit estimates now won't
fit in one transaction) but for reasonably sized journals this shouldn't
really be an issue. So just go with a safe and simple fix.

Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
Reported-by: Davidlohr Bueso <dave@stgolabs.net>
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: kdevops@lists.linux.dev
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..43286632e650 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2396,18 +2396,19 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
 int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 {
 	int index;
-	int depth;
 
 	/* If we are converting the inline data, only one is needed here. */
 	if (ext4_has_inline_data(inode))
 		return 1;
 
-	depth = ext_depth(inode);
-
+	/*
+	 * Extent tree can change between the time we estimate credits and
+	 * the time we actually modify the tree. Assume the worst case.
+	 */
 	if (extents <= 1)
-		index = depth * 2;
+		index = EXT4_MAX_EXTENT_DEPTH * 2;
 	else
-		index = depth * 3;
+		index = EXT4_MAX_EXTENT_DEPTH * 3;
 
 	return index;
 }
-- 
2.43.0


