Return-Path: <linux-ext4+bounces-8705-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B4AED776
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD1217514C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1D23E325;
	Mon, 30 Jun 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b8EiaXph";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqITN2RK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b8EiaXph";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqITN2RK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6201D8A10
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272696; cv=none; b=OVCJyOfRPormIPGKc60OrLixc/xtBPS9Q+iC68s5JjaaTqlttvmlbdO/OB6vpoy7E6LEQWpat6J2Vk6vjyYsnhTt8cIPvAWo7+W6kqotsZwiGWYI2R13SnxpeinhM+RbKI47ir2b1PdwwVhgELRBWxcP9rVq1uBefRzXHKBSffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272696; c=relaxed/simple;
	bh=5HJR6Ip4/vKwlAS2wmyEw7S9naxRwzxmIBnM7Kb7su4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAtjviJCFU/8mAiKuzR88e4ijxBmEdlpacSxuXP0HLxv21+04qDBMcYJlAGk38v0SQZbAyb42HzHXXMw0a6bUrge5Z9zqopADv4XrEe2bu1hNAuIbRoDyInSIZ99HRI08cG5WZVl//pAtSKhqqLsubLHCTXaNWgz9OPxpXr295Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b8EiaXph; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqITN2RK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b8EiaXph; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqITN2RK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 035181F45B;
	Mon, 30 Jun 2025 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751272693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjr1wzhf+8qcZOiOvTCjm4oRU6y/wppcg9keS2Tojaw=;
	b=b8EiaXphj0uJBqIoWtFS/c8SfcKWHt0FfPBlD23oyjuw3dnV5ij0OeNljFH3gUBlhvxCO+
	gadGfCL6L+OwFB/zY+2v5NnRpDvWSzdt+IZ5R2iyvbRGmOFvcjRloZRJiG4o52d5qmxXh3
	jf2+k+whMwzWuE+zRmrAgREXg1LBlas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751272693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjr1wzhf+8qcZOiOvTCjm4oRU6y/wppcg9keS2Tojaw=;
	b=fqITN2RKQBK6qTFyS/fLhr1xhs76aD0i7HV61qpbQHixlWJRZRgmRhsEiY5fUCDVW+SE4L
	Xot4Nu+aBvDH4uCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b8EiaXph;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fqITN2RK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751272693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjr1wzhf+8qcZOiOvTCjm4oRU6y/wppcg9keS2Tojaw=;
	b=b8EiaXphj0uJBqIoWtFS/c8SfcKWHt0FfPBlD23oyjuw3dnV5ij0OeNljFH3gUBlhvxCO+
	gadGfCL6L+OwFB/zY+2v5NnRpDvWSzdt+IZ5R2iyvbRGmOFvcjRloZRJiG4o52d5qmxXh3
	jf2+k+whMwzWuE+zRmrAgREXg1LBlas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751272693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjr1wzhf+8qcZOiOvTCjm4oRU6y/wppcg9keS2Tojaw=;
	b=fqITN2RKQBK6qTFyS/fLhr1xhs76aD0i7HV61qpbQHixlWJRZRgmRhsEiY5fUCDVW+SE4L
	Xot4Nu+aBvDH4uCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D844C1399F;
	Mon, 30 Jun 2025 08:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FN/ENPRMYmhifwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 08:38:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 722B5A08D2; Mon, 30 Jun 2025 10:38:12 +0200 (CEST)
Date: Mon, 30 Jun 2025 10:38:12 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 04/16] ext4: utilize multiple global goals to reduce
 contention
Message-ID: <qtdxe2rmnvrxdjmp26ro4l5erwq5lrbvmvysxfgqddadnpr7x4@xrkrdjkgsh67>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-5-libaokun1@huawei.com>
 <xmhuzjcgujdvmgmnc3mfd45txehmq73fiyg32vr6h7ldznctlq@rosxe25scojb>
 <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 035181F45B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 30-06-25 14:50:30, Baokun Li wrote:
> On 2025/6/28 2:31, Jan Kara wrote:
> > On Mon 23-06-25 15:32:52, Baokun Li wrote:
> > > When allocating data blocks, if the first try (goal allocation) fails and
> > > stream allocation is on, it tries a global goal starting from the last
> > > group we used (s_mb_last_group). This helps cluster large files together
> > > to reduce free space fragmentation, and the data block contiguity also
> > > accelerates write-back to disk.
> > > 
> > > However, when multiple processes allocate blocks, having just one global
> > > goal means they all fight over the same group. This drastically lowers
> > > the chances of extents merging and leads to much worse file fragmentation.
> > > 
> > > To mitigate this multi-process contention, we now employ multiple global
> > > goals, with the number of goals being the CPU count rounded up to the
> > > nearest power of 2. To ensure a consistent goal for each inode, we select
> > > the corresponding goal by taking the inode number modulo the total number
> > > of goals.
> > > 
> > > Performance test data follows:
> > > 
> > > Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> > > Observation: Average fallocate operations per container per second.
> > > 
> > >                     | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
> > >   Disk: 960GB SSD   |-------------------------|-------------------------|
> > >                     | base  |    patched      | base  |    patched      |
> > > -------------------|-------|-----------------|-------|-----------------|
> > > mb_optimize_scan=0 | 7612  | 19699 (+158%)   | 21647 | 53093 (+145%)   |
> > > mb_optimize_scan=1 | 7568  | 9862  (+30.3%)  | 9117  | 14401 (+57.9%)  |
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ...
> > 
> > > +/*
> > > + * Number of mb last groups
> > > + */
> > > +#ifdef CONFIG_SMP
> > > +#define MB_LAST_GROUPS roundup_pow_of_two(nr_cpu_ids)
> > > +#else
> > > +#define MB_LAST_GROUPS 1
> > > +#endif
> > > +
> > I think this is too aggressive. nr_cpu_ids is easily 4096 or similar for
> > distribution kernels (it is just a theoretical maximum for the number of
> > CPUs the kernel can support)
> 
> nr_cpu_ids is generally equal to num_possible_cpus(). Only when
> CONFIG_FORCE_NR_CPUS is enabled will nr_cpu_ids be set to NR_CPUS,
> which represents the maximum number of supported CPUs.

Indeed, CONFIG_FORCE_NR_CPUS confused me.

> > which seems like far too much for small
> > filesystems with say 100 block groups.
> 
> It does make sense.
> 
> > I'd rather pick the array size like:
> > 
> > min(num_possible_cpus(), sbi->s_groups_count/4)
> > 
> > to
> > 
> > a) don't have too many slots so we still concentrate big allocations in
> > somewhat limited area of the filesystem (a quarter of block groups here).
> > 
> > b) have at most one slot per CPU the machine hardware can in principle
> > support.
> > 
> > 								Honza
> 
> You're right, we should consider the number of block groups when setting
> the number of global goals.
> 
> However, a server's rootfs can often be quite small, perhaps only tens of
> GBs, while having many CPUs. In such cases, sbi->s_groups_count / 4 might
> still limit the filesystem's scalability.

I would not expect such root filesystem to be loaded by many big
allocations in parallel :). And with 4k blocksize 32GB filesystem would
have already 64 goals which doesn't seem *that* limiting?

Also note that as the filesystem is filling up and the free space is getting
fragmented, the number of groups where large allocation can succeed will
reduce. Thus regardless of how many slots for streaming goal you have, they
will all end up pointing only to those several groups where large
still allocation succeeds. So although large number of slots looks good for
an empty filesystem, the benefit for aged filesystem is diminishing and
larger number of slots will make the fs fragment faster.

> Furthermore, after supporting LBS, the number of block groups will
> sharply decrease.

Right. This is going to reduce scalability of block allocation in general.
Also as the groups grow larger with larger blocksize the benefit of
streaming allocation which just gives a hint about block group to use is
going to diminish when the free block search will be always starting from
0. We will maybe need to store ext4_fsblk_t (effectively combining
group+offset in a single atomic unit) as a streaming goal to mitigate this.

> How about we directly use sbi->s_groups_count (which would effectively be
> min(num_possible_cpus(), sbi->s_groups_count)) instead? This would also
> avoid zero values.

Avoiding zero values is definitely a good point. My concern is that if we
have sb->s_groups_count streaming goals, then practically each group will
become a streaming goal group and thus we can just remove the streaming
allocation altogether, there's no benefit.

We could make streaming goal to be ext4_fsblk_t so that also offset of the
last big allocation in the group is recorded as I wrote above. That would
tend to pack big allocations in each group together which is benefitial to
combat fragmentation even with higher proportion of groups that are streaming
goals (and likely becomes more important as the blocksize and thus group
size grow). We can discuss proper number of slots for streaming allocation
(I'm not hung up on it being quarter of the group count) but I'm convinced
sb->s_groups_count is too much :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

