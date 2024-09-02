Return-Path: <linux-ext4+bounces-4006-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C69688F9
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C12847E6
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7096920FA83;
	Mon,  2 Sep 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SlYu+qup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGfvrtC2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SlYu+qup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGfvrtC2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1015E81;
	Mon,  2 Sep 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284151; cv=none; b=J9jTf8Ijqohzh9PsjqrzsV4F2ef0S3pUS5b/FZBMjoBwSRZLtefGO8m/r0uM8TUlLUL9H17MSgIbd5NktqQuSsmt5fBmT0KtJQpWqzAAkgjQLPK1kbQTR3n3/MifAEqC6SOC30bPkFxhEF75CQ5QIfh9B80Ym76gnAhAkU7pX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284151; c=relaxed/simple;
	bh=BYOcur5wsgKwqmtScmDH7+SGVIW1wpmx7gq7vRrs3CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZWFAUEXUj4mhrT290XwPpVaaARyR+RyAdQzYO4TIdYIog2LMdiMXYiVnZ24RhxluVNPxjVIZDGgRJB0XTMHl/YvVv28vmv3mPrUUJe5UNmVD1eDCjpe0InLMkNdBqBhVQvldh8KahpvaXh/W31GWMCqa3CbjXMvNXXrf8T89JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SlYu+qup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGfvrtC2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SlYu+qup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGfvrtC2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 827DC21B0B;
	Mon,  2 Sep 2024 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725284146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1mxnWaMwl9qHAe7DXwp+6PNcBmAQUGuKb7aKLaqbAA=;
	b=SlYu+qupQ11kpPLKGceI86c9lJNabxkk/S2UVGgWknLitMbsfPUNyz6Nb/w2XbHQ6e/yBa
	yA8UgIL33VVPUzzYvzQ4s9HxoUnuj9akxyI/k3kSzBaQsMsHnv0ZW5w3YIu3tz0x0I8yy9
	whIK3yZ53OVR0AolHEWTlLhIDdRVUS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725284146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1mxnWaMwl9qHAe7DXwp+6PNcBmAQUGuKb7aKLaqbAA=;
	b=qGfvrtC2jyCr+pWcqSTr59MBvIU59LLYnaQaV9CVHDax4eTJeevVBjpSihv84Jkv7Ps1lf
	xCHAaUw5QD9HPSAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SlYu+qup;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qGfvrtC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725284146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1mxnWaMwl9qHAe7DXwp+6PNcBmAQUGuKb7aKLaqbAA=;
	b=SlYu+qupQ11kpPLKGceI86c9lJNabxkk/S2UVGgWknLitMbsfPUNyz6Nb/w2XbHQ6e/yBa
	yA8UgIL33VVPUzzYvzQ4s9HxoUnuj9akxyI/k3kSzBaQsMsHnv0ZW5w3YIu3tz0x0I8yy9
	whIK3yZ53OVR0AolHEWTlLhIDdRVUS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725284146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y1mxnWaMwl9qHAe7DXwp+6PNcBmAQUGuKb7aKLaqbAA=;
	b=qGfvrtC2jyCr+pWcqSTr59MBvIU59LLYnaQaV9CVHDax4eTJeevVBjpSihv84Jkv7Ps1lf
	xCHAaUw5QD9HPSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7823A13A7C;
	Mon,  2 Sep 2024 13:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8UZPHTK/1Wa0JAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 13:35:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D528A0965; Mon,  2 Sep 2024 15:35:46 +0200 (CEST)
Date: Mon, 2 Sep 2024 15:35:46 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/4] ext4: remove the special buffer dirty handling in
 do_journal_get_write_access
Message-ID: <20240902133546.wify64w2yif7vvh5@quack3>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
 <20240830053739.3588573-5-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830053739.3588573-5-zhangshida@kylinos.cn>
X-Rspamd-Queue-Id: 827DC21B0B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 13:37:39, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> This kinda revert the commit 56d35a4cd13e("ext4: Fix dirtying of
> journalled buffers in data=journal mode") made by Jan 14 years ago,
> since the do_get_write_access() itself can deal with the extra
> unexpected buf dirting things in a proper way now.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a28f279fd02f..2687bf451a25 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1023,27 +1023,11 @@ static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh)
>  {
> -	int dirty = buffer_dirty(bh);
> -	int ret;
> -
>  	if (!buffer_mapped(bh) || buffer_freed(bh))
>  		return 0;
> -	/*
> -	 * ext4_block_write_begin() could have dirtied some buffers. Clean
> -	 * the dirty bit as jbd2_journal_get_write_access() could complain
> -	 * otherwise about fs integrity issues. Setting of the dirty bit
> -	 * by ext4_block_write_begin() isn't a real problem here as we clear
> -	 * the bit before releasing a page lock and thus writeback cannot
> -	 * ever write the buffer.
> -	 */
> -	if (dirty)
> -		clear_buffer_dirty(bh);
>  	BUFFER_TRACE(bh, "get write access");
> -	ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
> +	return ext4_journal_get_write_access(handle, inode->i_sb, bh,
>  					    EXT4_JTR_NONE);
> -	if (!ret && dirty)
> -		ret = ext4_dirty_journalled_data(handle, bh);
> -	return ret;
>  }
>  
>  int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

