Return-Path: <linux-ext4+bounces-12803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B415ED1BEEF
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 02:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970933046554
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D22BEFF5;
	Wed, 14 Jan 2026 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LQSmJ9MZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB9199D8
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354088; cv=none; b=t3ZobHpnKS6+n+eCbN3Pa7KvAbJl12V4vRkJoLjWNpITBkPDP9Yo+mKv/9a+ybGdKrbq03pAyb+Smm/xJbXO8VSRdrjcIc7UXRwxvZ7PkMbQ2BqpupXAC6nM3TUL6iETW4o+KTwRCzTAucnhzAkRnfhinJ2w945QzSkcLorCIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354088; c=relaxed/simple;
	bh=TpegdtQmc+DuKYvDdG+v5J3jSOSwxKBXx7if9M4riGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=D6AbtCdJ6rUCg6jdslF0p2O/XHVQtHWk0JsQkd6HYtfo+gLOYMCXJazmT8D0+9YmLtq1nMrp/dC3yvOZzySWukELRcQtfjIiWijIoWVhKaR5k/Bk7emLbTO9F5jS1v1Uorbxv+8KxvY9jgZMjYNAqtJkyS3ZCA0jdZX5juHow/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LQSmJ9MZ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CfZ8ezJ9oLWColdX6JsxFKhR1JSjaa5wwhvkTcVVoF4=;
	b=LQSmJ9MZeErvGRz3Mrei8IRSkyE1x4HZhiRWwpxQ9XSTi/DE7Q+x1fsbnYoK6RWJamcXpVHsA
	/Y1hW5Rg9xosVw15O7kLak0KBKOqn/FVtXtNEkiltsWIPmXT1YGwOTh68VeHybu6DRxDN6tnlNK
	caaOpWJOICmpizw0EePLoh8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4drT116Sc0zpSvB;
	Wed, 14 Jan 2026 09:24:21 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id D8A68201E9;
	Wed, 14 Jan 2026 09:27:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Jan
 2026 09:27:54 +0800
Message-ID: <9c7d91dc-0d19-463a-860f-fb62c04a77ee@huawei.com>
Date: Wed, 14 Jan 2026 09:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ext4: fix dirtyclusters double decrement on fs
 shutdown
Content-Language: en-GB
To: Brian Foster <bfoster@redhat.com>
References: <20260113171905.118284-1-bfoster@redhat.com>
From: Baokun Li <libaokun1@huawei.com>
CC: <linux-ext4@vger.kernel.org>
In-Reply-To: <20260113171905.118284-1-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-14 01:19, Brian Foster wrote:
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

Looks good! Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>
> v3:
> - Fix up ext4_mb_mark_diskspace_used() call in mballoc-test.c.
> - Tweak reserved clusters release logic.
> v2: https://lore.kernel.org/linux-ext4/20260112143652.8085-1-bfoster@redhat.com/
> - Condense counter update logic instead of modifying return flow.
> - Added Fixes: tag.
> v1: https://lore.kernel.org/linux-ext4/20251212154735.512651-1-bfoster@redhat.com/
>
>
>  fs/ext4/mballoc-test.c |  2 +-
>  fs/ext4/mballoc.c      | 21 +++++----------------
>  2 files changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index a9416b20ff64..4abb40d4561c 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -567,7 +567,7 @@ test_mark_diskspace_used_range(struct kunit *test,
>  
>  	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
>  	memset(bitmap, 0, sb->s_blocksize);
> -	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
> +	ret = ext4_mb_mark_diskspace_used(ac, NULL);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	max = EXT4_CLUSTERS_PER_GROUP(sb);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..b3272266220d 100644
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
> +	/* release any reserved blocks */
> +	if (reserv_clstrs)
> +		percpu_counter_sub(&sbi->s_dirtyclusters_counter, reserv_clstrs);
>  
>  	trace_ext4_allocate_blocks(ar, (unsigned long long)block);
>  



