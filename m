Return-Path: <linux-ext4+bounces-2947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4179165DF
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F83E1C23055
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ABC14BF98;
	Tue, 25 Jun 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tyyi45Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ioloclc7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tyyi45Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ioloclc7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899214B971;
	Tue, 25 Jun 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313650; cv=none; b=UDIYlftJeB2JnKlFcZeo8CmrmWtBgqp0GtSHFv2hg2IAv8gB4PZrVvho/CgrCBJZpTw2iqlwcDeySRMLXc0iup2lXQUbL/JOSqe7veDvqI+5IP8wUQSsmlylUgM1VfJt71EqAlF9bVI6MNpBJ8QwqjTDRBmOr18tISHNxZAZRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313650; c=relaxed/simple;
	bh=PY7L13pxdLSE+2/a1H4QXK0nQoetndLGO4nqNavMs9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQpKMkA2G+hkc/yqM+FJC2uBoByqhhubCzBoLM5YTqTF3LKG0jnmb5k05ABgN79mjk6ikPwBLvViO5zGUP0Jupgh9V0ocCdUSV8p8MqgiqmvTecEJJlcCflWcOHhdlbV4P8tlYH2Vbl/1vsDh1lyiZJlyCNuRZf2UQkH9DfYglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tyyi45Ml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ioloclc7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tyyi45Ml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ioloclc7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98A3D1F84F;
	Tue, 25 Jun 2024 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719313646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5APHAkGV4Ml9LxniEYJ12b6ysCsT+JexPNHYPsrQCY=;
	b=Tyyi45MlktCjpgfigQoSmGJZeb5hYPUBIoNpOBm+3Thzc2Y4GRzMLOMI7/yN9I74wUgK6n
	SwuE6vCoXxd5o86yenB8OM1sQo/QPycKhry5aM9DMHUqW5XOvJOWwZEUfSBnItdfSi52sX
	Ri3JmFxQPlmKCIi+XnItd43rT2OOAUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719313646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5APHAkGV4Ml9LxniEYJ12b6ysCsT+JexPNHYPsrQCY=;
	b=Ioloclc7TIEKnUADSMc/fGe0Z38tW7gnM/wztfgGJw4SbGDucpIXIaPtVntsRwDTQyXKQR
	6gxu2U3yto5Ig/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719313646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5APHAkGV4Ml9LxniEYJ12b6ysCsT+JexPNHYPsrQCY=;
	b=Tyyi45MlktCjpgfigQoSmGJZeb5hYPUBIoNpOBm+3Thzc2Y4GRzMLOMI7/yN9I74wUgK6n
	SwuE6vCoXxd5o86yenB8OM1sQo/QPycKhry5aM9DMHUqW5XOvJOWwZEUfSBnItdfSi52sX
	Ri3JmFxQPlmKCIi+XnItd43rT2OOAUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719313646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5APHAkGV4Ml9LxniEYJ12b6ysCsT+JexPNHYPsrQCY=;
	b=Ioloclc7TIEKnUADSMc/fGe0Z38tW7gnM/wztfgGJw4SbGDucpIXIaPtVntsRwDTQyXKQR
	6gxu2U3yto5Ig/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B95E1384C;
	Tue, 25 Jun 2024 11:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oh3KIe6kemY8aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 11:07:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40D3BA083E; Tue, 25 Jun 2024 13:07:26 +0200 (CEST)
Date: Tue, 25 Jun 2024 13:07:26 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] jbd2: Precompute number of transaction descriptor
 blocks
Message-ID: <20240625110726.wny5vmig7v2ugdbh@quack3>
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-2-jack@suse.cz>
 <483983e0-8827-9801-5268-abfd97865d94@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483983e0-8827-9801-5268-abfd97865d94@huaweicloud.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 25-06-24 17:31:15, Kemeng Shi wrote:
> on 6/25/2024 1:01 AM, Jan Kara wrote:
> > Instead of computing the number of descriptor blocks a transaction can
> > have each time we need it (which is currently when starting each
> > transaction but will become more frequent later) precompute the number
> > once during journal initialization together with maximum transaction
> > size. We perform the precomputation whenever journal feature set is
> > updated similarly as for computation of
> > journal->j_revoke_records_per_block.
> > 
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/jbd2/journal.c     | 61 ++++++++++++++++++++++++++++++++-----------
> >  fs/jbd2/transaction.c | 24 +----------------
> >  include/linux/jbd2.h  |  7 +++++
> >  3 files changed, 54 insertions(+), 38 deletions(-)
> > 
> > +static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
> > +{
> > +	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
> > +	int tags_per_block;
> > +
> > +	/* Subtract UUID */
> > +	tag_space -= 16;
> > +	if (jbd2_journal_has_csum_v2or3(journal))
> > +		tag_space -= sizeof(struct jbd2_journal_block_tail);
> > +	/* Commit code leaves a slack space of 16 bytes at the end of block */
> > +	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
> > +	/*
> > +	 * Revoke descriptors are accounted separately so we need to reserve
> > +	 * space for commit block and normal transaction descriptor blocks.
> > +	 */
> > +	return 1 + DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal),
> > +				tags_per_block);
> > +}
> The change looks good to me. I wonder if the original calculation of
> number of JBD2_DESCRIPTOR_BLOCK blocks is correct.
> In my opinion, it should be:
> DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal), tags_per_block *+ 1*)
> Assume max_txn_bufs is 6, tags_per_block is 1, then we have one tag block
> after each JBD2_DESCRIPTOR_BLOCK block. Then we could get 3
> JBD2_DESCRIPTOR_BLOCK block at most rather than 6.
> Please let me konw if I miss something, this confused me for sometime...

So you are correct that the expression is overestimating the number of
descriptor blocks required, essentially because we don't need descriptor
blocks for descriptor blocks. But given tags_per_block is at least over 60,
in common configurations over 250, this imprecision is not really
substantial and I prefer a simple to argue about upper estimate...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

