Return-Path: <linux-ext4+bounces-11695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C74C42598
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 04:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F933AC9AD
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B252D12EA;
	Sat,  8 Nov 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cpnCiA59"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E42561D1;
	Sat,  8 Nov 2025 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571574; cv=none; b=CJUrL52CxCEz2gS7utnPg+dYYswh/Ruogn8ka9V0b3ndTGPWVqJ3uhrwGvwk+tAAivudsHpytYOqmyGHiStH2FIg87VXUzg0LjCo08Mudr+SOMKbAgLPjZ5pRQTHZtD6c+phuu9yeyCvjJYrqo8mfM9wFA7zwHJgQHhzFESdsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571574; c=relaxed/simple;
	bh=qJHCK2JoajrpFy7gk2q5zcvgv+lsZUYZxpEPKpHcakA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zajm6/8vDyBqTpjVYRl5c3dV2+qOYbbdYith94hSRqLvldMR2X3vBEjppKRgcHBU40oVzVUMF4SB+2340Bsti8Ab3c6ZbgvrJedme+oe4gb9v4gCstSzvqvvBi09tXu+JOtz4PZ3ac+kM4IEF9yVxdn78Rb7fUBh5sLKWmYlnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cpnCiA59; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KqJDm2b8tVz+5i/i1s/wTIfB2scGUckGQcchTU1SHd0=;
	b=cpnCiA59ANrW1KPHwkHBQJgXIqykFBg6JRhs2Qx6MYiL96EpIJbks1FJl2tFCuES4Z5EDp3ku
	MZRFO0YqxYiujBScO0CTJjqkvqRmZPddFh49tr/E5OivJbOnsk+W79k2cY9KKNh5umOVqLsqLQS
	Ss8rIc0PpFhqBsN175jlfx0=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d3LY928SJz1cyPF;
	Sat,  8 Nov 2025 11:11:09 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B278140142;
	Sat,  8 Nov 2025 11:12:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 11:12:45 +0800
Message-ID: <0fa6cee3-c25e-4649-8f85-8645cacab00e@huawei.com>
Date: Sat, 8 Nov 2025 11:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: xattr: fix null pointer deref in ext4_raw_inode()
Content-Language: en-GB
To: Karina Yankevich <k.yankevich@omp.ru>
CC: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Bhupesh <bhupesh@igalia.com>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-patches@linuxtesting.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>
References: <20251022093253.3546296-1-k.yankevich@omp.ru>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251022093253.3546296-1-k.yankevich@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-10-22 17:32, Karina Yankevich wrote:
> If ext4_get_inode_loc() fails (e.g. if it returns -EFSCORRUPTED),
> iloc.bh will remain set to NULL. Since ext4_xattr_inode_dec_ref_all()
> lacks error checking, this will lead to a null pointer dereference
> in ext4_raw_inode(), called right after ext4_get_inode_loc().
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c8e008b60492 ("ext4: ignore xattrs past end")
> Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

An error return at this point may lead to an inconsistent ea_inode
reference count. However, since the caller ext4_xattr_delete_inode()
has already loaded iloc.bh via ext4_get_inode_loc(), this almost never
fails.

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/xattr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index ce7253b3f549..2e02efbddaac 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1174,7 +1174,11 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
>  	if (block_csum)
>  		end = (void *)bh->b_data + bh->b_size;
>  	else {
> -		ext4_get_inode_loc(parent, &iloc);
> +		err = ext4_get_inode_loc(parent, &iloc);
> +		if (err) {
> +			EXT4_ERROR_INODE(parent, "parent inode loc (error %d)", err);
> +			return;
> +		}
>  		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
>  	}
>  



