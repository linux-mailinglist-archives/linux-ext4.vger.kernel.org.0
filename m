Return-Path: <linux-ext4+bounces-3962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B77963FFD
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745CA1C24651
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560618D62F;
	Thu, 29 Aug 2024 09:26:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAF18CC1B;
	Thu, 29 Aug 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923595; cv=none; b=EQhbCQasG1Uyi4pObiIOZZjrQ20IrZA1IwM0ESzOKaoS/EDIrG/pU33V1J8TyZ/cPo4pueIwp8arMfE45VxFN7TGd6dtM3VEpq0hT+mmTWPQX/vOXiVPPb3lXfocCumfrfNqfm5qntvyVTN4/eJmB+vfLd5D20lEjTptDYq6kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923595; c=relaxed/simple;
	bh=dMHJeWxKwHHIHYwpupto0QfO0aDT5yxQ86wMZDpxhSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTZFjrArsDovBSrk8LnTgLFV9W2L2fRYftJYn0lvZp3nHP6E8vMtnoyZ+TaJkAScc8bwrPsRvQw64qrdl5MgyS22m1T5aMNytKkzJ/onQN3AiXUFo8iG0/KlEjh09nxM/KGkaZO4WscXmxgBkctccrVPCAJQixBDCKwMsGKTbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95A622199E;
	Thu, 29 Aug 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8624C13408;
	Thu, 29 Aug 2024 09:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z6e7IMc+0GaMcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:26:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3FE80A0965; Thu, 29 Aug 2024 11:26:31 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:26:31 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] ext4: hoist ext4_block_write_begin and replace the
 __block_write_begin
Message-ID: <20240829092631.oa2fxpfs3ok6uzbw@quack3>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
 <20240829085407.3331490-3-zhangshida@kylinos.cn>
 <20240829091250.gq2cgkfubbvlysxy@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829091250.gq2cgkfubbvlysxy@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 95A622199E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu 29-08-24 11:12:50, Jan Kara wrote:
> On Thu 29-08-24 16:54:06, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> > 
> > Using __block_write_begin() make it inconvenient to journal the
> > user data dirty process. We can't tell the block layer maintainer,
> > ‘Hey, we want to trace the dirty user data in ext4, can we add some
> > special code for ext4 in __block_write_begin?’:P
> > 
> > So use ext4_block_write_begin() instead.
> > 
> > The two functions are basically doing the same thing except for the
> > fscrypt related code. Remove the unnecessary #ifdef since
> > fscrypt_inode_uses_fs_layer_crypto() returns false (and it's known at
> > compile time) when !CONFIG_FS_ENCRYPTION.
> > 
> > And hoist the ext4_block_write_begin so that it can be used in other
> > files.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> 
> I think I've given my Reviewed-by on this already in previous version - you
> can keep those tags unless the patch significantly changes. Anyway: feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I've realized the patch slightly changed so that's likely why you've
dropped the Reviewed-by so I retract my comment :)

I've also realized one thing:

> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -1024,10 +1024,10 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
> >  	if (!buffer_mapped(bh) || buffer_freed(bh))
> >  		return 0;
> >  	/*
> > -	 * __block_write_begin() could have dirtied some buffers. Clean
> > +	 * ext4_block_write_begin() could have dirtied some buffers. Clean
> >  	 * the dirty bit as jbd2_journal_get_write_access() could complain
> >  	 * otherwise about fs integrity issues. Setting of the dirty bit
> > -	 * by __block_write_begin() isn't a real problem here as we clear
> > +	 * by ext4_block_write_begin() isn't a real problem here as we clear
> >  	 * the bit before releasing a page lock and thus writeback cannot
> >  	 * ever write the buffer.
> >  	 */

This comment and the special buffer_dirty() handling in this function can
be removed after patch 3 of this series. Nice additional cleanup :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

