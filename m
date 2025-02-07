Return-Path: <linux-ext4+bounces-6385-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649BFA2C317
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53248188480A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC61E00A0;
	Fri,  7 Feb 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ze8c+jAs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QucHp0Yu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ze8c+jAs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QucHp0Yu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2CF2417C9
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932859; cv=none; b=tMT32sFATsZAZ+y11Q7j25/eiR9i39JR1awGCUNm0CICriRmne/UF46OWGbHBmHgwIUlc5ygvOuWJXsVc86VbjHqLIlXz//4At2jriSBV40LewNFnjeNACgR1kvq8E4qQ3H8szFRMccn7ip8zw+V5uDni4+3x6dfyqTHLTzZaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932859; c=relaxed/simple;
	bh=kDXhm36IznT/yFDUMEWFgJ9rLeUAlQW3x2AckSIRw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHbYbXztT4t3TJ4kxrzHDpLu5U0NEav7ZuAQ1TMmwfB73c7Df5uZPOYtS9IUiKhVOGpcP7CspDpOXJGDwaDf8HgISM+/KA7jKf8W5FY+isxiFX1wcYs1KZHdFJpw++G+9x8vTlmY53ysVoTn6ApgAQ5Dz6213Xi3FZWJXEkkzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ze8c+jAs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QucHp0Yu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ze8c+jAs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QucHp0Yu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 432452116E;
	Fri,  7 Feb 2025 12:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738932854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnSy491XrR6QBGRZx7DDhxfABuS1lS4Jrzmcwk0aJO0=;
	b=Ze8c+jAsQYyV07cEz3pwJ91WUgowqDnz8lYcFMY6U1RsUBQbBTkN7M+nPvr9Eqrc4q30Ok
	C7OgOGn1ije4bE3L2kynPHyidjvYcktclHhil27ZURkaxBuxuGltvxv33kxbsgCd2WPMcz
	ikJrYEO+Kd9zw2wFL1eAp5Ni+1FHRxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738932854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnSy491XrR6QBGRZx7DDhxfABuS1lS4Jrzmcwk0aJO0=;
	b=QucHp0Yuj58qwg9raxrGKn+LD1M1CAY/prUJuFcioGr4MQ2v9MX8pztL6WGoNFqZLQ21cY
	sg9QC/6yep4EXEDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ze8c+jAs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QucHp0Yu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738932854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnSy491XrR6QBGRZx7DDhxfABuS1lS4Jrzmcwk0aJO0=;
	b=Ze8c+jAsQYyV07cEz3pwJ91WUgowqDnz8lYcFMY6U1RsUBQbBTkN7M+nPvr9Eqrc4q30Ok
	C7OgOGn1ije4bE3L2kynPHyidjvYcktclHhil27ZURkaxBuxuGltvxv33kxbsgCd2WPMcz
	ikJrYEO+Kd9zw2wFL1eAp5Ni+1FHRxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738932854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnSy491XrR6QBGRZx7DDhxfABuS1lS4Jrzmcwk0aJO0=;
	b=QucHp0Yuj58qwg9raxrGKn+LD1M1CAY/prUJuFcioGr4MQ2v9MX8pztL6WGoNFqZLQ21cY
	sg9QC/6yep4EXEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38A95139CB;
	Fri,  7 Feb 2025 12:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DwTQDXYCpmePHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 12:54:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3D9FA28E7; Fri,  7 Feb 2025 13:54:13 +0100 (CET)
Date: Fri, 7 Feb 2025 13:54:13 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: Verify fast symlink length
Message-ID: <24k77s6puqfnzyj3h4yagfyxln777ejohc56xpfll3n7yjziap@lkyoqk725rx6>
References: <20250206094454.20522-2-jack@suse.cz>
 <20250206152419.GB1130956@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206152419.GB1130956@mit.edu>
X-Rspamd-Queue-Id: 432452116E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[48a99e426f29859818c0];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 06-02-25 10:24:19, Theodore Ts'o wrote:
> On Thu, Feb 06, 2025 at 10:44:55AM +0100, Jan Kara wrote:
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 7c54ae5fcbd4..64e280fed911 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> >  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
> >  		} else if (ext4_inode_is_fast_symlink(inode)) {
> >  			inode->i_op = &ext4_fast_symlink_inode_operations;
> > -			nd_terminate_link(ei->i_data, inode->i_size,
> > -				sizeof(ei->i_data) - 1);
> > +			if (inode->i_size == 0 ||
> > +			    inode->i_size >= sizeof(ei->i_data) ||
> > +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> > +								inode->i_size) {
> > +				ext4_error_inode(inode, function, line, 0,
> > +					"invalid fast symlink length %llu",
> > +					 (unsigned long long)inode->i_size);
> > +				ret = -EFSCORRUPTED;
> > +				goto bad_inode;
> > +			}
> >  			inode_set_cached_link(inode, (char *)ei->i_data,
> >  					      inode->i_size);
> 
> 
> I don't think this will do the right thing if the fast symlink is
> encrypted.  See ext4_encrypted_get_link() in fs/ext4/symlink.c in the
> kernel sources, and also look at how e2fsck_pass1_check_symlink()
> handles checking the size of an encrypted, fast symlink.

Thanks for having a look but as Eric writes, there's:

                if (IS_ENCRYPTED(inode)) {
                        inode->i_op = &ext4_encrypted_symlink_inode_operations;
		} else if (ext4_inode_is_fast_symlink(inode)) {

just above the context of this hunk so I *think* encrypted symlinks cannot
get into this code?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

