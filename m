Return-Path: <linux-ext4+bounces-11401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 117BBC2A286
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 07:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16C7734815B
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B02309B2;
	Mon,  3 Nov 2025 06:19:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CF34D3A5
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150764; cv=none; b=kOvtU3iS+wqVKlpq1/pdHQGYMbjIPREEC2Tqwm/dbH/n0Z+L6NjZqV5GIOkTqolOqFxUbfkDRGvwPxkOGunIYOKZb6MS+hPS1Q8di7Yc12BzmPxfDYOXXbvbbsBhjqe85NpsVXIODb6Bi6yCF55rg3F/+aYH91e+8mT/XG2y9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150764; c=relaxed/simple;
	bh=nPXLh981jFqHWNxDBDJCCDKy55Y/u4T5ay/FG+6rVt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwNQKPh5x7SDbO3PGuKEtWLV+xMTfvP8EXq5BGGd8tHaSgk6x51HhbggPpnfjLIcz4Jt8F7OwnZuG+jhB3XSBvWQYdkzT3LJ+RTVqCwN40u4juWxLz8sf8hgo/TH1VdI9zaT0WeDDmb07kEusYFp727H1PPZpPU+ADERA1DhigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0LyV6fW1zKHMXX
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 14:19:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D77591A07BB
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 14:19:18 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAnyEBlSQhpYQQsCg--.22036S3;
	Mon, 03 Nov 2025 14:19:18 +0800 (CST)
Message-ID: <2ce98373-7c5f-45a7-bb21-82b4559a80fe@huaweicloud.com>
Date: Mon, 3 Nov 2025 14:19:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ext4: cleanup for ext4_map_blocks
To: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com
References: <20251027122303.1146352-1-yangerkun@huawei.com>
 <20251027122303.1146352-3-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251027122303.1146352-3-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnyEBlSQhpYQQsCg--.22036S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy8AF1UXF18WF48Ar4ruFg_yoW8Wr1Dpr
	W7Cr1rCr1UW3yY9w4FyF1UZF129ayFkr48ZFWfZr95Z3s3Arn3KF1YkF13AFZrKrWxJw48
	XF42y34DCw4SkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> Retval from ext4_map_create_blocks means we really create some blocks,
> cannot happened with m_flags without EXT4_MAP_UNWRITTEN and
> EXT4_MAP_MAPPED.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/inode.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e8bac93ca668..3d8ada26d5cd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -799,7 +799,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	retval = ext4_map_create_blocks(handle, inode, map, flags);
>  	up_write((&EXT4_I(inode)->i_data_sem));
> -	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> +
> +	if (retval < 0)
> +		ext_debug(inode, "failed with err %d\n", retval);
> +	if (retval <= 0)
> +		return retval;
> +
> +	if (map->m_flags & EXT4_MAP_MAPPED) {
>  		ret = check_block_validity(inode, map);
>  		if (ret != 0)
>  			return ret;
> @@ -828,12 +834,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  				return ret;
>  		}
>  	}
> -	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
> -				map->m_flags & EXT4_MAP_MAPPED))
> -		ext4_fc_track_range(handle, inode, map->m_lblk,
> -					map->m_lblk + map->m_len - 1);
> -	if (retval < 0)
> -		ext_debug(inode, "failed with err %d\n", retval);
> +	ext4_fc_track_range(handle, inode, map->m_lblk, map->m_lblk +
> +			    map->m_len - 1);
>  	return retval;
>  }
>  


