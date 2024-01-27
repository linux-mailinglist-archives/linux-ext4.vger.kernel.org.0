Return-Path: <linux-ext4+bounces-976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C583E98E
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 03:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32C4B294C7
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2940B65D;
	Sat, 27 Jan 2024 02:07:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D569B669;
	Sat, 27 Jan 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321247; cv=none; b=PU277XjbFnEbzbQLw0WG2K2zQ7LYpc0Zvlsw4LNx55gKv4YjVfCyulV9uud2G8tkgMM2Y1ZR1hpxmlrAuPcKhNBOfpe++hJoyeBHaXKi6zDTdFdlAJFmIanxRwQCNR1Tgm1L1NlCsuEIKnslfFE3R+qqpH+qMczXjnszbtOQtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321247; c=relaxed/simple;
	bh=D1pPlkWVhGtFEIb+/MVR/16Ou0AZcX23YBF7y5BCQJA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HCVc+Eg5axEds50dQOh9aUO4lNR6U2sTsuErwfIriroYIOrChByHGY70txx5WXAdtINEkxNt+GNI6QO41rdzkycuK67zYsLvBGbjGkf0hl442sZ/nxg2Hz2LbKBSauDdahGADgCcL+adWrCCYhh3Wq37Vdnc9rjI/wOOU16uCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TMHwj4f5Yz18MJg;
	Sat, 27 Jan 2024 10:06:13 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id C307118001C;
	Sat, 27 Jan 2024 10:07:19 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 10:07:19 +0800
Subject: Re: [PATCH 4/7] ext4: add positive int attr pointer to avoid sysfs
 variables overflow
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
	<stable@vger.kernel.org>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-5-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <864b67a3-6a4a-2afb-8275-b8532ea3cb8f@huawei.com>
Date: Sat, 27 Jan 2024 10:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-5-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> We can easily trigger a BUG_ON by using the following commands:
> 
>     mount /dev/$disk /tmp/test
>     echo 2147483650 > /sys/fs/ext4/$disk/mb_group_prealloc
>     echo test > /tmp/test/file && sync
> 
> ==================================================================
> kernel BUG at fs/ext4/mballoc.c:2029!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 320 Comm: kworker/u36:1 Not tainted 6.8.0-rc1 #462
> RIP: 0010:mb_mark_used+0x358/0x370
> [...]
> Call Trace:
>  ext4_mb_use_best_found+0x56/0x140
>  ext4_mb_complex_scan_group+0x196/0x2f0
>  ext4_mb_regular_allocator+0xa92/0xf00
>  ext4_mb_new_blocks+0x302/0xbc0
>  ext4_ext_map_blocks+0x95a/0xef0
>  ext4_map_blocks+0x2b1/0x680
>  ext4_do_writepages+0x733/0xbd0
> [...]
> ==================================================================
> 
> In ext4_mb_normalize_group_request():
>     ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
> 
> Here fe_len is of type int, but s_mb_group_prealloc is of type unsigned
> int, so setting s_mb_group_prealloc to 2147483650 overflows fe_len to a
> negative number, which ultimately triggers a BUG_ON() in mb_mark_used().
> 
> Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
> value range of 0-INT_MAX to avoid the above problem. In addition to the
> mb_group_prealloc sysfs interface, the following interfaces also have uint
> to int conversions that result in overflows, and are also fixed.
> 
>   err_ratelimit_burst
>   msg_ratelimit_burst
>   warning_ratelimit_burst
>   err_ratelimit_interval_ms
>   msg_ratelimit_interval_ms
>   warning_ratelimit_interval_ms
>   mb_best_avail_max_trim_order
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/sysfs.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index a5d657fa05cb..6f9f96e00f2f 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -30,6 +30,7 @@ typedef enum {
>  	attr_first_error_time,
>  	attr_last_error_time,
>  	attr_feature,
> +	attr_pointer_pi,
>  	attr_pointer_ui,
>  	attr_pointer_ul,
>  	attr_pointer_u64,
> @@ -178,6 +179,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
>  #define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
>  	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
>  
> +#define EXT4_RW_ATTR_SBI_PI(_name,_elname)      \
> +	EXT4_ATTR_OFFSET(_name, 0644, pointer_pi, ext4_sb_info, _elname)
> +
>  #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>  	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>  
> @@ -213,17 +217,17 @@ EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> -EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> +EXT4_RW_ATTR_SBI_PI(mb_group_prealloc, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
>  #ifdef CONFIG_EXT4_DEBUG
>  EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>  #endif
> @@ -376,6 +380,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  
>  	switch (a->attr_id) {
>  	case attr_inode_readahead:
> +	case attr_pointer_pi:
>  	case attr_pointer_ui:
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> @@ -448,6 +453,10 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>  		return ret;
>  
>  	switch (a->attr_id) {
> +	case attr_pointer_pi:
> +		if ((int)t < 0)
> +			return -EINVAL;
> +		fallthrough;
>  	case attr_pointer_ui:
>  		if (t != (unsigned int)t)
>  			return -EINVAL;
> 

