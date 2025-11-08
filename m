Return-Path: <linux-ext4+bounces-11694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4FC4247D
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5619A3B3AAB
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731125F994;
	Sat,  8 Nov 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tq7m5wr+";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tq7m5wr+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26B1F0E25
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567860; cv=none; b=aHRQqwCAORMkjl594szer+bokFNQasXpw7R2dnaztUhWxXiN4Vanvtnk0hWwPqGtq/CO8LBNkBFQTjL0MV0MOt9JqDWD+Rn3pEccznMToITLgJicFRJwUfkjJ+UPORmdePdWRh4QJOvH9lUO74GCBCyvlnNyn4xlzxwy3q9Owio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567860; c=relaxed/simple;
	bh=/p8q/CHMNVTBPyAPPtpY2iC4Ig3LWoJrIp0UjcY7PJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i9oEL39yefM4OUqdPIu+3s+6YEiyV9i4HtQhxz3sEkmtcwLvKzOu+WbT0MLxta8dy0zBSeYsW9LuKfCkktv0cdPxxjkY1BHWD4ewyUb00fhjqm+Ckwqb8Fv5oFp+Kub98qcGicE+cqGo0v9cmjf0DlPaFisS6H4Emziba5VHD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tq7m5wr+; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tq7m5wr+; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mBzKR0po3UZunOS3JSFxgK/f10diNxSs9GelHLp8OTc=;
	b=Tq7m5wr+4oCNDFjA6xQsrCM7aK15jab2PTE/F8OHM1PMLc4f4TZTk1/tudfsDjB9Y0MlJtxo4
	xT3k86umC2JMwAQyVtV1AOz98riT5+KdabXMc4Cy+kFBuJtHG93deyozbX02B/jReO7zUtK5rfv
	YzxTLxpHfIgtBQgWQB0xjlE=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4d3Jrl6zcHz1BFmB
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 09:54:31 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mBzKR0po3UZunOS3JSFxgK/f10diNxSs9GelHLp8OTc=;
	b=Tq7m5wr+4oCNDFjA6xQsrCM7aK15jab2PTE/F8OHM1PMLc4f4TZTk1/tudfsDjB9Y0MlJtxo4
	xT3k86umC2JMwAQyVtV1AOz98riT5+KdabXMc4Cy+kFBuJtHG93deyozbX02B/jReO7zUtK5rfv
	YzxTLxpHfIgtBQgWQB0xjlE=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d3JqP3PJGz1T4GR;
	Sat,  8 Nov 2025 09:53:21 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C39F81400C8;
	Sat,  8 Nov 2025 09:54:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 09:54:37 +0800
Message-ID: <402fea1c-33ee-4e4c-a7b2-7cca54ab5351@huawei.com>
Date: Sat, 8 Nov 2025 09:54:36 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ext4: cleanup for ext4_map_blocks
Content-Language: en-GB
To: Yang Erkun <yangerkun@huawei.com>
CC: <yi.zhang@huawei.com>, <yangerkun@huaweicloud.com>,
	<linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, Baokun Li <libaokun1@huawei.com>
References: <20251107115810.47199-1-yangerkun@huawei.com>
 <20251107115810.47199-3-yangerkun@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251107115810.47199-3-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-07 19:58, Yang Erkun wrote:
> Retval from ext4_map_create_blocks means we really create some blocks,
> cannot happened with m_flags without EXT4_MAP_UNWRITTEN and
> EXT4_MAP_MAPPED.
>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

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



