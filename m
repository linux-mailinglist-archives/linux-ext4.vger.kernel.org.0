Return-Path: <linux-ext4+bounces-4584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A224E99D4AE
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4981C24F5F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5AB4B5AE;
	Mon, 14 Oct 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jAMmC2iW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAM0rKnx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jAMmC2iW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LAM0rKnx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45482231C92;
	Mon, 14 Oct 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923485; cv=none; b=hh84cBVkuGIoVWtjQNie0G5twPeCMTgpOHNabSpSbUVx7Lgrd1xbAwv36oDSBP51hN9XJBBkM9zxKmU2FvzoMCOjMp7NjPErskxh/INPLJyEtBYykTxGhaxVlWLfHcDEjSnX3w5fU+lqnLnP+nDtGjT4U4wDS45Uheg3oaBOTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923485; c=relaxed/simple;
	bh=AZFOPJj+z+E7HOyr0IfZb0QvrjK3TVWMJuVeJTFglNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyeFh9mPOck/PA9X6jBX45+f3jkZFqTuVyHmy6nG2W3jj9lg1AToBcVjVG+xe2csG6XEoTt3gNvM534pQUMwiXe6SW6rFbalIoHfS/n/89OWWdUWPOyJOoCCbGMvZTsAxsdLWzU72oe4jlpvkMA/EuevxHrSm4Tm1SKRTLAs3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jAMmC2iW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAM0rKnx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jAMmC2iW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LAM0rKnx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0E51FE87;
	Mon, 14 Oct 2024 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728923481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSvSwEinMbWBDsy63k3v3dPvLeoUCIAjXKJaTuFbjg=;
	b=jAMmC2iWP83lNj9CZWkFG7Z64BV3VKgtHA9SR5CUK7RfocqMP5vqGtjoBrlSsvAmlzjLja
	QdDQRIcmBT2sQJj4YskFDfg1sPzRx/V06ueFkuil7kcKoQg2Pv7FZ3mRiL0bVz0eyn23rR
	0njeItmjY9XUo2BC4X3cuzF4kadsm7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728923481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSvSwEinMbWBDsy63k3v3dPvLeoUCIAjXKJaTuFbjg=;
	b=LAM0rKnxwqFzWBT6CPRuPEgXd3Zew54inH0pdVN1eZZADpz/zlZJ3iRttR1D58W1wzfsQe
	rKAcO+mxo66/ZSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728923481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSvSwEinMbWBDsy63k3v3dPvLeoUCIAjXKJaTuFbjg=;
	b=jAMmC2iWP83lNj9CZWkFG7Z64BV3VKgtHA9SR5CUK7RfocqMP5vqGtjoBrlSsvAmlzjLja
	QdDQRIcmBT2sQJj4YskFDfg1sPzRx/V06ueFkuil7kcKoQg2Pv7FZ3mRiL0bVz0eyn23rR
	0njeItmjY9XUo2BC4X3cuzF4kadsm7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728923481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSvSwEinMbWBDsy63k3v3dPvLeoUCIAjXKJaTuFbjg=;
	b=LAM0rKnxwqFzWBT6CPRuPEgXd3Zew54inH0pdVN1eZZADpz/zlZJ3iRttR1D58W1wzfsQe
	rKAcO+mxo66/ZSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A31C13A42;
	Mon, 14 Oct 2024 16:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Rw1EllHDWccDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 16:31:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3F97A0896; Mon, 14 Oct 2024 18:31:20 +0200 (CEST)
Date: Mon, 14 Oct 2024 18:31:20 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Qianqiang Liu <qianqiang.liu@163.com>,
	tytso@mit.edu, adilger.kernel@dilger.ca,
	syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <20241014163120.hinbd5jc6mp4vev7@quack3>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
 <20241009155028.u7jpzrw6txldt43j@quack3>
 <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05f9c7c2-655a-4f5b-be8e-93f511a954bd@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[f792df426ff0f5ceb8d1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,163.com,mit.edu,dilger.ca,syzkaller.appspotmail.com,vger.kernel.org,googlegroups.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 11-10-24 10:18:04, Baokun Li wrote:
> On 2024/10/9 23:50, Jan Kara wrote:
> > > Or go one step further and add a mechanism like xfs Reverse-Mapping, which
> > > makes sure that allocated blocks do point to the target inode, which could
> > > replace the current block_validity, and could also be used in future online
> > > fscks.
> > Well, that is a rather big change. It requires significant on-disk format
> > change and also performance cost when to maintain. Furthermore for xattr
> > blocks which can be shared by many inodes it is not even clear how to
> > implement this... So I'm not sure we really want to do this either.
> 
> Yes, there can be a lot of work involved.
> 
>  * Perhaps we could create an rmap file to store the rmap tree to avoid
>    on-disk format changes.
>  * The performance impact of maintaining rmap really needs to be evaluated,
>    perhaps by writing a simple DEMO to test it.
>  * XFS supports shared blocks(A.K.A. reflink.), so even if the physical
>    blocks are the same, but the inodes are different or the logical blocks
>    are different, they will be recorded multiple times in the tree. So the
>    shared xattr block can be handled similarly.
> 
> We have plans to support online fsck in the future, and implementing rmap
> is one of the steps. Perhaps one can wait until rmap is implemented to
> assess whether it is worth a strict check here.

Yes, we could implement something like this be as you wrote, it's going to
be a lot of work. We've briefly discussed this with Ted on ext4 call and we
came to a conclusion that this is a type of corruption ext4 may never
protect agaist. You simply should not mount arbitrarily corrupted
filesystems... But if you want to try, sure go ahead :)

One relatively easy solution to similar class of problems would be to store
the type of metadata buffer inside the buffer_head when we are verifying
checksum, clear the info when freeing the block in __ext4_forget(), and
fail with EFSCORRUPTED error when one type -> another type transition would
happen.

> Implementing rmap may take some time, until then we can avoid the problem
> as much as possible by checking the magic and xattr block csum.
> Maybe something like this?
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7647e9f6e190..cd3ae1e3371c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1676,6 +1676,13 @@ static int ext4_xattr_set_entry(struct
> ext4_xattr_info *i,
>                 }
>         }
> 
> +       if (WARN_ON_ONCE(last < here)) {
> +               EXT4_ERROR_INODE(inode, "corrupted xattr entries in %s",
> +                                       is_block ? "block" : "ibody");
> +               ret = -EFSCORRUPTED;
> +               goto out;
> +       }
> +
>         /* Check whether we have enough space. */
>         if (i->value) {
>                 size_t free;
> @@ -1923,6 +1930,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode
> *inode,
>         }
> 
>         if (s->base) {
> +               struct ext4_xattr_header *hdr;
>                 int offset = (char *)s->here - bs->bh->b_data;
> 
>                 BUFFER_TRACE(bs->bh, "get_write_access");
> @@ -1932,6 +1940,16 @@ ext4_xattr_block_set(handle_t *handle, struct inode
> *inode,
>                         goto cleanup;
> 
>                 lock_buffer(bs->bh);
> +               hdr = header(s->base);
> +
> +               if (hdr->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
> +                   (ext4_has_metadata_csum(inode->i_sb) &&
> +                    (ext4_xattr_block_csum(inode, bs->bh->b_blocknr, hdr)
> !=
> +                     hdr->h_checksum))) {
> +                       unlock_buffer(bs->bh);
> +                       error = -EFSCORRUPTED;
> +                       goto bad_block;
> +               }
> 
>                 if (header(s->base)->h_refcount == cpu_to_le32(1)) {
>                         __u32 hash = le32_to_cpu(BHDR(bs->bh)->h_hash);

Hum, there are more places in xattr code that access a buffer that could
have been modified. So why do you add check into this place? Is it somehow
special?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

