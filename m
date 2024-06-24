Return-Path: <linux-ext4+bounces-2938-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948239154EC
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5A1F2157A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1E19E833;
	Mon, 24 Jun 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l0cwF35A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFE/2Q7G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1Tw3DsR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m61iNzMn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0019DF8F
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248491; cv=none; b=gBxHjtY2zCYv0+VevMEfMhEbGIsPibe2GZb8lsBpwHW6jQlI+l4hoiduwQS6sOw+r6bN9qxAX1J2CoVVDDlz4vsj6iJuDeZ3309owA4pgmHNbtdkcpHrzArgrJSUNnbl1Dfn2EpXtU9NkxEYJYm9WLHUhu+piKEsjba1fy5by6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248491; c=relaxed/simple;
	bh=+IDpm/XS0SJtvX+yvE/nTr/xcUPBFta4vmHz4Hj9b20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWd5XwD5WIwyJQ58Q/+7tjmGgsSFGYmDpDwKujUZr5nV/vY4ITHkL/a6qj+nwYlUvNEScDmNIFRlaKcn0qUsf6ihnvVoXFyKk75jGAl59yg5x8MmeyGkYwf2z77nrQMJ9x+NvgKI3hexMuqO0k+EbHuA3xdki/YoZYLftNNun1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l0cwF35A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFE/2Q7G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1Tw3DsR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m61iNzMn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F116D21A57;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x6ZPMvLTe7ggSIDVRLAtawQCqTusoj2E7AJzz74rpmY=;
	b=l0cwF35AKY1EDsUi2a287F3HBbAcKtPokKhlec2q5q8CRDPDyCqlpwXbL8SY4W+1Qq9IIP
	3HBv2vmUcabWk3SyFiXGi7+CDHdB7N6osrsnBe9afd6wjs4ksrjXLsiEeTbZkCJj7KbBfy
	OUdJENLS3ak1cX/9L2a+wOFv9+WF4EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x6ZPMvLTe7ggSIDVRLAtawQCqTusoj2E7AJzz74rpmY=;
	b=sFE/2Q7G3kSSkwvu6LBgFq+64DMLnCWYQhuCmM7Ha37EHHWkeVqK8Ovep8x51JMdIgwNVT
	Fl5rORJqUa2V0GAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x6ZPMvLTe7ggSIDVRLAtawQCqTusoj2E7AJzz74rpmY=;
	b=s1Tw3DsRMBMLTMmaZhOiwFSPWq4mK3QMiw8XE9/dbiJ/9ADY598D7YHscBjsUe2HUzdWIn
	q/4W+HOBZteG6GQLydRML9Sfl8u1sHyZGqfIbF4EblvK0qJ8nKvNQYAYj72ing8V0OMKCZ
	hQ9P6UHQM+xRBM0LDS4/zlzPc9WTtXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x6ZPMvLTe7ggSIDVRLAtawQCqTusoj2E7AJzz74rpmY=;
	b=m61iNzMnjlSu3hlKj8wyJL4b4G6vmYy2gw+mw7+6GYKc/FrBVJeFuzPBrZrUp7sFf54PlI
	xdsAt1VrqBSkjdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E251B13ACD;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXk5N2emeWbJOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7AC64A08AA; Mon, 24 Jun 2024 19:01:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] jbd2: Avoid infinite transaction commit loop
Date: Mon, 24 Jun 2024 19:01:16 +0200
Message-Id: <20240624165406.12784-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=745; i=jack@suse.cz; h=from:subject:message-id; bh=+IDpm/XS0SJtvX+yvE/nTr/xcUPBFta4vmHz4Hj9b20=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmeaZcHo4lk4tR0uUkeM5Z8IszEFKQx7E/wqCgdfKA eTlpPtCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnmmXAAKCRCcnaoHP2RA2Y8vCA DKj3CoWu5pFlmAwui8p4/xZeJQTDxtM1K19Ht6nRHm4i9IUJT1mbxvoYli/khqOAq7NiJZkHXnlgEK 3Up44ByjawXkFN3RwYyZ8ZtDGn6Ue1cwEYWTcU3pKHQz1/rowlrah1Gu32dBBsH2Nt8jsSWjXhTkJ7 z8MqEK5acbpEetQAXGYsXEkEKZqkiTTKl/zg+n7XCP5QletS4JmUp05WoNC0VC/pOJAyeyPn61mzYn zMAYcM+vfL6tCm+pufKm8/d3qpQvkxLLX8GzExk2LL9YEe1TJ8LzDvyNlIi52088QrJzwTLOtw6btA g+WtONv0Rq0d+g5f4ymQfTxt7j0eyS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-2.70)[98.68%];
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hello,

Alexander has reported [1] that when he tries to online-resize a small
filesystem JBD2 eventually BUGs in transaction commit code. This is caused by
online resize code starting a transaction of size close to maximum allowed
transaction size for the journal. When descriptor blocks are added to the
transaction it actually exceeds maximum transaction size and that confuses
start_this_handle() which enters infinite transaction commit loop (see patch 3
for details). This patch series fixes the confusion in start_this_handle().
There's still open question how to make online resizing with tiny journal work.

								Honza

[1] https://lore.kernel.org/all/CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com

