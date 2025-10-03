Return-Path: <linux-ext4+bounces-10624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B807BB71DE
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 16:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4346487052
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41051FDE01;
	Fri,  3 Oct 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lfl21iMe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XA88JfIT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lfl21iMe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XA88JfIT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3261FDE39
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500308; cv=none; b=CBQ8dOlu61BXc5+dkgbJ562yCBM0pVw/EdXz5Crjsi0EdPGQOlCGVn4NWJvGtyRQtP2/DwzI/DVKieQ6OG6MtWyak9EEZE12EKe7jmgvCHvubZGoLBJ4m+7QGejcTs3+vlI/nwmJKFnQotixCzX0lYP++5Rp8JTi5YyjZhq7zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500308; c=relaxed/simple;
	bh=eqLSZhYieTaSO98Y+ewn2PsjonmLLH63gdJmrOfK8Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGGxjlkzpfdZMUx84fj3iTUvCzhTYkK15NS5HmfTrZu8C8FWulHeTAiqdLTUpin/ZgMswIipoGgHboAXzONLmS7YvQwBYt5D6l3sNjUDJX5F7108a8tlNjYgBwS3wg7vPK7Ec2zx8+GueKqJ+io7vT3a/9Qi2wXvwhChd2O4Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lfl21iMe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XA88JfIT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lfl21iMe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XA88JfIT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B48F3369C;
	Fri,  3 Oct 2025 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759500297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YpYYO0WBQtFMfWk/eRAGiKMSyw4qTIIMBy/MJIROsA=;
	b=Lfl21iMeOXn9an/HNoczt8yAM7N6QlUDuUmND2LaXT4q44WYxSnEOPNOriKBMF9OTY45VD
	swOKCcEvBwOSXbI7J8ANiK0KNAGQYz7bF+bfruMp8b5zQ5Reh9RFwkI616rKveeE0VT86x
	9NPib4BxxiitGJFUH4jnHQn5c1Q+dYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759500297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YpYYO0WBQtFMfWk/eRAGiKMSyw4qTIIMBy/MJIROsA=;
	b=XA88JfIT6APbj4/v46502XbSA4Hl+UJMJrnkQ9gDNvHARPrj9sfvoCqrVzXqZ6RBTKsF9z
	O180MpyW5JA2xBCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lfl21iMe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XA88JfIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759500297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YpYYO0WBQtFMfWk/eRAGiKMSyw4qTIIMBy/MJIROsA=;
	b=Lfl21iMeOXn9an/HNoczt8yAM7N6QlUDuUmND2LaXT4q44WYxSnEOPNOriKBMF9OTY45VD
	swOKCcEvBwOSXbI7J8ANiK0KNAGQYz7bF+bfruMp8b5zQ5Reh9RFwkI616rKveeE0VT86x
	9NPib4BxxiitGJFUH4jnHQn5c1Q+dYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759500297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YpYYO0WBQtFMfWk/eRAGiKMSyw4qTIIMBy/MJIROsA=;
	b=XA88JfIT6APbj4/v46502XbSA4Hl+UJMJrnkQ9gDNvHARPrj9sfvoCqrVzXqZ6RBTKsF9z
	O180MpyW5JA2xBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB30513AAD;
	Fri,  3 Oct 2025 14:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yo1oMgfY32jrTgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 03 Oct 2025 14:04:55 +0000
Date: Fri, 3 Oct 2025 15:04:50 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, clameter@sgi.com, kravetz@us.ibm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, kernel_team@skhynix.com, 
	harry.yoo@oracle.com, gwan-gyeong.mun@intel.com, yeoreum.yun@arm.com, 
	syzkaller@googlegroups.com, ysk@kzalloc.com, Matthew Wilcox <willy@infradead.org>, 
	linux-ext4@vger.kernel.org
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <dglxbwe2i5ubofefdxwo5jvyhdfjov37z5jzc5guedhe4dl6ia@pmkjkec3isb4>
References: <20251002081612.53281-1-byungchul@sk.com>
 <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a586b5b-c47f-45eb-83c8-1e86431fc83d@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4B48F3369C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sk.com,linux-foundation.org,nvidia.com,intel.com,gmail.com,gourry.net,linux.alibaba.com,sgi.com,us.ibm.com,kvack.org,vger.kernel.org,skhynix.com,oracle.com,arm.com,googlegroups.com,kzalloc.com,infradead.org];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -2.51

(Adding ext4 list to CC)

On Thu, Oct 02, 2025 at 01:38:59PM +0200, David Hildenbrand wrote:
> > To simplify the scenario:
> > 
> 
> Just curious, where is the __folio_start_writeback() to complete the
> picture?
> 
> >     context X (wq worker)	context Y (process context)
> > 
> > 				migrate_pages_batch()
> >     ext4_end_io_end()		  ...
> >       ...			  migrate_folio_unmap()
> >       ext4_get_inode_loc()	    ...
> >         ...			    folio_lock() // hold the folio lock
> >         bdev_getblk()		    ...
> >           ...			    folio_wait_writeback() // wait forever
> >           __find_get_block_slow()
> >             ...			    ...
> >             folio_lock() // wait forever
> >             folio_unlock()	  migrate_folio_undo_src()
> > 				    ...
> >       ...			    folio_unlock() // never reachable
> >       ext4_finish_bio()
> > 	...
> > 	folio_end_writeback() // never reachable
> > 
> 
> But aren't you implying that it should from this point on be disallowed to
> call folio_wait_writeback() with the folio lock held? That sounds ... a bit
> wrong.
> 
> Note that it is currently explicitly allowed: folio_wait_writeback()
> documents "If the folio is not locked, writeback may start again after
> writeback has finished.". So there is no way to prevent writeback from
> immediately starting again.
> 
> In particular, wouldn't we have to fixup other callsites to make this
> consistent and then VM_WARN_ON_ONCE() assert that in folio_wait_writeback()?
> 
> Of course, as we've never seen this deadlock before in practice, I do wonder
> if something else prevents it?

As far as I can tell, the folio under writeback and the folio that
__find_get_block() finds will _never_ be the same. ext4_end_io_end() is
called for pages in an inode's address_space, and bdev_getblk() is called for
metadata blocks in block cache. Having an actual deadlock here would mean
that the folio is somehow both in an inode's address_space, and in the block
cache, I think? Also, AFAIK there is no way a folio can be removed from the
page cache while under writeback.

In any case, I added linux-ext4 so they can tell me how right/wrong I am.

-- 
Pedro

