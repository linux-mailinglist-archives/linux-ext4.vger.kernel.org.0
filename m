Return-Path: <linux-ext4+bounces-2269-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D28BA522
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5312C283CD0
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15273168B8;
	Fri,  3 May 2024 02:03:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96C11CA9;
	Fri,  3 May 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701803; cv=none; b=nRcDcr2kSYIBxticmrDchQlK7GB5yAjoT2dqrL7DxEuPXEdPyTG4poNKNXfIy7pQ4RLtHEY8k9gVBL13dIKiEMaEqkQP+v4svAXDCKB8XT5vjQPBIzm5tfp+friWAeD0CZgo/SPTYvW2KysB0e4XLnx2LhvzOp7TVqTUVx+a55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701803; c=relaxed/simple;
	bh=NJ4H1pZUAlpuiYEur2CV1Z0R1IDpFmWiWWgG6HEDU98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUdkiD4RwsjqCyQnTok1mSxxHonh4BudfudsF7fH3VGGrfflnSfdQiu4SYycjtJbPtvAscnnD9ynyTWp/BsuHsMJFV+KzzltNT8TiSa+E3s7eak4nRuZM5+8gKQFsPMhYTqjTWL6CiSdIJxXZhBEZRQvdPwnY+Ae84zdMgz8ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VVvGD6f2Qz4f3n6Q;
	Fri,  3 May 2024 10:03:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8605C1A1325;
	Fri,  3 May 2024 10:03:10 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7YRTRmdbxsLg--.54078S3;
	Fri, 03 May 2024 10:03:08 +0800 (CST)
Message-ID: <8cf61cfc-8717-ee33-c94f-959212ce9c85@huaweicloud.com>
Date: Fri, 3 May 2024 10:03:04 +0800
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
To: linux-ext4@vger.kernel.org, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, adobriyan@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
References: <20240319113325.3110393-1-libaokun1@huawei.com>
 <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <985285f6-973b-30d5-4742-29cf5e8c0e27@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ7YRTRmdbxsLg--.54078S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15CFW5WF18ZFyUJrW7CFg_yoW5GFyrpF
	s3Ka45WrZ8Cws7JrsrGw1DA34Fqws5JasrGF13Xa48AFWjyr129rZ2gr1F9F9rGrZ5CF1I
	yr17Zrn7uF1avrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Ted,

Would you consider merging in this patchset in the current merge
window? I would appreciate it if you could.

Thanks,
Baokun

On 2024/4/23 9:44, Baokun Li wrote:
> A gentle ping.
>
> On 2024/3/19 19:33, Baokun Li wrote:
>> Hello everyone,
>>
>> This patchset is intended to avoid variables that can be modified via 
>> sysfs
>> from overflowing when stored or used and thus causing various problems.
>>
>> "kvm-xfstests -c ext4/all -g auto" has been executed with no new 
>> failures.
>>
>> V3->V4:
>>    Patch 4: Corrects WARN_ON_ONCE added in V3.
>>
>> V2->V3:
>>    Add Reviewed-by tag from Jan Kara.
>>    Patch 4: Trimming order before the for loop makes the logic easier to
>>             understand.
>>
>> V1->V2:
>>    Patch 1: Use kstrtouint() as suggested by Alexey and Honza.
>>    Patch 2: Adapted to patch 1 changes.
>>    Patch 3: Add Reviewed-by tag.
>>    Patch 4: Avoid useless loops as suggested by Ojaswin and rename
>>        attr_group_prealloc to attr_clusters_in_group.
>>    Patch 5: New patch added to limit mb_best_avail_max_trim_order < 64
>>        as Honza's suggestion.
>>    Patch 6: Reordered and updated description.
>>    Patch 7: Add Reviewed-by tag.
>>    Patch 8: Keep unrelated variables on different lines as suggested 
>> by Honza.
>>    Patch 9: New patch to fix warnings found during compile checking.
>>
>> [V1]: 
>> https://lore.kernel.org/all/20240126085716.1363019-1-libaokun1@huawei.com/
>> [V2]: 
>> https://lore.kernel.org/all/20240227091148.178435-1-libaokun1@huawei.com/
>> [V3]: 
>> https://lore.kernel.org/all/20240314140906.3064072-1-libaokun1@huawei.com/
>>
>> Baokun Li (9):
>>    ext4: avoid overflow when setting values via sysfs
>>    ext4: refactor out ext4_generic_attr_store()
>>    ext4: refactor out ext4_generic_attr_show()
>>    ext4: fix slab-out-of-bounds in
>>      ext4_mb_find_good_group_avg_frag_lists()
>>    ext4: add new attr pointer attr_mb_order
>>    ext4: add positive int attr pointer to avoid sysfs variables overflow
>>    ext4: set type of ac_groups_linear_remaining to __u32 to avoid
>>      overflow
>>    ext4: set the type of max_zeroout to unsigned int to avoid overflow
>>    ext4: clean up s_mb_rb_lock to fix build warnings with C=1
>>
>>   fs/ext4/extents.c |   3 +-
>>   fs/ext4/mballoc.c |   5 +-
>>   fs/ext4/mballoc.h |   2 +-
>>   fs/ext4/sysfs.c   | 174 ++++++++++++++++++++++++++++------------------
>>   4 files changed, 112 insertions(+), 72 deletions(-)
>>


