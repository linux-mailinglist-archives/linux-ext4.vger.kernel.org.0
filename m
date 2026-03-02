Return-Path: <linux-ext4+bounces-14331-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN1dC+/RpWm1GwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14331-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 19:07:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C56261DE3DF
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 19:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30A2B305376D
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C631B13B;
	Mon,  2 Mar 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mg5oqQtB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2tFD/daK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mg5oqQtB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2tFD/daK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230453126D7
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474844; cv=none; b=a8mYALGxXoIe+5r7nl4e8KcBx+jS41QZeS74d1SrGY3T49MjIqubQ3Cp2B18Cl9VS2vJsZ1Y17kDeScPOf3k97OYAMLbTZ8gdnWPnVkBmZPON/FKJcBaEujlD6pOj36ZmCvQHDop8GxzIXbF4vc6K5x+F48Rq8lwKkLSgXrI9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474844; c=relaxed/simple;
	bh=mRCxL/27wubeignxdwbZb0xjvWL1orV/D7L7HtEx5F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGgDrUA1AlcU4W3wCte/TzrDlVQfagOf67ffYauk/DyFK0+5tlE/4y4yr7EdKjnTK3kssazF49YuMWJfR26GhMd/yRBXqGp1364NhEFZcF0soryBnHumcqaeRjtuK6B02jvQabi+wIllvDXhI/yCieNCNnFBVZZ5BoSL4PiqQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mg5oqQtB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2tFD/daK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mg5oqQtB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2tFD/daK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7787F5BD58;
	Mon,  2 Mar 2026 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772474840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtOcaykAImEmiH7wjcFAlpWqcoD0fnM1rZELyvcMsFs=;
	b=mg5oqQtBVBrJ9PZ5TXNTj6yVuDSBSaoJPG+/YgMLnEzgFq8uVUSGO7edA1HSoByTSzMXJw
	soFsIj7jPELdd2XBzwPMgPZKtgjYsy89YXrg9zaw5QybQ4yASBwwwvNkRf2ERGGohyrD5W
	JGMuTqFhsn1vvpptvJFaAlCatnyIZRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772474840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtOcaykAImEmiH7wjcFAlpWqcoD0fnM1rZELyvcMsFs=;
	b=2tFD/daKbViI0+EV97nJsjJg01W2G4dKF/n97l8JTZ5GYHEw3QApL9qsJXhMhBP5JtjOC6
	DxQaCOXMGx1yBTBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772474840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtOcaykAImEmiH7wjcFAlpWqcoD0fnM1rZELyvcMsFs=;
	b=mg5oqQtBVBrJ9PZ5TXNTj6yVuDSBSaoJPG+/YgMLnEzgFq8uVUSGO7edA1HSoByTSzMXJw
	soFsIj7jPELdd2XBzwPMgPZKtgjYsy89YXrg9zaw5QybQ4yASBwwwvNkRf2ERGGohyrD5W
	JGMuTqFhsn1vvpptvJFaAlCatnyIZRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772474840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtOcaykAImEmiH7wjcFAlpWqcoD0fnM1rZELyvcMsFs=;
	b=2tFD/daKbViI0+EV97nJsjJg01W2G4dKF/n97l8JTZ5GYHEw3QApL9qsJXhMhBP5JtjOC6
	DxQaCOXMGx1yBTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B22C3EA69;
	Mon,  2 Mar 2026 18:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nAYiGtjRpWnnHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 18:07:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28022A0A4E; Mon,  2 Mar 2026 19:07:16 +0100 (CET)
Date: Mon, 2 Mar 2026 19:07:16 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Mark Fasheh <mark@fasheh.com>, linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ocfs2: use jbd2 jinode dirty range accessor
Message-ID: <procxfyhq22vyvzhmpuw5jwleelceymecuea3nk6cgrjn5pq47@ljz4hrvvvv5g>
References: <20260224092434.202122-1-me@linux.beauty>
 <20260224092434.202122-4-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224092434.202122-4-me@linux.beauty>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Queue-Id: C56261DE3DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-14331-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:email,suse.com:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 24-02-26 17:24:32, Li Chen wrote:
> ocfs2 journal commit callback reads jbd2_inode dirty range fields without
> holding journal->j_list_lock.
> Use jbd2_jinode_get_dirty_range() to get the range in bytes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Li Chen <me@linux.beauty>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v2:
> - Use jbd2_jinode_get_dirty_range() instead of direct i_dirty_* reads.
> - Drop per-caller page->byte conversion (now handled by the accessor).
> 
>  fs/ocfs2/journal.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 85239807dec78..68c2f567e6e1b 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -902,8 +902,13 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
>  
>  static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  {
> -	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
> -			jinode->i_dirty_start, jinode->i_dirty_end);
> +	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> +	loff_t range_start, range_end;
> +
> +	if (!jbd2_jinode_get_dirty_range(jinode, &range_start, &range_end))
> +		return 0;
> +
> +	return filemap_fdatawrite_range(mapping, range_start, range_end);
>  }
>  
>  int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
> -- 
> 2.52.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

