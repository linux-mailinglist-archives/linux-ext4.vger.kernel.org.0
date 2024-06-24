Return-Path: <linux-ext4+bounces-2937-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7099154D1
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 18:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D9DB219FC
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44319E7F2;
	Mon, 24 Jun 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XE4eOXYH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H6Z99u4e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XE4eOXYH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H6Z99u4e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76B2F24;
	Mon, 24 Jun 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248034; cv=none; b=mzR/2NhoDf+Stfsnd89TZ4mT+MyUrJXaH230EkFWiauW3SXw8O6a1rFH3KgkMczcBZX4X6aD2zjjOl5NvXgBjKqJuuw9Lu1XSANN8MjGXVxoVbP7zbmd5HX/TBElQFIVGFV7bwiQ00bjgROhVVL91jj62SJaDjDT7RAdoS8WH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248034; c=relaxed/simple;
	bh=HwZd8EBFezechcjlh/DZYRg80NRaVK6S2q4FyzxMzcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtoOMy+p0WczX95Zh6aWEK7OxGVVGv1CG1mgjvd2a7edpLRedjfZoLc5VZI2vWQRJdEjrUFkvcnyjx/WV6pAODBOgEwVkrFaXYpIplyPbIH1s4g5x7xeTcMCuD6qm4JmNMiUxKjnGRvpO/WXwqYxeRGpWhXXAmaj16fQCdG803o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XE4eOXYH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H6Z99u4e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XE4eOXYH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H6Z99u4e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28AE71F7D1;
	Mon, 24 Jun 2024 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TWOup02Yc3C8yKWXbJzQeMjL6ZnMIgYxFd9eout+Yo=;
	b=XE4eOXYHStl8Tl3femccYkSxHa9Zcha3fhJVHn2af+WSgAZfr9haAx6vVeOH/FwWPpYnpS
	sEVmlZw6JfNa7Ai26JvZJi5qx2lm4/vjLLCR5B5+Qyj5w9SrLeXtQudKTSjCJaTijLFh++
	ihVH77zg8qHMwzZmWyT2GG7cGdUFwKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TWOup02Yc3C8yKWXbJzQeMjL6ZnMIgYxFd9eout+Yo=;
	b=H6Z99u4eAVmEjrkNrvVcnGYn0ErthfE8vW3k8VG8LRLeQBjjNaA62CMkAZ5x2+VduEPUUC
	w2eVp+muxTn6L6Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XE4eOXYH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H6Z99u4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TWOup02Yc3C8yKWXbJzQeMjL6ZnMIgYxFd9eout+Yo=;
	b=XE4eOXYHStl8Tl3femccYkSxHa9Zcha3fhJVHn2af+WSgAZfr9haAx6vVeOH/FwWPpYnpS
	sEVmlZw6JfNa7Ai26JvZJi5qx2lm4/vjLLCR5B5+Qyj5w9SrLeXtQudKTSjCJaTijLFh++
	ihVH77zg8qHMwzZmWyT2GG7cGdUFwKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TWOup02Yc3C8yKWXbJzQeMjL6ZnMIgYxFd9eout+Yo=;
	b=H6Z99u4eAVmEjrkNrvVcnGYn0ErthfE8vW3k8VG8LRLeQBjjNaA62CMkAZ5x2+VduEPUUC
	w2eVp+muxTn6L6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9AA1384C;
	Mon, 24 Jun 2024 16:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YeU8Bp+keWaTNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 16:53:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3325A08AA; Mon, 24 Jun 2024 18:53:50 +0200 (CEST)
Date: Mon, 24 Jun 2024 18:53:50 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext4 resize2fs on-line resizing panic
Message-ID: <20240624165350.madyxs74vx3niyy2@quack3>
References: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
 <20240624152658.GC280025@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624152658.GC280025@mit.edu>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 28AE71F7D1
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 24-06-24 11:26:58, Theodore Ts'o wrote:
> On Sun, Jun 23, 2024 at 06:57:13PM -0700, Alexander Coffin wrote:
> > [1.] One line summary of the problem:
> > Using resize2fs on-line resizing on a specific ext4 partition is
> > causing an Oops.
> > 
> > 
> > [6.] Output of Oops.. message (if applicable) with symbolic information
> >      resolved (see Documentation/admin-guide/bug-hunting.rst)
> > 
> > ```
> > [  445.552287] ------------[ cut here ]------------
> > [  445.552300] kernel BUG at fs/jbd2/journal.c:846!
> 
> Thanks for the bug report.  The BUG_ON is from the following assert in
> jbd2_journal_next_log_block:
> 
> 	J_ASSERT(journal->j_free > 1);
> 
> and it indicates that we ran out of space in the journal.  There are
> mechanisms to make sure that this should never happen, and if the
> journal is too small and the transaction couldn't be broken up, then
> the operation (whether it is a resize or a file truncate or some other
> operation) should have errored out, and not triggered a BUG.

Yeah, I was debugging this today and I'll shortly send a fix for JBD2 so
that we don't trigger this BUG. But the online resize will fail anyway
after my fixes (just gracefully) because the add_flex_bg() code tries to
start a transaction with more credits than the journal allows.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

