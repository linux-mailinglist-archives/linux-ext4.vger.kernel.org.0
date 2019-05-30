Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D730179
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfE3SG2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 14:06:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34542 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE3SGT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 14:06:19 -0400
Received: by mail-it1-f195.google.com with SMTP id g23so8792338iti.1
        for <linux-ext4@vger.kernel.org>; Thu, 30 May 2019 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ukGzLbp6uBLX3/O/hi+i21Y99Ie3oYCbtzuO97eK1Mc=;
        b=qfH1QO+4m+66Ajkdva/35iyEjWwBqOyAfVe4TqFrH8WbxliSE46qZNXrbXotwxDDA0
         M4i0w8q16UJ+4y6NUp83RGewqOndDgD4cBzthhAt2r60UrFmK8QMTAEhF4kA59WW7ks/
         15kvr9nkdtDGf9x46bCWRU71vdYsoQ9kOBJXCjLkcSRVT7Li1ev6fKEbYp4WWQd6UnSI
         vSPFrvO5po6Z/QC8ADW9TjTiob1bPOV6qjruyhSxVjdPL8aphjmgXRMJa+MLP1yTfHcP
         00cju5U0NPA/VzbDl1YCODo03/hDDKtK9PSbyYQbXPHdd7tc8PfCEOWyTF7rmxXpWyf2
         Zk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ukGzLbp6uBLX3/O/hi+i21Y99Ie3oYCbtzuO97eK1Mc=;
        b=SHn2e2DMzrKkElyU3R9ntzCczHDuqDUYZa9wIKZJOhuFpGea1OgGBw/vdHCeaOeqVp
         xMo0/4YPOoR6aYx1HwmcbHneh6n1DDGKdcBV5jOUvwY7igRYY6PnGMXf/DRmO/pi/MK8
         tPEJp7Q9wq2QQnu2pYEUV5JQHirU36buM0q0RfUraEBEi4dNNXYXwSL5u1NqMBL+PoQE
         69U74QdqngJ2JzwViwwyBwhxXA8IpdsVp7S8+zEWdydcPDFYFfYRhfTtzoz4EGubENrJ
         D21nkl2aT8HOuZO3IP2ddhzoocV4HaXcddh0I23SFpCl6tvXI6dGtMfwXRwXryazMNj1
         Mr7Q==
X-Gm-Message-State: APjAAAWeFroBa0SFzJsEyeNa8qzW7gMUOgE+OIMhGtX1A6kiY+1L6d8d
        y7QkeJwSmou+FeLU+CvbG+A=
X-Google-Smtp-Source: APXvYqy28w31fPbwJNj9vVrIjfOjTPp/9kqTke14LxoJPNxM+JMGxPUxfaHbDxg/hUDoT+Z/712jeg==
X-Received: by 2002:a05:660c:886:: with SMTP id o6mr3746998itk.34.1559239578702;
        Thu, 30 May 2019 11:06:18 -0700 (PDT)
Received: from [192.168.65.54] (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id p1sm1014492iob.72.2019.05.30.11.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:06:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH] don't search large block range if disk is full
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <842F530C-5F9E-4E17-A563-170CFB181244@dilger.ca>
Date:   Thu, 30 May 2019 21:05:56 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BBA0C9A-E028-48E0-85F8-79E57A1A912B@gmail.com>
References: <20190311090851.29189-1-c17828@cray.com>
 <842F530C-5F9E-4E17-A563-170CFB181244@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Andreas,

Thank you for feedback!
I really wanted send new version (with test results, but without kernel =
decision-maker) of this patch this evening, but you were faster.


> On 30 May 2019, at 19:56, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> Artem, we discussed this patch on the Ext4 concall today. A couple
> of items came up during discussion:
> - the patch submission should include performance results to
>   show that the patch is providing an improvement
> - it would be preferable if the thresholds for the stages were found
>   dynamically in the kernel based on how many groups have been skipped
>   and the free chunk size in each group
> - there would need to be some way to dynamically reset the scanning
>   level when lots of blocks have been freed
>=20
> Cheers, Andreas

My suggestion is split this plan to 2 phases.
Phase 1 - loop skipping code and interface to user-mode that gives to =
administrator ability configure loop-skipping code.
Phase 2 in kernel discussion-maker based on groups info (and some other =
information)

Here are testing results I wanted to add to new patch version. Adding it =
here for descussion:

Here are some aproach test results.

During test, system was fragmented with pattern "50 free blocks - 50
occupied  blocks". Performance digradated from 1.2 Gb/sed to 10 MB/sec.
68719476736 bytes (69 GB) copied, 6619.02 s, 10.4 MB/s

Let's exlude c1 loops
echo "60" > /sys/fs/ext4/md0/mb_c1_threshold

Excluding c1 loops doesn't change performance. Same 10 MB/s
Statistics shows that 981753 c1 loops were skipped, but
1664192 finished without sucess.
mballoc: (7829, 1664192, 0) useless c(0,1,2) loops
mballoc: (981753, 0, 0) skipped c(0,1,2) loops

Then c1 and c2 loops ware disabled.
echo "60" > /sys/fs/ext4/md0/mb_c1_threshold
echo "60" > /sys/fs/ext4/md0/mb_c2_threshold

mballoc: (0, 0, 0) useless c(0,1,2) loops
mballoc: (1425456, 1393743, 0) skipped c(0,1,2) loops

A lot of loops c1 and c2 skipped.
For given fragmentation write performance returned to ~500 MB/s
68719476736 bytes (69 GB) copied, 133.066 s, 516 MB/s

This is example how to improve performance for exact
partition fragmentation. The patch adds interfaces for
adjusting block allocator for any situation.

Best regards,
Artem Blagodarenko.
>> On Mar 11, 2019, at 03:08, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>>=20
>> Block allocator tries to find:
>> 1) group with the same range as required
>> 2) group with the same average range as required
>> 3) group with required amount of space
>> 4) any group
>>=20
>> For quite full disk step 1 is failed with higth
>> probability, but takes a lot of time.
>>=20
>> Skip 1st step if disk full > 75%
>> Skip 2d step if disk full > 85%
>> Skip 3d step if disk full > 95%
>>=20
>> This three tresholds can be adjusted through added interface.
>>=20
>> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
>> ---
>> fs/ext4/ext4.h    |  3 +++
>> fs/ext4/mballoc.c | 32 ++++++++++++++++++++++++++++++++
>> fs/ext4/mballoc.h |  3 +++
>> fs/ext4/sysfs.c   |  6 ++++++
>> 4 files changed, 44 insertions(+)
>>=20
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 185a05d3257e..fbccb459a296 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1431,6 +1431,9 @@ struct ext4_sb_info {
>>   unsigned int s_mb_min_to_scan;
>>   unsigned int s_mb_stats;
>>   unsigned int s_mb_order2_reqs;
>> +    unsigned int s_mb_c1_treshold;
>> +    unsigned int s_mb_c2_treshold;
>> +    unsigned int s_mb_c3_treshold;
>>   unsigned int s_mb_group_prealloc;
>>   unsigned int s_max_dir_size_kb;
>>   /* where last allocation was done - for stream allocation */
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 4e6c36ff1d55..85f364aa96c9 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2096,6 +2096,20 @@ static int ext4_mb_good_group(struct =
ext4_allocation_context *ac,
>>   return 0;
>> }
>>=20
>> +static u64 available_blocks_count(struct ext4_sb_info *sbi)
>> +{
>> +    ext4_fsblk_t resv_blocks;
>> +    u64 bfree;
>> +    struct ext4_super_block *es =3D sbi->s_es;
>> +
>> +    resv_blocks =3D EXT4_C2B(sbi, =
atomic64_read(&sbi->s_resv_clusters));
>> +    bfree =3D =
percpu_counter_sum_positive(&sbi->s_freeclusters_counter) -
>> +         percpu_counter_sum_positive(&sbi->s_dirtyclusters_counter);
>> +
>> +    bfree =3D EXT4_C2B(sbi, max_t(s64, bfree, 0));
>> +    return bfree - (ext4_r_blocks_count(es) + resv_blocks);
>> +}
>> +
>> static noinline_for_stack int
>> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>> {
>> @@ -2104,10 +2118,13 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
>>   int err =3D 0, first_err =3D 0;
>>   struct ext4_sb_info *sbi;
>>   struct super_block *sb;
>> +    struct ext4_super_block *es;
>>   struct ext4_buddy e4b;
>> +    unsigned int free_rate;
>>=20
>>   sb =3D ac->ac_sb;
>>   sbi =3D EXT4_SB(sb);
>> +    es =3D sbi->s_es;
>>   ngroups =3D ext4_get_groups_count(sb);
>>   /* non-extent files are limited to low blocks/groups */
>>   if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
>> @@ -2157,6 +2174,18 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
>>=20
>>   /* Let's just scan groups to find more-less suitable blocks */
>>   cr =3D ac->ac_2order ? 0 : 1;
>> +
>> +    /* Choose what loop to pass based on disk fullness */
>> +    free_rate =3D available_blocks_count(sbi) * 100 / =
ext4_blocks_count(es);
>> +
>> +    if (free_rate < sbi->s_mb_c3_treshold) {
>> +        cr =3D 3;
>> +    } else if(free_rate < sbi->s_mb_c2_treshold) {
>> +        cr =3D 2;
>> +    } else if(free_rate < sbi->s_mb_c1_treshold) {
>> +        cr =3D 1;
>> +    }
>> +
>>   /*
>>    * cr =3D=3D 0 try to get exact allocation,
>>    * cr =3D=3D 3  try to get anything
>> @@ -2618,6 +2647,9 @@ int ext4_mb_init(struct super_block *sb)
>>   sbi->s_mb_stats =3D MB_DEFAULT_STATS;
>>   sbi->s_mb_stream_request =3D MB_DEFAULT_STREAM_THRESHOLD;
>>   sbi->s_mb_order2_reqs =3D MB_DEFAULT_ORDER2_REQS;
>> +    sbi->s_mb_c1_treshold =3D MB_DEFAULT_C1_TRESHOLD;
>> +    sbi->s_mb_c2_treshold =3D MB_DEFAULT_C2_TRESHOLD;
>> +    sbi->s_mb_c3_treshold =3D MB_DEFAULT_C3_TRESHOLD;
>>   /*
>>    * The default group preallocation is 512, which for 4k block
>>    * sizes translates to 2 megabytes.  However for bigalloc file
>> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index 88c98f17e3d9..d880923e55a5 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -71,6 +71,9 @@ do {                                    \
>> * for which requests use 2^N search using buddies
>> */
>> #define MB_DEFAULT_ORDER2_REQS        2
>> +#define MB_DEFAULT_C1_TRESHOLD        25
>> +#define MB_DEFAULT_C2_TRESHOLD        15
>> +#define MB_DEFAULT_C3_TRESHOLD        5
>>=20
>> /*
>> * default group prealloc size 512 blocks
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index 9212a026a1f1..e4f1d98195c2 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -175,6 +175,9 @@ EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
>> EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>> EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>> EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>> +EXT4_RW_ATTR_SBI_UI(mb_c1_treshold, s_mb_c1_treshold);
>> +EXT4_RW_ATTR_SBI_UI(mb_c2_treshold, s_mb_c2_treshold);
>> +EXT4_RW_ATTR_SBI_UI(mb_c3_treshold, s_mb_c3_treshold);
>> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>> @@ -203,6 +206,9 @@ static struct attribute *ext4_attrs[] =3D {
>>   ATTR_LIST(mb_max_to_scan),
>>   ATTR_LIST(mb_min_to_scan),
>>   ATTR_LIST(mb_order2_req),
>> +    ATTR_LIST(mb_c1_treshold),
>> +    ATTR_LIST(mb_c2_treshold),
>> +    ATTR_LIST(mb_c3_treshold),
>>   ATTR_LIST(mb_stream_req),
>>   ATTR_LIST(mb_group_prealloc),
>>   ATTR_LIST(max_writeback_mb_bump),
>> --=20
>> 2.14.3
>>=20

