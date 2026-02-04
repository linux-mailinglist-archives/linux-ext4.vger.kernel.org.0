Return-Path: <linux-ext4+bounces-13518-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKlkE0LngmlTegMAu9opvQ
	(envelope-from <linux-ext4+bounces-13518-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 07:29:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6117E2533
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 07:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D516F304F21F
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121F37F11E;
	Wed,  4 Feb 2026 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="080blcXj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9B37F0F4;
	Wed,  4 Feb 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186555; cv=none; b=Tz1+i/vie1/dmVJiUKsOc2jBSBZ5hlesFjyQ1VodS/od4sccqWaUwnJEtPTTY8BP/vc6LdBhglqRQw9iNCAE4VIrKVUYgKGVB3Qa2VR5zOdlnX9D0Ev0D6FbWKGO/nr0PNfMcx8SZjsDSes+D6Ruj6dwvyVf+DZImN17wTq2PR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186555; c=relaxed/simple;
	bh=2KyYnjnFnxV0kXpqvPA5fd74nfX9k3kv/XEQU3f4b7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUQvTVTJpyyntQZB1vQtX6lg9HThw2UlHi6xsE0Zkr2aY4SkA54V1yq9pxALkI6Cj0yXawMbdEm+LuAZv/k+XbwWwUJTVkI8oeMsq6PqrHPLSYY4QJi6ibj4XelPw8uDlWfSIGqJyggLyczseZf40JC3+hcA4YKZ7BUUfPucBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=080blcXj; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FAoHAVu5PeBUU58hDd9iKhl+JihlYYfgLxt55xiyZf0=;
	b=080blcXj2PQV2Ne3zGhfSEivFm2W39MrbUWj1NTgbttkYaefE2VF0kp5ZNn6QkD5DGdjtqVtU
	ma/Wu/mfWeUqSJ6icP5YlfOfMoMFgsgmb5wUzOTME1GNAL9AmoF8PJ4PaEwsN8Yan5fK5iF6qly
	CF20CKEbtsGPi05ZfoddQHY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f5VhD27TFzpStQ;
	Wed,  4 Feb 2026 14:25:00 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B83A440363;
	Wed,  4 Feb 2026 14:29:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 14:29:09 +0800
Message-ID: <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
Date: Wed, 4 Feb 2026 14:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
To: Mario Lohajner <mario_lohajner@rocketmail.com>, <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>,
	<libaokun9@gmail.com>, Baokun Li <libaokun1@huawei.com>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260204033112.406079-1-mario_lohajner@rocketmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,vger.kernel.org,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-13518-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com,mit.edu];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun1@huawei.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: A6117E2533
X-Rspamd-Action: no action

On 2026-02-04 11:31, Mario Lohajner wrote:
> Add support for the rotalloc allocation policy as a new mount
> option. Policy rotates the starting block group for new allocations.
>
> Changes:
> - fs/ext4/ext4.h
> 	rotalloc policy dedlared, extend sb with cursor, vector & lock
>
> - fs/ext4/mballoc.h
> 	expose allocator functions for vectoring in super.c
>
> - fs/ext4/super.c
> 	parse rotalloc mnt opt, init cursor, lock and allocator vector
>
> - fs/ext4/mballoc.c
> 	add rotalloc allocator, vectored allocator call in new_blocks
>
> The policy is selected via a mount option and does not change the
> on-disk format or default allocation behavior. It preserves existing
> allocation heuristics within a block group while distributing
> allocations across block groups in a deterministic sequential manner.
>
> The rotating allocator is implemented as a separate allocation path
> selected at mount time. This avoids conditional branches in the regular
> allocator and keeps allocation policies isolated.
> This also allows the rotating allocator to evolve independently in the
> future without increasing complexity in the regular allocator.
>
> The policy was tested using v6.18.6 stable locally with the new mount
> option "rotalloc" enabled, confirmed working as desribed!
>
> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
> ---
>  fs/ext4/ext4.h    |   8 +++
>  fs/ext4/mballoc.c | 152 ++++++++++++++++++++++++++++++++++++++++++++--
>  fs/ext4/mballoc.h |   3 +
>  fs/ext4/super.c   |  18 +++++-
>  4 files changed, 175 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..cbbb7c05d7a2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
>  	unsigned int flags;
>  };
>  
> +/* expose rotalloc allocator argument pointer type */
> +struct ext4_allocation_context;
> +
>  /*
>   * Logical to physical block mapping, used by ext4_map_blocks()
>   *
> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>   * Mount flags set via mount options or defaults
>   */
>  #define EXT4_MOUNT_NO_MBCACHE		0x00001 /* Do not use mbcache */
> +#define EXT4_MOUNT_ROTALLOC			0x00002 /* Use rotalloc policy/allocator */
>  #define EXT4_MOUNT_GRPID		0x00004	/* Create files with directory's group */
>  #define EXT4_MOUNT_DEBUG		0x00008	/* Some debugging messages */
>  #define EXT4_MOUNT_ERRORS_CONT		0x00010	/* Continue on errors */
> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
>  	unsigned long s_mount_flags;
>  	unsigned int s_def_mount_opt;
>  	unsigned int s_def_mount_opt2;
> +	/* Rotalloc cursor, lock & new_blocks allocator vector */
> +	unsigned int s_rotalloc_cursor;
> +	spinlock_t s_rotalloc_lock;
> +	int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
>  	ext4_fsblk_t s_sb_block;
>  	atomic64_t s_resv_clusters;
>  	kuid_t s_resuid;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..74f79652c674 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>   *   stop the scan and use it immediately
>   *
>   * * If free extent found is smaller than goal, then keep retrying
> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). After
>   *   that stop scanning and use whatever we have.
>   *
>   * * If free extent found is bigger than goal, then keep retrying
> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) before
>   *   stopping the scan and using the extent.
>   *
>   *
> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct ext4_allocation_context *ac,
>  	return ret;
>  }
>  
> -static noinline_for_stack int
> +noinline_for_stack int
>  ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  {
>  	ext4_group_t i;
> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  	 * is greater than equal to the sbi_s_mb_order2_reqs
>  	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>  	 * We also support searching for power-of-two requests only for
> -	 * requests upto maximum buddy size we have constructed.
> +	 * requests up to maximum buddy size we have constructed.
>  	 */
>  	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
>  		if (is_power_of_2(ac->ac_g_ex.fe_len))
> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  	return err;
>  }
>  
> +/* Rotating allocator (rotalloc mount option) */
> +noinline_for_stack int
> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
> +{
> +	ext4_group_t i, goal;
> +	int err = 0;
> +	struct super_block *sb = ac->ac_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_buddy e4b;
> +
> +	BUG_ON(ac->ac_status == AC_STATUS_FOUND);
> +
> +	/* Set the goal from s_rotalloc_cursor */
> +	spin_lock(&sbi->s_rotalloc_lock);
> +	goal = sbi->s_rotalloc_cursor;
> +	spin_unlock(&sbi->s_rotalloc_lock);
> +	ac->ac_g_ex.fe_group = goal;
> +
> +	/* first, try the goal */
> +	err = ext4_mb_find_by_goal(ac, &e4b);
> +	if (err || ac->ac_status == AC_STATUS_FOUND)
> +		goto out;
> +
> +	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> +		goto out;
> +
> +	/*
> +	 * ac->ac_2order is set only if the fe_len is a power of 2
> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
> +	 * so that we try exact allocation using buddy.
> +	 */
> +	i = fls(ac->ac_g_ex.fe_len);
> +	ac->ac_2order = 0;
> +	/*
> +	 * We search using buddy data only if the order of the request
> +	 * is greater than equal to the sbi_s_mb_order2_reqs
> +	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
> +	 * We also support searching for power-of-two requests only for
> +	 * requests up to maximum buddy size we have constructed.
> +	 */
> +	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
> +		if (is_power_of_2(ac->ac_g_ex.fe_len))
> +			ac->ac_2order = array_index_nospec(i - 1,
> +							   MB_NUM_ORDERS(sb));
> +	}
> +
> +	/* if stream allocation is enabled, use global goal */
> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> +		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
> +
> +		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
> +		ac->ac_g_ex.fe_start = -1;
> +		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;

Rotating block allocation looks a lot like stream allocation—they both
pick up from where the last successful allocation left off.

I noticed that the stream allocation's global goal is now split up.
Is there an advantage to keeping it as a single goal?
Alternatively, do you see any downsides to this split in your use case?



