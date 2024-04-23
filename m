Return-Path: <linux-ext4+bounces-2155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836658ADBA5
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 03:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59CD1C21308
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11F134D1;
	Tue, 23 Apr 2024 01:44:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFB3FF4;
	Tue, 23 Apr 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836678; cv=none; b=rczOck7P61Q3Mp+SEYaeDCv27G9FDZVp/hnKIdgKbtgEBT6ITBgyAm8vIhEbFoP/5nshw+b0Xrab490XHWW9CpWyePxNZ9mX6mG85Ej7VZRgjTtjXhdIaF9slZm4KV1d//8lAwrxVINyKdTTJzyztGhtXZoXGuNYF85BN1qV0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836678; c=relaxed/simple;
	bh=r4WznIYg5k4SVGULs1Q8+9QuWxNOFXcnZi9zzumsie8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgERA3iUPyrYlvW4ONszvlXp8Rhj+nVtCkl2A1dQXyNDOML9WWCkPU5ENQEMVpG9J+pBKCHTLpa6bstzdj40P1EdcO2Q78Oh5OxHdcXBTwGs50H90lgizS9akAKUtLD+BABjmwkoAmhZkP+yWb6Sm3s7diBggTjoJANHk1ZPN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNlKR04cBz4f3kJs;
	Tue, 23 Apr 2024 09:44:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC0891A09FB;
	Tue, 23 Apr 2024 09:44:31 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g57EidmtP7WKg--.27129S3;
	Tue, 23 Apr 2024 09:44:30 +0800 (CST)
Message-ID: <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
Date: Tue, 23 Apr 2024 09:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 0/9] ext4: avoid sysfs variables overflow causing
 BUG_ON/SOOB
Content-Language: en-US
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, adobriyan@gmail.com,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 libaokun@huaweicloud.com
References: <20240319113325.3110393-1-libaokun1@huawei.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240319113325.3110393-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g57EidmtP7WKg--.27129S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF13KF1kXw1fCw4kCFyfWFg_yoW8uw13pF
	sI9w15Gr40qw47Ja9F93Z8Z3WFgw4kJa47KFW7X34rCFyjvryS9ryIgF1rAF97CrZ5uFyx
	tr12vr10kr1j9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

A gentle ping.

On 2024/3/19 19:33, Baokun Li wrote:
> Hello everyone,
>
> This patchset is intended to avoid variables that can be modified via sysfs
> from overflowing when stored or used and thus causing various problems.
>
> "kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.
>
> V3->V4:
>    Patch 4: Corrects WARN_ON_ONCE added in V3.
>
> V2->V3:
>    Add Reviewed-by tag from Jan Kara.
>    Patch 4: Trimming order before the for loop makes the logic easier to
>             understand.
>
> V1->V2:
>    Patch 1: Use kstrtouint() as suggested by Alexey and Honza.
>    Patch 2: Adapted to patch 1 changes.
>    Patch 3: Add Reviewed-by tag.
>    Patch 4: Avoid useless loops as suggested by Ojaswin and rename
> 	   attr_group_prealloc to attr_clusters_in_group.
>    Patch 5: New patch added to limit mb_best_avail_max_trim_order < 64
> 	   as Honza's suggestion.
>    Patch 6: Reordered and updated description.
>    Patch 7: Add Reviewed-by tag.
>    Patch 8: Keep unrelated variables on different lines as suggested by Honza.
>    Patch 9: New patch to fix warnings found during compile checking.
>
> [V1]: https://lore.kernel.org/all/20240126085716.1363019-1-libaokun1@huawei.com/
> [V2]: https://lore.kernel.org/all/20240227091148.178435-1-libaokun1@huawei.com/
> [V3]: https://lore.kernel.org/all/20240314140906.3064072-1-libaokun1@huawei.com/
>
> Baokun Li (9):
>    ext4: avoid overflow when setting values via sysfs
>    ext4: refactor out ext4_generic_attr_store()
>    ext4: refactor out ext4_generic_attr_show()
>    ext4: fix slab-out-of-bounds in
>      ext4_mb_find_good_group_avg_frag_lists()
>    ext4: add new attr pointer attr_mb_order
>    ext4: add positive int attr pointer to avoid sysfs variables overflow
>    ext4: set type of ac_groups_linear_remaining to __u32 to avoid
>      overflow
>    ext4: set the type of max_zeroout to unsigned int to avoid overflow
>    ext4: clean up s_mb_rb_lock to fix build warnings with C=1
>
>   fs/ext4/extents.c |   3 +-
>   fs/ext4/mballoc.c |   5 +-
>   fs/ext4/mballoc.h |   2 +-
>   fs/ext4/sysfs.c   | 174 ++++++++++++++++++++++++++++------------------
>   4 files changed, 112 insertions(+), 72 deletions(-)
>


