Return-Path: <linux-ext4+bounces-6384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEDAA2C2C6
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48341693B7
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7962F3E;
	Fri,  7 Feb 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u7XFDDNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iR28v2Kl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u7XFDDNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iR28v2Kl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7781E
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931655; cv=none; b=jV0eFr/cR2fMre8a5qgSAHnTAm4Jfv1TER/Oz03MherPYvr0JPFjo4BNRHs9k3lu9Tt0vwaLq6xg2kNBmSGYTUzLwpRnfUAwxdD0nmFQ1w3O0hRjNssn0rqQtOmX79oavlvK/2VUzNZ65b92m4RL0fGOZOgeULwlImWCSPaUwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931655; c=relaxed/simple;
	bh=x+GwdNDRZzxVRcTiUix+EQjcxuhKLEpWKKM0uWO53Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZynpGfW8JcSPpLX3rzqrdw+tE91uEyw4jdwdaW/rrLcRG6KAHkxsDgt8GmelsFt6jxlWj9krZAqjURVfoBqrzsbfKufH1HV/ORJLnzlusiWmJR+JaXLf1SK+EK1ZW9qsbJ4LkiEpl9y9PGGblo/89kepto5AjIu6K1uV8hu4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u7XFDDNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iR28v2Kl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u7XFDDNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iR28v2Kl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98E951F443;
	Fri,  7 Feb 2025 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738931651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eq7Rt3cELGKUrpj1AdA/LxflrrMsAAxrwAnoGDKek=;
	b=u7XFDDNddKLR8cSZq2SYq152IMAVASAyqQJeyIUPHTo5klcniOJjIpKFidzjg1qyk7SZtU
	4NyaISO7pgxS0RF9ePLeoFaLvEonlR3ae3YCERSiuGzOtMxY0Nui16anZqnTeF8/hEvMAM
	z4CnnM/oOq4U4Zmyo1DpMLd6pWhYv04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738931651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eq7Rt3cELGKUrpj1AdA/LxflrrMsAAxrwAnoGDKek=;
	b=iR28v2Kln+EOdLhv7FWaLn7qOja4iKUd8ogOteJmMXHsO5ObChoDFR3yt88A9z9NUjn5kZ
	T+cb6DZjgxYaMNDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u7XFDDNd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iR28v2Kl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738931651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eq7Rt3cELGKUrpj1AdA/LxflrrMsAAxrwAnoGDKek=;
	b=u7XFDDNddKLR8cSZq2SYq152IMAVASAyqQJeyIUPHTo5klcniOJjIpKFidzjg1qyk7SZtU
	4NyaISO7pgxS0RF9ePLeoFaLvEonlR3ae3YCERSiuGzOtMxY0Nui16anZqnTeF8/hEvMAM
	z4CnnM/oOq4U4Zmyo1DpMLd6pWhYv04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738931651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eq7Rt3cELGKUrpj1AdA/LxflrrMsAAxrwAnoGDKek=;
	b=iR28v2Kln+EOdLhv7FWaLn7qOja4iKUd8ogOteJmMXHsO5ObChoDFR3yt88A9z9NUjn5kZ
	T+cb6DZjgxYaMNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88EAA139CB;
	Fri,  7 Feb 2025 12:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HYxjIcP9pWeZGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 12:34:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C2E4A28E7; Fri,  7 Feb 2025 13:34:11 +0100 (CET)
Date: Fri, 7 Feb 2025 13:34:11 +0100
From: Jan Kara <jack@suse.cz>
To: yebin <yebin@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [RESEND PATCH 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Message-ID: <e2sijmndq76k73e2oemcays4bgfl6ujvlgux3iocg5jigkvy3z@cxmfbh3i7nbc>
References: <20250207032743.882949-1-yebin@huaweicloud.com>
 <20250207032743.882949-3-yebin@huaweicloud.com>
 <20250207041629.GE21787@frogsfrogsfrogs>
 <67A5D305.9080605@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67A5D305.9080605@huaweicloud.com>
X-Rspamd-Queue-Id: 98E951F443
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 07-02-25 17:31:49, yebin wrote:
> On 2025/2/7 12:16, Darrick J. Wong wrote:
> > On Fri, Feb 07, 2025 at 11:27:43AM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > There's issue as follows:
> > > BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
> > > Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172
> > > 
> > > CPU: 3 PID: 15172 Comm: syz-executor.0
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:82 [inline]
> > >   dump_stack+0xbe/0xfd lib/dump_stack.c:123
> > >   print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
> > >   __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
> > >   kasan_report+0x3a/0x50 mm/kasan/report.c:585
> > >   ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
> > >   ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
> > >   ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
> > >   evict+0x39f/0x880 fs/inode.c:622
> > >   iput_final fs/inode.c:1746 [inline]
> > >   iput fs/inode.c:1772 [inline]
> > >   iput+0x525/0x6c0 fs/inode.c:1758
> > >   ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
> > >   ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
> > >   mount_bdev+0x355/0x410 fs/super.c:1446
> > >   legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
> > >   vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
> > >   do_new_mount fs/namespace.c:2983 [inline]
> > >   path_mount+0x119a/0x1ad0 fs/namespace.c:3316
> > >   do_mount+0xfc/0x110 fs/namespace.c:3329
> > >   __do_sys_mount fs/namespace.c:3540 [inline]
> > >   __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
> > >   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> > >   entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > > 
> > > Memory state around the buggy address:
> > >   ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >   ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >                     ^
> > >   ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >   ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > 
> > > Above issue happens as ext4_xattr_delete_inode() isn't check xattr
> > > is valid if xattr is in inode.
> > > To solve above issue call xattr_check_inode() check if xattr if valid
> > > in inode.
> > > 
> > > Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/ext4/xattr.c | 14 +++++++++++---
> > >   1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > > index 0e4494863d15..cb724477f8da 100644
> > > --- a/fs/ext4/xattr.c
> > > +++ b/fs/ext4/xattr.c
> > > @@ -2922,7 +2922,6 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
> > >   			    int extra_credits)
> > >   {
> > >   	struct buffer_head *bh = NULL;
> > > -	struct ext4_xattr_ibody_header *header;
> > >   	struct ext4_iloc iloc = { .bh = NULL };
> > >   	struct ext4_xattr_entry *entry;
> > >   	struct inode *ea_inode;
> > > @@ -2937,6 +2936,9 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
> > > 
> > >   	if (ext4_has_feature_ea_inode(inode->i_sb) &&
> > >   	    ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> > > +		struct ext4_xattr_ibody_header *header;
> > > +		struct ext4_inode *raw_inode;
> > > +		void *end;
> > > 
> > >   		error = ext4_get_inode_loc(inode, &iloc);
> > >   		if (error) {
> > > @@ -2952,14 +2954,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
> > >   			goto cleanup;
> > >   		}
> > > 
> > > -		header = IHDR(inode, ext4_raw_inode(&iloc));
> > > -		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC))
> > > +		raw_inode = ext4_raw_inode(&iloc);
> > > +		header = IHDR(inode, raw_inode);
> > > +		end = ITAIL(inode, raw_inode);
> > > +		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
> > 
> > This needs to make sure that header + sizeof(h_magic) >= end before
> > checking the magic number in header::h_magic, right?
> > 
> > --D
> Thank you for your reply.
> There ' s no need to check "header + sizeof(h_magic) >= end" because it has
> been checked
> when the EXT4_STATE_XATTR flag bit is set:
> __ext4_iget
>   ret = ext4_iget_extra_inode(inode, raw_inode, ei);
>     if (EXT4_INODE_HAS_XATTR_SPACE(inode) && *magic ==
> cpu_to_le32(EXT4_XATTR_MAGIC))
>       ext4_set_inode_state(inode, EXT4_STATE_XATTR);
> It seems that the judgment of "header->h_magic ==
> cpu_to_le32(EXT4_XATTR_MAGIC)"
> should be redundant here.

Yes, if we have EXT4_STATE_XATTR set, xattr_check_inode() should be safe to
call (ext4_iget_extra_inode() makes sure inode space is sane) and should
return success. I'm actually wondering whether it wouldn't be better for
ext4_iget_extra_inode() to check xattr validity with xattr_check_inode()
along with setting EXT4_STATE_XATTR. So we'd be checking xattr validity
when loading from disk similarly as for xattr blocks which is a well
defined place. When doing the checking on use (as we do now) it is always
easy to miss some place...

								Honza

> > > +			error = xattr_check_inode(inode, header, end);
> > > +			if (error)
> > > +				goto cleanup;
> > >   			ext4_xattr_inode_dec_ref_all(handle, inode, iloc.bh,
> > >   						     IFIRST(header),
> > >   						     false /* block_csum */,
> > >   						     ea_inode_array,
> > >   						     extra_credits,
> > >   						     false /* skip_quota */);
> > > +		}
> > >   	}
> > > 
> > >   	if (EXT4_I(inode)->i_file_acl) {
> > > --
> > > 2.34.1
> > > 
> > > 
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

