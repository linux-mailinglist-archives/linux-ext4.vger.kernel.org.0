Return-Path: <linux-ext4+bounces-12708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311AD0CB9D
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 02:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24BA3009FC8
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE5234964;
	Sat, 10 Jan 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLBdnTf/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DB21CC62
	for <linux-ext4@vger.kernel.org>; Sat, 10 Jan 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009017; cv=none; b=WYi6zwCHs9qkwQmRQYxaaedk4QOwofv34R82/ZWhlinTJ1rzv0D7f+rD38DTclSnqy9urWvamONPDsEJz7KpP37JVhAjw4UjDM0WV65ti5nQTYO6xJ/OxmtUg3NZzEt/iVepOgnU3eMSTwSVsY5hCXEgslZRqYQ7AeuBYAa27v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009017; c=relaxed/simple;
	bh=Sq6vaA8Gh5lHoXpHz4Fy2q2qsrgWcjMuxzJ2TzDg/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnsXnFg4KCtu/0Mk8kESPpvPXQ2TSt4k1eCXSsaBk48FL55LSNiPaxW1ahYdnbiMADBH77hgaKmQZ9mzLGDobjX6sZFM8EEbA9hLIXmrpju9O9Z1EIyNMSxBD1Xf0+s2D3f2VMKEogXvja9ivDjB93YqNLfo57KGe7rMyMCoQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLBdnTf/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c363eb612so2990249a91.0
        for <linux-ext4@vger.kernel.org>; Fri, 09 Jan 2026 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768009015; x=1768613815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llwWanzi+khGSewg4db3Bll4dz8lmVOlRjFteSO3cPY=;
        b=NLBdnTf/3PtZS8eO0bUOQqWK1he1ClPayT+97UT+Rjo98Ksgjv6xItUhVK/gbzGBgT
         ApezTZr4WR5LeHROF1ELVba0RWO73idl43m21ggQsWGDpYjPPu8zclAvF4/yDNOan50B
         SaD8o6CiHKb8l+/mOb6IjkqKLvYt/B9ROTErljGnttCk8kwJCDeMZKTSBb/JEJQhfRAT
         13dhkokE9WqbsBtcTzQf5fDtBDOceGPn0lfpXN/Pe+bT5Sp8ERu9BYyt9tz6xcLmrwSI
         O8ke9nI+zmbeeZkwLQ3XqeWkQpjae1iwGA+bQjlVU1IOdY/FbI9tBcyub2O7dpcKuuDW
         SSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768009015; x=1768613815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llwWanzi+khGSewg4db3Bll4dz8lmVOlRjFteSO3cPY=;
        b=HXvfexWQhf1b3W879bOhqvgGMcBD35eUt6lrgHHtNC8hwVXMaMVsNRj9eXE9DY42h5
         QXpDrz6QGRyNxiPmB1B5OrgFi40YqV0P6pgs5huGEvd0AhnYYQqdYrEg48pwThAZn3dZ
         OPZeE3RQEFjE0FQDe8l5Mru3YwUnPGEITiONDZqox+BhllWnTSA92Q+twIkmjHt2HI/q
         Y+0rq/28O/GIgKg1Yw5IM3tNaXanDhf7rurt/aLUvflb8TS6hV4PWGJuJye8XyIR6Bdg
         dxsLqTd72v5ocwOyliZHjseuVlWtAKKdyxjFqqrac/YFz5z8sLOcHhubghFOaa70ADaf
         zPUw==
X-Gm-Message-State: AOJu0YzqfTlsic/U0FHKzFxjdAN3l8weV0noVdjscDrajJE4VFkn+XxX
	wRWJxsODbwQ7qoDSjNCu84Z7hc51NueL2vs/rpmfW0rVDJORasKppr85
X-Gm-Gg: AY/fxX6kDFRG87YNkgVmqmFoL/2vXoZyHtMqIQvJoVNfHQdTXp5bkWA0btRb+2/Nkaf
	KzGT1hE8ImcMx1urf1tBIUteK0kV137gatUIGbWQ9JdXzO1wNQ3NrJULZ825hdLrLHOnx4gEBDN
	WfuUGa6MH1VqIaxN6qJgouS9DDYn8NEsF4E9PMMReCEyb+HjlV8hAhVFAUQpuGRioLewmTvdJd2
	X6/IUPVV7AnVFuyAl0YlPvhusaBbiv9uPNar1xlO1kgrAG9OWy9poY59sNfR8GWtQoLSUHa2/4p
	SbETcdnOu1q1l3lIe42iCHl6cdjV9bufQ0eb9aK12ScSfMSF8nuRTWQXLP/cxTVQ3djfUeXKLX1
	YAHZx1VA0qPnn5aXbtqrENDep1m+BSHeEc01y8ZkEkHE6D0Ko7dDwwj1+h6/A9H/Y4NL8vVXxjJ
	YYnW8iybzQaa/h7l/p4neS1GwabnyQv4w9iOZMsV+tOvdjvXym6SoJyeHG
X-Google-Smtp-Source: AGHT+IHBuqehIdVRDyTZuXRGnFynaBD4SIT3ose79JoKBcWcsQYLB/6zWa+arfn/J3buvvlkIMQi+w==
X-Received: by 2002:a17:90b:2883:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-34f68b4c5d3mr9933101a91.3.1768009015167;
        Fri, 09 Jan 2026 17:36:55 -0800 (PST)
Received: from ?IPV6:240e:390:a96:d731:80fd:27b:ba3:55f2? ([240e:390:a96:d731:80fd:27b:ba3:55f2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa7820fsm11449363a91.2.2026.01.09.17.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 17:36:54 -0800 (PST)
Message-ID: <672568c5-0f5f-4e94-bfc3-45cf6135e47e@gmail.com>
Date: Sat, 10 Jan 2026 09:36:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode
 can use
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-3-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260109105354.16008-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/2026 6:53 PM, Jan Kara wrote:
> For filesystems with more than 2^32 blocks inodes using indirect block
> based format cannot use blocks beyond the 32-bit limit.
> ext4_mb_scan_groups_linear() takes care to not select these unsupported
> groups for such inodes however other functions selecting groups for
> allocation don't. So far this is harmless because the other selection
> functions are used only with mb_optimize_scan and this is currently
> disabled for inodes with indirect blocks however in the following patch
> we want to enable mb_optimize_scan regardless of inode format.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/mballoc.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..f0e07bf11a93 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -892,6 +892,18 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>   	}
>   }
>   
> +static ext4_group_t ext4_get_allocation_groups_count(
> +				struct ext4_allocation_context *ac)
> +{
> +	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> +
> +	/* non-extent files are limited to low blocks/groups */
> +	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> +		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
> +
> +	return ngroups;
> +}
> +
>   static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
>   					struct xarray *xa,
>   					ext4_group_t start, ext4_group_t end)
> @@ -899,7 +911,7 @@ static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
>   	struct super_block *sb = ac->ac_sb;
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	enum criteria cr = ac->ac_criteria;
> -	ext4_group_t ngroups = ext4_get_groups_count(sb);
> +	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
>   	unsigned long group = start;
>   	struct ext4_group_info *grp;
>   
> @@ -951,7 +963,7 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
>   	ext4_group_t start, end;
>   
>   	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>   wrap_around:
>   	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
>   		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
> @@ -1001,7 +1013,7 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
>   	ext4_group_t start, end;
>   
>   	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>   wrap_around:
>   	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
>   	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> @@ -1083,7 +1095,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
>   		min_order = fls(ac->ac_o_ex.fe_len);
>   
>   	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>   wrap_around:
>   	for (i = order; i >= min_order; i--) {
>   		int frag_order;
> @@ -1182,11 +1194,7 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
>   	int ret = 0;
>   	ext4_group_t start;
>   	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> -	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> -
> -	/* non-extent files are limited to low blocks/groups */
> -	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> -		ngroups = sbi->s_blockfile_groups;
> +	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
>   
>   	/* searching for the right group start from the goal value specified */
>   	start = ac->ac_g_ex.fe_group;


