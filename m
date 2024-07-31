Return-Path: <linux-ext4+bounces-3569-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6B942D93
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F351C2088F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBFD1AED3C;
	Wed, 31 Jul 2024 11:55:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE91AD9F6;
	Wed, 31 Jul 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426903; cv=none; b=kJGyQ+IJC0m4mLzWnqpehFWoDK0NZmRad1tzxpw/J/+l4L2pLfMhS3DV5oWnOdr3YbONLx+ke/6e813M8uilgHlVmSHixl885+v444ybHNv5VajLYPkTqn4aJ+fms1OAjx1CsJgeadMd22MfiQgJ/LeVfQWRXH5AbokKXZdvyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426903; c=relaxed/simple;
	bh=0BIFvrvK2ne771IGbC/UKbRtviiZiVvnJ3dOjFj5f+o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ztg5toGobqeVaC/ukQWG91Xc545aHJ2828fXFBggiWntDpbjyqAkr3CV28a7bFKH566dOQCMRsIgqkFAoB0IMgZHk9zMgKsvK44XoQZgqDEXqWHt7VWpRR1RIWqgnUxByw+RHOnswLwL5xB0LQciEJp4CgSXeqjNqxvSw8Jiklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WYr9y4mN6z1L96F;
	Wed, 31 Jul 2024 19:54:46 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A7FB180AE6;
	Wed, 31 Jul 2024 19:54:58 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 19:54:57 +0800
Subject: Re: [PATCH v3 4/8] jbd2: remove unneeded kmap for
 jh_in->b_frozen_data in jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.com>
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-5-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <e3fc4766-ce2b-b7d3-abcf-f145c2ff2727@huawei.com>
Date: Wed, 31 Jul 2024 19:54:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240731092910.2383048-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/7/31 17:29, Kemeng Shi wrote:
> Remove kmap for page of b_frozen_data from jbd2_alloc() which always
> provides an address from the direct kernel mapping.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 312c7575b54f..9c1ffb0dc740 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -352,12 +352,13 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		done_copy_out = 1;
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		mapped_data = jh_in->b_frozen_data;
>  	} else {
>  		new_folio = bh_in->b_folio;
>  		new_offset = offset_in_folio(new_folio, bh_in->b_data);
> +		mapped_data = kmap_local_folio(new_folio, new_offset);
>  	}
>  
> -	mapped_data = kmap_local_folio(new_folio, new_offset);
>  	/*
>  	 * Fire data frozen trigger if data already wasn't frozen.  Do this
>  	 * before checking for escaping, as the trigger may modify the magic
> @@ -373,7 +374,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 */
>  	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>  		do_escape = 1;
> -	kunmap_local(mapped_data);
> +	if (!jh_in->b_frozen_data)
> +		kunmap_local(mapped_data);
>  
>  	/*
>  	 * Do we need to do a data copy?
> 

