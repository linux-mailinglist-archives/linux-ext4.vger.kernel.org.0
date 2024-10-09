Return-Path: <linux-ext4+bounces-4537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9D9970D3
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927C31C2286A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D7205E33;
	Wed,  9 Oct 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLRheKmN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x24IOWQl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLRheKmN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x24IOWQl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972601D31BB;
	Wed,  9 Oct 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489042; cv=none; b=Q6Xjij5Mv1u5sfLZ4lkyGg4oySpBA8ynXuc6SYDf0CswqI2gvYn4YgG/mfg7qSvbf/va2Ka4AzV0emlkBgT8yP8kkrnePyXhoF0jsdB2nrUVyozuVJWupxM4bxWb7LImXyogNujhafCpPeDRH5YOdMOzw7Cggn3ohAw9FsHprhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489042; c=relaxed/simple;
	bh=K4a6Anb6XFV0N0vLSweihy8dhlHDWNe2cLz75Sm/SRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Ai4QHg8Q6IFr4mqdjiVBhI6XSvY0KqSXTsklx1syrLqWWdTy/dr5RijYjr0Jmsp5UC/XISFwsdd4jPBwqJemNaJrn6z+7rWmNLznZj7LjFBdtHLg7T6nuPeJ81u0CIlDRDqkHxsRyk/u7zz4fsKCXS6n9vc5I/MOWxa0YuJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLRheKmN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x24IOWQl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLRheKmN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x24IOWQl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53B9921F8A;
	Wed,  9 Oct 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728489033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j07AqS1qj107vCWfCFBhnKE8M9hBSY14+6ixtpYjsyY=;
	b=BLRheKmNJI4qOm/Xvpcfw09m7jYcqmxz42QYKCuub36Z393Cp//yDIga6ktovFphV4EQI+
	fA3+2Qj9ewIT/jBJj+qIXoUYNqqXf4GQ2a0Uk9oPftj/k8PxnI6548KA1nRYrAg/IqQA19
	QjwDX+atnPqdzTl5FDhGrJcIBrl8k+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728489033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j07AqS1qj107vCWfCFBhnKE8M9hBSY14+6ixtpYjsyY=;
	b=x24IOWQlm98sKXVT3JS7Lzy8SriWrRyrTZf7DRaoKi+XyLhsIL7+jOMFh2liY6IG0x2Pll
	NruBaNTZc/0dulBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728489033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j07AqS1qj107vCWfCFBhnKE8M9hBSY14+6ixtpYjsyY=;
	b=BLRheKmNJI4qOm/Xvpcfw09m7jYcqmxz42QYKCuub36Z393Cp//yDIga6ktovFphV4EQI+
	fA3+2Qj9ewIT/jBJj+qIXoUYNqqXf4GQ2a0Uk9oPftj/k8PxnI6548KA1nRYrAg/IqQA19
	QjwDX+atnPqdzTl5FDhGrJcIBrl8k+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728489033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j07AqS1qj107vCWfCFBhnKE8M9hBSY14+6ixtpYjsyY=;
	b=x24IOWQlm98sKXVT3JS7Lzy8SriWrRyrTZf7DRaoKi+XyLhsIL7+jOMFh2liY6IG0x2Pll
	NruBaNTZc/0dulBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4672513A58;
	Wed,  9 Oct 2024 15:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRwtEUmmBmdnXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 15:50:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EE669A0896; Wed,  9 Oct 2024 17:50:28 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:50:28 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, tytso@mit.edu,
	Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
	syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <20241009155028.u7jpzrw6txldt43j@quack3>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
X-Spam-Score: -2.30
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
	FREEMAIL_CC(0.00)[163.com,mit.edu,suse.cz,dilger.ca,syzkaller.appspotmail.com,vger.kernel.org,googlegroups.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-10-24 15:40:39, Baokun Li wrote:
> On 2024/9/22 14:42, Qianqiang Liu wrote:
> > syzbot has found an out-of-bounds issue in ext4_xattr_set_entry:
> > 
> > ==================================================================
> > BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> > Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095
> > 
> > CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:93 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> >   print_address_description mm/kasan/report.c:377 [inline]
> >   print_report+0x169/0x550 mm/kasan/report.c:488
> >   kasan_report+0x143/0x180 mm/kasan/report.c:601
> >   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >   __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
> >   ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> > [...]
> > ==================================================================
> > 
> > This issue is caused by a negative size in memmove.
> > We need to check for this.
> > 
> > Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
> > Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> > Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> > Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> > ---
> >   fs/ext4/xattr.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 46ce2f21fef9..336badb46246 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
> >   	} else if (s->not_found) {
> >   		/* Insert new name. */
> >   		size_t size = EXT4_XATTR_LEN(name_len);
> > -		size_t rest = (void *)last - (void *)here + sizeof(__u32);
> > +		size_t rest;
> > +
> > +		if (last < here) {
> > +			ret = -ENOSPC;
> > +			goto out;
> > +		} else {
> > +			rest = (void *)last - (void *)here + sizeof(__u32);
> > +		}
> >   		memmove((void *)here + size, here, rest);
> >   		memset(here, 0, size);
> This change just passes syzbot's test cases without fixing the real
> problem.
> 
> The root cause of the problem is that the inode's xattr block is marked as
> free in the block bitmap, so that block is allocated to the ea inode
> resulting in the data in the xattr block being overwritten, and the last of
> the second lookups changing resulting in out-of-bounds access.
> 
> The stack that triggers the problem is as follows:
> 
> // An inode with an xattr block of 33.
> __ext4_mark_inode_dirty
>  __ext4_expand_extra_isize
>   ext4_expand_extra_isize_ea
>    ext4_xattr_make_inode_space
>     // Move xattr from inode to block
>     ext4_xattr_move_to_block
>      // Find out if the xattr exists in the block
>      ext4_xattr_block_find
>       // If xattr does not exist, here == last
>       xattr_find_entry
>      // Add a new xattr to the block
>      ext4_xattr_block_set
>       |// xattr is too long, needs an ea inode
>       |ext4_xattr_inode_lookup_create
>       | ext4_xattr_inode_create
>       | ext4_xattr_inode_write
>       |  ext4_map_blocks
>       |   // xattr block 33 is assigned to the new ea inode
>       |  memcpy(bh->b_data, buf, csize)
>       |   // The value of xattr overwrites the data in the xattr block.
>       |ext4_xattr_set_entry
>        // Since the contents of the xattr block have changed,
>        // now here == last does not hold, so it is possible to
>        // have last < here and trigger an out-of-bounds access.
> 
> So I think we should probably add a helper function ext4_mb_block_inuse()
> that checks if xattr block is free with the block bitmap in check_xattrs().

Well, even that would be a relatively narrow fix. You could have e.g.
file reference the xattr block as one of its data blocks and then corrupt
xattr contents at unfortunate moment. That will not get fixed by checking
whether the block is allocated. These multiply claimed blocks (as e2fsck
calls it) are very hard to detect inside the kernel.

> Or go one step further and add a mechanism like xfs Reverse-Mapping, which
> makes sure that allocated blocks do point to the target inode, which could
> replace the current block_validity, and could also be used in future online
> fscks.

Well, that is a rather big change. It requires significant on-disk format
change and also performance cost when to maintain. Furthermore for xattr
blocks which can be shared by many inodes it is not even clear how to
implement this... So I'm not sure we really want to do this either.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

