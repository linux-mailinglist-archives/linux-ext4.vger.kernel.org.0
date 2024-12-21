Return-Path: <linux-ext4+bounces-5836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE009F9F1E
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B1A1891A0E
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D91EBFFA;
	Sat, 21 Dec 2024 07:45:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9722AF0B;
	Sat, 21 Dec 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734767156; cv=none; b=jEouoO45UisE8pzUo0j4oOc4DGmfZdH3X+VJY/071ZLU1l2bMJC+DFs5h5dw0h+H65X14Wg+YV5dUteTyhumuW3wAEtLQ/YX7dVz7Gzu5HeVZu+YS7fytCdY1fFq9SM7r8a/N/tlvi4nxbstvjlIJu442ziGY6otxhV9SCtpNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734767156; c=relaxed/simple;
	bh=Bpie1/sD/RzvtnfUa5X0+zBXx2ayjQ3OtMYJMFd1ghM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw3h2DIMMIp7CkulAyqOXJrfpPYgNUEXFx9ywWPBNT9Yte24QD3Md0+IiDyV2tjG82nyCv5SrV0DzCa7R4C4342URsf4ciP9cgWRSLt33gHpgPoBZNUa+nJqnVmKKbWUa16ndRFREFBSal4sQ6QWS81fid/XI02xjkbHal3dOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFbtJ5HK5z4f3kvv;
	Sat, 21 Dec 2024 15:45:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 61C7D1A018C;
	Sat, 21 Dec 2024 15:45:49 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoIscmZnpTTXFA--.43320S3;
	Sat, 21 Dec 2024 15:45:49 +0800 (CST)
Message-ID: <3aec5085-48f5-476a-8003-05ad5dfa30a1@huaweicloud.com>
Date: Sat, 21 Dec 2024 15:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ext4: remove unused input "inode" in
 ext4_find_dest_de
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-6-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241219110027.1440876-6-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3XoIscmZnpTTXFA--.43320S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWftw1kGrW3Gr1DKw13twb_yoW8Kw1Upr
	Z8JF1DCr47Wryq9F4xuF4UZw4Sv3ZrGr4UWrWfG345KrW2qwn5KFn8tF10yF13trW8uw12
	vFZ8KFy8Gw4agrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/19 19:00, Kemeng Shi wrote:
> Remove unused input "inode" in ext4_find_dest_de.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4.h   | 3 +--
>  fs/ext4/inline.c | 2 +-
>  fs/ext4/namei.c  | 5 ++---
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bbffb76d9a90..f7cec0de2790 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2821,8 +2821,7 @@ extern int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
>  				struct ext4_dir_entry_2 *dirent,
>  				struct fscrypt_str *ent_name);
>  extern void ext4_htree_free_dir_info(struct dir_private_info *p);
> -extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
> -			     struct buffer_head *bh,
> +extern int ext4_find_dest_de(struct inode *dir, struct buffer_head *bh,
>  			     void *buf, int buf_size,
>  			     struct ext4_filename *fname,
>  			     struct ext4_dir_entry_2 **dest_de);
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 3536ca7e4fcc..29081a04aef5 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1012,7 +1012,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
>  	int		err;
>  	struct ext4_dir_entry_2 *de;
>  
> -	err = ext4_find_dest_de(dir, inode, iloc->bh, inline_start,
> +	err = ext4_find_dest_de(dir, iloc->bh, inline_start,
>  				inline_size, fname, &de);
>  	if (err)
>  		return err;
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 07a1bb570deb..aee1858e6482 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2024,8 +2024,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  	return ERR_PTR(err);
>  }
>  
> -int ext4_find_dest_de(struct inode *dir, struct inode *inode,
> -		      struct buffer_head *bh,
> +int ext4_find_dest_de(struct inode *dir, struct buffer_head *bh,
>  		      void *buf, int buf_size,
>  		      struct ext4_filename *fname,
>  		      struct ext4_dir_entry_2 **dest_de)
> @@ -2111,7 +2110,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
>  		csum_size = sizeof(struct ext4_dir_entry_tail);
>  
>  	if (!de) {
> -		err = ext4_find_dest_de(dir, inode, bh, bh->b_data,
> +		err = ext4_find_dest_de(dir, bh, bh->b_data,
>  					blocksize - csum_size, fname, &de);
>  		if (err)
>  			return err;


