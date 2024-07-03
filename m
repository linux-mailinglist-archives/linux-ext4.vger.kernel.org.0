Return-Path: <linux-ext4+bounces-3097-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29747924D29
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 03:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D844428457A
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2024 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CAC1FB4;
	Wed,  3 Jul 2024 01:24:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59E623;
	Wed,  3 Jul 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969889; cv=none; b=U84cIIO50++bhtdHaUk1jp4VFQ+mFZ2QMEof7rggngpLdAvi5CBzHidzv4iCRn0d0GEhQyDNWmSIgkAXsyKKZETQCen4AnSUkINe4hvOYHopKpxaBMLj12q5h3OkxaAU/Rj1ACrcEPM/xFVM1OvvJauEePbgB3SfL3qUu8V4Z7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969889; c=relaxed/simple;
	bh=hVJFtsQLStwaNgFureVv0oR1O+Ev1bYFBNSi90GSxpI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aDmJdRMK1+dzRu58YmwL4sWN+UCU1ZbL5yjHDTPzOjBcZo/XLm6Efo6djy8bZ2o9Z29FDioCGoa7Wx6qiW2pU/jaHy0tv+p+Zg/rLLJNX8cSP4bHlrptnwGv9AlcwEUNwXdwS4XatLV+ch81rpxJoiSmMJxEB+rtwaMR61dXxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDMQm2k5xzxTbX;
	Wed,  3 Jul 2024 09:20:16 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FD191402CE;
	Wed,  3 Jul 2024 09:24:43 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jul 2024 09:24:42 +0800
Subject: Re: [PATCH v2] Fix WARNING in __ext4_ioctl
To: Pei Li <peili.dev@gmail.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <syzkaller-bugs@googlegroups.com>,
	<linux-kernel-mentees@lists.linuxfoundation.org>,
	<syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
References: <20240702-bug8-v2-1-be675f490db1@gmail.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <154c52ab-2452-df90-a8d8-5b786f46041b@huawei.com>
Date: Wed, 3 Jul 2024 09:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702-bug8-v2-1-be675f490db1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/7/3 8:07, Pei Li wrote:
> Specify the size of s_volume_name in strscpy_pad() to avoid buffer
> overflow.
> 
> strscpy_pad() by default takes the size of destination string as the
> size to be read from source string. However, as s_volume_name is only
> declared as an array of size EXT4_LABEL_MAX, we are reading 1 byte more
> than expected.
> 
> Reported-by: syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2cab87506a0e7885f4b9
> Fixes: 744a56389f73 ("ext4: replace deprecated strncpy with alternatives")
> Signed-off-by: Pei Li <peili.dev@gmail.com>

Thanks for the fix, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
> strscpy_pad() by default takes the size of destination string as the
> size to be read from source string. However, as s_volume_name is only
> declared as an array of size EXT4_LABEL_MAX, we are reading 1 byte more
> than expected.
> 
> Specify the size of s_volume_name in strscpy_pad() to avoid buffer
> overflow.
> ---
> Changes in v2:
> - Add fixes label
> - Move workaround into commit log
> - Link to v1: https://lore.kernel.org/r/20240628-bug8-v1-1-417ef53cca33@gmail.com
> ---
>  fs/ext4/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index dab7acd49709..0c4fb579757a 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1151,7 +1151,7 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
>  	BUILD_BUG_ON(EXT4_LABEL_MAX >= FSLABEL_MAX);
>  
>  	lock_buffer(sbi->s_sbh);
> -	strscpy_pad(label, sbi->s_es->s_volume_name);
> +	strscpy_pad(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
>  	unlock_buffer(sbi->s_sbh);
>  
>  	if (copy_to_user(user_label, label, sizeof(label)))
> 
> ---
> base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
> change-id: 20240628-bug8-7f700a228c4a
> 
> Best regards,
> 

