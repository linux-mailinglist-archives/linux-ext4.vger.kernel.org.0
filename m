Return-Path: <linux-ext4+bounces-12752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FAD16319
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7581301143E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A8726CE39;
	Tue, 13 Jan 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ox0e3Nf8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AA21257B
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268670; cv=none; b=IkgLq8fp/z6s6TDT6OGDCwX/JyFP+thZt4DRGHAKLXX5rJxFd3DQv0wAHTUGzIAyMmWL0IR/tgQ3m22It0HjRkUjSfzSbNgbfg4wDiVhT1l8+1q2ZlO/6CnKsowzGIKZk6Ek0DuexyKDK88qwgdrZKMfdfFqPjMhUK1HA0MAhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268670; c=relaxed/simple;
	bh=+nuZ4vCmtN/C4d0h41FaLOqAH6hASgp1ahiK1TQrflU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=DUR5CPQ+c+4Dz2Ena/MOVLjliDSq6/lOH0wesPpPv2azwYpV6cKVQ5h9XzhTHiQ0XwSPkHqQOMwEUW9vSvEhHdp2bZttfMMWQw8RgRgVBq9nw+ltk/jKwFRHa2wvH+AIW0QWbbgAlgmW7/oInQEXBDyRrVSf0CoNtAfghjmZTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ox0e3Nf8; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FNbwkpMKdA749WWSB8NV7VvQLEBdZCrW18l/xwz310E=;
	b=ox0e3Nf8eZkoldrCbEtPliFdwy8BUs95qDFebbN+wEFjxVl0sED+bugfhUhlbmbCV5hd7Pbq3
	Y5NluRytl2qH1pgMtKtCKumJMXWTlSVmYMaHOxKpy95pECXEjPtMYQfZ20iZ9OAoa7c3YLmxRYX
	iQy1J4PLtqjTIWxhOn1oazo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dqsQD4J3NzcZxp;
	Tue, 13 Jan 2026 09:40:36 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C3A224056E;
	Tue, 13 Jan 2026 09:44:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 Jan
 2026 09:44:18 +0800
Message-ID: <94ccc367-f631-40fe-a99e-635d1eb0a3dd@huawei.com>
Date: Tue, 13 Jan 2026 09:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: fix dirtyclusters double decrement on fs
 shutdown
Content-Language: en-GB
To: Brian Foster <bfoster@redhat.com>
References: <20260112143652.8085-1-bfoster@redhat.com>
CC: <linux-ext4@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260112143652.8085-1-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-12 22:36, Brian Foster wrote:
> fstests test generic/388 occasionally reproduces a warning in
> ext4_put_super() associated with the dirty clusters count:
>
>   WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]
>
> Tracing the failure shows that the warning fires due to an
> s_dirtyclusters_counter value of -1. IOW, this appears to be a
> spurious decrement as opposed to some sort of leak. Further tracing
> of the dirty cluster count deltas and an LLM scan of the resulting
> output identified the cause as a double decrement in the error path
> between ext4_mb_mark_diskspace_used() and the caller
> ext4_mb_new_blocks().
>
> First, note that generic/388 is a shutdown vs. fsstress test and so
> produces a random set of operations and shutdown injections. In the
> problematic case, the shutdown triggers an error return from the
> ext4_handle_dirty_metadata() call(s) made from
> ext4_mb_mark_context(). The changed value is non-zero at this point,
> so ext4_mb_mark_diskspace_used() does not exit after the error
> bubbles up from ext4_mb_mark_context(). Instead, the former
> decrements both cluster counters and returns the error up to
> ext4_mb_new_blocks(). The latter falls into the !ar->len out path
> which decrements the dirty clusters counter a second time, creating
> the inconsistency.
>
> To avoid this problem and simplify ownership of the cluster
> reservation in this codepath, lift the counter reduction to a single
> place in the caller. This makes it more clear that
> ext4_mb_new_blocks() is responsible for acquiring cluster
> reservation (via ext4_claim_free_clusters()) in the !delalloc case
> as well as releasing it, regardless of whether it ends up consumed
> or returned due to failure.
>
> Fixes: 0087d9fb3f29 ("ext4: Fix s_dirty_blocks_counter if block allocation failed with nodelalloc")
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Thanks for the patch.

However, the call site in test_mark_diskspace_used_range() missed the
argument update, which triggered a Kernel Test Robot warning. Also,
I have one nit below.

> ---
>
> v2:
> - Condense counter update logic instead of modifying return flow.
> - Added Fixes: tag.
> v1: https://lore.kernel.org/linux-ext4/20251212154735.512651-1-bfoster@redhat.com/
>
>  fs/ext4/mballoc.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..b31d7ddc52a9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4185,8 +4185,7 @@ ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
>   * Returns 0 if success or error code
>   */
>  static noinline_for_stack int
> -ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
> -				handle_t *handle, unsigned int reserv_clstrs)
> +ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
>  {
>  	struct ext4_group_desc *gdp;
>  	struct ext4_sb_info *sbi;
> @@ -4241,13 +4240,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  	BUG_ON(changed != ac->ac_b_ex.fe_len);
>  #endif
>  	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
> -	/*
> -	 * Now reduce the dirty block count also. Should not go negative
> -	 */
> -	if (!(ac->ac_flags & EXT4_MB_DELALLOC_RESERVED))
> -		/* release all the reserved blocks if non delalloc */
> -		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
> -				   reserv_clstrs);
>  
>  	return err;
>  }
> @@ -6332,7 +6324,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  			ext4_mb_pa_put_free(ac);
>  	}
>  	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
> -		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
> +		*errp = ext4_mb_mark_diskspace_used(ac, handle);
>  		if (*errp) {
>  			ext4_discard_allocated_blocks(ac);
>  			goto errout;
> @@ -6363,12 +6355,9 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  out:
>  	if (inquota && ar->len < inquota)
>  		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
> -	if (!ar->len) {
> -		if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)
> -			/* release all the reserved blocks if non delalloc */
> -			percpu_counter_sub(&sbi->s_dirtyclusters_counter,
> -						reserv_clstrs);
> -	}
> +	/* release all the reserved blocks if non delalloc */
> +	if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)

Nit: It might be better to check if (reserv_clstrs) directly. It’s more
straightforward and stays robust even if the flag logic changes later.

> +		percpu_counter_sub(&sbi->s_dirtyclusters_counter, reserv_clstrs);
>  
>  	trace_ext4_allocate_blocks(ar, (unsigned long long)block);
>  



