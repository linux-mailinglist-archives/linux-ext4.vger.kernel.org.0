Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268E830070
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfE3Q4j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 12:56:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34939 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfE3Q4i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 12:56:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so4354015pfd.2
        for <linux-ext4@vger.kernel.org>; Thu, 30 May 2019 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GIH5J9gwELM48bsKXuJsfJeWcbsCCLVj1OiBMVabHGk=;
        b=0MT0sI9Rk9b01mj5lYFbUEUAElzSGBLbicAC0NnxfOmRD4AWCYpT0ITj38b5NWKV3b
         ng3U97sMkJrybXUATLtVTC7mkNGcpNEdgy4ekagXsrVoX30iYykxo9E4gsJB+0VU8m03
         hCUbHUiOVKsozFgfVT0bT38MtyN93tdo8gnLT4y1NY8Ji6opYbBSHswjt3F6J312YGie
         rJrgCPk/laBURVtR+V7MmygSFqC9eNFyD1UYdvvwZuWstRaewMFi9udmYqK7QmWb27hm
         1BLVYjizPqDWPX1sFJFGqUawMH9thpX/Y0L9rma6IafHb8qb1biMs7bEUjcQHfr2LlY2
         N/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GIH5J9gwELM48bsKXuJsfJeWcbsCCLVj1OiBMVabHGk=;
        b=GzKMTC8creFasctvu5RzgnB3b+JrRwhSCr5Wug9hXsnYoZU9ic3oVaMHofWKvLhUOe
         4qrPhga5Z79wfiRcIu3AM2TQ+xHoBeRze+CLrY1F0Jmvvv+i5/ecgkugBj6PLU80u7zG
         wgfPKND/gBR0FvVyRaENlTEbxx46iuh3Wr+aEdTjvHMRskohejkNKarlQNb83vcK/9Ma
         i1PxpZCbtfhMM3YsY/uTwKX787v8cWF5e2DqQ3iejtASqacyBKokx8LJfvNZmBaZvwTt
         Fwh9LXU+A6S8UgGrRdQqIaYeKK1cOOtDKbAinR7+tGSQ0qa0J2QS9xVoIiWv7AGtFrlo
         /IAw==
X-Gm-Message-State: APjAAAUYcNur26MeOa5Y2v2OAc8m0rmzyXUPDrTP1/d/b/s7uuLAGpSL
        jpwCjx4uDsES59T0HofzNTqSMg==
X-Google-Smtp-Source: APXvYqwb8+nFelyYJl9EPUI2K7r1VwNOCvxGxQQpxz+8e+a6BrCP7vkwx4ogrlmWkZXq9Kca/GTscQ==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr4702160pfa.70.1559235397776;
        Thu, 30 May 2019 09:56:37 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 2sm2869190pgc.49.2019.05.30.09.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 09:56:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] don't search large block range if disk is full
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190311090851.29189-1-c17828@cray.com>
Date:   Thu, 30 May 2019 10:56:35 -0600
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        alexey.lyashkov@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <842F530C-5F9E-4E17-A563-170CFB181244@dilger.ca>
References: <20190311090851.29189-1-c17828@cray.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Artem, we discussed this patch on the Ext4 concall today. A couple
of items came up during discussion:
- the patch submission should include performance results to
   show that the patch is providing an improvement
- it would be preferable if the thresholds for the stages were found
   dynamically in the kernel based on how many groups have been skipped
   and the free chunk size in each group
- there would need to be some way to dynamically reset the scanning
   level when lots of blocks have been freed

Cheers, Andreas

> On Mar 11, 2019, at 03:08, Artem Blagodarenko <artem.blagodarenko@gmail.co=
m> wrote:
>=20
> Block allocator tries to find:
> 1) group with the same range as required
> 2) group with the same average range as required
> 3) group with required amount of space
> 4) any group
>=20
> For quite full disk step 1 is failed with higth
> probability, but takes a lot of time.
>=20
> Skip 1st step if disk full > 75%
> Skip 2d step if disk full > 85%
> Skip 3d step if disk full > 95%
>=20
> This three tresholds can be adjusted through added interface.
>=20
> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
> ---
> fs/ext4/ext4.h    |  3 +++
> fs/ext4/mballoc.c | 32 ++++++++++++++++++++++++++++++++
> fs/ext4/mballoc.h |  3 +++
> fs/ext4/sysfs.c   |  6 ++++++
> 4 files changed, 44 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 185a05d3257e..fbccb459a296 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1431,6 +1431,9 @@ struct ext4_sb_info {
>    unsigned int s_mb_min_to_scan;
>    unsigned int s_mb_stats;
>    unsigned int s_mb_order2_reqs;
> +    unsigned int s_mb_c1_treshold;
> +    unsigned int s_mb_c2_treshold;
> +    unsigned int s_mb_c3_treshold;
>    unsigned int s_mb_group_prealloc;
>    unsigned int s_max_dir_size_kb;
>    /* where last allocation was done - for stream allocation */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4e6c36ff1d55..85f364aa96c9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2096,6 +2096,20 @@ static int ext4_mb_good_group(struct ext4_allocatio=
n_context *ac,
>    return 0;
> }
>=20
> +static u64 available_blocks_count(struct ext4_sb_info *sbi)
> +{
> +    ext4_fsblk_t resv_blocks;
> +    u64 bfree;
> +    struct ext4_super_block *es =3D sbi->s_es;
> +
> +    resv_blocks =3D EXT4_C2B(sbi, atomic64_read(&sbi->s_resv_clusters));
> +    bfree =3D percpu_counter_sum_positive(&sbi->s_freeclusters_counter) -=

> +         percpu_counter_sum_positive(&sbi->s_dirtyclusters_counter);
> +
> +    bfree =3D EXT4_C2B(sbi, max_t(s64, bfree, 0));
> +    return bfree - (ext4_r_blocks_count(es) + resv_blocks);
> +}
> +
> static noinline_for_stack int
> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> {
> @@ -2104,10 +2118,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_c=
ontext *ac)
>    int err =3D 0, first_err =3D 0;
>    struct ext4_sb_info *sbi;
>    struct super_block *sb;
> +    struct ext4_super_block *es;
>    struct ext4_buddy e4b;
> +    unsigned int free_rate;
>=20
>    sb =3D ac->ac_sb;
>    sbi =3D EXT4_SB(sb);
> +    es =3D sbi->s_es;
>    ngroups =3D ext4_get_groups_count(sb);
>    /* non-extent files are limited to low blocks/groups */
>    if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> @@ -2157,6 +2174,18 @@ ext4_mb_regular_allocator(struct ext4_allocation_co=
ntext *ac)
>=20
>    /* Let's just scan groups to find more-less suitable blocks */
>    cr =3D ac->ac_2order ? 0 : 1;
> +
> +    /* Choose what loop to pass based on disk fullness */
> +    free_rate =3D available_blocks_count(sbi) * 100 / ext4_blocks_count(e=
s);
> +
> +    if (free_rate < sbi->s_mb_c3_treshold) {
> +        cr =3D 3;
> +    } else if(free_rate < sbi->s_mb_c2_treshold) {
> +        cr =3D 2;
> +    } else if(free_rate < sbi->s_mb_c1_treshold) {
> +        cr =3D 1;
> +    }
> +
>    /*
>     * cr =3D=3D 0 try to get exact allocation,
>     * cr =3D=3D 3  try to get anything
> @@ -2618,6 +2647,9 @@ int ext4_mb_init(struct super_block *sb)
>    sbi->s_mb_stats =3D MB_DEFAULT_STATS;
>    sbi->s_mb_stream_request =3D MB_DEFAULT_STREAM_THRESHOLD;
>    sbi->s_mb_order2_reqs =3D MB_DEFAULT_ORDER2_REQS;
> +    sbi->s_mb_c1_treshold =3D MB_DEFAULT_C1_TRESHOLD;
> +    sbi->s_mb_c2_treshold =3D MB_DEFAULT_C2_TRESHOLD;
> +    sbi->s_mb_c3_treshold =3D MB_DEFAULT_C3_TRESHOLD;
>    /*
>     * The default group preallocation is 512, which for 4k block
>     * sizes translates to 2 megabytes.  However for bigalloc file
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 88c98f17e3d9..d880923e55a5 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -71,6 +71,9 @@ do {                                    \
>  * for which requests use 2^N search using buddies
>  */
> #define MB_DEFAULT_ORDER2_REQS        2
> +#define MB_DEFAULT_C1_TRESHOLD        25
> +#define MB_DEFAULT_C2_TRESHOLD        15
> +#define MB_DEFAULT_C3_TRESHOLD        5
>=20
> /*
>  * default group prealloc size 512 blocks
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 9212a026a1f1..e4f1d98195c2 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -175,6 +175,9 @@ EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
> EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
> EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
> EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
> +EXT4_RW_ATTR_SBI_UI(mb_c1_treshold, s_mb_c1_treshold);
> +EXT4_RW_ATTR_SBI_UI(mb_c2_treshold, s_mb_c2_treshold);
> +EXT4_RW_ATTR_SBI_UI(mb_c3_treshold, s_mb_c3_treshold);
> EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> @@ -203,6 +206,9 @@ static struct attribute *ext4_attrs[] =3D {
>    ATTR_LIST(mb_max_to_scan),
>    ATTR_LIST(mb_min_to_scan),
>    ATTR_LIST(mb_order2_req),
> +    ATTR_LIST(mb_c1_treshold),
> +    ATTR_LIST(mb_c2_treshold),
> +    ATTR_LIST(mb_c3_treshold),
>    ATTR_LIST(mb_stream_req),
>    ATTR_LIST(mb_group_prealloc),
>    ATTR_LIST(max_writeback_mb_bump),
> --=20
> 2.14.3
>=20
