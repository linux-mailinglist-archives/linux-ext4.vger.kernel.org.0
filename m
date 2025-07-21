Return-Path: <linux-ext4+bounces-9137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E28B0C46E
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128E516D5D4
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94527FB22;
	Mon, 21 Jul 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1LZth9q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5l66tSs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1LZth9q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5l66tSs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8C2D46AE
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102202; cv=none; b=TYmpOQ02wDY6AmuO/fQUShw5ChY2cfDkR1IrovSe8fNu6T2iUGrAQ+kWy4CuQ6k5t1Y3XBkzC9oJt0nzu6JwsVL8AZik7NvBd/XLCKrfGi5R9Kvdt60HKgxQSUgxwsQP+Fin8e7HXoaO+4P2D+8Wpv+lSj+P3/Z+NsYSZWO5mI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102202; c=relaxed/simple;
	bh=IylyLkwQeebIQ0KYAOzyGHaHz2oJRHGJAahqMnxVvwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjCP+CBBc0348kDH0H+/6xbuT3hwoytLr7ty6niJ8Xa8py7Q2LXT+1Fs7ur8xclPr1KIyoUIwiTztCr3xfZm+sXLBppUOcKkwY7GLiKa0LKZqm7vr1NHibn9ZLg0xWsBfD/PjwnmBNIgSGUYWnk7BQyd5lUf3AMjLo3LpnFcvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1LZth9q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5l66tSs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1LZth9q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5l66tSs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F67D1FD49;
	Mon, 21 Jul 2025 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753102198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1kFRDXpcU60KHBCoXhpcUeApUFRWzWuvaE9tAoENZM=;
	b=z1LZth9qgpUG3UjsoQinD2xEf2nmKMerZtkyE94RMnO9SUU9WMrZFd+vXROMILSWdcvYzo
	vuEUHy+R9X6wLSZUm7g7J2BroZ41Gyz6KnYsUHpYJlfXKJ0Qdd14dYSkc9nAaSKzqBrftP
	Yr6vHTXBuBiweLo5h+FN1n60+8HIMkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753102198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1kFRDXpcU60KHBCoXhpcUeApUFRWzWuvaE9tAoENZM=;
	b=q5l66tSskmyuvBlFqnOt2jexmXQ+QANO49n96WaEUjs8pY3/AiKEk9GStCqJvUcdVpMGbn
	VvtNK+p1c1hp4TBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z1LZth9q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=q5l66tSs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753102198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1kFRDXpcU60KHBCoXhpcUeApUFRWzWuvaE9tAoENZM=;
	b=z1LZth9qgpUG3UjsoQinD2xEf2nmKMerZtkyE94RMnO9SUU9WMrZFd+vXROMILSWdcvYzo
	vuEUHy+R9X6wLSZUm7g7J2BroZ41Gyz6KnYsUHpYJlfXKJ0Qdd14dYSkc9nAaSKzqBrftP
	Yr6vHTXBuBiweLo5h+FN1n60+8HIMkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753102198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1kFRDXpcU60KHBCoXhpcUeApUFRWzWuvaE9tAoENZM=;
	b=q5l66tSskmyuvBlFqnOt2jexmXQ+QANO49n96WaEUjs8pY3/AiKEk9GStCqJvUcdVpMGbn
	VvtNK+p1c1hp4TBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02FAB136A8;
	Mon, 21 Jul 2025 12:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0i0AHY3fmgPRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 12:49:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0FCAA0884; Mon, 21 Jul 2025 14:49:57 +0200 (CEST)
Date: Mon, 21 Jul 2025 14:49:57 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Moon Hee Lee <moonhee.lee.ca@gmail.com>, 
	syzbot+544248a761451c0df72f@syzkaller.appspotmail.com, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ext4: do not BUG when INLINE_DATA_FL lacks system.data
 xattr
Message-ID: <t6yl3jtspvfby4c6nlqbwjucfkx2evpuebaqvwolgjzcdst3sx@y4yuq7xegul6>
References: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
 <20250717145911.GB112967@mit.edu>
 <CAF3JpA6RwyzQMdG4y3P_8jkaS8qUFPerE5MJ8Xecs+VkbPEmpg@mail.gmail.com>
 <20250718010521.GC112967@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718010521.GC112967@mit.edu>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0F67D1FD49
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,dilger.ca,vger.kernel.org,googlegroups.com,suse.cz,kernel.dk];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[544248a761451c0df72f];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.51

On Thu 17-07-25 21:05:21, Theodore Ts'o wrote:
> On Thu, Jul 17, 2025 at 09:59:13AM -0700, Moon Hee Lee wrote:
> > The current patch addresses ext4_update_inline_data() directly, but the
> > same condition also leads to a BUG_ON in ext4_create_inline_data() [2],
> > which the earlier approach intended to prevent as well.
> 
> Actually, the two conditions are opposite to each other.  The one in
> ext4_update_inline_data() was:
> 
>          BUG_ON(is.s.not_found);
> 
> while te one in ext4_create_inline_data() was:
> 
> 	BUG_ON(!is.s.not_found);
> 
> So your patch would not only cause an extra xattr lookup in
> ext4_prepare_inline_data(), but it would actually cause problems by
> causing spurious failures when first writing to an inline data file.
> (Which makes me suspect that you hadn't run other test on your patich
> other than just vaidating that the syzkaller reproduce was no longer
> reproducing.)   
> 
> Also, having taking a closer look at te code paths, I became
> suspicious that there is something about the syzkaller reproducer is
> doing which might be a bit sus.  That's because whether we call
> ext4_update_inline_data() or ext4_create_inline_data() is based on
> whether i_inline off is set or not:
> 
> 	if (ei->i_inline_off)
> 		ret = ext4_update_inline_data(handle, inode, len);
> 	else
> 		ret = ext4_create_inline_data(handle, inode, len);
> 
> 
> But how is ei->i_inline_off set?  It's set from a former call to
> ext4_xattr_ibody_find():
> 
> 	error = ext4_xattr_ibody_find(inode, &i, &is);
> 	if (error)
> 		goto out;
> 
> 	if (!is.s.not_found) {
> 		if (is.s.here->e_value_inum) {
> 			EXT4_ERROR_INODE(inode, "inline data xattr refers "
> 					 "to an external xattr inode");
> 			error = -EFSCORRUPTED;
> 			goto out;
> 		}
> 		EXT4_I(inode)->i_inline_off = (u16)((void *)is.s.here -
> 					(void *)ext4_raw_inode(&is.iloc));
> 		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
> 				le32_to_cpu(is.s.here->e_value_size);
> 	}
> 
> So the whole *reason* why i_inline_off exists is because we're caching
> the result of calling ext4_xattr_ibody_find().  So if i_inline_off is
> non-zero, and then when we call ext4_ibody_find() later on, and we
> find that xattr has suddenly disappeared, there is something weird
> going on.   That's why the BUG_ON was added orginally.
> 
> When I took a look at the reproduer, I found that indeed, it is
> calling LOOP_CLR_FD and LOOP_SET_STATUS64 to reconfigure the loop
> device out from under the mounted file system.  This is smashing the
> file system, and is therefore corrupting the block device.  As it
> turns out, Jan Kara recently sent out a patch, and it has been
> accepted in the block tree, to prevent a similar Syzkaller issue using
> LOOP_SET_BLOCK_SIZE[1].
> 
> [1] https://lore.kernel.org/r/20250711163202.19623-2-jack@suse.cz
> 
> We need to do something similar for LOOP_CLR_FD, LOOP_SET_STATUS,
> LOOP_SET_STATUS64, LOOP_CHANGE_FD, and LOOP_SET_CAPACITY ioctls.

Well, careful here. Changing loop device underneath mounted filesystem is a
valid usecase in active use (similarly as changing DM device underneath a
filesystem). So don't think we can play similar tricks as with
LOOP_SET_BLOCK_SIZE where changing block device block size just doesn't
make sense while the device is in use. Similarly LOOP_CLR_FD is an
equivalent of device going away. LOOP_CHANGE_FD is a legacy of the past but
it was *designed* to be used to swap backing file under a life filesystem
(old days of Wild West :)) during boot. We may get away with dropping that
these days but so far I'm not convinced it's worth the risk. So in this case
I don't see anything here that couldn't happen with say DM device and thus
I wouldn't really restrict the loop device functionality...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

