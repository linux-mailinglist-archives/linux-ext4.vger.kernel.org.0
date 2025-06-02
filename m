Return-Path: <linux-ext4+bounces-8278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B95ACB8B7
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A5F7A636F
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D386221F06;
	Mon,  2 Jun 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qCWL+kRA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WudUNCtB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qCWL+kRA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WudUNCtB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF564221299
	for <linux-ext4@vger.kernel.org>; Mon,  2 Jun 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879082; cv=none; b=FPoyVq448fm2Clx6kLrvkqpTVN5rY9iXN7V330tiW/gkSN/oqAiH0r08sfXNH79JjTnp+jrttjy+oyByQPByOhgT1MFUwNlqZXxHq724YGyXTaC932TMWe3pqLs8l5MWVFiocwNyYGSS+iEs4ZZ7aVL48JvlKnx8oSLsypCnFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879082; c=relaxed/simple;
	bh=5BGy1ZFZgVdgU4Ybb7k6V7+DZSi2lSFfGDksG89sg8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUDXKlriPiRAzpH1YK3L/yFXpMxaRJEVQHfvs5gDZQ+3sW6p5Bs/F0G+CP3owgxxA6Rw6VwN0obxLhtEezPu4t+S/ffYaMmZsHIdsxbfe8YvR+Refhud38/xiurO2CaK18OTrfBOgr5E07bmLN1lQz98bUjvthbgHKAKTA3M4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qCWL+kRA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WudUNCtB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qCWL+kRA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WudUNCtB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C72CD1F790;
	Mon,  2 Jun 2025 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748879078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfjyeHEyh7hJgT7OoNiC1/dbvbwsMYqtSmG3KK/uKg=;
	b=qCWL+kRAlUoVS6m98KucsKQiLqjhxiM1cbeEkAQ5438Nae55BMyDQhuQr9rPgSUIkZoS9V
	1/qk/Q5FqoC2mDCN4VmHFI83GN/V553dFJ8nPywpYd1hqAeKuvX0WKXYNdw2GRVgABop7F
	seLo5xGXWwdyZApFn3nc+DjRxG6cGP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748879078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfjyeHEyh7hJgT7OoNiC1/dbvbwsMYqtSmG3KK/uKg=;
	b=WudUNCtBM6ZsOE+mX0H4R4Vbv6NXgCz3c6NGEETTm+gBh90jQ6/BjCA+/2O+wh7B8wQpfB
	/sgjg0csdZ9KrRCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748879078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfjyeHEyh7hJgT7OoNiC1/dbvbwsMYqtSmG3KK/uKg=;
	b=qCWL+kRAlUoVS6m98KucsKQiLqjhxiM1cbeEkAQ5438Nae55BMyDQhuQr9rPgSUIkZoS9V
	1/qk/Q5FqoC2mDCN4VmHFI83GN/V553dFJ8nPywpYd1hqAeKuvX0WKXYNdw2GRVgABop7F
	seLo5xGXWwdyZApFn3nc+DjRxG6cGP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748879078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGfjyeHEyh7hJgT7OoNiC1/dbvbwsMYqtSmG3KK/uKg=;
	b=WudUNCtBM6ZsOE+mX0H4R4Vbv6NXgCz3c6NGEETTm+gBh90jQ6/BjCA+/2O+wh7B8wQpfB
	/sgjg0csdZ9KrRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2C4E13A63;
	Mon,  2 Jun 2025 15:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iq6eK+bGPWiLAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Jun 2025 15:44:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67FC4A094C; Mon,  2 Jun 2025 17:44:30 +0200 (CEST)
Date: Mon, 2 Jun 2025 17:44:30 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 2/4] ext4: move mb_last_[group|start] to ext4_inode_info
Message-ID: <5oqysbekjn7vazkzrh4lgtg25vqqxgrugvld6av7r2nx7dbghr@kk4yidjw735c>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-3-libaokun@huaweicloud.com>
 <afjkyrm4y5mp5p72ew3ddqma7v4gkmjqdkcloeaidcj55ruami@zfkn6dzgqfwh>
 <6200e067-0ad1-4dc4-9694-05ee1e977f4c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6200e067-0ad1-4dc4-9694-05ee1e977f4c@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Level: 

Hello!

On Fri 30-05-25 17:31:48, Baokun Li wrote:
> On 2025/5/29 20:56, Jan Kara wrote:
> > On Fri 23-05-25 16:58:19, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > After we optimized the block group lock, we found another lock
> > > contention issue when running will-it-scale/fallocate2 with multiple
> > > processes. The fallocate's block allocation and the truncate's block
> > > release were fighting over the s_md_lock. The problem is, this lock
> > > protects totally different things in those two processes: the list of
> > > freed data blocks (s_freed_data_list) when releasing, and where to start
> > > looking for new blocks (mb_last_[group|start]) when allocating.
> > > 
> > > Moreover, when allocating data blocks, if the first try (goal allocation)
> > > fails and stream allocation is on, it tries a global goal starting from
> > > the last group we used (s_mb_last_group). This can make things faster by
> > > writing blocks close together on the disk. But when many processes are
> > > allocating, they all fight over s_md_lock and might even try to use the
> > > same group. This makes it harder to merge extents and can make files more
> > > fragmented. If different processes allocate chunks of very different sizes,
> > > the free space on the disk can also get fragmented. A small allocation
> > > might fit in a partially full group, but a big allocation might have
> > > skipped it, leading to the small IO ending up in a more empty group.
> > > 
> > > So, we're changing stream allocation to work per inode. First, it tries
> > > the goal, then the last group where that inode successfully allocated a
> > > block. This keeps an inode's data closer together. Plus, after moving
> > > mb_last_[group|start] to ext4_inode_info, we don't need s_md_lock during
> > > block allocation anymore because we already have the write lock on
> > > i_data_sem. This gets rid of the contention between allocating and
> > > releasing blocks, which gives a huge performance boost to fallocate2.
> > > 
> > > Performance test data follows:
> > > 
> > > CPU: HUAWEI Kunpeng 920
> > > Memory: 480GB
> > > Disk: 480GB SSD SATA 3.2
> > > Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
> > > Observation: Average fallocate operations per container per second.
> > > 
> > >                        base     patched
> > > mb_optimize_scan=0    6755     23280 (+244.6%)
> > > mb_optimize_scan=1    4302     10430 (+142.4%)
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > Good spotting with the s_md_lock contention here. But your changes don't
> > quite make sense to me. The idea of streaming allocation in mballoc is to
> > have an area of filesystem for large files to reduce fragmentation.  When
> > you switch to per-inode, this effect of packing large files together goes
> > away. Futhermore for each inode either all allocations will be very likely
> > streaming or not streaming (the logic uses file size) so either your
> > per-inode target will be unused or just another constantly used copy of
> > goal value.
> Sorry, I didn't intend to  break streaming allocation's semantics.
> A precise definition of streaming allocation is not found in the
> existing code, documentation, or historical records. Consequently,
> my previous understanding of it was somewhat inaccurate.
> 
> I previously thought it was used to optimize the efficiency of linear
> traversal. For instance, if 500 inodes are created in group 0 and each
> file is sequentially filled to 1GB, each file's goal, being empty, would
> be group 1 (the second group in the inode's flex_bg).
> 
> Without a global goal and in the absence of non-linear traversal,
> after the first inode is filled, the second inode would need to traverse
> groups 1 through 8 to find its first free block.
> 
> This inefficiency escalates, eventually requiring the 500th inode to
> potentially traverse almost 4000 block groups to find its first available
> block.

I see. But doesn't ext4_mb_choose_next_group() usually select group from
which allocation can succeed instead of linearly scanning through all the
groups? The linear scan is just a last resort as far as I remember. Anyway
I'm not 100% sure what was the original motivation for the streaming goal.
Maybe Andreas would remember since he was involved in the design.  What I
wrote is mostly derived from the general understanding of mballoc operating
principles but I could be wrong.

> I initially believed it could be split to the inode level to reduce
> traversal time and file fragmentation. However, as you pointed out,
> its purpose is to cluster large files, not data blocks within a file.
> Given this, splitting it to the inode level no longer makes sense.
> > So I can see two sensible solutions here:
> > a) Drop streaming allocations support altogether.
> As mentioned above, it can also greatly improve the efficiency of linear
> traversal, so we can't simply remove it.
> > 
> > b) Enhance streaming allocation support to avoid contention between
> > processes allocating in parallel and freeing. Frankly, there's no strong
> > reason why reads & writes of streaming allocation goal need to use a
> > spinlock AFAICS.
> Yes, since it's just a hint, we don't need a lock at all, not even
> fe_start, we just need the last fe_group.
> > We could just store a physical block number and use
> > atomic64 accessors for it? Also having single goal value is just causing
> > more contention on group locks for parallel writers that end up using it
> > (that's the problem I suspect you were hitting the most).
> Spot on! We did try a single, lockless atomic64 variable, and just as
> you pointed out, all processes started traversing from the very same
> group, which just cranked up the contention, dropping OPS to just 6745.
> >   So perhaps we
> > can keep multiple streaming goal slots in the superblock (scale the count
> > based on CPU count & filesystem group count) and just pick the slot based
> > on inode number hash to reduce contention?
> > 
> > 								Honza
> That's a brilliant idea, actually!
> 
> Since most containers are CPU-pinned, this would naturally cluster a single
> container's data blocks together. I believe we can also apply this to inode
> allocation, so a container's inodes and data are all in a single region,
> significantly reducing interference between containers.
> 
> My gratitude for your valuable suggestion!
> I'm going to try out the CPU bucketing approach.

Cool, let's see how it works out :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

