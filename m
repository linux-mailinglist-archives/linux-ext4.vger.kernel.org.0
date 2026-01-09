Return-Path: <linux-ext4+bounces-12704-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FFD08BAC
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFDD30056CC
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1233A003;
	Fri,  9 Jan 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ghpAxnj9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VSoiq5q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x51bbXT6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yPVE+kHw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79026738B
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956053; cv=none; b=ThmpccCuWbX7/WXuCSuNFdFSSlHL60v1xnH8lTEPk3WPZs+wFHh3oj2lckAEMQNCOd9iZNALsh4onPUKf5zrIXp+mdI33cSbg+pji74GXmpLT2SDASboG7JFSZJpzrAlS3U/73uNu+zgKMtHzmI1vn6Qj7M5XkRyiD3gdc43r1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956053; c=relaxed/simple;
	bh=dODP2s1RpHz0TsGaAIz1HLvIk72TE5ObnIcFd0nCOq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3J0ZMOU5bbo22nZ+fTFAP+t4sdVqGk0lhVDA7VVG92cqmMQqyJgiaGN8yzxkY2s1GlUN8/9Tpkd68j2Q5AIkQK8nf9P39yGEHqKoNmpd2wfjFI9A5TYXNHDurvGqjaFqwl0Ja/i9/Hev8+bIvq/t6xj2rMVOXrPT1iSjW175Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ghpAxnj9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VSoiq5q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x51bbXT6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yPVE+kHw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E345333840;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q6sFjOHyDf1q86r/tiK5WdjlvI1ULy2c3u6u6Zgw9x4=;
	b=ghpAxnj90BRUdDfGQZIS8FKfJMuIjEuk/s0opLx8TDMAveC1rw5f7lwdr2ISKUqZhStaLj
	1LPry1axPr0TlGU2x1fErb9/lFfGVHj1Drv0Av4CzCZL9isTzLHo8Krntqr1AI+42ifYrr
	s6AURX+e5/kHNUkkKnORgjCKnRdaMrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q6sFjOHyDf1q86r/tiK5WdjlvI1ULy2c3u6u6Zgw9x4=;
	b=0VSoiq5q46DLyGviN661LKjO1GdESfaiMnZ9wgZaK5k5Brix7yleeW045W3KAS5apsDJxt
	Kaqf+Xxo5fYRp3AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x51bbXT6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yPVE+kHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q6sFjOHyDf1q86r/tiK5WdjlvI1ULy2c3u6u6Zgw9x4=;
	b=x51bbXT68qYOQG/hNOyN0abL0+EpHIpnODOy+Sgolu/SET9OUcF/qWt+4VC5oKlHVKM7HJ
	psd2PHDfqRzWAVXlJw0AemEIS6KzvF/dFK/3l3SPjd53KnMCBn4sudMCeXRvGI/mSQ5qJE
	OVnjj1wlEtzbhiFOZkV97aw32Lzsg4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q6sFjOHyDf1q86r/tiK5WdjlvI1ULy2c3u6u6Zgw9x4=;
	b=yPVE+kHwC5qoAK4cnhjsPqkyp2+2t8szbHeBsIGoAjugUPnezaMsUamUFZzaTcbXeCuY2F
	xFqNery5AloohXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DABF63EA63;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JS1jNUXeYGlHVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Jan 2026 10:53:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93C68A0951; Fri,  9 Jan 2026 11:53:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] ext4: use mb_optimize_scan regardless of inode format
Date: Fri,  9 Jan 2026 11:53:36 +0100
Message-ID: <20260109105007.27673-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=383; i=jack@suse.cz; h=from:subject:message-id; bh=dODP2s1RpHz0TsGaAIz1HLvIk72TE5ObnIcFd0nCOq0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpYN4vjJhLx55kA5xN9pNZn8iyXxMm8j+Jv5Lg5 KjuYyYE3w2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaWDeLwAKCRCcnaoHP2RA 2SwTB/0RZPNa5GFev0MuSIjLaoH0ebAvYvpmA9BHnOb16Qd2fSYhovy8R1zZ+vFXKQcsPMtQZgK jPlrMYsnthNV2kqGca/IBXrk+VGnvKkcpi9DEnybx6ZDAIb/g+Oiq+g2odE11UO17NXpRaEvVea GRBpVOGPrY6dOLJ+GofE0bv5+XxsNp1KpvAVJzbv8amE0lIMe5ONJuYGFzp1XXpb206Q+e3u7XO NMWo2A5WRcdUYqjm48QHh76b5SWMNcCwVe617YrxaeLPv0OJemr3UzKPBkQ4UZA9uErJ95uq6xw EjniInh0DKSltP0lkMx0AoyPKx9c9zQ2qbTblh4eNqiZyBWF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E345333840
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hello,

this patch series enables use of mballoc optimizations regardless of the inode
format. See patch 2 for details.

Changes since v1:
* Added patch to make sure mballoc doesn't select group with block numbers
  greater than 2^32 for indirect block based inodes

Previous versions:
v1: https://lore.kernel.org/all/20260108160907.24892-2-jack@suse.cz/

								Honza

