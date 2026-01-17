Return-Path: <linux-ext4+bounces-12957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD89D38D46
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94679301E93B
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934233375B;
	Sat, 17 Jan 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy9Wvb7O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C547332EC8
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640420; cv=none; b=r8QTSvwUJYfYv83OEU0XmoMblB4QyQHulTo4He2IzcplPriZp0t4m5mx0iK2UazL4YrckzoM83M5XKTEZ1AXTKSj2EwAVAOQEdGBDJKf0fsx7hmqcYK503GUCklKqeXRHw6uqj6GiZikA8yfBmWzGzbrd87qavBBb2P8GyJJaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640420; c=relaxed/simple;
	bh=TB2Ih0n3LLuiMAAwqIXoCn0N3ebOUHk1Hm7aW2tabnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WM5TcT1MSi3AD1OXeE0TX5vJvY0DXBVzEjG2laTYHY9jgHlsvysnkSeK8FFu8ihEw7vAUKRZBnWJmH3wWurlB53f264TfGQaDBcGYuh8tb9TR9ZyC4yiF3R4JXp02X9L2dW6Wp8DtZdeo4dWBrrJ9SE/tfye0Iy6h01aLsRPnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy9Wvb7O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0a95200e8so18542145ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768640419; x=1769245219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7bhIVKOwHgULhwTtDYRyo43zC62kJHUX67IghOCSwY=;
        b=Gy9Wvb7OUaUQElL8mQ0pIxQonG/wEsTVhPHs+JzkXlXrhph9iymJNlzW92m42kJZCe
         5ZZc7rkBtPkkplx+Mcc3Kea/5bQu5Y7FcR0wnCRL9ak9TIL7chvUanLxvjGAdGqgQzjr
         po3abEk4A4Yi6QViHPIr7HHf+FyiiAMZlAVR9vzePqFFsi++gn7LIr9GscDLLrsn0M3E
         qcvMtEm8br6P5uiSocoYlqhLNeC+k6rwAXBHWw5WQeHyim2EoPK3zxqS/vCWTwcLYRbG
         10R6rED3q1qHxmyfSUzA2iuaeoCH0mG7/q5OfxtIvDcsNccj5G9JhAohNu4SHbKiRI/h
         3ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768640419; x=1769245219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7bhIVKOwHgULhwTtDYRyo43zC62kJHUX67IghOCSwY=;
        b=GpwytenTIC5k7F2ZLjFt4XAdh+y7eeUMuHd7yZzZQKInO2G0qgErOrb0Sl+3gpU9uN
         pmXRnLN41jihAQyFSIs6vs1tFfE2VVsGkgt+/URYB+ixAJjx+HsQsx9y3B3CeoA3zha4
         HL3UZ92owtbDu5KkUtXmxe2efyM7Va2azhQFtl5IN8LDGEqUD6J/T8BuFOZwtJkVUbBU
         2lmLKNrGpd23svEhlE+i8qi6z0/lkxMKFNQyfaPp2FjznT71lobbos0qDqlblaTI+QoP
         N/d0TNKbfQhrOzAvjGIig71fSHohMgl7rMRBgJwnG58GOMKKUOLFVE/Azez7PBGkxMRv
         YGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/R4dEyTdEHOk14igfo7b23/Ii17kdVAG8HHuYzPELvX/uJnhyI+1SevMxiNFxdCTjfgmvHhWXIEyK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2LcFhHY6dUxpmxyhX4ZYe1/9g8smddWrCKYIwNEOFNTMQaol
	5rUbsaL6xqRpTXR0Fq8LdPzr0z6nU6q0V+zzXXlFrF9oTMBtubqZbDXL
X-Gm-Gg: AY/fxX5gfXptHPeNeb2JuICF2Vf3t140nhOxfMn/AohAYPzP53WuLLGvEDkLi1u/t5W
	hD+aIwkf36AyPJ9yDYqNn4GUasR3gaRCQGCaLgcPcU5oCDJfd+Z3tluNbZuvCWwVjAj3/SoGC6u
	aBmYmvd1+LCKVmnjOXHNnBPCt9ChHwFto4yj+3B2mG67zViKdTQtibEOfPpBDaliS38Tp2/JHZc
	IR0x4MfMu8wKRAz2GQrrUSS1IkPCakZWFO2G1VU89W99nEPfR+6ne+kFvWYusxnEY3/buDNxUdX
	IKprEBaRdc88hiiDCjbdz7u9Ddao8Lyddxxgq5Me0adEw5kku7UT6VAOMnMbeNVOi0Nk/RxNPfF
	qMrHa48F9bGFjX4b82xLrQAQyUu4UNvdPGhQI1Y2CgSiRFRdj1MIzVSkVU2fdsTQtiOxRrPVjgZ
	WgYUCE04NcZrNh29AvOhiPET1D2S6iL/VbJeGcl3cmkL/aUH7JpI6eumXSqLQ=
X-Received: by 2002:a17:903:13d0:b0:2a0:a92c:2cb6 with SMTP id d9443c01a7336-2a7175a63b4mr59826725ad.36.1768640418708;
        Sat, 17 Jan 2026 01:00:18 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa312sm42249585ad.10.2026.01.17.01.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 01:00:18 -0800 (PST)
Message-ID: <770acb41-64be-4446-bcea-ad8b03c5608c@gmail.com>
Date: Sat, 17 Jan 2026 17:00:13 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] ext4: propagate flags to
 ext4_convert_unwritten_extents_endio()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <91a23f1c21837277b1ba24db359fe928380aa979.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <91a23f1c21837277b1ba24db359fe928380aa979.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Currently, callers like ext4_convert_unwritten_extents() pass
> EXT4_EX_NOCACHE flag to avoid caching extents however this is not
> respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
> accept flags from the caller and to pass the flags on to other extent
> manipulation functions it calls. This makes sure the NOCACHE flag is
> respected throughout the code path.
> 
> Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
> we don't need to explicitly pass it anymore.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3d45abfb13cd..54f45b40fe73 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3784,7 +3784,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   static struct ext4_ext_path *
>   ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>   				     struct ext4_map_blocks *map,
> -				     struct ext4_ext_path *path)
> +				     struct ext4_ext_path *path, int flags)
>   {
>   	struct ext4_extent *ex;
>   	ext4_lblk_t ee_block;
> @@ -3801,15 +3801,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>   		  (unsigned long long)ee_block, ee_len);
>   
>   	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		int flags = EXT4_GET_BLOCKS_CONVERT |
> -			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -
>   		path = ext4_split_convert_extents(handle, inode, map, path,
>   						  flags, NULL);
>   		if (IS_ERR(path))
>   			return path;
>   
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
>   		if (IS_ERR(path))
>   			return path;
>   		depth = ext_depth(inode);
> @@ -3942,7 +3939,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>   	/* IO end_io complete, convert the filled extent to written */
>   	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>   		path = ext4_convert_unwritten_extents_endio(handle, inode,
> -							    map, path);
> +							    map, path, flags);
>   		if (IS_ERR(path))
>   			return path;
>   		ext4_update_inode_fsync_trans(handle, inode, 1);


