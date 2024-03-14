Return-Path: <linux-ext4+bounces-1635-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE287BD0A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F61F222EC
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418E59161;
	Thu, 14 Mar 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tfXvYe6q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JgvZ0+NR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tfXvYe6q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JgvZ0+NR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7318E20;
	Thu, 14 Mar 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420660; cv=none; b=PZx5uQiOvwkjPA574fiz7+aa6TZmF5ZbQ2DtraYl5398mJtYWMOkNKOVJ5b8LF0OlbAlSvQVWTq9igtjDxETCuEybZJA6m7BjcNfoeYnYqrgs2CJm3ZQ9MoAfHtwMIgmHz10unidgOqjHwszzNxQ0sphEQXjrOp7MVyomq/gi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420660; c=relaxed/simple;
	bh=LSRB++TWHz6SdMwzx8ZmAqfTuUlUBjxPfPFRxob96mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkCdThIN2kARQb2SYE4HoNg3fi9siNvFm1mvEJAEqF8VpVnl8ZnNYhfVT56DmLPJcs5gBImIuWWSqMziA+q9612u7Z/a6aOl0cVw9zXWwdbzBlV75XR/9V1ZiufI00gjCUeR7/SH4c9d+ivtmCbyQx5yMA+Hb9Dl7z+nU01oFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tfXvYe6q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JgvZ0+NR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tfXvYe6q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JgvZ0+NR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58F7521D20;
	Thu, 14 Mar 2024 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710420654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdctWDhd2pnna23oUKV11hCUoIkdth6KOWFyYEMCnCo=;
	b=tfXvYe6q2KG8F7ZyLFgysEOCTLisPwVSg75RbLwFXS+fNfgvUbbv8g03Nekyp/UQ7+WO8P
	pvmq5p1zh7gS56R9jMqEFesDCx89ZrZsLe2anNbJ463JcRTXtGOhjlAGABM393DLSdfFJj
	5ZT9NtlfYdJIbECuUATAtL83rVHrVqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710420654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdctWDhd2pnna23oUKV11hCUoIkdth6KOWFyYEMCnCo=;
	b=JgvZ0+NRRpzVY4o7498hMNGuCOoug2RvsmIi0jBsM6+fxIcKL68hl8hQe9VfNtm6fapbh9
	Tj46h2JzBo9OJmDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710420654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdctWDhd2pnna23oUKV11hCUoIkdth6KOWFyYEMCnCo=;
	b=tfXvYe6q2KG8F7ZyLFgysEOCTLisPwVSg75RbLwFXS+fNfgvUbbv8g03Nekyp/UQ7+WO8P
	pvmq5p1zh7gS56R9jMqEFesDCx89ZrZsLe2anNbJ463JcRTXtGOhjlAGABM393DLSdfFJj
	5ZT9NtlfYdJIbECuUATAtL83rVHrVqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710420654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdctWDhd2pnna23oUKV11hCUoIkdth6KOWFyYEMCnCo=;
	b=JgvZ0+NRRpzVY4o7498hMNGuCOoug2RvsmIi0jBsM6+fxIcKL68hl8hQe9VfNtm6fapbh9
	Tj46h2JzBo9OJmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464631386E;
	Thu, 14 Mar 2024 12:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4yogEa7y8mXrfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 12:50:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1A88A07D9; Thu, 14 Mar 2024 13:50:49 +0100 (CET)
Date: Thu, 14 Mar 2024 13:50:49 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <20240314125049.ym7u7o4cwybizuyl@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-5-libaokun1@huawei.com>
 <20240314103056.rykwi2hhfm7v575a@quack3>
 <50f9333b-831a-8b4b-a6f2-ae79ab46a88b@huawei.com>
 <20240314120011.xggrokdfuu6fh4uv@quack3>
 <d166d7e6-bc55-8718-19a9-6bd97f4bd032@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d166d7e6-bc55-8718-19a9-6bd97f4bd032@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 14-03-24 20:37:38, Baokun Li wrote:
> On 2024/3/14 20:00, Jan Kara wrote:
> > On Thu 14-03-24 19:24:56, Baokun Li wrote:
> > > Hi Jan,
> > > 
> > > On 2024/3/14 18:30, Jan Kara wrote:
> > > > On Tue 27-02-24 17:11:43, Baokun Li wrote:
> > > > 
> > > > 
> > > > At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> > > > but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> > > > to be triggered by an attempt to access an element at index 29.
> > > > 
> > > > Add a new attr_id attr_clusters_in_group with values in the range
> > > > [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> > > > that type to fix the issue. In addition avoid returning an order
> > > > from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> > > > and reduce some useless loops.
> > > > 
> > > > Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> > > > CC: stable@vger.kernel.org
> > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > > Looks good. Just one nit below. Otherwise feel free to add:
> > > > 
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > 
> > > > > ---
> > > > >    fs/ext4/mballoc.c |  6 ++++++
> > > > >    fs/ext4/sysfs.c   | 13 ++++++++++++-
> > > > >    2 files changed, 18 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > > > index 85a91a61b761..7ad089df2408 100644
> > > > > --- a/fs/ext4/mballoc.c
> > > > > +++ b/fs/ext4/mballoc.c
> > > > > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> > > > >    		return 0;
> > > > >    	if (order == MB_NUM_ORDERS(sb))
> > > > >    		order--;
> > > > > +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > > > > +		order = MB_NUM_ORDERS(sb) - 1;
> > > > >    	return order;
> > > > >    }
> > > > > @@ -1057,6 +1059,10 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
> > > > >    			ac->ac_flags |= EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED;
> > > > >    			return;
> > > > >    		}
> > > > > +
> > > > > +		/* Skip some unnecessary loops. */
> > > > > +		if (unlikely(i > MB_NUM_ORDERS(ac->ac_sb)))
> > > > > +			i = MB_NUM_ORDERS(ac->ac_sb);
> > > > How can this possibly trigger now? MB_NUM_ORDERS is sb->s_blocksize_bits +
> > > > 2. 'i' is starting at fls(ac->ac_g_ex.fe_len) and ac_g_ex.fe_len shouldn't
> > > > be larger than clusters per group, hence fls() should be less than
> > > > sb->s_blocksize_bits? Am I missing something? And if yes, we should rather
> > > > make sure 'order' is never absurdly big?
> > > > 
> > > > I suspect this code is defensive upto a point of being confusing :)
> > > > 
> > > > Honza
> > > Yes, this is indeed defensive code! Only walk into this branch when
> > > WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)) is triggered.
> > > As previously mentioned by ojaswin in the following link:
> > > 
> > > "The reason for this is that otherwise when order is large eg 29,
> > > we would unnecessarily loop from i=29 to i=13 while always
> > > looking at the same avg_fragment_list[13]."
> > > 
> > > Link：https://lore.kernel.org/lkml/ZdQ7FEA7KC4eAMpg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
> > > 
> > > Thank you so much for the review! ღ( ´･ᴗ･` )
> > Thanks for the link. So what Ojaswin has suggested has been slightly
> > different though. He suggested to trim the order before the for loop, not
> > after the first iteration as you do which is what was confusing me. I'd
> > even suggest to replace your check with:
> > 
> >          /*
> >           * mb_avg_fragment_size_order() returns order in a way that makes
> >           * retrieving back the length using (1 << order) inaccurate. Hence, use
> >           * fls() instead since we need to know the actual length while modifying
> >           * goal length.
> >           */
> > -       order = fls(ac->ac_g_ex.fe_len) - 1;
> > +	order = min(fls(ac->ac_g_ex.fe_len), MB_NUM_ORDERS(ac->ac_sb)) - 1;
> >          min_order = order - sbi->s_mb_best_avail_max_trim_order;
> >          if (min_order < 0)
> >                  min_order = 0;
> > 
> > 								Honza
> Yes, I changed it that way because it only happens when an exception
> somewhere causes fe_len to be a huge value. I think in this case we
> should report the exception via WARN_ON_ONCE(), and trimming the
> order before the for loop will bypass WARN_ON_ONCE and not report
> any errors.

Fair enough. Then:
         /*
          * mb_avg_fragment_size_order() returns order in a way that makes
          * retrieving back the length using (1 << order) inaccurate. Hence, use
          * fls() instead since we need to know the actual length while modifying
          * goal length.
          */
	order = fls(ac->ac_g_ex.fe_len) - 1;
+	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(ac->ac_sb) - 1))
+		order = MB_NUM_ORDERS(ac->ac_sb) - 1;
        min_order = order - sbi->s_mb_best_avail_max_trim_order;
        if (min_order < 0)
                min_order = 0;

Still much less confusing...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

