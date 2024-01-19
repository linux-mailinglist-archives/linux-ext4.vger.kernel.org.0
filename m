Return-Path: <linux-ext4+bounces-851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E79832B60
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jan 2024 15:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7489C285D0B
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jan 2024 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAD524D4;
	Fri, 19 Jan 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uP+49nNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+/8uPswl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uP+49nNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+/8uPswl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D0343174
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jan 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674809; cv=none; b=bMqUrUwya+BtAXdepp5dOdqoj41M6FCtghGS5WKyIZIryPp4yvgpU6FW6dFRf8J+5xCgxyMQBR1pDZNr6OFmcbuJUZmzKKQTjxiQ+rO1gxiEBP2ObV8cY1NeoyXcT4m3hYszGP7DlRDvk7izGukk680z2M8JGewo3gXXs9j1x78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674809; c=relaxed/simple;
	bh=yUEvuaR6hfk8jMGZoWFJ2IJvBeWM01SpZYVMZuizGXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9LQh24IMzpOWuAbjqqHV8ZpV9siNBsqnLizYW5GfKDgFGWTLhs1Fi9cfDI/xIxtBW2r9RnJALFt7wVQ7eDW7O0M6Jn5hkELOsBl68lvODNVseq1UCYAKBbDZ1xVvr9y63i9mjcyOqQj6hslG0nN0S6qCq47VRF7o3vY/vpplHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uP+49nNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+/8uPswl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uP+49nNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+/8uPswl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CC181FD17;
	Fri, 19 Jan 2024 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705674805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h42tOpZyrdJJ9jSAGMF5lJiKKOC+j/gZZbAevYiuTPk=;
	b=uP+49nNeynWsVVnIBmywThlF0lDQlQaVEVcdysTWBBKcKHcuiw1oZ1tqrQVfDwDGopfnSF
	8hI3deNBeEKWiaQDPdD1WC1mOu/YlcfRJkn3W3CKd/km8z61qnotgf7njeWthiOWl6wlaS
	XBEBPgyyROh/7mZk7SWmV8GeeUXYrjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705674805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h42tOpZyrdJJ9jSAGMF5lJiKKOC+j/gZZbAevYiuTPk=;
	b=+/8uPswlh+AgVxUtjhNg6AGd4Io578Kk3T1kGEde4wBmXScjYFRZ+q+IZCcFB7WUMvteX2
	7VtKhnIXkUgNh5Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705674805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h42tOpZyrdJJ9jSAGMF5lJiKKOC+j/gZZbAevYiuTPk=;
	b=uP+49nNeynWsVVnIBmywThlF0lDQlQaVEVcdysTWBBKcKHcuiw1oZ1tqrQVfDwDGopfnSF
	8hI3deNBeEKWiaQDPdD1WC1mOu/YlcfRJkn3W3CKd/km8z61qnotgf7njeWthiOWl6wlaS
	XBEBPgyyROh/7mZk7SWmV8GeeUXYrjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705674805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h42tOpZyrdJJ9jSAGMF5lJiKKOC+j/gZZbAevYiuTPk=;
	b=+/8uPswlh+AgVxUtjhNg6AGd4Io578Kk3T1kGEde4wBmXScjYFRZ+q+IZCcFB7WUMvteX2
	7VtKhnIXkUgNh5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DEA9136F5;
	Fri, 19 Jan 2024 14:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kR7oFjWIqmVrMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Jan 2024 14:33:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDEA2A0803; Fri, 19 Jan 2024 15:33:24 +0100 (CET)
Date: Fri, 19 Jan 2024 15:33:24 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] ext4: add a hint for block bitmap corrupt state in
 mb_groups
Message-ID: <20240119143324.5cehalj5wgy7cozc@quack3>
References: <20240119061154.1525781-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119061154.1525781-1-yi.zhang@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uP+49nNe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+/8uPswl"
X-Spamd-Result: default: False [0.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.45%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.18
X-Rspamd-Queue-Id: 6CC181FD17
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 19-01-24 14:11:54, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> If one group is marked as block bitmap corrupted, its free blocks cannot
> be used and its free count is also deducted from the global
> sbi->s_freeclusters_counter. User might be confused about the absent
> free space because we can't query the information about corrupted block
> groups except unreliable error messages in syslog. So add a hint to show
> block bitmap corrupted groups in mb_groups.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..641c9be8e25e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3035,7 +3035,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  	for (i = 0; i <= 13; i++)
>  		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
>  				sg.info.bb_counters[i] : 0);
> -	seq_puts(seq, " ]\n");
> +	seq_puts(seq, " ]");
> +	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
> +		seq_puts(seq, " Block bitmap corrupted!");
> +	seq_puts(seq, "\n");
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

