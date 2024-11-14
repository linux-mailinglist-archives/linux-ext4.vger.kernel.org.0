Return-Path: <linux-ext4+bounces-5150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE29C81B6
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 05:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E728056D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C897F1DFD82;
	Thu, 14 Nov 2024 04:03:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8F154C0B;
	Thu, 14 Nov 2024 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556988; cv=none; b=ZQLrCu/ccODH7r4ARSsFyTICsI5MkcTrsK2VkmyP0Tc+w46ULmyNO3di8fQE9LpaWW14l7zGvDd8zyE42G7BOzpqBasoJ5S/ALwk0yX2ZKQIsc7/3HS3VfvGHEwhbKCuIqSwGQKvOGWY8ihz2D8tsET/D0cciBuxuqMd3+gujU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556988; c=relaxed/simple;
	bh=EDedrwmGEc4iJVB/qhKnd2nLZ/vBF8NU/WcC2meldYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uzgRfU9sugokbcHCixq+Gs0WZIdKZxE28r8d2rbTtMl3J5iiMWKby84IzUq1QB/4EifjO8FvfeBwg4ZEln8Du8XahRPf7eDM4xAq1zy9bOUNIl3EfXbeZyucYC3/p5kSRntnSgy9SoJ+FWnCAXqoe2w1vDRUk041hn9cV0RdqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XpmfV58XPz10V8q;
	Thu, 14 Nov 2024 12:01:06 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id C205B140157;
	Thu, 14 Nov 2024 12:03:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 12:03:00 +0800
Message-ID: <7bbc91b6-2a39-4dd8-86b5-4bdea9070f5e@huawei.com>
Date: Thu, 14 Nov 2024 12:03:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4/032: add a new testcase in online resize tests
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	<fstests@vger.kernel.org>
CC: <linux-ext4@vger.kernel.org>, <jack@suse.cz>, <tytso@mit.edu>,
	<zlang@redhat.com>, Yang Erkun <yangerkun@huawei.com>
References: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/11 23:21, Alexander Mikhalitsyn wrote:
> Add a new testcase for [1] commit in ext4 online resize testsuite.
>
> Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Looks good, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   tests/ext4/032     |  6 ++++++
>   tests/ext4/032.out | 18 ++++++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 6bc3b61b..238ab178 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -10,6 +10,9 @@
>   . ./common/preamble
>   _begin_fstest auto quick ioctl resize
>   
> +_fixed_by_kernel_commit 6121258c2b33 \
> +	"ext4: fix off by one issue in alloc_flex_gd()"
> +
>   BLK_SIZ=4096
>   CLUSTER_SIZ=4096
>   
> @@ -136,6 +139,9 @@ for CLUSTER_SIZ in 4096 16384 65536; do
>   
>   	## Extending a 2/3rd block group to 1280 block groups.
>   	ext4_online_resize $(c2b 24576) $(c2b 41943040)
> +
> +	# tests for "ext4: fix off by one issue in alloc_flex_gd()"
> +	ext4_online_resize $(c2b 6400) $(c2b 786432)
>   done
>   
>   status=0
> diff --git a/tests/ext4/032.out b/tests/ext4/032.out
> index b372b014..d5d75c9e 100644
> --- a/tests/ext4/032.out
> +++ b/tests/ext4/032.out
> @@ -60,6 +60,12 @@ QA output created by 032
>   +++ resize fs to 41943040
>   +++ umount fs
>   +++ check fs
> ++++ truncate image file to 786432
> ++++ create fs on image file 6400
> ++++ mount image file
> ++++ resize fs to 786432
> ++++ umount fs
> ++++ check fs
>   ++ set cluster size to 16384
>   +++ truncate image file to 98304
>   +++ create fs on image file 65536
> @@ -115,6 +121,12 @@ QA output created by 032
>   +++ resize fs to 167772160
>   +++ umount fs
>   +++ check fs
> ++++ truncate image file to 3145728
> ++++ create fs on image file 25600
> ++++ mount image file
> ++++ resize fs to 3145728
> ++++ umount fs
> ++++ check fs
>   ++ set cluster size to 65536
>   +++ truncate image file to 393216
>   +++ create fs on image file 262144
> @@ -170,3 +182,9 @@ QA output created by 032
>   +++ resize fs to 671088640
>   +++ umount fs
>   +++ check fs
> ++++ truncate image file to 12582912
> ++++ create fs on image file 102400
> ++++ mount image file
> ++++ resize fs to 12582912
> ++++ umount fs
> ++++ check fs



