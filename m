Return-Path: <linux-ext4+bounces-2329-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC48BD3F5
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E8A1F239A2
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76E157A45;
	Mon,  6 May 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qdyc9Wyt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7j783TR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FCUleZCI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDRuJQEZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00C157461
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017297; cv=none; b=Tq7tbU5lwDBNJTdcNwXWTW5hmUvaBZrxCtEcK4qJSI/CCG4z++6FcqQCpFFWNjM03g4anOxRqi8Ke5TxIdCI4eNptz34FseORAZZh03e+fmjx685+c8FI7hK2kdUfkmzE+glGC0rwhfy/DpbluilglvhOLiAtdeXCbIsN/SRq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017297; c=relaxed/simple;
	bh=HHBwMx4DAU3C0v57L4sB5MTkK9oDqsV96skq0ZakKUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAFqK8ZFnLnHaFcBTf6asoAheIoU55zf8ShxlrzUBxYrIyJKRy/y78319ekZDH/qpAqJ5a8MxfJ7MPoXicAt/pCYD3d5QkQXdOhHhVyincLh28hO7F419Qtl4gJR3nJ6Du7SU811lGOusVYcUgAyVZBR1S/Fs71CgarVUWT2EsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qdyc9Wyt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7j783TR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FCUleZCI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDRuJQEZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E479921994;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rdIQySh/ZwgdHq6YTLrmyaeVkR28rxo1diw1+gh9La0=;
	b=Qdyc9Wytqa6ug0pWEG6CGIDFwDf+DOiF2NOM2o4jmAO3z3SZ5aizvSRKWTGO5+510NrGOz
	Rj4SqFtjqZ+G+U0B2Gt9VMBnMKNe7jFEZn+s8qvlpIQTPGAFzd3WxrvS2VhHkSovlUqlFM
	3l0y6RuOI03Y/M9JIPrU2PycrL+UaPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rdIQySh/ZwgdHq6YTLrmyaeVkR28rxo1diw1+gh9La0=;
	b=S7j783TR6auUr+iMgOo75K92qvPZN2wr3nfJRPmDQhYZygXYCN+i3LUU8uMbZ2X60whaUO
	PU1qO0ILKtxA3CCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FCUleZCI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qDRuJQEZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rdIQySh/ZwgdHq6YTLrmyaeVkR28rxo1diw1+gh9La0=;
	b=FCUleZCIRheRbFm/L+PaR/neBSqh9WOfzC1s1hlE3aWcIQbzOMOh81mU44NYwvLoXJz6YC
	MDm8d5HKMn9m/6JuXzi6Hflsv2XUyOvrNRI1uC3Eurq0ALoY0JvxkMhlTeLZ+GNflraa6q
	U4tQ/wEYN3KUDTVlQcM4kto4dWKHTKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rdIQySh/ZwgdHq6YTLrmyaeVkR28rxo1diw1+gh9La0=;
	b=qDRuJQEZy+cOmxvfSmaEieF55g5IvYRImltSR/tfDjyWVEQVKdIOAISwfhyzg7Z+amNl5Z
	xJSR7z01TgQ+TICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D069D13A38;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y8SGMkwWOWb1MgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 17:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02223A1306; Mon,  6 May 2024 19:41:31 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] e2fsck: expand checking of EA inode
Date: Mon,  6 May 2024 19:41:16 +0200
Message-Id: <20240506173704.24995-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=390; i=jack@suse.cz; h=from:subject:message-id; bh=HHBwMx4DAU3C0v57L4sB5MTkK9oDqsV96skq0ZakKUc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmORY3IamIZn8szJLJluldMPA6Oph4b+bGf5VLJqEX hh9izxaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZjkWNwAKCRCcnaoHP2RA2fuVB/ 0X/05PI2FiFMS5x55xVxb2gh1qN3en1Xi0XJbFOd3VnDUIklJ0ikZ2Ywda2qcjBMORj2CIlouSozgK C1DwuZOuy4LV9Zu5UTedBQj8fcNKPVS1Y0f8rULIfF9lep6SQ898L+rshF9MhVZ8r+I6/2O+22oSY9 ooyhvS4jkmX+WQGAZnVAN14F8/m0SStXXSdSDef1PnvQHvS76cZRgEdtBc9SfZhBvMiR+S2yXL1+kl /2GTZUgfawplYWzcYh0nwys//JZxhsb6XNRWKjKShGpS+IUD1MuWfu65zYzac38V/hyeQGh4FPNIUy oeISLdbfXEfq0uywBTRGW0zUI2fKEA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.21 / 50.00];
	BAYES_HAM(-1.20)[89.19%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E479921994
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.21

Hello,

customer has reported that his filesystem was reporting errors from
ext4_iget() about inode with EA_INODE_FL but e2fsck was considering the
filesystem as clean. Indeed the EA inode checking in e2fsck is weak and
lets through several cases of corruption related to EA inodes. This series
adds more strict checking of EA inodes and adds e2fsck tests for them.

								Honza

