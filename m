Return-Path: <linux-ext4+bounces-3685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7BF94D405
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DF4B20E46
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62B198A3D;
	Fri,  9 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpQ+b9OA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkQ39kvl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpQ+b9OA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkQ39kvl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E102168B8;
	Fri,  9 Aug 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218917; cv=none; b=Q3/va6wfCC2kTuUSlZEMcdMJFyMnPc0EKAKV9Dq+9ucKXEDgHTIgnSxEUq0HpkbEcVFz/Lwd6s+dMvMl+n1PByrgcsXeHeCO+pDCtEOXZQqGs5sSg1Ot8ufr2hMW2kv+lCt+bEBcxHXnH+R5OEIej4vpGOBEKggqD1PqwpvXC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218917; c=relaxed/simple;
	bh=K998szMebXw+wiKMQrAzHK1blG5e7UVa5gHFuMwOoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFPLaJ13xIBzewf2pgOUbN/4/K2yL7U6X2rU/TGKCwOIE9OzUDH0DLbqCqnOO2LQFV2GnaSdhUMA8dFUn/SUZwWZ3GpyD6wY8fLpF4T7xA2k42wTy0xH+Z869VhkAV2LYLg685SU8Ea2U4qduqMRiOehjCBKW/G7KsrdE7JIpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpQ+b9OA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkQ39kvl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpQ+b9OA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkQ39kvl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DB281FF9B;
	Fri,  9 Aug 2024 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723218913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e85hNo6ni4A5wp+GZGW17HDhN1ds6aKku/DzMvBRVxk=;
	b=TpQ+b9OAoa5ikzu6Ij7UDN2K8PR77z4mqW1+q+SLqnHwHpQyCgw1/cF4/E650o5+mMUukX
	WJvutI3vqhYgewclGZazlMhpHS0yXQXtg8BoFk1J5W6SNnYLeidxklrNiKoOoi4pc6TLOv
	MOD0rvtQcLoH6e3+aA7D6ovow4Dfm7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723218913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e85hNo6ni4A5wp+GZGW17HDhN1ds6aKku/DzMvBRVxk=;
	b=pkQ39kvlWu8uxmH6YmEzl4Yrdni4UOPnjpYDTsTrZr6JvvwE4iltxCuiIBXGH6uzI3P8pY
	feMNvvTTqWbI0lDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723218913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e85hNo6ni4A5wp+GZGW17HDhN1ds6aKku/DzMvBRVxk=;
	b=TpQ+b9OAoa5ikzu6Ij7UDN2K8PR77z4mqW1+q+SLqnHwHpQyCgw1/cF4/E650o5+mMUukX
	WJvutI3vqhYgewclGZazlMhpHS0yXQXtg8BoFk1J5W6SNnYLeidxklrNiKoOoi4pc6TLOv
	MOD0rvtQcLoH6e3+aA7D6ovow4Dfm7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723218913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e85hNo6ni4A5wp+GZGW17HDhN1ds6aKku/DzMvBRVxk=;
	b=pkQ39kvlWu8uxmH6YmEzl4Yrdni4UOPnjpYDTsTrZr6JvvwE4iltxCuiIBXGH6uzI3P8pY
	feMNvvTTqWbI0lDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE6813A7D;
	Fri,  9 Aug 2024 15:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rZi+EuE7tmYrLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 15:55:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A55C4A084B; Fri,  9 Aug 2024 17:55:08 +0200 (CEST)
Date: Fri, 9 Aug 2024 17:55:08 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [RFC PATCH] jbd2: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240809155508.taxgdkwuvsbg3i2k@quack3>
References: <20240720062356.2522658-1-zhangshida@kylinos.cn>
 <20240806134023.rm2ggd7swopryqci@quack3>
 <CANubcdV32L71ARCznZgKdrt0BmSyOYwW50L17zP=TG4PO2MH4Q@mail.gmail.com>
 <20240807120659.y6cpxas5g3mze2rr@quack3>
 <CANubcdVHbbq=WsTXU4EWAUPUby5--CLe5rf1GPzNPv+Y0a9VzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdVHbbq=WsTXU4EWAUPUby5--CLe5rf1GPzNPv+Y0a9VzQ@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 08-08-24 11:05:26, Stephen Zhang wrote:
> Jan Kara <jack@suse.cz> 于2024年8月7日周三 20:07写道：
> > So I agree with your analysis now. But still don't like adding hacks to
> > jbd2 to acommodate for this oddity of data=journal mode. Since we already
> > have ext4_block_write_begin() implementation anyway, we should be able to
> > tweak it to do the right thing for data=journal mode inodes...
> >
> > So we could replace uses of __block_write_begin() with
> > ext4_block_write_begin() and then call do_journal_get_write_access() in
> > ext4_block_write_begin() for inodes with journalled data after the buffer
> > is mapped with get_block().
> >
> > From the part:
> >                                 if (folio_test_uptodate(folio)) {
> >                                         clear_buffer_new(bh);
> >                                         set_buffer_uptodate(bh);
> >                                         mark_buffer_dirty(bh);
> >                                         continue;
> >                                 }
> >
> > we can actually remove the clear_buffer_new() and mark_buffer_dirty() bits
> > because they will be done by block_commit_write() or
> > folio_zero_new_buffers() and they are superfluous and somewhat odd here
> > anyway.
> >
> > And the call to folio_zero_new_buffers() from ext4_block_write_begin()
> > needs to call ext4_journalled_zero_new_buffers() for inodes where data is
> > journalled.
> >
> > Will you try to implement this or should I look into it?
> >
> 
> Yeah, Thank you for giving me the opportunity to work on something truly
> meaningful. All I can do until now is some small cleanups. And doing cleanups
> all the time is annoyable to the maintainers and frustrating to me. I
> will try my best.
> 
> So basically, we should:
> 1.Trace the user data dirting in ext4_block_write_begin().
> 2.Replace the uncontrollable __block_write_begin with ext4_block_write_begin().
> 3.Remove some superfluous things.

Yes. In the first patch, I'd convert all uses of __block_write_begin() to
ext4_block_write_begin(). In the second patch I'd replace
folio_zero_new_buffers() with ext4_journalled_zero_new_buffers() if inode
has journalled data (with explanation to avoid unexpected dirtying). In the
third patch I'd remove the clear_buffer_new() and mark_buffer_dirty()
mentioned above with explanation that either folio_zero_new_buffers() or
block_commit_write() take care of dirtying the buffer properly. Thanks for
working on this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

