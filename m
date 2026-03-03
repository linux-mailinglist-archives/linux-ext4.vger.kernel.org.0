Return-Path: <linux-ext4+bounces-14475-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF0cAERJpmleNgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14475-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 03:36:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46A1E81E2
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 03:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF4B302E7EC
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 02:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE2375F76;
	Tue,  3 Mar 2026 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lfc+rIMB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28EA375F80
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505406; cv=none; b=shWMrZcwZkO2g2TpoYrNsHHwlE3/1MA4YEoQHMO/H3xa9f2TgWilLg0+DHDjOGzyNhyxKNak7xP6hzNvWzUOhb9vq/Qi7LdKtmdc8EFBcd7VqV/+9DzjiKg3BuswZVGzjKh4ezBESzKf3GQBO3o+UM93+La1L01BdjTqPO2Mgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505406; c=relaxed/simple;
	bh=SstLVoPgW2DAHDXYz+LJvSQcHtkoNP/EvwaIN8/CtpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+aYfgwyOiijXTAnPmizL4G7Rgo8DcEotP+XN4tUbz0FmtnGrDpem8/CawIiwIrao2/3YpqEHSl6DEDidcBcMvE7W+BupnE/e1ZEl8wFac5h5Wcev7EZ+It4h54x7AmCwcPAghKrTGxnDTk6LW3B5Fvcofq90O9MuLH5+xBaOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lfc+rIMB; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772505402; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QFlnj6RFEUeesbO+l+2Ge3cqltJPBYZWnevUN6K+jMM=;
	b=lfc+rIMBy6O8rigJX5TJBQvLjjMvwGnbMR2wK7GdUHn/W7E4UCpzDsztr2VCWQnssWYEh0vA1HA8rSeQQDTJY2RdKfFuI+dzOlQTNlKo9Tr7bl5fjd3lpKzfK5DelVowvfqRVs/MmV30EtuOAzkWCVOj5R7qtBIn8tKXgy2ujZY=
Received: from 30.221.146.232(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X-8BzXS_1772505401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 10:36:42 +0800
Message-ID: <80be4b7a-976f-44cc-a50d-66a0e9ed05a0@linux.alibaba.com>
Date: Tue, 3 Mar 2026 10:36:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: avoid allocate block from corrupted group in
 ext4_mb_find_by_goal()
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org
References: <20260302134619.3145520-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260302134619.3145520-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6E46A1E81E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14475-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 3/2/26 9:46 PM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> There's issue as follows:
> ...
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at logical offset 0 with max blocks 1 with error 117
> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>
> EXT4-fs (mmcblk0p1): error count since last fsck: 1
> EXT4-fs (mmcblk0p1): initial error at time 1765597433: ext4_mb_generate_buddy:760
> EXT4-fs (mmcblk0p1): last error at time 1765597433: ext4_mb_generate_buddy:760
> ...
>
> According to the log analysis, blocks are always requested from the
> corrupted block group. This may happen as follows:
> ext4_mb_find_by_goal
>   ext4_mb_load_buddy
>    ext4_mb_load_buddy_gfp
>      ext4_mb_init_cache
>       ext4_read_block_bitmap_nowait
>       ext4_wait_block_bitmap
>        ext4_validate_block_bitmap
>         if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
>          return -EFSCORRUPTED; // There's no logs.
>  if (err)
>   return err;  // Will return error
> ext4_lock_group(ac->ac_sb, group);
>   if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // Unreachable
>    goto out;
>
> After commit 9008a58e5dce ("ext4: make the bitmap read routines return
> real error codes") merged, Commit 163a203ddb36 ("ext4: mark block group
> as corrupt on block bitmap error") is no real solution for allocating
> blocks from corrupted block groups. This is because if
> 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
> 'ext4_mb_load_buddy()' may return an error. This means that the block
> allocation will fail.
> Therefore, check block group if corrupted when ext4_mb_load_buddy()
> returns error.

Good catch!

Agreed, we should try other groups upon failure unless it's a goal-only
allocation.

But note that e4b->bd_info might be uninitialized if ext4_mb_load_buddy()
fails.

I think we can optimize this in ext4_mb_regular_allocator(): we can record
the error from ext4_mb_find_by_goal() but avoid an early exit.

Specifically, after checking that EXT4_MB_HINT_GOAL_ONLY is not set,
we can assign the error to ac->ac_first_err. This way, if subsequent
allocation attempts still fail, we can preserve the original.


Cheers,
Baokun

> Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block bitmap error")
> Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/mballoc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e2341489f4d0..ffa6886de8a3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2443,8 +2443,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>  		return 0;
>  
>  	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
> -	if (err)
> +	if (err) {
> +		if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
> +		    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
> +			return 0;
>  		return err;
> +	}
>  
>  	ext4_lock_group(ac->ac_sb, group);
>  	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))

