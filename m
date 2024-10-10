Return-Path: <linux-ext4+bounces-4540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0E99822C
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B241C247E4
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47ABE6F;
	Thu, 10 Oct 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqoR0CX/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPM8xB/F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqoR0CX/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPM8xB/F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0E29AF;
	Thu, 10 Oct 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552571; cv=none; b=aOxr7/fvAeHdwM/lIkqwWZMk/BhHGPGJ/3AO2nEjZ7j9h/cD0CE9Qf4ozCR/Pt+s0f9dwIikPaRYUeM4FUztqIog31AhvusevEVMvRbxaU7B4bjbzCNrBpM7lsbrCo7Xsnp53w5XYumNpSlBQKbcnXqIKCF28E4SLvNTCcbBd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552571; c=relaxed/simple;
	bh=Vafp+6xNToGewgmfw0ctcoQo3aBvxiSthYN15fmMkI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMA1OmTQpYj77A/DTBXpBfNB7dNhnf72Qex7pB1Iwzc+ccJ/Yana6e0IORCTx6B96WDjqyuXPFG2DnSGdNdR14QuM+NR/qnegQEud+HVpZ/71E5RGFpFFlGfSkN1l3mpVKWWujqSBVG9eXDj5c9tJ2Z0G+f1tBGx5tbNzMac7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqoR0CX/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPM8xB/F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqoR0CX/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPM8xB/F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 910391FE66;
	Thu, 10 Oct 2024 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728552567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1YsnS/ai3mHhkG2ip3Wq7ejBD/D+GDDlFRCn1oZ1Tk=;
	b=HqoR0CX/ocYbfC1/4g8SN9oLBl7lrRH/EyvOAzYSw25ukNfe99mjSGmzX+9vfUgeFhlxtp
	bPGESPvGqXJWjzKcbRaOaE3uV63dN5RPq9KFqz0DpPAvuXXtOqRL0zK59QQj+EUgFQ2zyn
	e4bCsiMfks2QlmEDTazkVMoGYSSjliM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728552567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1YsnS/ai3mHhkG2ip3Wq7ejBD/D+GDDlFRCn1oZ1Tk=;
	b=EPM8xB/FPO7klw6s/K6JZ4eidn5FSS27gZSj/AaamiUS+VdBMPPDp3in13hBx9EJXYrun2
	ZV8rmlB0N7kwWGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728552567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1YsnS/ai3mHhkG2ip3Wq7ejBD/D+GDDlFRCn1oZ1Tk=;
	b=HqoR0CX/ocYbfC1/4g8SN9oLBl7lrRH/EyvOAzYSw25ukNfe99mjSGmzX+9vfUgeFhlxtp
	bPGESPvGqXJWjzKcbRaOaE3uV63dN5RPq9KFqz0DpPAvuXXtOqRL0zK59QQj+EUgFQ2zyn
	e4bCsiMfks2QlmEDTazkVMoGYSSjliM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728552567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1YsnS/ai3mHhkG2ip3Wq7ejBD/D+GDDlFRCn1oZ1Tk=;
	b=EPM8xB/FPO7klw6s/K6JZ4eidn5FSS27gZSj/AaamiUS+VdBMPPDp3in13hBx9EJXYrun2
	ZV8rmlB0N7kwWGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8864B13A6E;
	Thu, 10 Oct 2024 09:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9fBGIXeeB2cFBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Oct 2024 09:29:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33131A08A2; Thu, 10 Oct 2024 11:29:23 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:29:23 +0200
From: Jan Kara <jack@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	zhangshida@kylinos.cn, longzhi@sangfor.com.cn,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
Message-ID: <20241010092923.r53povuflevzhxrw@quack3>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010025855.2632516-1-liubaolin12138@163.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 10-10-24 10:58:55, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> Since the merge of commit 3910b513fcdf ("ext4: persist the new uptodate
> buffers in ext4_journalled_zero_new_buffers"), a new assertion failure
> occurred under a old kernel(ext3, data=journal, pagesize=64k) with
> corresponding ported patches:
...
> which was caused by bh dirting without calling
> do_journal_get_write_access().
> 
> In the loop for all bhs of a page in ext4_block_write_begin(),
> when a err occurred, it will jump out of loop.
> But that will leaves some bhs being processed and some not,
> which will lead to the asserion failure in calling write_end_fn().

Thanks for the patch but I don't understand one thing here: For
ext4_journalled_zero_new_buffers() to call write_end_fn() the buffer must
have buffer_new flag set. That flag can get set only by ext4_get_block()
function when it succeeds in which case we also call
do_journal_get_write_access(). So how is it possible that buffer_new was
set on a buffer on which we didn't call do_journal_get_write_access()? This
indicates there may be some deeper problem hidden. How exactly did you
trigger this problem?

								Honza

> 
> To fixed that, get write access for the rest unprocessed bhs, just
> as what write_end_fn do.
> 
> Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
> Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
> Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> ---
>  fs/ext4/inode.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..a72f951288e4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1102,9 +1102,24 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  			err = -EIO;
>  	}
>  	if (unlikely(err)) {
> -		if (should_journal_data)
> +		if (should_journal_data) {
> +			if (bh != head || !block_start) {
> +				do {
> +					block_end = block_start + bh->b_size;
> +
> +					if (buffer_new(bh))
> +						if (block_end > from && block_start < to)
> +							do_journal_get_write_access(handle,
> +										    inode, bh);
> +
> +					block_start = block_end;
> +					bh = bh->b_this_page;
> +				} while (bh != head);
> +			}
> +
>  			ext4_journalled_zero_new_buffers(handle, inode, folio,
>  							 from, to);
> +		}
>  		else
>  			folio_zero_new_buffers(folio, from, to);
>  	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

