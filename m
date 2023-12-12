Return-Path: <linux-ext4+bounces-405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B580EEF0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD23B20D8C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D77319D;
	Tue, 12 Dec 2023 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nVMVQ4w5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7F0wFQJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nVMVQ4w5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7F0wFQJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A768E
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:38:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 827481FB45;
	Tue, 12 Dec 2023 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZOmGiL2XSwyp2RvWwhBdg1lvKKLDaZcV4wtLkchxZI=;
	b=nVMVQ4w5IbRVEr2TDGKDgg19bX7FL7rK9Cj0a/wuKOLp5kJL7PzjwKsvtYc4FosqVsFTRz
	WRDLd8+CRtWk8X8dCYlNECD9iGlEShUloDh3nwDyog1G5JuWx6CNLTlVmN0Mluy4DFVvO4
	TKKk4duYS7VFghY1TuVeq85++cXbF4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZOmGiL2XSwyp2RvWwhBdg1lvKKLDaZcV4wtLkchxZI=;
	b=b7F0wFQJ9w8AR1x5USRxUO3gfR39yO6ZPjV9lZyBfSyhVnyoBX2qE4Y1WUd8o9Gb2e+OE7
	8pz/FWQSaG9mAJAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZOmGiL2XSwyp2RvWwhBdg1lvKKLDaZcV4wtLkchxZI=;
	b=nVMVQ4w5IbRVEr2TDGKDgg19bX7FL7rK9Cj0a/wuKOLp5kJL7PzjwKsvtYc4FosqVsFTRz
	WRDLd8+CRtWk8X8dCYlNECD9iGlEShUloDh3nwDyog1G5JuWx6CNLTlVmN0Mluy4DFVvO4
	TKKk4duYS7VFghY1TuVeq85++cXbF4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZOmGiL2XSwyp2RvWwhBdg1lvKKLDaZcV4wtLkchxZI=;
	b=b7F0wFQJ9w8AR1x5USRxUO3gfR39yO6ZPjV9lZyBfSyhVnyoBX2qE4Y1WUd8o9Gb2e+OE7
	8pz/FWQSaG9mAJAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7745E132DC;
	Tue, 12 Dec 2023 14:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vBEdHU1weGVkVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:38:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27DFFA06E5; Tue, 12 Dec 2023 15:38:05 +0100 (CET)
Date: Tue, 12 Dec 2023 15:38:05 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 4/5] jbd2: Abort journal when detecting metadata
 writeback error of fs dev
Message-ID: <20231212143805.annty5auy6q2uf3d@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
 <20231103145250.2995746-5-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-5-chengzhihao1@huawei.com>
X-Spam-Level: 
X-Spam-Score: 0.08
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.42%]
X-Spam-Score: 0.17

On Fri 03-11-23 22:52:49, Zhihao Cheng wrote:
> This is a replacement solution of commit bc71726c725767 ("ext4: abort
> the filesystem if failed to async write metadata buffer"), JBD2 can
> detects metadata writeback error of fs dev by 'j_fs_dev_wb_err'.
  ^^^ detect

> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 5f08b5fd105a..cb0b8d6fc0c6 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1231,11 +1231,25 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
>  int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
>  {
>  	struct journal_head *jh;
> +	journal_t *journal;
>  	int rc;
>  
>  	if (is_handle_aborted(handle))
>  		return -EROFS;
>  
> +	journal = handle->h_transaction->t_journal;
> +	if (jbd2_check_fs_dev_write_error(journal)) {
> +		/*
> +		 * If the fs dev has writeback errors, it may have failed
> +		 * to async write out metadata buffers in the background.
> +		 * In this case, we could read old data from disk and write
> +		 * it out again, which may lead to on-disk filesystem
> +		 * inconsistency. Aborting journal can avoid it happen.
> +		 */
> +		jbd2_journal_abort(journal, -EIO);
> +		return -EIO;
> +	}
> +
>  	if (jbd2_write_access_granted(handle, bh, false))
>  		return 0;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

