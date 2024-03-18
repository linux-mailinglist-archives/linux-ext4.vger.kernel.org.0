Return-Path: <linux-ext4+bounces-1680-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250787EC16
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD88C1F21E0E
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A44F217;
	Mon, 18 Mar 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N7QDLfSO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZTjCHXrW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfXMzMXw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/z0mKqaD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116E4F1FA;
	Mon, 18 Mar 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775521; cv=none; b=oaPum8t/zL+oJa54PnMJm6eWikUoTt/avHXeM5oIoz6uxVCB1KQoWEWopQ+nRRDtiKDOzNn1waiG28FRjAEEwbgzSLOI0sti0YgSazAVUUOnV5fHDm7EKb4ZeY4k5l/nES3OG+QU0IKUo++E2CFEfmDyVees1KrcyTrsOPtk9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775521; c=relaxed/simple;
	bh=PK/AFuE4d26F9yJkFry5cVwY/JjHa0X2rvqK959sqao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HczU7ALsHB/v1L5s6E1H1M0ZkFtrHXti31eahd9NPGE02wyveSDJpisfTnk4aUZUTIGWw5NV3FGu/dgV7R5izKHaGiN07RWo7UEtlPzzVgtnPJTGV2hpfppmryV4nj2RdabyjdxY5txFTBvXWY9EHjTsuBmu4bhhK4mTKLBBoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N7QDLfSO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZTjCHXrW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfXMzMXw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/z0mKqaD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF8225C699;
	Mon, 18 Mar 2024 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710775516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TuguZ4pEpnLQaEpC5CAxXefyoe3rAzShOZPC2cxkvkw=;
	b=N7QDLfSOQBr1PjDf8h5pqhB2J8FjBaZTLJViEOc19+NJoSedZBTB9dFJ72m/CXg739DbXD
	9B0DyAiEwPHTI06czMtIx2tcJ6SFKI9Pe75/FO0FhfprqMfACulF+BhFxeAW5o7w9A6LFy
	rWKhhbdzS+hXhaH+Q5y7NYLgp+2BSv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710775516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TuguZ4pEpnLQaEpC5CAxXefyoe3rAzShOZPC2cxkvkw=;
	b=ZTjCHXrWUVoVMyOoGLXKGB6/F3Ot8epYK4Wx2y9AreCPrtXvtzJFZzOZM0DuRPVc7GFpBf
	wuFRf/3Kgj63jnAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710775513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TuguZ4pEpnLQaEpC5CAxXefyoe3rAzShOZPC2cxkvkw=;
	b=yfXMzMXwa5L4e8xXQ5XkbSZncnzJH1dTIHW85Ep3l4ljiojsaQxg/K+4NgZ3XcxsNe0kvc
	EZJ56hzGw2ou6tpaHrQnNToFbq29yK0j+cVxnmUp0G2K+9HZlBweniz+hSLLipRMHprlDh
	QD4c9/bf9a7g9XhAABBhhD22dawwyuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710775513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TuguZ4pEpnLQaEpC5CAxXefyoe3rAzShOZPC2cxkvkw=;
	b=/z0mKqaDX71Ea5tK0VUpklz3HQSHxU3bJemAPr+Q1RObisuKEgssVtfcoLYO0gcQih497x
	t36p8ES/P2yWknCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E07441349D;
	Mon, 18 Mar 2024 15:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t2PFNtlc+GVYTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 15:25:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 533A5A07D9; Mon, 18 Mar 2024 16:25:09 +0100 (CET)
Date: Mon, 18 Mar 2024 16:25:09 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/9] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <20240318152509.5tdmkojnhd3gqxqu@quack3>
References: <20240314140906.3064072-1-libaokun1@huawei.com>
 <20240314140906.3064072-5-libaokun1@huawei.com>
 <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfg19s2+fn9QYnUQ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon 18-03-24 18:09:18, Ojaswin Mujoo wrote:
> On Thu, Mar 14, 2024 at 10:09:01PM +0800, Baokun Li wrote:
> > We can trigger a slab-out-of-bounds with the following commands:
> > 
> >     mkfs.ext4 -F /dev/$disk 10G
> >     mount /dev/$disk /tmp/test
> >     echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
> >     echo test > /tmp/test/file && sync
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> > Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
> > CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
> > Call Trace:
> >  dump_stack_lvl+0x2c/0x50
> >  kasan_report+0xb6/0xf0
> >  ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> >  ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
> >  ext4_mb_new_blocks+0x88a/0x1370 [ext4]
> >  ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
> >  ext4_map_blocks+0x569/0xea0 [ext4]
> >  ext4_do_writepages+0x10f6/0x1bc0 [ext4]
> > [...]
> > ==================================================================
> > 
> > The flow of issue triggering is as follows:
> > 
> > // Set s_mb_group_prealloc to 2147483647 via sysfs
> > ext4_mb_new_blocks
> >   ext4_mb_normalize_request
> >     ext4_mb_normalize_group_request
> >       ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
> >   ext4_mb_regular_allocator
> >     ext4_mb_choose_next_group
> >       ext4_mb_choose_next_group_best_avail
> >         mb_avg_fragment_size_order
> >           order = fls(len) - 2 = 29
> >         ext4_mb_find_good_group_avg_frag_lists
> >           frag_list = &sbi->s_mb_avg_fragment_size[order]
> >           if (list_empty(frag_list)) // Trigger SOOB!
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
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/mballoc.c |  4 ++++
> >  fs/ext4/sysfs.c   | 13 ++++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 12b3f196010b..48afe5aa228c 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> >     return 0;
> >   if (order == MB_NUM_ORDERS(sb))
> >     order--;
> > + if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > +   order = MB_NUM_ORDERS(sb) - 1;
> 
> Hey Baokun,
> 
> Thanks for fixing this. This patch looks good to me, feel free to add:
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> my comments after this are less about the patch and more about some
> thoughts on the working of average fragment lists.
> 
> So going through the v2 and this patch got me thinking about what really
> is going to happen when a user tries to allocate 32768 blocks which is also 
> the maximum value we could have in say ac->ac_g_ex.fe_len.
> 
> When this happens, ext4_mb_regular_allocator() will directly set the
> criteria as CR_GOAL_LEN_FAST. Now, we'll follow:
> 
> ext4_mb_choose_next_group_goal_fast()
>   for (i=mb_avg_fragment_size_order(); i < MB_NUM_ORDERS; i++) { .. }
> 
> Here, mb_avg_fragment_siz_order() will do something like:
> 
>   order = fls(32768) - 2 = 14
>   ...
>   if (order == MB_NUM_ORDERS(sb))
>     order--;
> 
>   return order;
> 
> And we'll look in the fragment list[13] and since none of the groups
> there would have 32768 blocks free (since we dont track it here) we'll
> unnecessarily traverse the full list before falling to CR_BEST_AVAIL_LEN
> (this will become a noop due to the way order and min_order
> are calculated) and eventually to CR_GOAL_LEN_SLOW where we might get
> something or end up splitting.

Yeah, agreed this looks a bit suboptimal. I'm just not 100% sure whether
we'll ever generate a request to allocate 32768 blocks - that would need
verification with tracing - because I have some vague recollection I once
arrived at conclusion this is not possible.

> I think something more optimal would be to:
> 
> 1. Add another entry to average fragment lists for completely empty
> groups. (As a sidenote i think we should use something like MB_NUM_FRAG_ORDER
> instead of MB_NUM_ORDERS in calculating limits related to average
> fragment lists since the NUM_ORDERS seems to be the buddy max order ie
> 8192 blocks only valid for CR_POWER2 and shouldn't really limit the
> fragment size lists)

I guess the thinking was that you can never get larger than
1<<(MB_NUM_ORDERS-1) chunk from mballoc so there's no point to keep
fragment lists of such chunks?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

