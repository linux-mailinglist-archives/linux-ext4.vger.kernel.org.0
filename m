Return-Path: <linux-ext4+bounces-6397-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E5A2EED2
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998F81885286
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E322FDFA;
	Mon, 10 Feb 2025 13:51:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA4221DA9
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195466; cv=none; b=L6DULhc3RwwUqrDaMhNb63EGazblQZTmlDJGuUmhwTvcFFr5H4K1Pcz4w4leG/4pD4NafWmRMLg3V7aPA+pQroc2UoUTHsiYHyaeEpEdFdQL0i/6Goih7ZQrPl09Xu8illc4mVZ22iigTvN4qa9RRZse/izxC9yYCwJ2GKI9SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195466; c=relaxed/simple;
	bh=+mZx0v53X8/MHrWvjJ4bWi66xStOT1AHLzbKnJaXAUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EW6quYd2jm+8ntIeUt4MyIUV5yY71FIfXAjcnJTbokag3EVAVcv9Limu/Km1hm9xh5SsaM00e2tS/VTKA1CHkV0Zfix21mnhOPSKfQNWeDNQnkY58zP72Fg35hfUaeg+0OataKaCQQe1f2XqiuoskaMY3BXyIEhkFqJk+w6yW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ys5Xy2L2Kz1JJm5;
	Mon, 10 Feb 2025 21:49:38 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 612F71402C7;
	Mon, 10 Feb 2025 21:50:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 10 Feb
 2025 21:50:58 +0800
Message-ID: <0e379083-ec9b-4b99-b3f4-6f40e7167c61@huawei.com>
Date: Mon, 10 Feb 2025 21:50:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Verify fast symlink length
To: Jan Kara <jack@suse.cz>
CC: Ted Tso <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, "Darrick J. Wong"
	<djwong@kernel.org>, Yang Erkun <yangerkun@huawei.com>
References: <20250206094454.20522-2-jack@suse.cz>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250206094454.20522-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/6 17:44, Jan Kara wrote:
> Verify fast symlink length stored in inode->i_size matches the string
> stored in the inode to avoid surprises from corrupted filesystems.
>
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
Looks good to me, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
>   fs/ext4/inode.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..64e280fed911 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>   		} else if (ext4_inode_is_fast_symlink(inode)) {
>   			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			nd_terminate_link(ei->i_data, inode->i_size,
> -				sizeof(ei->i_data) - 1);
> +			if (inode->i_size == 0 ||
> +			    inode->i_size >= sizeof(ei->i_data) ||
> +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> +								inode->i_size) {
> +				ext4_error_inode(inode, function, line, 0,
> +					"invalid fast symlink length %llu",
> +					 (unsigned long long)inode->i_size);
> +				ret = -EFSCORRUPTED;
> +				goto bad_inode;
> +			}
>   			inode_set_cached_link(inode, (char *)ei->i_data,
>   					      inode->i_size);
>   		} else {



