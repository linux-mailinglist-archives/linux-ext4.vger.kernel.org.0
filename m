Return-Path: <linux-ext4+bounces-1633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD687BC6C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BCB1C20961
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE076F07C;
	Thu, 14 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfVSfay/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Zd7EYui";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfVSfay/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Zd7EYui"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C616EB74;
	Thu, 14 Mar 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417622; cv=none; b=uFTrszCxfKoBkoip8U8TLJZOPSlErFqkO2jHGFJt7eh6YFg3gfPDo9/5hKTrCo/XvoNxF99SiBSlqRypkA9jxOwRU7gU5luyyfYv3gaC/mVsQhrlnyi886bAAp/f5nyIsZovtwb+WnfVJpK6pKabbFLEjpZkK7hdc+C0aSaU1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417622; c=relaxed/simple;
	bh=Wdn85na5ngxM1lyYk0wwPmAO4xMXMvvFNMt6cQGSe08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNADwPncvgU6yEj3l55BZe+pP3KOM4UmUgiHP2xNEKg+YkFm/TJB7Jt7iogsRP47ZphDAvRJfVNUEKl6Z+wl6oBh7gJbfJD8eHOz6NKzWzCiU/DJELxSRvpn+aO/9JeFc/l/WeboWlf28+c3my80kYMrFCCri33inGJlKeDIgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfVSfay/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Zd7EYui; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfVSfay/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Zd7EYui; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50FE421D29;
	Thu, 14 Mar 2024 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710417616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt/sGyVuk2bhBD8OTghdQIVIOtIBbX3yINDxt/NEMW8=;
	b=BfVSfay/osZdneGkpKygrjjcodm5Vp3G1wSRAxQXj8CE94sZqFqobhsEDV93MGT6VtmeJU
	UKvOsHmG27jnAfbxkQBG3eAlt0tKYy4GqUxhTsl5gis8MC5SV1P5yi8+WbZ7a7slQ/s2qm
	Ml8DOLobYIuKJn7U5G99fX1Pv9y/oXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710417616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt/sGyVuk2bhBD8OTghdQIVIOtIBbX3yINDxt/NEMW8=;
	b=6Zd7EYuiDYWdIiMSv8+gzGDTvm3Wq/iNbIKloB++z3p2GYLUsdK+DHeX9PhkJV6uEiX4+b
	d8wWjj8F5/l+W+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710417616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt/sGyVuk2bhBD8OTghdQIVIOtIBbX3yINDxt/NEMW8=;
	b=BfVSfay/osZdneGkpKygrjjcodm5Vp3G1wSRAxQXj8CE94sZqFqobhsEDV93MGT6VtmeJU
	UKvOsHmG27jnAfbxkQBG3eAlt0tKYy4GqUxhTsl5gis8MC5SV1P5yi8+WbZ7a7slQ/s2qm
	Ml8DOLobYIuKJn7U5G99fX1Pv9y/oXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710417616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt/sGyVuk2bhBD8OTghdQIVIOtIBbX3yINDxt/NEMW8=;
	b=6Zd7EYuiDYWdIiMSv8+gzGDTvm3Wq/iNbIKloB++z3p2GYLUsdK+DHeX9PhkJV6uEiX4+b
	d8wWjj8F5/l+W+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41968139E7;
	Thu, 14 Mar 2024 12:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ivX7D9Dm8mWqbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 12:00:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6B36A07D9; Thu, 14 Mar 2024 13:00:11 +0100 (CET)
Date: Thu, 14 Mar 2024 13:00:11 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <20240314120011.xggrokdfuu6fh4uv@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-5-libaokun1@huawei.com>
 <20240314103056.rykwi2hhfm7v575a@quack3>
 <50f9333b-831a-8b4b-a6f2-ae79ab46a88b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50f9333b-831a-8b4b-a6f2-ae79ab46a88b@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="BfVSfay/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6Zd7EYui
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 50FE421D29
X-Spam-Flag: NO

On Thu 14-03-24 19:24:56, Baokun Li wrote:
> Hi Jan,
> 
> On 2024/3/14 18:30, Jan Kara wrote:
> > On Tue 27-02-24 17:11:43, Baokun Li wrote:
> > 
> > 
> > At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> > but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> > to be triggered by an attempt to access an element at index 29.
> > 
> > Add a new attr_id attr_clusters_in_group with values in the range
> > [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> > that type to fix the issue. In addition avoid returning an order
> > from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> > and reduce some useless loops.
> > 
> > Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > Looks good. Just one nit below. Otherwise feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > > ---
> > >   fs/ext4/mballoc.c |  6 ++++++
> > >   fs/ext4/sysfs.c   | 13 ++++++++++++-
> > >   2 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 85a91a61b761..7ad089df2408 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> > >   		return 0;
> > >   	if (order == MB_NUM_ORDERS(sb))
> > >   		order--;
> > > +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > > +		order = MB_NUM_ORDERS(sb) - 1;
> > >   	return order;
> > >   }
> > > @@ -1057,6 +1059,10 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
> > >   			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
> > >   			return;
> > >   		}
> > > +
> > > +		/* Skip some unnecessary loops. */
> > > +		if (unlikely(i > MB_NUM_ORDERS(ac->ac_sb)))
> > > +			i = MB_NUM_ORDERS(ac->ac_sb);
> > How can this possibly trigger now? MB_NUM_ORDERS is sb->s_blocksize_bits +
> > 2. 'i' is starting at fls(ac->ac_g_ex.fe_len) and ac_g_ex.fe_len shouldn't
> > be larger than clusters per group, hence fls() should be less than
> > sb->s_blocksize_bits? Am I missing something? And if yes, we should rather
> > make sure 'order' is never absurdly big?
> > 
> > I suspect this code is defensive upto a point of being confusing :)
> > 
> > Honza
> 
> Yes, this is indeed defensive code! Only walk into this branch when
> WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)) is triggered.
> As previously mentioned by ojaswin in the following link:
> 
> "The reason for this is that otherwise when order is large eg 29,
> we would unnecessarily loop from i=29 to i=13 while always
> looking at the same avg_fragment_list[13]."
> 
> Link：https://lore.kernel.org/lkml/ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
> 
> Thank you so much for the review! ღ( ´･ᴗ･` )

Thanks for the link. So what Ojaswin has suggested has been slightly
different though. He suggested to trim the order before the for loop, not
after the first iteration as you do which is what was confusing me. I'd
even suggest to replace your check with:

        /*      
         * mb_avg_fragment_size_order() returns order in a way that makes
         * retrieving back the length using (1 << order) inaccurate. Hence, use
         * fls() instead since we need to know the actual length while modifying
         * goal length.
         */     
-       order = fls(ac->ac_g_ex.fe_len) - 1;
+	order = min(fls(ac->ac_g_ex.fe_len), MB_NUM_ORDERS(ac->ac_sb)) - 1;
        min_order = order - sbi->s_mb_best_avail_max_trim_order;
        if (min_order < 0)
                min_order = 0;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

