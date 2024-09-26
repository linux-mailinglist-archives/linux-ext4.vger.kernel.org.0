Return-Path: <linux-ext4+bounces-4324-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B8986B7D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 05:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FC51C217B5
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 03:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7F183CC4;
	Thu, 26 Sep 2024 03:45:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE6175D47;
	Thu, 26 Sep 2024 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322315; cv=none; b=i7tPOE9qo6YioXqjamInRW72VGIxjIsHy1LNWzcmJuLUCJRxF/oLW9qD2bpO/3CUTL0/g4q94jvbRg17ayxCdhJ07EH69tf5UEvKCQmPxJqihqvl6aFv6HrdhCdVmvx5fGY10GHhAeSTtXGZo47LRBioUwC/dW/B8KzbjNViuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322315; c=relaxed/simple;
	bh=qz6oqaoHU+fyLcNZCRF12W4BQn20rRcxUh15w77YX74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CBUT+31Vjo+dcUH9dLCm10n1GdVtiHrebq7ijMlbND7xtlfcJRpwDtWmh7Fe1GCTWemVDAZIXKx7MBCHZxHqwLvI50boZUs6aknScXesFDJxTrD8Yt9xB5YHadV6K0r/jyZyzKqYN5vtFbFutRA2z3Bo49MA7W3oB07nBJ6SYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XDfXH1Sy2z1HK1B;
	Thu, 26 Sep 2024 11:41:19 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 7252F1400D5;
	Thu, 26 Sep 2024 11:45:10 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Sep 2024 11:45:09 +0800
Message-ID: <c9819809-c159-400a-9031-7ecdff3092fc@huawei.com>
Date: Thu, 26 Sep 2024 11:45:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Call ext4_journal_stop(handle) only once in
 ext4_dio_write_iter()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-ext4@vger.kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, Matthew
 Bobrowski <mbobrowski@mbobrowski.org>, Ritesh Harjani
	<riteshh@linux.ibm.com>, Theodore Ts'o <tytso@mit.edu>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/9/26 3:54, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 21:47:39 +0200
> 
> An ext4_journal_stop(handle) call was immediately used after a return value
> check for a ext4_orphan_add() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/file.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f14aed14b9cf..23005f1345a8 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -564,12 +564,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		}
> 
>  		ret = ext4_orphan_add(handle, inode);
> -		if (ret) {
> -			ext4_journal_stop(handle);
> -			goto out;
> -		}
> -
>  		ext4_journal_stop(handle);
> +		if (ret)
> +			goto out;
>  	}
> 
>  	if (ilock_shared && !unwritten)
> --
> 2.46.1
> 
> 


