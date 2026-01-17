Return-Path: <linux-ext4+bounces-12956-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2AD38D44
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8C96300B00B
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A0329E6F;
	Sat, 17 Jan 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC9EapxV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185A271457
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640389; cv=none; b=Ut+4XXMZSy6y2jppV6MaeIXHTc77UJujkObLjeNi/jYzeFKRgSdJm01FfwDp7ut1d+/9BeraLguLdBENIOTZgxm9ge3+17hDf8e62FXJiPE2Kd0kq2QtqVUlzIfeV6vxVy2Dq2q0Tw3P4ojkcvLTmXW7J/5JN10eMS+HdY261kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640389; c=relaxed/simple;
	bh=r9k7Sm/BNoslvOvU/HrfL6D+oM8FsIbvfesNKK2U+Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5xAIL7qq5XNbq97VOlniBBSP51GEyxF+q7Rm+7sRxYenUZXLSzB469LMK9h6hd7UyMD5rmHSZr9dOSUIaiE1jT2alv5+JtonY8Jy+oSTXcwfTQMa5xAksSWrQVcDFB06Q1Vt8HZfVzNH4aKYYvyWVUvqCSdRR/2zmJn5kJeziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC9EapxV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso1620100a12.1
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768640387; x=1769245187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQKtFx9Go+TUS9fb3gQWfT5aIO81SmUPaLrxb+LyPb0=;
        b=OC9EapxVzBs4OatBh8mgsfurwwG24Gzem3SJ4bw33YpA8r3rpYOR5GCo8i69b0EBYA
         MMloVkl0lQy5Gq5mo27IPeH0F2PcXaHpRhoiHygPrWyoenmzc4iY0JM8bA4N/wd+Bti5
         XmZkCB+6R0YJ0ZoGoJeWMqLjrczGyK1a0tbugsMm8iQl2ycUU+12FHHNxwXMKh9+kzbg
         Dp4I9gIW9f9wqLeAo5U8Mz7zbP2AReQOuLPgxUSaFu+Q+hiMWI+jhI5sgSz8l4ww7CZ+
         gdXU05aogcnr0zbx24HzYqSm7pH2HStD4cXEreaPFEJeptjRJGVfp/Wmln82+eCQ3zSE
         AY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768640387; x=1769245187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQKtFx9Go+TUS9fb3gQWfT5aIO81SmUPaLrxb+LyPb0=;
        b=cWFi0g3Df00Iqw+u3WKJuOkkHmkGdYu8sMfnr7TOaAtpuk4/trrvLHDqPR7ro4dzqj
         9q9zcbuBBSe2NJhBFv4F7sdVyOzHPyQfWscHDbOLHCsDeQO6BEuzWCaKJHB1UmlpaQgT
         F6o9ikL9B7pZ8ozuyTTQWjI7Jb+GRaKVFP636SI/9VBpWAC13EjUvU+LvlmGDjnvefZ6
         H5egEGCZnzkflPp/aIxQKqrfnzA0GPvZbgSH27L037fj0kA9kKYugq8phq+E1HgaCWGl
         Qg6//ClzDZeewxs7+1xYsrwW+uQPudJ45JTHCw+1GgmGU6KMmaKsiq3s1nplC8VjN0UL
         EaUA==
X-Forwarded-Encrypted: i=1; AJvYcCWS0t9uA44mYyhjD7X4Fc8acQLNpS9vOeLxn4M+XDUfljJxlzn+TLc7t8Bj6ZjE1IoYq5vz0Yoj9nBy@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkRw2OjC2HYH4Hw+L9vx0qB3ZUi7gzk9ghtCgyGtDrVta5BWd
	//bXsq8zoFEaebRtAYvsDk2ci/ItiVVSpaCdesbJkNRB/m+HbVN06PqW
X-Gm-Gg: AY/fxX5hmMO47B0/zcxhd2DFqcogJPme5G1RbeaQtHvzPZwnY0qCv5vKoh28WZsjzIX
	Ke1zr6xlUxjmeINxvdsW9Ggdq8tNbam96TN69kh4WfgoFla3yhuqtvHl5fnv3k1xvwDhkwxUMKk
	5MRwlC5ewn2UAT3Ucq0TLut/djo6nkO8i7VYb/0Ij9Q7UyeBn4lAzy1T+Gz/bvad8TjRAYRHO+O
	S+wcOrP4JDDq2ZLXgqcwVatJyeN2UXJru+LNmxyuvKcw537p2xdZ0UtfemGaxGdyfIavzVAX5+f
	8siKWlJ1nujh8+bKVQLYnM6t2LgPAV9ry7BHkwHW0Aqh5lr6WURhjqzH4jttHZMQJ9LR9HURmvy
	IES/JckYW3vrwjElHNIYtIRtdbBH31X8qCvYf1Z4Qp+1RTF8q+xgB5gtyrT5fn6p+FYmRLd1jHV
	KEvwKSO8jPy4XRwXxPGsyRlnMe7B7ktzwrgtTowZOzYF3cAfMAAwV6TpHUMhk=
X-Received: by 2002:a17:902:c408:b0:2a0:9a3b:d2a4 with SMTP id d9443c01a7336-2a700990d72mr85699545ad.10.1768640387316;
        Sat, 17 Jan 2026 00:59:47 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fbf8fsm41231755ad.78.2026.01.17.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:59:47 -0800 (PST)
Message-ID: <4df67ba2-cc04-447a-8cbd-cd655b6539c9@gmail.com>
Date: Sat, 17 Jan 2026 16:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] ext4: propagate flags to
 convert_initialized_extent()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
> extents however this is not respected by convert_initialized_extent().
> Hence, modify it to accept flags from the caller and to pass the flags
> on to other extent manipulation functions it calls. This makes
> sure the NOCACHE flag is respected throughout the code path.
> 
> Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
> care of this. Account this behavior in Kunit tests as well.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>


It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>


> ---
>   fs/ext4/extents.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a581e9278d48..3d45abfb13cd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3844,6 +3844,7 @@ static struct ext4_ext_path *
>   convert_initialized_extent(handle_t *handle, struct inode *inode,
>   			   struct ext4_map_blocks *map,
>   			   struct ext4_ext_path *path,
> +			   int flags,
>   			   unsigned int *allocated)
>   {
>   	struct ext4_extent *ex;
> @@ -3869,11 +3870,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   
>   	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>   		path = ext4_split_convert_extents(handle, inode, map, path,
> -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +						  flags, NULL);
>   		if (IS_ERR(path))
>   			return path;
>   
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
>   		if (IS_ERR(path))
>   			return path;
>   		depth = ext_depth(inode);
> @@ -4263,7 +4264,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>   			if ((!ext4_ext_is_unwritten(ex)) &&
>   			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
>   				path = convert_initialized_extent(handle,
> -					inode, map, path, &allocated);
> +					inode, map, path, flags, &allocated);
>   				if (IS_ERR(path))
>   					err = PTR_ERR(path);
>   				goto out;


