Return-Path: <linux-ext4+bounces-5726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A169F5D91
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 04:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62FC1890A3D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E237146D57;
	Wed, 18 Dec 2024 03:43:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC82E630;
	Wed, 18 Dec 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493434; cv=none; b=NQfCK+ELwwsU+axNCmFFQEgdR/JPGBE1TskOdi9LYScKHaLjgu/1kJUYwFqL1lOnn28v9Ps3R/iPtykjGmnPGIHP9s6LbZZ0R9R7bFISd/zejmhhuoXp2C1kvIii3fq1FFS9+z0LqRwdi6o4eWX2SUifnQ88VUSTuFtKZUubyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493434; c=relaxed/simple;
	bh=k+OJpvJX9UHLKSj+6ZHy0MK0SEU4q7qJGbsgzk8MU6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAdAyMaG8M2rvwVlOCme3Fi4Wj/aKdU/tXYlrD9lP3IRPM2FFaMHu1xJT+wY/aOWtGPtwCe6Uunmqj/Ep5pZAzxejVCaOcYbX9XPa5fc7dDxiW2coqEK2aynl/0B8Zk80rk1ByopiVXto+cDyBf8Y9L5GIxWD8BiuIhSCdAPIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCffM3D9Zz4f3jMw;
	Wed, 18 Dec 2024 11:43:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E57C01A0194;
	Wed, 18 Dec 2024 11:43:42 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYXuRGJnKQusEw--.64336S3;
	Wed, 18 Dec 2024 11:43:42 +0800 (CST)
Message-ID: <5af5427f-f0ac-495d-a0ec-ab30b94f4cd5@huaweicloud.com>
Date: Wed, 18 Dec 2024 11:43:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ext4: remove unneeded forward declaration
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: dennis.lamerice@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.com
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
 <20241217120356.1399443-4-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241217120356.1399443-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHMYXuRGJnKQusEw--.64336S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyUKF1xGFWkCFWUtF48tFb_yoWDGrbE9r
	4xAr4xGry3Aw1SkF1F9a17JanY9rs8Zr18XFWrt34Uur1jqrW8Zw1DZry7Aa98WF4rJay3
	C34kXF1rKrWkXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUTnQUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/17 20:03, Kemeng Shi wrote:
> Remove unneeded forward declaration of ext4_destroy_lazyinit_thread().
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8dfda41dabaa..d294cd43d3f2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -79,7 +79,6 @@ static int ext4_unfreeze(struct super_block *sb);
>  static int ext4_freeze(struct super_block *sb);
>  static inline int ext2_feature_set_ok(struct super_block *sb);
>  static inline int ext3_feature_set_ok(struct super_block *sb);
> -static void ext4_destroy_lazyinit_thread(void);
>  static void ext4_unregister_li_request(struct super_block *sb);
>  static void ext4_clear_request_list(void);
>  static struct inode *ext4_get_journal_inode(struct super_block *sb,


