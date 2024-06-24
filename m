Return-Path: <linux-ext4+bounces-2943-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DB915583
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE01F24496
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6498819F461;
	Mon, 24 Jun 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UYa8XJRC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u3wAtqUT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRuclHGm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1SGPMFjt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D5FC08;
	Mon, 24 Jun 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250708; cv=none; b=MCk29OvD0f+PMNgNcc9Fx9QzVFqzrXXY3Tno6QVYo334UNgk19JYi0EqfI3NeM5GVKi7KetMiHXuZ5nv79azAEcZ6EWdNHu+96hKnGFPq+izrI41r5jqq2H94X4COhA0jbnJLEKU/0P+Sbv/C5dpdAJLZY7y6atpqFqrA5TE234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250708; c=relaxed/simple;
	bh=+K9TrWo+nrR5Bp1WKgmjEixh6h0x8NnnpUzq/8maT6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWR5tSBeqO3VFNwsAxYXAgpaYt7nmf2H5TXzEB+IBjLqOzPbuZ+MCWhHBhIIddgVVvS/GrrQUpK1iXw6JVXgE+qNWGt7jZTOSr9zZF4dMX5H4BXZUUmkezakUI/+2FpAw3Y/Z3I7V9cN6zHymZVC7Ci7zjVDNWrGZwD3x4f+nZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UYa8XJRC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u3wAtqUT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRuclHGm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1SGPMFjt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 868ED219B6;
	Mon, 24 Jun 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719250704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UkOmw9j/RdejhDDiZkoe7o0qMyio1yTKvDD8d7IQx2k=;
	b=UYa8XJRCxb5KSk89TibhhcZRXqJ1vDw/jCbdboVB6xe8MqXE36rvDt4LJSDs1HtJ+prGlI
	CZtqBd0fG0cJy0N49FeO/ml3eyf54/45K9yz7x5doZYBRc/V7Kx+J0hHXvNa6pjEvMG7Ut
	h5KV/+uQDEDIDR+De81iZ+lNKEBbA+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719250704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UkOmw9j/RdejhDDiZkoe7o0qMyio1yTKvDD8d7IQx2k=;
	b=u3wAtqUTujMA+DPHMTByML3vWHST6IwEU7yHv+wgVLCK9yufJ+LlPP5Zv/jDghI90lg9WY
	6BZu3uw4KoKtNNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oRuclHGm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1SGPMFjt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719250703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UkOmw9j/RdejhDDiZkoe7o0qMyio1yTKvDD8d7IQx2k=;
	b=oRuclHGmRQs+w6Uz+T2YVOYpROMjpG8I1V3Q+oGGJzQDLmBJaj5Ga7m9W0zOyYbJQYjPBI
	BVK0LoTkfbG5GCPGZ0ArE0CYYXlcOcOdg4TCFbPOojfYbPgu3gZkrdS5KU6+8Hn/2QpWV7
	CP5J+Ah0ZFUKnRq6eNIgQJp6tsH4Pz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719250703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UkOmw9j/RdejhDDiZkoe7o0qMyio1yTKvDD8d7IQx2k=;
	b=1SGPMFjtJNTQtT8Gk6i7CCcNk/e+2zv2tWylo5gBcummSCeqymSMiuSStj8I0q4DUDYwyt
	tpTMIHGmX6jy/UBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75FF313AA4;
	Mon, 24 Jun 2024 17:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLuHHA+veWa5QgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:38:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E883A08AA; Mon, 24 Jun 2024 19:38:23 +0200 (CEST)
Date: Mon, 24 Jun 2024 19:38:23 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext4 resize2fs on-line resizing panic
Message-ID: <20240624173823.qacrdbxfxwn42kmr@quack3>
References: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
 <20240624152658.GC280025@mit.edu>
 <20240624165350.madyxs74vx3niyy2@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624165350.madyxs74vx3niyy2@quack3>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 868ED219B6
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 24-06-24 18:53:50, Jan Kara wrote:
> On Mon 24-06-24 11:26:58, Theodore Ts'o wrote:
> > On Sun, Jun 23, 2024 at 06:57:13PM -0700, Alexander Coffin wrote:
> > > [1.] One line summary of the problem:
> > > Using resize2fs on-line resizing on a specific ext4 partition is
> > > causing an Oops.
> > > 
> > > 
> > > [6.] Output of Oops.. message (if applicable) with symbolic information
> > >      resolved (see Documentation/admin-guide/bug-hunting.rst)
> > > 
> > > ```
> > > [  445.552287] ------------[ cut here ]------------
> > > [  445.552300] kernel BUG at fs/jbd2/journal.c:846!
> > 
> > Thanks for the bug report.  The BUG_ON is from the following assert in
> > jbd2_journal_next_log_block:
> > 
> > 	J_ASSERT(journal->j_free > 1);
> > 
> > and it indicates that we ran out of space in the journal.  There are
> > mechanisms to make sure that this should never happen, and if the
> > journal is too small and the transaction couldn't be broken up, then
> > the operation (whether it is a resize or a file truncate or some other
> > operation) should have errored out, and not triggered a BUG.
> 
> Yeah, I was debugging this today and I'll shortly send a fix for JBD2 so
> that we don't trigger this BUG. But the online resize will fail anyway
> after my fixes (just gracefully) because the add_flex_bg() code tries to
> start a transaction with more credits than the journal allows.

To be more precise, the problem is that with this size of the journal,
maximum transaction size is 250 metadata blocks (+6 blocks reserved for
descriptors). Online resizing tries to start a transaction with 252 credits
in ext4_flex_group_add(). 246 credits come from es->s_reserved_gdt_blocks
so I don't see an easy way how to avoid that because to each of these
reserve gdt blocks we need to add reserved gdt blocks from the new groups.
So I see two possibilities:

1) Just make mke2fs / tune2fs refuse so many reserved gdt blocks with a
tiny journal.

2) Allow larger transaction size - currently we require that 4 max sized
transactions fit into the journal, we could reduce it to 3 without
introducing deadlocks. But larger transactions could have other unexpected
performance side effects so I'm not sure the risk is worth it for a corner
case like this.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

