Return-Path: <linux-ext4+bounces-5132-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8659C6B1B
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 10:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C8C28199E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A11BD9DC;
	Wed, 13 Nov 2024 09:01:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F831BD028;
	Wed, 13 Nov 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488505; cv=none; b=rzWuI1oyQ6sbPpacb67Ejt9Wh/I0PX1q+LC2DTx8X3pVtbrjirIFDltPQRobddunHNgf+//PGd7asakq5BdfrBGlrA+FwP96SPAwOlI1t9YZzV/My/QSdNCFzo2bUf28lQltC0TluZyNcVu6bOe4fIOxAJAeN0WNbYlzhtYhB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488505; c=relaxed/simple;
	bh=jhk19CQ6FUVBPu7dg13m3a3FIIlipLa/ceK1m6NAurs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l0XHrUjIILQxn08G37Bufz08yAX1HUwM3ji4P/qdsunT8DUzwP2RaXaSsx0pq/7c0Kl/NjFUIVV7axHLdRvbvPGsMmMDzRf+bEiHs6WawLOYkvp/xlz6JD2hsTXUjsq8SC0X8d6AOBx2AKz3RIfNQ1WhTTBDPnIosOs56YQphWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XpHKZ4hMhz1SGHh;
	Wed, 13 Nov 2024 16:59:46 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 29FE31400DA;
	Wed, 13 Nov 2024 17:01:37 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 17:01:36 +0800
Message-ID: <4548041a-9614-4ddb-8a07-b87cfc66b743@huawei.com>
Date: Wed, 13 Nov 2024 17:01:35 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: remove duplicate check for EXT4_FC_REPLAY
To: Jinliang Zheng <alexjlzheng@gmail.com>, <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jinliang Zheng <alexjlzheng@tencent.com>
References: <20241113044158.1609384-1-alexjlzheng@tencent.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241113044158.1609384-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/11/13 12:41, Jinliang Zheng wrote:
> EXT4_FC_REPLAY will be checked in ext4_es_lookup_extent(). If it is
> set, ext4_es_lookup_extent() will return 0.
> 
> Remove the repeated check for EXT4_FC_REPLAY in ext4_map_blocks()
> to simplify the code.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>

It makes sense to me, thanks for the cleanup.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 89aade6f45f6..999f947c13d2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -619,8 +619,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		return -EFSCORRUPTED;
>  
>  	/* Lookup extent status tree firstly */
> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>  			map->m_pblk = ext4_es_pblock(&es) +
>  					map->m_lblk - es.es_lblk;


