Return-Path: <linux-ext4+bounces-12031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8652C87FAB
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Nov 2025 04:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4863B47F0
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Nov 2025 03:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D07830E0F3;
	Wed, 26 Nov 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TrPcEToX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E030DEA3
	for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128479; cv=none; b=iVXz5jkYuxraSe+ayUHhFtVB+ADY+RkLrPJ9e2gKztYCgNCx/s0QZ4uU5+gNouvVVU+r2G14pwJwU4eXuTWjLqp+OIDVZ8KfzDoaXD59OMMxWFVBn/PAcSfr593k1VNec4yGn4LuGYN5y1S47/kgkKx6tc0sq4n32ZqwWmbH+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128479; c=relaxed/simple;
	bh=iXX7d8xUVYdzsZw+bQ3kdN+gskmq4D9CndxW+xCCBbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j/2kRGiaFTnNVKbw8vTfH9y27r2SFRSamkEugz2Q981iD1TPE+b3rihPrfeY4mu67QKhKggzfHealWt+tSzLPZcHbnAVwwPiwBiEY6pW1HAlRFa+8VL3EFsd2OL+iih70bfo8Hl8E882iMcDh94ud20Je7nr/Db1XV2ww8F35Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TrPcEToX; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4Xe5XMpXbl58WeQWz0L9750UD+lQ+X+VMP+ontD27Pk=;
	b=TrPcEToXfnY417WNOLOy2MKDQN/RrqruT8jbuHg3/kcyQ3l2SkFNOuLhSDibZ3VsSKlO+QB5u
	zCLNOf42+ZjIlXDl2+kVx5E07Dy6f6z+FQD4g+cfNA5BRADaSg6E2DgtM2ZuHzqA7ov33oNXnxu
	CEG+eqKdAoL4S0UIurZlBfc=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dGQKN3R4rzmV7M;
	Wed, 26 Nov 2025 11:39:20 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 735D0140258;
	Wed, 26 Nov 2025 11:41:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Nov
 2025 11:41:07 +0800
Message-ID: <53c4968b-c083-4d69-9562-31e155a34a1e@huawei.com>
Date: Wed, 26 Nov 2025 11:41:06 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Mark inodes without acls in __ext4_iget()
To: Jan Kara <jack@suse.cz>
CC: Ted Tso <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, Mateusz Guzik
	<mjguzik@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
References: <20251125101340.24276-2-jack@suse.cz>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251125101340.24276-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-25 18:13, Jan Kara wrote:
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

Looks good! Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

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



