Return-Path: <linux-ext4+bounces-12230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F49CAD786
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5467305968F
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBFC2DC78C;
	Mon,  8 Dec 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKJ6u8yx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4dGgSZMy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKJ6u8yx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4dGgSZMy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879232BE657
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204423; cv=none; b=bYHP4+qZz/28B2M74jpgRQInX4RMOuBztDnKCqEoOcqHgMfX1qXa7QdBswtUrtSEdDcGbaLTc5lBr5S8x/S8PrJwrw3XwaZy1qxssZCuhzQgpFc8EavAUSFMq5ZK3GPvo3zaYxkUkXKA8TXZyMstFrzI2qsvblgS7a7Cpf0gzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204423; c=relaxed/simple;
	bh=1e3fKwKqOavKZGWmT5m+Mib71Rb4q99G7h77yXjY9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KENizNIU0nl+m4CF8xiGStl9Yt9wg5DMPpVGw+YVskkYjB07TbJ1CNE/eqcEhZYi2yqXbLnH7GuatdMcZ37lk4tjkkO3HjPXnEhhN5F293+Kd7BhsQPObTith45Ltpzs0VKqkCJsHuOul2WgHImezJvhmaWgVVAZ63/S/kGozXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKJ6u8yx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4dGgSZMy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKJ6u8yx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4dGgSZMy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80B495BCC9;
	Mon,  8 Dec 2025 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765204418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPmLEi5X19s/mvBvrx/EjSfP54GjiTUNNJXG1uiHiiY=;
	b=iKJ6u8yx0OaMI+7nJAYdt1J58YMfphc9i/n5nr74YLj2eYKHBos8enCVjdRpzL1vmgCEiz
	/YgrWGwpM0e0JKWMOJBY2v9kkcV9N8sPmDmQ3TUhdCjWS55N3uMX/7e35XeOANx6ns3Xd2
	W6amA8nq+/owbla1Pw3V4kb3/3hJZ8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765204418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPmLEi5X19s/mvBvrx/EjSfP54GjiTUNNJXG1uiHiiY=;
	b=4dGgSZMyWMA8aKoE5kJJz2a7Lwo33xTzzHkCfXNREU2wbqMEuj4yuaeoIdntbUE/Hctv6l
	cBWV6BSHRQXeJHAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iKJ6u8yx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4dGgSZMy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765204418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPmLEi5X19s/mvBvrx/EjSfP54GjiTUNNJXG1uiHiiY=;
	b=iKJ6u8yx0OaMI+7nJAYdt1J58YMfphc9i/n5nr74YLj2eYKHBos8enCVjdRpzL1vmgCEiz
	/YgrWGwpM0e0JKWMOJBY2v9kkcV9N8sPmDmQ3TUhdCjWS55N3uMX/7e35XeOANx6ns3Xd2
	W6amA8nq+/owbla1Pw3V4kb3/3hJZ8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765204418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPmLEi5X19s/mvBvrx/EjSfP54GjiTUNNJXG1uiHiiY=;
	b=4dGgSZMyWMA8aKoE5kJJz2a7Lwo33xTzzHkCfXNREU2wbqMEuj4yuaeoIdntbUE/Hctv6l
	cBWV6BSHRQXeJHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74D8D3EA65;
	Mon,  8 Dec 2025 14:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ckd/HMLhNmkxOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Dec 2025 14:33:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 207AEA09E4; Mon,  8 Dec 2025 15:33:34 +0100 (CET)
Date: Mon, 8 Dec 2025 15:33:34 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, yi.zhang@huawei.com, 
	jack@suse.cz
Subject: Re: [PATCH] ext4: add missing down_write_data_sem in
 mext_move_extent().
Message-ID: <zdy5jew73giogj2nm6m6nbl2jculzc6vdy5dqb7mir4fi566x3@oucwvxvajcok>
References: <20251208123713.1971068-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208123713.1971068-1-sunjunchao@bytedance.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 80B495BCC9
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email,bytedance.com:email,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon 08-12-25 20:37:13, Julian Sun wrote:
> Commit 962e8a01eab9 ("ext4: introduce mext_move_extent()") attempts to
> call ext4_swap_extents() on the failure path to recover the swapped
> extents, but fails to acquire locks for the two inode->i_data_sem,
> triggering the BUG_ON statement in ext4_swap_extents().
> 
> This issue can be fixed by calling ext4_double_down_write_data_sem()
> before ext4_swap_extents().
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Reported-by: syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69368649.a70a0220.38f243.0093.GAE@google.com/
> Fixes: 962e8a01eab9 ("ext4: introduce mext_move_extent()")

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0550fd30fd10..635fb8a52e0c 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -393,9 +393,11 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  
>  repair_branches:
>  	ret2 = 0;
> +	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>  	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
>  				  mext->donor_lblk, orig_map->m_lblk,
>  				  *m_len, 0, &ret2);
> +	ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  	if (ret2 || r_len != *m_len) {
>  		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
>  				       EIO, "Unable to copy data block, data will be lost!");
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

