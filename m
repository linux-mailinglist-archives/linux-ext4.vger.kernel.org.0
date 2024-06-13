Return-Path: <linux-ext4+bounces-2870-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5C90619E
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 04:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA61F22762
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36429CFE;
	Thu, 13 Jun 2024 02:09:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698510A0E
	for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244590; cv=none; b=lk7uFm0iAh8hO3js8mks6ngsyCbIUSnNEhvBKScU81GlB6CiycMwkefHVjAC4jHWJWgwjZk1T4pS8RtQ10ai2vKimyEQa3L1F5JkGNv78HXJzOBhWQdHaOhLZNyjomTcyE4ffS5WPuSldr5C1YFlBSXdlQXCUZToJoZCYKkIXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244590; c=relaxed/simple;
	bh=BQ95PuknC4GlVPtxWcrk7r89yfPzQ0wXx0gTyMW/gTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZLOAQdrw7QjO7vMtVvWu+I12WkQicOic/Kkshm5HRnEAGMMtG9BUs85G52IVwT0NhHKkvWOs2Mtjo4ZCT02owOwm2ziujLRafMkFTjEDw1Om5d+5OWn3I2ye8r+pcOxeoZ5C2XOXKqI7I3IH04Cv20C/iJfMdRtWLNYqEdHXYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W05Qs213mz1HDmc;
	Thu, 13 Jun 2024 10:07:49 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A1871A0188;
	Thu, 13 Jun 2024 10:09:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 10:09:44 +0800
Message-ID: <45251246-e24b-4ace-9b45-2efad65e8eb5@huawei.com>
Date: Thu, 13 Jun 2024 10:09:44 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/059: disable block_validity checks when mounting a
 corrupted file system
To: <zlang@kernel.org>, Theodore Ts'o <tytso@mit.edu>
CC: Ext4 Developers List <linux-ext4@vger.kernel.org>,
	<linux-fstests@mit.edu>, =?UTF-8?B?5p2o5LqM5Z2k?= <yangerkun@huawei.com>
References: <20230823145621.3680601-1-tytso@mit.edu>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230823145621.3680601-1-tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100021.china.huawei.com (7.185.36.148)

Hi Zorro,

Could you pick up this patch?
This test case has been failing in the mainline for a while now.

Thanks,
Baokun

On 2023/8/23 22:56, Theodore Ts'o wrote:
> Kernels with the commit "ext4: add correct group descriptors and
> reserved GDT blocks to system zone" will refuse to mount the corrupted
> file system constructed by this test.  So in order to perform the
> test, we need to disable the block_validity checks.
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good to me, thanks for the patch!

Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>

> ---
>   tests/ext4/059 | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tests/ext4/059 b/tests/ext4/059
> index 4230bde92..e4af77f1e 100755
> --- a/tests/ext4/059
> +++ b/tests/ext4/059
> @@ -31,6 +31,11 @@ $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
>   $DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
>   	grep "Reserved GDT blocks"
>   
> +# Kernels with the commit "ext4: add correct group descriptors and
> +# reserved GDT blocks to system zone" will refuse to mount the file
> +# system due to block_validity checks; so disable block_validity.
> +MOUNT_OPTIONS="$MOUNT_OPTIONS -o noblock_validity"
> +
>   _scratch_mount
>   
>   # Expect no crash from this resize operation


-- 
With Best Regards,
Baokun Li


