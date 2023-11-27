Return-Path: <linux-ext4+bounces-197-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B27FA589
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9489BB211E1
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233034CF2;
	Mon, 27 Nov 2023 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CaF4o0IH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UiXnvop2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C7BC
	for <linux-ext4@vger.kernel.org>; Mon, 27 Nov 2023 08:02:20 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED7E31FDA8;
	Mon, 27 Nov 2023 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701100935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4yJ90L+MIJiFG+Lj/0fDkAAq8vkzO1tAs0Dt1atZJQ=;
	b=CaF4o0IHZFoGV4B0tQF6VKegyiG0+Y2eHSCcYlQm9sudiShTbC2nlLEpePeiI3dXb3+3PI
	yj1s0KNVBWU4zLnE7t/gvmnGiG0OhnAFohqltbs8jVK8ZNoRkz4XZhTqtgvVXvl8o2pPh3
	lnsijo9MzXPVhHEG7hZfuP2owK7GL8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701100935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4yJ90L+MIJiFG+Lj/0fDkAAq8vkzO1tAs0Dt1atZJQ=;
	b=UiXnvop297bU2N5PcMm8JvPfP40QVYX5cQBxoHv5EcL3H++Q4ZCLos12c/OoHKkQ69RgZi
	BJHOt/6OhzyvjwDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D809F13440;
	Mon, 27 Nov 2023 16:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4UJ0NIe9ZGXDWwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 27 Nov 2023 16:02:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EB85A07CB; Mon, 27 Nov 2023 17:02:15 +0100 (CET)
Date: Mon, 27 Nov 2023 17:02:15 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 1/2] jbd2: correct the printing of write_flags in
 jbd2_write_superblock()
Message-ID: <20231127160215.7wyowq5nt6ss2xgk@quack3>
References: <20231125121740.1035816-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125121740.1035816-1-yi.zhang@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.12
X-Spamd-Result: default: False [-0.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.34%]

On Sat 25-11-23 20:17:38, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The write_flags print in the trace of jbd2_write_superblock() is not
> real, so move the modification before the trace.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 30dec2bd2ecc..e7aa47a02d4d 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1791,9 +1791,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
>  		return -EIO;
>  	}
>  
> -	trace_jbd2_write_superblock(journal, write_flags);
>  	if (!(journal->j_flags & JBD2_BARRIER))
>  		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
> +
> +	trace_jbd2_write_superblock(journal, write_flags);
> +
>  	if (buffer_write_io_error(bh)) {
>  		/*
>  		 * Oh, dear.  A previous attempt to write the journal
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

