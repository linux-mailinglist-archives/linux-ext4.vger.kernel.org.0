Return-Path: <linux-ext4+bounces-2154-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC88ADB9C
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 03:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AB0B229BF
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286512E6D;
	Tue, 23 Apr 2024 01:42:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071D125C0;
	Tue, 23 Apr 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836526; cv=none; b=clOErlmNYEOfcmYi5Re+VNooU10XB2fNjT7k09hEh31yDob3pwuIvBgs5Q2pMZnNJV1iWlBR0xjCYdMhSWxPng5mGq/so+0DiPQvK2v88viLfS+pXlZDlfXIQqorYPSCU/1EKB3Fz7ftsSILMy+vLb9077/41Q/WNA+gb8j0StQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836526; c=relaxed/simple;
	bh=9r57Vx40Y2nfjtPI7LcaBPKursErV0Ugz29e2aGiKXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSYsGVtvZzSlQ58QXkb7fS2h70G0UK4a7cVS21lDxEi13QlCEzZRxqjXh4D8zSSdUQ6EbhDwsCjbJUZja5O8vaxI3NNFMZx58/080g2uCaiF8AuT83y56U112RDETqE6lAyxeMpVjhpVQIieq5IQUi/6wgjUXjI5rrpLDnpNM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNlGR4jQKz4f3kG9;
	Tue, 23 Apr 2024 09:41:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 24C851A0DD8;
	Tue, 23 Apr 2024 09:41:59 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7jESdm3NXWKg--.48899S3;
	Tue, 23 Apr 2024 09:41:58 +0800 (CST)
Message-ID: <a1874551-7e02-aa0d-9ef7-4322e920c661@huaweicloud.com>
Date: Tue, 23 Apr 2024 09:41:55 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix uninitialized ratelimit_state->lock access in
 __ext4_fill_super()
Content-Language: en-US
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, yukuai3@huawei.com, libaokun@huaweicloud.com
References: <20240102133730.1098120-1-libaokun1@huawei.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240102133730.1098120-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHZQ7jESdm3NXWKg--.48899S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3uw48Gry5GF18ur48WFg_yoWrAw47pr
	srCa4fJry8X3yjgwsxJFn3JFy8Xw18CFyUCr1xur1UJFyvqrn3XF1xtF48AFW29rWxC3Wv
	qF1UKrWDCa4UG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Gently ping again.

On 2024/1/2 21:37, Baokun Li wrote:
> In the following concurrency we will access the uninitialized rs->lock:
>
> ext4_fill_super
>    ext4_register_sysfs
>     // sysfs registered msg_ratelimit_interval_ms
>                               // Other processes modify rs->interval to
>                               // non-zero via msg_ratelimit_interval_ms
>    ext4_orphan_cleanup
>      ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
>        __ext4_msg
>          ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
>            if (!rs->interval)  // do nothing if interval is 0
>              return 1;
>            raw_spin_trylock_irqsave(&rs->lock, flags)
>              raw_spin_trylock(lock)
>                _raw_spin_trylock
>                  __raw_spin_trylock
>                    spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
>                      lock_acquire
>                        __lock_acquire
>                          register_lock_class
>                            assign_lock_key
>                              dump_stack();
>    ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
>      raw_spin_lock_init(&rs->lock);
>      // init rs->lock here
>
> and get the following dump_stack:
>
> =========================================================
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
> [...]
> Call Trace:
>   dump_stack_lvl+0xc5/0x170
>   dump_stack+0x18/0x30
>   register_lock_class+0x740/0x7c0
>   __lock_acquire+0x69/0x13a0
>   lock_acquire+0x120/0x450
>   _raw_spin_trylock+0x98/0xd0
>   ___ratelimit+0xf6/0x220
>   __ext4_msg+0x7f/0x160 [ext4]
>   ext4_orphan_cleanup+0x665/0x740 [ext4]
>   __ext4_fill_super+0x21ea/0x2b10 [ext4]
>   ext4_fill_super+0x14d/0x360 [ext4]
> [...]
> =========================================================
>
> Normally interval is 0 until s_msg_ratelimit_state is initialized, so
> ___ratelimit() does nothing. But registering sysfs precedes initializing
> rs->lock, so it is possible to change rs->interval to a non-zero value
> via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
> uninitialized, and then a call to ext4_msg triggers the problem by
> accessing an uninitialized rs->lock. Therefore register sysfs after all
> initializations are complete to avoid such problems.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/super.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0980845c8b8f..1db23b0e8a4f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5564,19 +5564,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   	if (err)
>   		goto failed_mount6;
>   
> -	err = ext4_register_sysfs(sb);
> -	if (err)
> -		goto failed_mount7;
> -
>   	err = ext4_init_orphan_info(sb);
>   	if (err)
> -		goto failed_mount8;
> +		goto failed_mount7;
>   #ifdef CONFIG_QUOTA
>   	/* Enable quota usage during mount. */
>   	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
>   		err = ext4_enable_quotas(sb);
>   		if (err)
> -			goto failed_mount9;
> +			goto failed_mount8;
>   	}
>   #endif  /* CONFIG_QUOTA */
>   
> @@ -5602,7 +5598,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   		ext4_msg(sb, KERN_INFO, "recovery complete");
>   		err = ext4_mark_recovery_complete(sb, es);
>   		if (err)
> -			goto failed_mount10;
> +			goto failed_mount9;
>   	}
>   
>   	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> @@ -5619,15 +5615,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   	atomic_set(&sbi->s_warning_count, 0);
>   	atomic_set(&sbi->s_msg_count, 0);
>   
> +	/* Register sysfs after all initializations are complete. */
> +	err = ext4_register_sysfs(sb);
> +	if (err)
> +		goto failed_mount9;
> +
>   	return 0;
>   
> -failed_mount10:
> +failed_mount9:
>   	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
> -failed_mount9: __maybe_unused
> +failed_mount8: __maybe_unused
>   	ext4_release_orphan_info(sb);
> -failed_mount8:
> -	ext4_unregister_sysfs(sb);
> -	kobject_put(&sbi->s_kobj);
>   failed_mount7:
>   	ext4_unregister_li_request(sb);
>   failed_mount6:



