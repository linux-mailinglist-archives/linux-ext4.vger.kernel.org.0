Return-Path: <linux-ext4+bounces-407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546080EEF7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C2D1C2092A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423F745C1;
	Tue, 12 Dec 2023 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsHQD5K0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3/y1Gqv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsHQD5K0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3/y1Gqv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334CCD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:39:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73CBD1FB45;
	Tue, 12 Dec 2023 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xyk0xLc4aITEOjcb/hxvGlqTGCq+if/7Cq9DGz23vo=;
	b=IsHQD5K0vcCfFFuoAYIm1SoGp7LNEpHSd9K2gt8AZ23TIedAvNQzacLCeYuJcBMpFDuqom
	6WXCAk7dHr1OhC85TX0lLaKigH334zN0JwGiTUcz5Om9SCz6Dd6/Rg76Q/SZCtm9ZK5XAH
	mZnJYzVlmnfJfaQIARWZXdoQqViXh/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xyk0xLc4aITEOjcb/hxvGlqTGCq+if/7Cq9DGz23vo=;
	b=D3/y1Gqv2qilN2M9QBkpdCDxWrl9NCeCcF06/uXgpyyrr3N/KuzVyQ+bH1CT/VxD4HhmK4
	p+Zd3b+MYtidWKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xyk0xLc4aITEOjcb/hxvGlqTGCq+if/7Cq9DGz23vo=;
	b=IsHQD5K0vcCfFFuoAYIm1SoGp7LNEpHSd9K2gt8AZ23TIedAvNQzacLCeYuJcBMpFDuqom
	6WXCAk7dHr1OhC85TX0lLaKigH334zN0JwGiTUcz5Om9SCz6Dd6/Rg76Q/SZCtm9ZK5XAH
	mZnJYzVlmnfJfaQIARWZXdoQqViXh/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xyk0xLc4aITEOjcb/hxvGlqTGCq+if/7Cq9DGz23vo=;
	b=D3/y1Gqv2qilN2M9QBkpdCDxWrl9NCeCcF06/uXgpyyrr3N/KuzVyQ+bH1CT/VxD4HhmK4
	p+Zd3b+MYtidWKDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67A2D132DC;
	Tue, 12 Dec 2023 14:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id p55LGa9weGXzVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:39:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E6AEA06E5; Tue, 12 Dec 2023 15:39:43 +0100 (CET)
Date: Tue, 12 Dec 2023 15:39:43 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 0/5] jbd2: Add errseq to detect writeback
Message-ID: <20231212143943.ycy35sujw3e5cz5k@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-1-chengzhihao1@huawei.com>
X-Spam-Score: 14.71
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IsHQD5K0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="D3/y1Gqv";
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.98)[-0.977];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 NEURAL_SPAM_SHORT(1.77)[0.591];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.75%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 6.75
X-Rspamd-Queue-Id: 73CBD1FB45
X-Spam-Flag: NO

On Fri 03-11-23 22:52:45, Zhihao Cheng wrote:
> According to discussions in [1], this patchset adds errseq in journal to
> enable JDB2 detecting meatadata writeback error of fs dev. Then, orginal
> checking mechanism could be removed.
> 
> [1] https://lore.kernel.org/all/20230908124317.2955345-1-chengzhihao1@huawei.com/T/

Thanks for the series! I'm sorry for the very delayed review. There has
been a lot of work, conference and other stuff happening lately... Anyway
the series looks good, I had just some language corrections.

								Honza

> 
> Zhihao Cheng (5):
>   jbd2: Add errseq to detect client fs's bdev writeback error
>   jbd2: Replace journal state flag by checking errseq
>   jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
>   jbd2: Abort journal when detecting metadata writeback error of fs dev
>   ext4: Move ext4_check_bdev_write_error() into nojournal mode
> 
>  fs/ext4/ext4_jbd2.c   |  5 ++---
>  fs/jbd2/checkpoint.c  | 11 -----------
>  fs/jbd2/journal.c     | 11 ++++++-----
>  fs/jbd2/recovery.c    |  7 +------
>  fs/jbd2/transaction.c | 14 ++++++++++++++
>  include/linux/jbd2.h  | 37 ++++++++++++++++++++++++++-----------
>  6 files changed, 49 insertions(+), 36 deletions(-)
> 
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

