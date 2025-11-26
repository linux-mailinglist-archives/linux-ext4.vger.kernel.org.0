Return-Path: <linux-ext4+bounces-12032-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8ACC88655
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Nov 2025 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F78D4E41A5
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Nov 2025 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B372BD5BD;
	Wed, 26 Nov 2025 07:20:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0C1EDA2C
	for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141601; cv=none; b=M/58V38DiAG6ys3Wcj8mO4DBIGSStsCvwWFztSDRmCrmNd9nldCcQvSGsp0/r1kxI/cUjiPJ+aJfw75RtknJgLefWIbBHSwYLPzxDRT0IlVoenH+vjnN7brVSwhQi6caPGoAO80G/Vhxpe57V/9YF4N1aEOYhCVM8JjqFl7AjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141601; c=relaxed/simple;
	bh=6f2AOX2VdbHYO2O8NRhOK2MOF72YBxMGNIs2hzVXw+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUjhsJP++z88U1BV1I449cZpfjtOCva0chYoSsn2ZQxynEdPb8aQKuIpuv2rwDdOSjqyqLFeo1YVMJzbg/Q4OCt+SDUulEkDvatvl44Nhyax0TFUGZ9LSTlS6YQdhRvfE9wxM6Xg96+vKzzkvFZwVQha83Wa2GA/u0hQCvvi4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dGWC728pxzKHMl0
	for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 15:19:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B21611A089F
	for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 15:19:53 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgB31HoWqiZpQok+CA--.62394S3;
	Wed, 26 Nov 2025 15:19:52 +0800 (CST)
Message-ID: <007c67b2-9922-4ea8-953f-eb1be5715baf@huaweicloud.com>
Date: Wed, 26 Nov 2025 15:19:50 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Mark inodes without acls in __ext4_iget()
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20251125101340.24276-2-jack@suse.cz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251125101340.24276-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB31HoWqiZpQok+CA--.62394S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfWw1rtry3trWDKw43Awb_yoW8XF4rpF
	Z3WFy8Gw4IgFy8C3WxKr17Z34Yga18Wr47WrZrAw4UWFW5uryI9r1aqrW5XF1jyrWkGayS
	qF4jkw1q9a15G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/25/2025 6:13 PM, Jan Kara wrote:
> Mark inodes without acls with cache_no_acl() in __ext4_iget() so that
> path lookup can run in RCU mode from the start. This is interesting in
> particular for the case where the file owner does the lookup because in
> that case end up constantly hitting the slow path otherwise. We drop out
> from the fast path (because ACL state is unknown) but never end up calling
> check_acl() to cache ACL state.
> 
> The problem was originally analyzed by Linus and fix tested by Matheusz,
> I'm just putting it into mergeable form :).
> 
> Link: https://lore.kernel.org/all/CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com
> Reported-by: Mateusz Guzik <mjguzik@gmail.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

This makes sense to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..2b68d0651652 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5521,7 +5521,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	if (ret)
>  		goto bad_inode;
>  	brelse(iloc.bh);
> -
> +	/* Initialize the "no ACL's" state for the simple cases */
> +	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
> +		cache_no_acl(inode);
>  	unlock_new_inode(inode);
>  	return inode;
>  


