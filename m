Return-Path: <linux-ext4+bounces-12048-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AFC8D3F9
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Nov 2025 08:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5579F3B38B2
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Nov 2025 07:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBA3254A6;
	Thu, 27 Nov 2025 07:49:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3731CEAA3;
	Thu, 27 Nov 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229773; cv=none; b=Pu+l8BatA7DUMuLbtPCk+l9WDTC/1a5d7YStRWgahgclOa6QTn3jQuH8KBwGmErGw+yra9QJNUnFX822H+dqvIaXm5P4Jc3T/XJDcx+rfSM83oVP3gNhaog4GlsVEgVMeL8Za0m4p37bdwvzwgDoZuW2e10cn5WnV4Id4IOU7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229773; c=relaxed/simple;
	bh=l4ZM3W6PpBM69A7K1kpQczNUXjJqAL+GJwAQYCeS51M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUtbIUPzQ8wDm4xlDAMyeHXTgJF7Vys+LUZJ+C+ac0jw0FHFj6/Fp/CCx2Y3LUJW8nZhsr3l99Z8juCrijJ6jn7etPudurP2E1DxdKP/umB83VKFZxj2CBob0V3hzYEU+0DJpXtbU0LM5obTAKK6woO+0Hms7vRC34+pmsT4GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH7pV2Y0PzYQtGy;
	Thu, 27 Nov 2025 15:48:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9401B1A01A6;
	Thu, 27 Nov 2025 15:49:27 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXuFAihpQWe0CA--.21132S3;
	Thu, 27 Nov 2025 15:49:27 +0800 (CST)
Message-ID: <cf7b5376-8f49-4d77-86c8-1301325d2d57@huaweicloud.com>
Date: Thu, 27 Nov 2025 15:49:25 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: align max orphan file size with e2fsprogs limit
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun1@huawei.com
References: <20251120134233.2994147-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251120134233.2994147-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXuFAihpQWe0CA--.21132S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47Wr4kKw1kXr1rWFW8Crg_yoW8AFWfpF
	y5J3s5Ga10gFyY9anIyF47Jry8A3WrG3WUXFyqv34Yqry3Xr9akrnrt34jgFyDtrs7Jr40
	gFs2gryjvr4j93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/20/2025 9:42 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> limits the maximum supported orphan file size to 8 << 20.
> 
> However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
> blocks when creating a filesystem.
> 
> With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
> than the kernel allows, so mount prints an error and fails:
> 
>     EXT4-fs (vdb): orphan file too big: 8650752
>     EXT4-fs (vdb): mount failed
> 
> To prevent this issue and allow previously created 64KB filesystems to
> mount, we updates the maximum allowed orphan file size in the kernel to
> 512 filesystem blocks.
> 
> Fixes: 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/orphan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 82d5e7501455..fb57bba0d19d 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -8,6 +8,8 @@
>  #include "ext4.h"
>  #include "ext4_jbd2.h"
>  
> +#define EXT4_MAX_ORPHAN_FILE_BLOCKS 512
> +
>  static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
>  {
>  	int i, j, start;
> @@ -588,7 +590,7 @@ int ext4_init_orphan_info(struct super_block *sb)
>  	 * consuming absurd amounts of memory when pinning blocks of orphan
>  	 * file in memory.
>  	 */
> -	if (inode->i_size > 8 << 20) {
> +	if (inode->i_size > (EXT4_MAX_ORPHAN_FILE_BLOCKS << inode->i_blkbits)) {
>  		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
>  			 (unsigned long long)inode->i_size);
>  		ret = -EFSCORRUPTED;


