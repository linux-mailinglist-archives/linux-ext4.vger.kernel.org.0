Return-Path: <linux-ext4+bounces-5011-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FC9C29B8
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 04:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337D41F22A2F
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 03:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14A4437C;
	Sat,  9 Nov 2024 03:32:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38B28F3;
	Sat,  9 Nov 2024 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123131; cv=none; b=rqkQVe8mas7YQ/lkZY4Maot6/BAMuiGoUcHYAHYQRLsW+kz6REuSATh0j1R6Ft4oLIXybBwzspoEp1aVVG04R44mVibOunC0mt+RLsJYilnBFtyouwLkghXvKA5MBEWuLzg4xUEYBc47mD4KizLvmjYKXsjfEP+uiJKWwMa2glQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123131; c=relaxed/simple;
	bh=XXIRHT4LhgVU1nmmw2DGDBK2LyO3O6Fv4t04S/8D+xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gRVk9gcIrQoWiWv5V4369rcKJ7WUZeGE+4fxMeL+xDLflpwk284D4itWx1Xo+qK8KIgAEPCQ9FQ+D1ELSh5pWUW0Np+O1H/Rvlaxe75KcN3iWSaLAxP13L3ElCyhw9f3rl/0qukjlk1vQHU6MpuVySHtBOoGnwWJkEDrwiE1Eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XlhCJ37z8z2Fbpc;
	Sat,  9 Nov 2024 11:30:20 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id EB19E18002B;
	Sat,  9 Nov 2024 11:32:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 9 Nov
 2024 11:32:04 +0800
Message-ID: <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
Date: Sat, 9 Nov 2024 11:32:03 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	<fstests@vger.kernel.org>
CC: <linux-ext4@vger.kernel.org>, <jack@suse.cz>, <tytso@mit.edu>, Yang Erkun
	<yangerkun@huawei.com>
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Alexander,

Thanks for the patch.

On 2024/11/8 21:48, Alexander Mikhalitsyn wrote:
> Add a new testcase for [1] commit in ext4 online resize testsuite.
>
> Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   tests/ext4/032 | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 6bc3b61b..77d592f4 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
>   # Check if online resizing with bigalloc is supported by the kernel
>   ext4_online_resize 4096 8192 1
>   
> +_fixed_by_kernel_commit 6121258c2b33 \
> +	"ext4: fix off by one issue in alloc_flex_gd()"
> +ext4_online_resize $(c2b 6400) $(c2b 786432)
> +
I think this test would be better placed in the loop below. Then add some
comments describing the scenario being tested.

There are two current scenarios for off by one:
  * The above test is to expand from the first block group of a flex_bg to
    the next flex_bg;
  * Another scenario is to expand from the first block group of a flex_bg
    to the last block group of this flex_bg. For example,
      `ext4_online_resize $(c2b 6400) $(c2b 524288)`

In addition, we need to modify the tests/ext4/032.out or the use cases
will fail due to inconsistent output.


Regards,
Baokun
>   ## We perform resizing to various multiples of block group sizes to
>   ## ensure that we cover maximum edge cases in the kernel code.
>   for CLUSTER_SIZ in 4096 16384 65536; do



