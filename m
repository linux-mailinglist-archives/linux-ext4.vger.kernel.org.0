Return-Path: <linux-ext4+bounces-629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0521821D8F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 15:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A42128350C
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81D11704;
	Tue,  2 Jan 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJyyHrJv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e16jXS6d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2pbDJ/Jw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqwxlzj9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E511194
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6B7B21D40;
	Tue,  2 Jan 2024 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704205355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycFwqemr+yg8WM3MEhlIy40Ty3ZaWHoc7zcTbZtMq6U=;
	b=YJyyHrJvpHqMZ0rsgxn+naGM6Knfz3XSNG18RwbIh0rdlyFPWG5Gvor9pV8ljcOQa8PVe/
	U/nBvtdurnY9uyem5sOm+4vkI7MvTJnN+5C1F21iEpF5Q9my+kfmvy5CYaPJq09DvImYBK
	mz2IWtipefH2aU2F9c0/a9jwiJCklzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704205355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycFwqemr+yg8WM3MEhlIy40Ty3ZaWHoc7zcTbZtMq6U=;
	b=e16jXS6dtvdn77o23esvPq/GaW5DIymuLPH0NTs2AfQcyk5GpNc13sVMGVjnTKCv3ZElyu
	mO/P2lEUWnXmTGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704205354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycFwqemr+yg8WM3MEhlIy40Ty3ZaWHoc7zcTbZtMq6U=;
	b=2pbDJ/JwUudoI4ZRou4/XahgQfo8QvjFIfYehPgC19nT5uSN5sv65YL2iqS9Fnuo4e9i8u
	VaeDlvbCdDGflbs/uPezSLbHs/8WqFNyFbxJyeidoaqxWgRn8REJ42K0qveaPPgI+bEZKW
	j6xHTEUBQTUR5KKwkj8dnhmnHRXxXmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704205354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycFwqemr+yg8WM3MEhlIy40Ty3ZaWHoc7zcTbZtMq6U=;
	b=yqwxlzj9LPSoAVAcwoNCd9CgP2Dzw9THlCYUvUUyzsDfnY4TZlsytuCstMvnUWxlG2ZBjw
	myjGuVtncQ4RA8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9619C1340C;
	Tue,  2 Jan 2024 14:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LOZSJCoclGUgXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 14:22:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2D549A07EF; Tue,  2 Jan 2024 15:22:30 +0100 (CET)
Date: Tue, 2 Jan 2024 15:22:30 +0100
From: Jan Kara <jack@suse.cz>
To: Haibo Liu <haiboliu6@gmail.com>
Cc: djwong@kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: [v2] ext4/super.c : Fix a goto label
Message-ID: <20240102142230.hwmjkmbrhproilkp@quack3>
References: <20230828092726.19400-1-haiboliu6@gmail.com>
 <20230829075222.50962-1-haiboliu6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829075222.50962-1-haiboliu6@gmail.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.46%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2pbDJ/Jw";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yqwxlzj9
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: A6B7B21D40

This seems to have fallen through the cracks. CCing ext4 maintainer (which
is a good idea with any patch BTW)...

On Tue 29-08-23 15:52:22, Haibo Liu wrote:
> Thank you for Darrick J. Wong's suggestions :). 
> I wrote a new patch and renamed these 9 labels.  
> 
> Original labels -> New labels: 
> 
> out -> out_unregister_ext23_and_dentry_cache 
> out05 -> out_inodecache
> out1 -> out_mballoc
> out2 -> out_sysfs
> out3 -> out_system_zone 
> out4 -> out_pageio
> out5 -> out_post_read_processing
> out6 -> out_pending
> out7 -> out_es 

I agree this is more standard and probably more future proof.

> v1->v2: 
> Followed Darrick J. Wong's suggestions, renamed these 9 goto labels. 

This versioning belongs below the --- line (probably below diffstat).

> Signed-off-by: Haibo Liu <haiboliu6@gmail.com>

Otherwise looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/ext4/super.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 91f20afa1d71..11cffb5a05a4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7347,61 +7347,61 @@ static int __init ext4_init_fs(void)
>  
>  	err = ext4_init_pending();
>  	if (err)
> -		goto out7;
> +		goto out_es;
>  
>  	err = ext4_init_post_read_processing();
>  	if (err)
> -		goto out6;
> +		goto out_pending;
>  
>  	err = ext4_init_pageio();
>  	if (err)
> -		goto out5;
> +		goto out_post_read_processing;
>  
>  	err = ext4_init_system_zone();
>  	if (err)
> -		goto out4;
> +		goto out_pageio;
>  
>  	err = ext4_init_sysfs();
>  	if (err)
> -		goto out3;
> +		goto out_system_zone;
>  
>  	err = ext4_init_mballoc();
>  	if (err)
> -		goto out2;
> +		goto out_sysfs;
>  	err = init_inodecache();
>  	if (err)
> -		goto out1;
> +		goto out_mballoc;
>  
>  	err = ext4_fc_init_dentry_cache();
>  	if (err)
> -		goto out05;
> +		goto out_inodecache;
>  
>  	register_as_ext3();
>  	register_as_ext2();
>  	err = register_filesystem(&ext4_fs_type);
>  	if (err)
> -		goto out;
> +		goto out_unregister_ext23_and_dentry_cache;
>  
>  	return 0;
> -out:
> +out_unregister_ext23_and_dentry_cache:
>  	unregister_as_ext2();
>  	unregister_as_ext3();
>  	ext4_fc_destroy_dentry_cache();
> -out05:
> +out_inodecache:
>  	destroy_inodecache();
> -out1:
> +out_mballoc:
>  	ext4_exit_mballoc();
> -out2:
> +out_sysfs:
>  	ext4_exit_sysfs();
> -out3:
> +out_system_zone:
>  	ext4_exit_system_zone();
> -out4:
> +out_pageio:
>  	ext4_exit_pageio();
> -out5:
> +out_post_read_processing:
>  	ext4_exit_post_read_processing();
> -out6:
> +out_pending:
>  	ext4_exit_pending();
> -out7:
> +out_es:
>  	ext4_exit_es();
>  
>  	return err;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

