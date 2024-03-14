Return-Path: <linux-ext4+bounces-1631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3687BB90
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749F1284B5F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133246E2BE;
	Thu, 14 Mar 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vg7qfZZ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgHc6rwr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vg7qfZZ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgHc6rwr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894865DF26
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413708; cv=none; b=eSI0qRB/RY3OAH/mKWYwU8xs9uvE/B6LaO+Ttj4lT4LvkKxGgRhgNhv1c8/sYDRssMkDZgYj7/sSUepricZx4sNxMN382Pe9HnAns7ooRdjBfHVI68nbrSV6B+wYDCl8hHIxZ2oiJnGOG42zL9EJQnDKqwn9alP7Akq0xAJZnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413708; c=relaxed/simple;
	bh=yIbycwJkbRtKyWHReoJK3UkPNvgRTqYTNq/2Wc65d7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5yz+4RejZeoa2MypgaNvLxcC3yjKkWoF6x+z5Mn2pb8ROjv7Ydt8FOHfPaccV52989MaYfna1iT1M59hiIoeO2Qxcmcshkb6iNQ6yLLmzBc2oyNvdBl+JkON7HVXg+t1LVyUnnqOWke1UFkrdoOyZHQrHBygM9WRBHY+aJd4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vg7qfZZ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgHc6rwr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vg7qfZZ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgHc6rwr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F81021D1F;
	Thu, 14 Mar 2024 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710413704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVNtfbvyZZjSAdzas2UiqJnAS4+dfM1EV/3oqN8ocsk=;
	b=vg7qfZZ5Y3Xdsl/oxE5ksKmkde/y0+fY3iGPpvddT5u+iwbFfue6s6Nhh4m9wtrHWXyiz9
	yXGBvxQHCFmx22XxfYe+J8A1ggO0+qmBKO8nNdv/8FMkFEsk1QgcoCJiQZeL7b/yeJ4iq0
	Vo6zgVctJ2jxogbpCBThd1EydnOpHyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710413704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVNtfbvyZZjSAdzas2UiqJnAS4+dfM1EV/3oqN8ocsk=;
	b=lgHc6rwr9rOqL4Nd8Au5i+V8OavNW9z43R+Y4xUt3VvzpsHjRRasmHhUcBxuUcSMWmKfEA
	iBHdpaFyh9nQQ8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710413704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVNtfbvyZZjSAdzas2UiqJnAS4+dfM1EV/3oqN8ocsk=;
	b=vg7qfZZ5Y3Xdsl/oxE5ksKmkde/y0+fY3iGPpvddT5u+iwbFfue6s6Nhh4m9wtrHWXyiz9
	yXGBvxQHCFmx22XxfYe+J8A1ggO0+qmBKO8nNdv/8FMkFEsk1QgcoCJiQZeL7b/yeJ4iq0
	Vo6zgVctJ2jxogbpCBThd1EydnOpHyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710413704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVNtfbvyZZjSAdzas2UiqJnAS4+dfM1EV/3oqN8ocsk=;
	b=lgHc6rwr9rOqL4Nd8Au5i+V8OavNW9z43R+Y4xUt3VvzpsHjRRasmHhUcBxuUcSMWmKfEA
	iBHdpaFyh9nQQ8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95F4A1386E;
	Thu, 14 Mar 2024 10:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IrqXJIjX8mXjVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:55:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42497A07D9; Thu, 14 Mar 2024 11:55:00 +0100 (CET)
Date: Thu, 14 Mar 2024 11:55:00 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: do not create EA inode under buffer lock
Message-ID: <20240314105500.nalegmszhrs7hwsn@quack3>
References: <6e5f8a70-1cba-41fa-98f3-2ef3bcc29017@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5f8a70-1cba-41fa-98f3-2ef3bcc29017@moroto.mountain>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vg7qfZZ5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lgHc6rwr
X-Spamd-Result: default: False [-2.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.22)[96.30%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.03
X-Rspamd-Queue-Id: 9F81021D1F
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hello!

On Tue 27-02-24 12:17:11, Dan Carpenter wrote:
> The patch ea554578483b: "ext4: do not create EA inode under buffer
> lock" from Feb 9, 2024 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	fs/ext4/xattr.c:2265 ext4_xattr_ibody_set()
> 	warn: duplicate check 'error' (previous on line 2255)
> 
> fs/ext4/xattr.c
>     2232 int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
>     2233                                 struct ext4_xattr_info *i,
>     2234                                 struct ext4_xattr_ibody_find *is)
>     2235 {
>     2236         struct ext4_xattr_ibody_header *header;
>     2237         struct ext4_xattr_search *s = &is->s;
>     2238         struct inode *ea_inode = NULL;
>     2239         int error;
>     2240 
>     2241         if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
>     2242                 return -ENOSPC;
>     2243 
>     2244         /* If we need EA inode, prepare it before locking the buffer */
>     2245         if (i->value && i->in_inode) {
>     2246                 WARN_ON_ONCE(!i->value_len);
>     2247 
>     2248                 ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
>     2249                                         i->value, i->value_len);
>     2250                 if (IS_ERR(ea_inode))
>     2251                         return PTR_ERR(ea_inode);
>     2252         }
>     2253         error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>     2254                                      false /* is_block */);
>     2255         if (error) {
>                      ^^^^^
> 
>     2256                 if (ea_inode) {
>     2257                         int error2;
>     2258 
>     2259                         error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
>     2260                         if (error2)
>     2261                                 ext4_warning_inode(ea_inode, "dec ref error=%d",
>     2262                                                    error2);
>     2263 
>     2264                         /* If there was an error, revert the quota charge. */
> --> 2265                         if (error)
>                                      ^^^^^
> We know "error" is non-zero.  I'm not sure whether to delete this check
> or change "error" to "error2".

Deleting the check is the right solution. The patch didn't go upstream in
the end anyway for now because it has some functional issues but I've fixed
this up locally. Thanks for report!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

