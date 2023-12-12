Return-Path: <linux-ext4+bounces-406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C56280EEF2
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2361F21225
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2557317D;
	Tue, 12 Dec 2023 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVEyOfVY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XmDns+b/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVEyOfVY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XmDns+b/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605DAD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:38:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5522922510;
	Tue, 12 Dec 2023 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0jWie4Of4VZwC2PpN/AEgLxjO5Ex/qA2QSXF4tualY=;
	b=VVEyOfVYbTwgnpkPnni1B4hT4yK+c1o2bpHbKZk4frYffx+c51u+kE5FP0+g4OnW2qCVgC
	QKRbY1XwVOf7c3NloL45rWI0OUweqYpMgPBpM3ZDrC4/w6NhrE2solvz9wPOJUeK63l2X4
	QWadYrdCNzr7oMRNiEeHe4CAs3IJfpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0jWie4Of4VZwC2PpN/AEgLxjO5Ex/qA2QSXF4tualY=;
	b=XmDns+b/kXo2+7EAuxfpV8fLuABmY2Gf0ewiAHrbCMBiVPz3a0hcfQyq342nfyei+0BY+w
	6DtCDLxJ3480QzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0jWie4Of4VZwC2PpN/AEgLxjO5Ex/qA2QSXF4tualY=;
	b=VVEyOfVYbTwgnpkPnni1B4hT4yK+c1o2bpHbKZk4frYffx+c51u+kE5FP0+g4OnW2qCVgC
	QKRbY1XwVOf7c3NloL45rWI0OUweqYpMgPBpM3ZDrC4/w6NhrE2solvz9wPOJUeK63l2X4
	QWadYrdCNzr7oMRNiEeHe4CAs3IJfpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0jWie4Of4VZwC2PpN/AEgLxjO5Ex/qA2QSXF4tualY=;
	b=XmDns+b/kXo2+7EAuxfpV8fLuABmY2Gf0ewiAHrbCMBiVPz3a0hcfQyq342nfyei+0BY+w
	6DtCDLxJ3480QzDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4694B132DC;
	Tue, 12 Dec 2023 14:38:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Agg7EWJweGWAVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:38:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03EAAA06E5; Tue, 12 Dec 2023 15:38:25 +0100 (CET)
Date: Tue, 12 Dec 2023 15:38:25 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 5/5] ext4: Move ext4_check_bdev_write_error() into
 nojournal mode
Message-ID: <20231212143825.dcthdevylh3sbosa@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
 <20231103145250.2995746-6-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-6-chengzhihao1@huawei.com>
X-Spam-Score: 14.87
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VVEyOfVY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="XmDns+b/";
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.96)[-0.961];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email];
	 NEURAL_SPAM_SHORT(1.89)[0.631];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 6.92
X-Rspamd-Queue-Id: 5522922510
X-Spam-Flag: NO

On Fri 03-11-23 22:52:50, Zhihao Cheng wrote:
> Since JBD2 takes care of all metadata writeback errors of fs dev,
> ext4_check_bdev_write_error() is useful only in nojournal mode.
> Move it into '!ext4_handle_valid(handle)' branch.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4_jbd2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index d1a2e6624401..5d8055161acd 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -235,8 +235,6 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
>  
>  	might_sleep();
>  
> -	ext4_check_bdev_write_error(sb);
> -
>  	if (ext4_handle_valid(handle)) {
>  		err = jbd2_journal_get_write_access(handle, bh);
>  		if (err) {
> @@ -244,7 +242,8 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
>  						  handle, err);
>  			return err;
>  		}
> -	}
> +	} else
> +		ext4_check_bdev_write_error(sb);
>  	if (trigger_type == EXT4_JTR_NONE || !ext4_has_metadata_csum(sb))
>  		return 0;
>  	BUG_ON(trigger_type >= EXT4_JOURNAL_TRIGGER_COUNT);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

