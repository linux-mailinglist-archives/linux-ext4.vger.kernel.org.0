Return-Path: <linux-ext4+bounces-12959-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9012D38D4A
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2738230194FD
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A2FE577;
	Sat, 17 Jan 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiCJLFHi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEF19004A
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640496; cv=none; b=u5KLjhMQrGIPymLJyWCReEpnmZ2+UOvWdXai926+NOvv2z04xwjsCvcDT+obOW6psPhj+/lVRt/G2tfEcvtP8AmX54mmmANdzf3jIzBhPFPj4X0bRrL06qMkSl+eWMfd54jB0uAHpY0+qTssg+zyjoUJbl8HVTsX9WcIsDklRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640496; c=relaxed/simple;
	bh=9i183PQeSHC8Lx4cWl230jBTWUbaZWmYxPQcl4/fOFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQajrdT9lgwogJajqJvYT3mHOiO32vE6p4DSBOUREhGDLRIPCcWEpW5kJ+PxVl8VTjozCBQqqEYQItN5+GGlBAYC3m8l7X7xBGvcHfUQgmhZd8wPdq/Y+zFgOP9oVL9M+6kmPFdCeCmJRu++MOi/+/HvoldpzFwEotk7+DuaM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiCJLFHi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so1865511a91.1
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768640494; x=1769245294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDILhteTRemXkvzova5N8iqxNPxWfUjNwJP0iU+NbZw=;
        b=KiCJLFHi6cdXeazaTZ+Wn7hX+dWTV6ppraguYOS6BUxLC+bgsoRvJea+e/AnqqFH6b
         bEYMBJnoAvuz4tadgBEVy/Zyv/LPOts8UBnv1mUz2RZstEK6zPXZWW6VTGmObOrZoMVW
         RbQ1CbpB4ggeBfA66tkyTe7bVfpm8YyeDGDf66TcLZ2zthCM6xlC+HBobu6StsXb6oHl
         oLvl4BGOJ6B7SNJP2M3NbavdCf3TKgE8Sc57gSZE0H/LSwajssjlaIqJktAF1vrFUUBH
         9nY8UTfWmNFHkl/uAJ5WCP0SwmmAbtJlzvOooy9scewg6LHPCWvWsWKTBOgLgxyYYKUF
         Uo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768640494; x=1769245294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDILhteTRemXkvzova5N8iqxNPxWfUjNwJP0iU+NbZw=;
        b=M+0rVHixyaZf513nEXzIkMFzkJKw7j6xIifEtg7Yq0ySw4A/ZCSUjsoyKpM6T088GD
         rwEHd1UA6yLlFCYDR96T623RWa5nq/F7c1i2n5YuChCpLq7uDqkCSFEowqQoAHsMMsuO
         yK0DvfmHRJ220eSxNdc58khvxMDipu28+5OMU7D6zKTU9O8YcYN4AJfLO343omL0Q0nQ
         aXX2YSSkLo6sQUwr58yajkmiALBP+DhMYN2HAjazIyol0i5QZMVu5E7QAwPqf5AEoigI
         LV+tAYsa2uDBReHcvU861n/YGH3gYavr5vpnSBAeDhXhXAj2u9H4+l0gw6U0r7/q0FzN
         qgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHnIkIUTdx5Xf9H1MtWIKsgDZvHf3Vd2KhCrpIf5n/7aKLtawT0ou+Labd3ukjfqi6yxiomkrKDXnu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf55G867scIPiGR+DWXcH87i9c+c8woVgdfv3fyc8YhK9R5fn1
	PaL3Y7yCe0bxHZP3hwb8JVobW3pT9mrksLWWcfjazwHt08O4s2ceVlL9
X-Gm-Gg: AY/fxX7sJyjplEKLqxs3RN5E3gSIhM/h0/4ywjON6ng+DGIRLKypUlb+7XSw13H0LOM
	8To5pqVi9E+4nFg8pmkr++eYbwwxWM3WfiKpW2rq7ojPUcCfKv2RzTCtsmXjRJwQm6x0hHDjnIZ
	9/kxbwFex3XiIZRW3pptcTjOFM0vqhvOcx/qNOvBbz7pL9iBCduKAfYpMi1kzwXJhK8519/dCxl
	AHL+7nKOnGE9RLAzAWTn/KUCgoQZdx8Zc+5QQbdGwVuG8q89hUh1Xo8qKOfTDSjdsY7waSNMK0S
	CVAaTNcb7boEIHXEKUHaePoq1HLMUXL2ActYnuY/coVLZnPw2LZ4xnr7HY8mw0F3u84DQPIir6C
	0dje+E+uE3f1q/mI9fIV1sbXT2C0oeFAlimUD8EP4TenDq1oV8Xedduq65zPmGoL9rgLt4bUPDY
	iiiknW7qpBO1Y1uN92VXJuZrfjvnLZ18FI6kpyDNMCY0AnuPMTA/bxNnfwsydRPh3puCv5BQ==
X-Received: by 2002:a17:90b:2ec4:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-35272f87fc2mr4670308a91.20.1768640494125;
        Sat, 17 Jan 2026 01:01:34 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af3dcsm6380209a91.9.2026.01.17.01.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 01:01:33 -0800 (PST)
Message-ID: <3757a5d3-624b-4705-b1c0-e33e6adce340@gmail.com>
Date: Sat, 17 Jan 2026 17:01:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ext4: Allow zeroout when doing written to
 unwritten split
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <16dc2c0921f482fd3dc6fa1d5bbae64eaba591eb.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <16dc2c0921f482fd3dc6fa1d5bbae64eaba591eb.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Currently, when we are doing an extent split and convert operation of
> written to unwritten extent (example, as done by ZERO_RANGE), we don't
> allow the zeroout fallback in case the extent tree manipulation fails.
> This is mostly because zeroout might take unsually long and the fact that
> this code path is more tolerant to failures than endio.
> 
> Since we have zeroout machinery in place, we might as well use it hence
> lift this restriction. To mitigate zeroout taking too long respect the
> max zeroout limit here so that the operation finishes relatively fast.
> 
> Also, add kunit tests for this case.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>   fs/ext4/extents.c      | 33 +++++++++++++++-----
>   2 files changed, 96 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 86fcac66be6f..d3a26cc8a9ad 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -578,6 +578,41 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>   			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
>   			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
>   
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 }}},
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 2, .len_blk = 1 }}},
>   };
>   
>   static const struct kunit_ext_test_param test_convert_initialized_params[] = {
> @@ -610,6 +645,42 @@ static const struct kunit_ext_test_param test_convert_initialized_params[] = {
>   			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
>   			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
>   	  .is_zeroout_test = 0 },
> +
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 }}},
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 2, .len_blk = 1 }}},
>   };
>   
>   static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8ade9c68ddd8..4c6e4e7a80b0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3463,6 +3463,15 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   		 */
>   		goto out_orig_err;
>   
> +	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> +		int max_zeroout_blks =
> +			EXT4_SB(inode->i_sb)->s_extent_max_zeroout_kb >>
> +			(inode->i_sb->s_blocksize_bits - 10);
> +
> +		if (map->m_len > max_zeroout_blks)
> +			goto out_orig_err;
> +	}
> +
>   	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
>   	if (IS_ERR(path))
>   		goto out_orig_err;
> @@ -3818,15 +3827,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   		goto convert;
>   
>   	/*
> -	 * We don't use zeroout fallback for written to unwritten conversion as
> -	 * it is not as critical as endio and it might take unusually long.
> -	 * Also, it is only safe to convert extent to initialized via explicit
> +	 * It is only safe to convert extent to initialized via explicit
>   	 * zeroout only if extent is fully inside i_size or new_size.
>   	 */
> -	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> -		split_flag |= ee_block + ee_len <= eof_block ?
> -				      EXT4_EXT_MAY_ZEROOUT :
> -				      0;
> +	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
>   
>   	/*
>   	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
> @@ -3948,7 +3952,20 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   
>   	ext4_update_inode_fsync_trans(handle, inode, 1);
>   
> -	map->m_flags |= EXT4_MAP_UNWRITTEN;
> +	/*
> +	 * The extent might be initialized in case of zeroout.
> +	 */
> +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +	if (IS_ERR(path))
> +		return path;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +
> +	if (ext4_ext_is_unwritten(ex))
> +		map->m_flags |= EXT4_MAP_UNWRITTEN;
> +	else
> +		map->m_flags |= EXT4_MAP_MAPPED;
>   	if (*allocated > map->m_len)
>   		*allocated = map->m_len;
>   	map->m_len = *allocated;


