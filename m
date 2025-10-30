Return-Path: <linux-ext4+bounces-11365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF515C202E8
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 14:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3253534EE72
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CEF334693;
	Thu, 30 Oct 2025 13:12:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5C2D4B57
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829954; cv=none; b=FhF8iSithTlwAVnyUfnaDwie68peXfg7txzjI87LulIudVg+zNI4xAewagj6e7toJ372bpjHdpSL2qdKtHP18ssK67KHU8Ox08afa6/qczAVpB7RBNZn4h3TF8vuXsMSLYRKzQbVU7u49MJzpTGZxUMCMz2wdKQpKKQ1CSamk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829954; c=relaxed/simple;
	bh=S3Ol/TmEvc/LUDwshl4WXO6LG3WF3ylIZJBD5ogNvtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJojXTiHzJA9rijMe8JbAeBL+wTpMJNbuCOsDlobxqnhpw1mp/PsuKTJlj3Z71wIkMGW2nfMa4LR/xFQGe+cBZms6PJCMXy44uv6e+2iK3p3+75MxO/TKrlYbsLeXXRrXow48WKa9geCOgFOc3E5EYJ10M3Dw+uhvLc0uKeYDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cy4K06qnGzYQv1R
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 21:12:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B64861A07C0
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 21:12:27 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUY6ZANpzMyDCA--.15063S3;
	Thu, 30 Oct 2025 21:12:27 +0800 (CST)
Message-ID: <ed114762-fe34-458d-989f-e0fbf3afd42a@huaweicloud.com>
Date: Thu, 30 Oct 2025 21:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ext4: remove useless code in ext4_map_create_blocks
To: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz
References: <20251027122303.1146352-1-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251027122303.1146352-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3TUY6ZANpzMyDCA--.15063S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDXrW7ZF4fJFyDKr4xXrb_yoW8Kw48pr
	ZxCr18Gr1qg34j9ayxCF18Xr1ak3W5GrW7AF4xGw15KFy3JrySkF10k3yFkF4qgrZ5X3WY
	vF4jy348uan7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/27/2025 8:23 PM, Yang Erkun wrote:
> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> dioread_nolock buffer writeback, they all means we need a unwritten
> extent(or this extent has already been initialized), and the split won't
> zero the range we really write. So this check seems useless. Besides,
> even if we repeatedly execute ext4_es_insert_extent, there won't
> actually be any issues.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Before submitting I/O with EXT4_GET_BLOCKS_PRE_IO flag set, if
ext4_split_extent_at() tries to split a large unwritten extent but fails
to due to ENOSPC, it will zero out the leftover part but still leave the
origin large extent intact. However, it will insert the zeroed part into
the extent status tree as written. This write zeros and inserting
operations seems useless because:
1. After the I/O is completed, ext4_convert_unwritten_extents_endio()
   will call ext4_split_convert_extents() to the same thing again.
2. If I/O fails, there will be no stale data issue because the extent
   remains unwritten.

Leaving the written extent in the status tree would also lead to
inconsistencies with the state in the actual tree. Although this won't
cause any practical issues. So...

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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


