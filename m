Return-Path: <linux-ext4+bounces-12841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD39D20889
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764543018D42
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B322F83A7;
	Wed, 14 Jan 2026 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvQfxvGV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0d4uVb13";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvQfxvGV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0d4uVb13"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299E2EE611
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411575; cv=none; b=MU58qiDgRJD1fVEKIXW19MTVwAoTaozXILn3BP5oAVUW7MgkHeJMWgYY50OcPPiSI9s76gE8jGVC2xUNtf+s/bUjaU+IwDewRgel3XsQPzjKodB5ykS3R008i7y77injaeze/B80KOxfW9JgPJxMou7v0p401qiRC85pkH+dxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411575; c=relaxed/simple;
	bh=medZbnHfpZCAxENo1Xrq+ze0N90EyBQ4aRBiiZNvulw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfjFWdpTa5gICulg2WPbKkZNUHuhvQAatnvAXXCSEj9LiH2B9NLEpiWKQM4mmJv+6skwXKUO49OzG43x01Sgu27KzUMBI0+7QjqEsj8bzUfPXljomXNzANf0QRff+jbftEX4x1OeLDbl8DqYg8HxiMgsoDMBmco36d6VNfh0wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvQfxvGV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0d4uVb13; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvQfxvGV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0d4uVb13; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64A0D348A7;
	Wed, 14 Jan 2026 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768411572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=groeBnjGHmXVrY/q1HmIBzxmUHdDPq2uJ4IW6O4sSwQ=;
	b=vvQfxvGVaWOCtcAoxRRuIdfI026QHgtBNTKKl/QY8Dzs6ybLi40X4Noa5PBr6sfuLKdvKX
	8oHDif+GpChAq0lCVbuAFATjMugZvKx3KrzMd2a4qEfewnZWPLvktLgUV8juJ5R25QSKAs
	OZPotl57bpKCpGS+HFBc2PUVLBHrEQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768411572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=groeBnjGHmXVrY/q1HmIBzxmUHdDPq2uJ4IW6O4sSwQ=;
	b=0d4uVb13QlzFYypE2c40HAVMZQ5fr2ZR78FH4bI+EMwtBnSPPBMZ2RTT5UzEtasOfhJacV
	oFtZvhlpy8lpevAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768411572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=groeBnjGHmXVrY/q1HmIBzxmUHdDPq2uJ4IW6O4sSwQ=;
	b=vvQfxvGVaWOCtcAoxRRuIdfI026QHgtBNTKKl/QY8Dzs6ybLi40X4Noa5PBr6sfuLKdvKX
	8oHDif+GpChAq0lCVbuAFATjMugZvKx3KrzMd2a4qEfewnZWPLvktLgUV8juJ5R25QSKAs
	OZPotl57bpKCpGS+HFBc2PUVLBHrEQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768411572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=groeBnjGHmXVrY/q1HmIBzxmUHdDPq2uJ4IW6O4sSwQ=;
	b=0d4uVb13QlzFYypE2c40HAVMZQ5fr2ZR78FH4bI+EMwtBnSPPBMZ2RTT5UzEtasOfhJacV
	oFtZvhlpy8lpevAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C5543EA63;
	Wed, 14 Jan 2026 17:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HmGFrTRZ2mSAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 17:26:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 079A1A0C40; Wed, 14 Jan 2026 18:26:08 +0100 (CET)
Date: Wed, 14 Jan 2026 18:26:07 +0100
From: Jan Kara <jack@suse.cz>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode
 can use
Message-ID: <e472kuaklq556gbycq2h4e34jomct7aysjvkdcgwmhl4elwpci@u5abofkkhg4h>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-3-jack@suse.cz>
 <fmycqmyw25fpfkov5bvl77gqz7mc3kgsfi44al4rn4n5mhzara@ijqxuq6wpna7>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fmycqmyw25fpfkov5bvl77gqz7mc3kgsfi44al4rn4n5mhzara@ijqxuq6wpna7>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 13-01-26 16:28:07, Pedro Falcato wrote:
> On Fri, Jan 09, 2026 at 11:53:37AM +0100, Jan Kara wrote:
> > For filesystems with more than 2^32 blocks inodes using indirect block
> > based format cannot use blocks beyond the 32-bit limit.
> > ext4_mb_scan_groups_linear() takes care to not select these unsupported
> > groups for such inodes however other functions selecting groups for
> > allocation don't. So far this is harmless because the other selection
> > functions are used only with mb_optimize_scan and this is currently
> > disabled for inodes with indirect blocks however in the following patch
> > we want to enable mb_optimize_scan regardless of inode format.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/mballoc.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 56d50fd3310b..f0e07bf11a93 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -892,6 +892,18 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
> >  	}
> >  }
> >  
> > +static ext4_group_t ext4_get_allocation_groups_count(
> > +				struct ext4_allocation_context *ac)
> > +{
> > +	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> > +
> > +	/* non-extent files are limited to low blocks/groups */
> > +	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> > +		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
> > +
> > +	return ngroups;
> > +}
> 
> I know you're mostly only moving code around, but I think I see a problem here.
> Namely, we (probably?) need an smp_rmb() right after the s_blockfile_groups
> read to pair with the one in ext4_update_super(). The pre-existing smp_rmb()
> in ext4_get_groups_acount() after the s_groups_count load perhaps *incidentally*
> works here, but it seems to me like we need a new barrier. So fundamentally
> something like:
> 
> static ext4_group_t ext4_get_allocation_groups_count(...)
> {
> 	struct ext4_sb_info *sb = EXT4_SB(ac->ac_sb);
> 	ext4_group_t ngroups;
> 
> 	ngroups = sb->s_groups_count;
> 	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> 		ngroups = sb->s_blockfile_groups;
> 	/* pairs with ext4_group_add() logic */
> 	smp_rmb();
> 	return ngroups;
> }
> 
> and to be even more technically correct, we probably want READ_ONCE()
> and WRITE_ONCE() here as well.
> 
> Does this make sense?

I agree with both although I'd note this isn't strictly related to this
patch as the problem is already preexisting in the code. I think smp_rmb()
is good to add when we are touching the code, regarding READ_ONCE /
WRITE_ONCE, that will require modifying all the places touching
s_blockfile_groups / s_groups_count so I'd leave that for a separate series
as that's going to be more intrusive.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

