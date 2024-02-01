Return-Path: <linux-ext4+bounces-1056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326284566E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D11F2289C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABF12CDB4;
	Thu,  1 Feb 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pinzLHWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnggnc1M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pinzLHWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnggnc1M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519315CD4F;
	Thu,  1 Feb 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787978; cv=none; b=sSVC3b+l2To/IktB5qgAots1I1qwrgs+wDn2l8fpjRVyFjoQ9i3nLwYkWrA1PJbyPIXwaiRDInh3Kl+M/Fbo2Uh175r2QQbi4F69QFTcH+M3ilF6CbExH8PY197acZ0McaYxMg07uBJnwlRWemblxkGs9+gVtG6iAYp7wr1kla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787978; c=relaxed/simple;
	bh=dyKu5gOYG3cW5DXvumuesAjji+Qtsbt9OWZDBgfLJqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T298njXX6WlMTD55aKoHFmsad3VZH+tRpb/6QAFabPns6Oa+rxmY3HuGFk14ZEh+taL0vlqukIyXwzk1ptmUWjTG1g2ictPVXjjOjKC23ydsiftkpmFGWidyN0CIi8bgmHVsk15TCvsFmIqyGryyqP3L3AkGqUp8HOnF0NNyd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pinzLHWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnggnc1M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pinzLHWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnggnc1M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82CC31FD10;
	Thu,  1 Feb 2024 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706787974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhi8t6NDbG3WnRa+lrhzLoNDE+1STw2ZJvyqnqre/Ew=;
	b=pinzLHWf1il9zaWdKxJkCHCBr7aivvFibDksAUlodXEo41flY61nY0P4kYe0CYq0wRKXCb
	OspTgEi3WvETNKDWQu19lIIqL7e/66KyDZpxM6pReNXATKbdtrZYWmbxxSBD2jiSCaUo5+
	1Acr8Tp1EHnJIfeUbPM6Yx4Watfhx2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706787974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhi8t6NDbG3WnRa+lrhzLoNDE+1STw2ZJvyqnqre/Ew=;
	b=lnggnc1MoaFNuSxrKNE2CoZOyW5RR4F5jYb9k4H1XgS3OW/Bq/x0SYVqDlMIS8LJ9uLSY2
	Xx8wcEfwpI4VHCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706787974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhi8t6NDbG3WnRa+lrhzLoNDE+1STw2ZJvyqnqre/Ew=;
	b=pinzLHWf1il9zaWdKxJkCHCBr7aivvFibDksAUlodXEo41flY61nY0P4kYe0CYq0wRKXCb
	OspTgEi3WvETNKDWQu19lIIqL7e/66KyDZpxM6pReNXATKbdtrZYWmbxxSBD2jiSCaUo5+
	1Acr8Tp1EHnJIfeUbPM6Yx4Watfhx2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706787974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhi8t6NDbG3WnRa+lrhzLoNDE+1STw2ZJvyqnqre/Ew=;
	b=lnggnc1MoaFNuSxrKNE2CoZOyW5RR4F5jYb9k4H1XgS3OW/Bq/x0SYVqDlMIS8LJ9uLSY2
	Xx8wcEfwpI4VHCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72DAE13672;
	Thu,  1 Feb 2024 11:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5MGHIaEu2VqKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 11:46:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B371A0809; Thu,  1 Feb 2024 12:46:14 +0100 (CET)
Date: Thu, 1 Feb 2024 12:46:14 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@kernel.org
Subject: Re: [PATCH] ext4: correct best extent lstart adjustment logic
Message-ID: <20240201114614.4jkvi2c6buuovsj7@quack3>
References: <20240122123332.555370-1-libaokun1@huawei.com>
 <20240131124636.gmxaiex6yqrhvxcj@quack3>
 <3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com>
 <Zbt7setS4c/Q4fyv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt7setS4c/Q4fyv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pinzLHWf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lnggnc1M
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[huawei.com,suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 82CC31FD10
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hi guys!

On Thu 01-02-24 16:38:33, Ojaswin Mujoo wrote:
> Thanks for the CC, I somehow missed this patch.
> 
> As described in the discussion Jan linked [1] , there is a known bug in the
> normalize code (which i should probably get back to now ) where we sometimes
> end up with a goal range which doesn't completely cover the original extent and
> this was causing issues when we tried to cover the complete original request in
> the PA window adjustment logic. That and to minimize fragmentation, we ended up
> going with the logic we have right now.
> 
> In short, I agree that in the example Baokun pointed out, it is not
> optimal to have to make an allocation request twice when we can get it in
> one go.
> 
> I also think Baokun is correct that if keeping the best extent at the end
> doesn't cover the original start, then any other case should not lead to
> it overflowing out of goal extent, including the case where original
> extent is overflowing goal extent.

Right, it was not obvious to me yesterday but when I've now reread how the
normalization shifts the goal window, it is obvious.

> So, as mentioned, it boils down to a trade off between multiple allocations and slightly 
> increased fragmentation. iiuc preallocations are anyways dropped when the file closes
> so I think it shouldn't hurt too much fragmentation wise to prioritize less
> allocations. What are your thoughts on this Jan, Baokun?

OK, I'm fine with the Baokun's change if we remove the problematic BUG_ON.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

