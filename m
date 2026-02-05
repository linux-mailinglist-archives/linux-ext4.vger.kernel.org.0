Return-Path: <linux-ext4+bounces-13541-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI/6ATJkhGkK2wMAu9opvQ
	(envelope-from <linux-ext4+bounces-13541-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 10:34:42 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08261F0D8D
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FCE30CC4A1
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6ED3921CE;
	Thu,  5 Feb 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0atXNMF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MF15H2FN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0atXNMF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MF15H2FN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887E3921D1
	for <linux-ext4@vger.kernel.org>; Thu,  5 Feb 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283545; cv=none; b=V8wS3cPCenWOf6TiJ47I0rX+fAcdnPnR15g+ILTdiQXAloVYUVrbQV+JrXbyafcLlrF99eNM21VrXXM529WSeWrwv3TZUkfCHczvaOUhoqWgdXnvkamS06eXZfgdq6VKreHK4Ob1C3lj3L4i6x1Qo+oq9dBVDeVWNQrkjhmCdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283545; c=relaxed/simple;
	bh=KTapkWoXB2jtTdohE4dGoz3tDJTQ8fsIDd1XB1/S+0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q28JqoHgzIqJwAiegZTF0QX0c3Jz033lAZad/HE4FVgi8gf7kRGCzxgnKkgtKIwzkghwyQZGsnxsSl1BhJ8iCKBTlTFSDpU+grFAzETaCBoID8jh4b3HoZV2v6ZjbAcSsdmiFIXo/DeTYySwori5SgAratRU9FIn0xS/jmbH6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0atXNMF6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MF15H2FN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0atXNMF6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MF15H2FN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0D8B5BD9F;
	Thu,  5 Feb 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770283543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APdaobgvIXoTN9naCopRVTV+3nTDAdXaYQ3C4AfX44w=;
	b=0atXNMF6XUoVmfNVI0MiyzdSla5IHS7YZX9vH6zLPyuMkIgfMhJg3y1+d/P54MuBoxfs1j
	+eiivWOL2nm1hi51sbbHffYnyZ9fUvH88dg/yvInQmAkiRwBsXdmcbK+Z6556bUFIBvpQb
	q2UoiJipjYmn1ghRNq6pLVNQ/Q+7AN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770283543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APdaobgvIXoTN9naCopRVTV+3nTDAdXaYQ3C4AfX44w=;
	b=MF15H2FNPPMVYGb/pwnrCwym2mXQ9hTG5tFI6wzPHpR8a+Z8ovXXgqJ0/I9gEaEPU7xdJC
	0JXHVFnEESQCa6Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770283543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APdaobgvIXoTN9naCopRVTV+3nTDAdXaYQ3C4AfX44w=;
	b=0atXNMF6XUoVmfNVI0MiyzdSla5IHS7YZX9vH6zLPyuMkIgfMhJg3y1+d/P54MuBoxfs1j
	+eiivWOL2nm1hi51sbbHffYnyZ9fUvH88dg/yvInQmAkiRwBsXdmcbK+Z6556bUFIBvpQb
	q2UoiJipjYmn1ghRNq6pLVNQ/Q+7AN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770283543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APdaobgvIXoTN9naCopRVTV+3nTDAdXaYQ3C4AfX44w=;
	b=MF15H2FNPPMVYGb/pwnrCwym2mXQ9hTG5tFI6wzPHpR8a+Z8ovXXgqJ0/I9gEaEPU7xdJC
	0JXHVFnEESQCa6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE2833EA63;
	Thu,  5 Feb 2026 09:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N6aCKhdihGlzUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 09:25:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72928A09D8; Thu,  5 Feb 2026 10:25:39 +0100 (CET)
Date: Thu, 5 Feb 2026 10:25:39 +0100
From: Jan Kara <jack@suse.cz>
To: Gerald Yang <gerald.yang@canonical.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, gerald.yang.tw@gmail.com
Subject: Re: [PATCH] ext4: Fix call trace when remounting to read only in
 data=journal mode
Message-ID: <tmtgzmvkfag4r6lbt4i2ej5ad3bfudezcm35l27ybit25r7l4d@5o2i4cuymh5j>
References: <20260128074515.2028982-1-gerald.yang@canonical.com>
 <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
 <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
 <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
 <CAMsNC+ve3dRwT1xGWB0pvBJXqBpeksf7PgbEeihcnfs=AmwVRQ@mail.gmail.com>
 <gluj62pw5pu7ag2juf5ejwsr3ghvckag7wh4zunwyk57slcrmg@42of57gybigz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gluj62pw5pu7ag2juf5ejwsr3ghvckag7wh4zunwyk57slcrmg@42of57gybigz>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13541-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 08261F0D8D
X-Rspamd-Action: no action

On Tue 03-02-26 15:50:43, Jan Kara wrote:
> Hello,
> 
> On Fri 30-01-26 19:38:55, Gerald Yang wrote:
> > Thanks for sharing the findings, I'd also like to share some findings:
> > I tried to figure out why the buffer is dirty after calling sync_filesystem,
> > in mpage_prepare_extent_to_map, first I printed folio_test_dirty(folio):
> > 
> > while (index <= end)
> >     ...
> >     for (i = 0; i < nr_folios; i++) {
> >         ...
> >         (print if folio is dirty here)
> > 
> > and actually all folios are clean:
> > if (!folio_test_dirty(folio) ||
> >     ...
> >     folio_unlock(folio);
> >     continue;       <==== continue here without writing anything
> > 
> > Because the call trace happens before going into the above while loop:
> > 
> > if (ext4_should_journal_data(mpd->inode)) {
> >     handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
> > 
> > it checks if the file system is read only and dumps the call trace in
> > ext4_journal_check_start, but it doesn't check if there are any real writes
> > that will happen later in the loop.
> > 
> > To confirm this, first I added 2 more lines in the reproduce script before
> > remounting read only:
> > sync      <==== it calls ext4_sync_fs to flush all dirty data same as what's
> >                          called during remount read only
> > echo 1 > /proc/sys/vm/drop_caches       <==== drop clean page cache
> > mount -o remount,ro ext4disk mnt
> > 
> > Then I can no longer reproduce the call trace.
> 
> OK, but ext4_do_writepages() has a check at the beginning:
> 
>         if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>                 goto out_writepages;
> 
> So if there are no dirty pages, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)
> should be false and so we shouldn't go further?
> 
> It all looks like some kind of a race because I'm not always able to
> reproduce the problem... I'll try to look more into this.

OK, the race is with checkpointing code writing the buffers while flush
worker tries to writeback the pages. I've posted a patch which fixes the
issue for me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

