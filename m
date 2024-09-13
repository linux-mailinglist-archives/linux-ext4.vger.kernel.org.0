Return-Path: <linux-ext4+bounces-4136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BE977E09
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281AAB2697C
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276B1D86E0;
	Fri, 13 Sep 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2LfT74wn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRo2otEf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2LfT74wn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iRo2otEf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975001D67AB;
	Fri, 13 Sep 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224809; cv=none; b=gFNLt8hLhhZXBJQZYEcVMEbKRjpCniJu74ZuIhGNRFDrXmZFycSrC1kaoi8oHsNkZZs/eGZU+b7Sqo3z3W4vwnVn4GBk2Ffk75NXWmwPo69Rmc1Gm3S9FZg7V31TVRavnJOBpbrDheZLOAhi1nb2fvZjkjRQmtWjZ6jeGPLPLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224809; c=relaxed/simple;
	bh=Uc9FxDNdoUWjc+hbZ9UaZylbEv2yZbdiKtk7vYetpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMDvRBPX+UIXFFssm9ckhPqbW3E9KvZOWX2PIJupu2Rs4pczCrN+LsfMWZidqCxyxt6XBNL/FKMP0qfXpdDeR806YzOngn6Yuv78+uVttXa8MlVfzN7Z0Pa9WkUak/ojTVQPmRvJOVBRYexWp+Oq2EqIB2Nl1tM6fKavNzubFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2LfT74wn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iRo2otEf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2LfT74wn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iRo2otEf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF631219CA;
	Fri, 13 Sep 2024 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726224805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olF/tjLVnkmEFHRD9cOhZmsPxNvhRvaywZFv/z2JUyc=;
	b=2LfT74wnCcxzbMz1AWJNwlvHu00UwXPd7bjx9IVWXfUKHtnNYl/62DOI6IkkL9/o+cQrCC
	DSTX/abF2cLbpS9slYAo8+nxbFd1X7WANdeCATCJ25x8gzuSZA+5YcN6UIQ7RWC0+2i9eo
	xl1x7/ANJYPp7G8GjzPEZOAnHiQMfqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726224805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olF/tjLVnkmEFHRD9cOhZmsPxNvhRvaywZFv/z2JUyc=;
	b=iRo2otEfgTRtgHfPOYqkkBhtr1dZUZvo32uXzdFtly8mbefzmj0mICZGp0igN6ZTb9N9RX
	Y2MolsUPOGjYh7Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726224805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olF/tjLVnkmEFHRD9cOhZmsPxNvhRvaywZFv/z2JUyc=;
	b=2LfT74wnCcxzbMz1AWJNwlvHu00UwXPd7bjx9IVWXfUKHtnNYl/62DOI6IkkL9/o+cQrCC
	DSTX/abF2cLbpS9slYAo8+nxbFd1X7WANdeCATCJ25x8gzuSZA+5YcN6UIQ7RWC0+2i9eo
	xl1x7/ANJYPp7G8GjzPEZOAnHiQMfqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726224805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olF/tjLVnkmEFHRD9cOhZmsPxNvhRvaywZFv/z2JUyc=;
	b=iRo2otEfgTRtgHfPOYqkkBhtr1dZUZvo32uXzdFtly8mbefzmj0mICZGp0igN6ZTb9N9RX
	Y2MolsUPOGjYh7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4EC413999;
	Fri, 13 Sep 2024 10:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eoc7KKUZ5GbtbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Sep 2024 10:53:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5CB9EA08EF; Fri, 13 Sep 2024 12:53:10 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:53:10 +0200
From: Jan Kara <jack@suse.cz>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <steve.kang@unisoc.com>
Subject: Re: [PATCHv3 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240913105310.enqz47nmcn24ux45@quack3>
References: <20240904075300.1148836-1-zhaoyang.huang@unisoc.com>
 <CAGWkznF0LvqP59edcrs_wxpbUAnK6mZWY-ovE0CPBBXNysUUtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznF0LvqP59edcrs_wxpbUAnK6mZWY-ovE0CPBBXNysUUtg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 13-09-24 10:02:40, Zhaoyang Huang wrote:
> loop in jan kara
> 
> On Wed, Sep 4, 2024 at 3:54 PM zhaoyang.huang <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
> > can not be migrated out of CMA area[1] as the jh has one cp_transaction
> > pending on it because of j_free > j_max_transaction_buffers[2][3][4][5][6].
> > We temporarily solve this by launching jbd2_log_do_checkpoint forcefully
> > somewhere. Since journal is common mechanism to all JFSs and
> > cp_transaction has a little fewer opportunity to be launched, the
> > cma_alloc() could be affected under the same scenario. This patch
> > would like to have buffer_head of ext4 not use CMA pages when doing
> > sb_getblk.
> >
> > [1]
> > crash_arm64_v8.0.4++> kmem -p|grep ffffff808f0aa150(sb->s_bdev->bd_inode->i_mapping)
> > fffffffe01a51c00  e9470000 ffffff808f0aa150        3  2 8000000008020 lru,private
> > fffffffe03d189c0 174627000 ffffff808f0aa150        4  2 2004000000008020 lru,private
> > fffffffe03d88e00 176238000 ffffff808f0aa150      3f9  2 2008000000008020 lru,private
> > fffffffe03d88e40 176239000 ffffff808f0aa150        6  2 2008000000008020 lru,private
> > fffffffe03d88e80 17623a000 ffffff808f0aa150        5  2 2008000000008020 lru,private
> > fffffffe03d88ec0 17623b000 ffffff808f0aa150        1  2 2008000000008020 lru,private
> > fffffffe03d88f00 17623c000 ffffff808f0aa150        0  2 2008000000008020 lru,private
> > fffffffe040e6540 183995000 ffffff808f0aa150      3f4  2 2004000000008020 lru,private
> >
> > [2] page -> buffer_head
> > crash_arm64_v8.0.4++> struct page.private fffffffe01a51c00 -x
> >       private = 0xffffff802fca0c00
> >
> > [3] buffer_head -> journal_head
> > crash_arm64_v8.0.4++> struct buffer_head.b_private 0xffffff802fca0c00
> >   b_private = 0xffffff8041338e10,
> >
> > [4] journal_head -> b_cp_transaction
> > crash_arm64_v8.0.4++> struct journal_head.b_cp_transaction 0xffffff8041338e10 -x
> >   b_cp_transaction = 0xffffff80410f1900,
> >
> > [5] transaction_t -> journal
> > crash_arm64_v8.0.4++> struct transaction_t.t_journal 0xffffff80410f1900 -x
> >   t_journal = 0xffffff80e70f3000,
> >
> > [6] j_free & j_max_transaction_buffers
> > crash_arm64_v8.0.4++> struct journal_t.j_free,j_max_transaction_buffers 0xffffff80e70f3000 -x
> >   j_free = 0x3f1,
> >   j_max_transaction_buffers = 0x100,
> >
> > Suggested-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

I think there are better fixes to the problem but as a quick stopgap
solution I have no problem with this since this is trivial and influences
only CMA users on ext4. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > ---
> > v3: switch to use getblk_unmoveable as suggested by Theodore Ts'o
> > ---
> > ---
> >  fs/ext4/inode.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 941c1c0d5c6e..a0f48840c5c1 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -869,7 +869,14 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
> >         if (nowait)
> >                 return sb_find_get_block(inode->i_sb, map.m_pblk);
> >
> > -       bh = sb_getblk(inode->i_sb, map.m_pblk);
> > +       /*
> > +        * Since bh could introduce extra ref count such as referred by
> > +        * journal_head etc. Try to avoid using __GFP_MOVABLE here
> > +        * as it may fail the migration when journal_head remains.
> > +        */
> > +       bh = getblk_unmovable(inode->i_sb->s_bdev, map.m_pblk,
> > +                               inode->i_sb->s_blocksize);
> > +
> >         if (unlikely(!bh))
> >                 return ERR_PTR(-ENOMEM);
> >         if (map.m_flags & EXT4_MAP_NEW) {
> > --
> > 2.25.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

