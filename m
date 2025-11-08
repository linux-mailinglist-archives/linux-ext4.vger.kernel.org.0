Return-Path: <linux-ext4+bounces-11693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1BC4246D
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 03:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D801896F82
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780902BEFFD;
	Sat,  8 Nov 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W898lgrY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91129A310
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567515; cv=none; b=TLZcm+JTPq19IFn2UeatdUHnG0ezyOOAL/MQrjTBE597rNc+d87lWlROfd9outJqkfy2Ptm84lcoTnpQ+7FvnbPF4QXlOGqZqVC20p0a89LZaEyQRvq9t2xLJZHQIEtqD1SzvIMyPNBd6wwC0rIR1B9CcBocB7iRgMq7jDqHbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567515; c=relaxed/simple;
	bh=pACpCUcVur/sMHp6LwPoVr9RsYBh6prWZO9IKDKsu/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBKSyR+7DnOPH55Q2cyi8Bel3iF81JQ81x2e6bl2gYYWfWrcYwmG03bxaEcgH38ouqmsAMKxt+7IDlaLv2ZjTiZRuITvDN2zW/bu+rGUujW8rdthtYByq/lY/S0U0GjYPBBOR1fAV7XB+FY+BnFxig4yYJi2PTugHPnY62rcJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W898lgrY; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4d3JYs3X5czCtZM
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 09:41:37 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dZFYskyPNeeLSi/R3V729QE1IM88fPYPtwh4fmHQ5YA=;
	b=W898lgrYN2QonIuZ4GU5O9Gi3LBuQ7iKp0q3KLBiPIaxuHm9sRhnS9ImDclwt+n8gHFJm+oiB
	8GHLFJ2cPNfX0C9poL7R/MOQ3DgIUZ0eCvvir+qTZCr0ja8WGrRYIkfVrcEGF7X8Ue3WnUuagFp
	rn9vm3muMyc3tvkTNhq+AdA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d3Jdk2fvQznTWc;
	Sat,  8 Nov 2025 09:44:58 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A3AA1800B2;
	Sat,  8 Nov 2025 09:46:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 09:46:31 +0800
Message-ID: <fc342fe4-87f0-47de-a4e8-36a1fa996468@huawei.com>
Date: Sat, 8 Nov 2025 09:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ext4: remove useless code in
 ext4_map_create_blocks
Content-Language: en-GB
To: Yang Erkun <yangerkun@huawei.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huaweicloud.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, Baokun Li <libaokun1@huawei.com>
References: <20251107115810.47199-1-yangerkun@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251107115810.47199-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-07 19:58, Yang Erkun wrote:
> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> dioread_nolock buffer writeback, they all means we need a unwritten
> extent(or this extent has already been initialized), and the split won't
> zero the range we really write. So this check seems useless. Besides,
> even if we repeatedly execute ext4_es_insert_extent, there won't
> actually be any issues.
>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/inode.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..e8bac93ca668 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,



