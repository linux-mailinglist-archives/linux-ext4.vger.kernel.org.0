Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4075F8E0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGXNuu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGXNui (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 09:50:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B646AB;
        Mon, 24 Jul 2023 06:47:37 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8hGK6gdPzNmbL;
        Mon, 24 Jul 2023 21:44:09 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 21:47:31 +0800
Subject: Re: [PATCH v5 7/8] ext4: add some kunit stub for mballoc kunit test
To:     Kemeng Shi <shikemeng@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ojaswin@linux.ibm.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
 <20230629144007.1263510-8-shikemeng@huaweicloud.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <fbc8b67b-d3cd-a30b-99b5-8c160224e928@huawei.com>
Date:   Mon, 24 Jul 2023 21:47:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230629144007.1263510-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/29 22:40, Kemeng Shi wrote:
> Multiblocks allocation will read and write block bitmap and group
> descriptor which reside on disk. Add kunit stub to function
> ext4_get_group_desc, ext4_read_block_bitmap_nowait, ext4_wait_block_bitmap
> and ext4_mb_mark_group_bb to avoid real IO to disk.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/ext4/balloc.c  | 16 ++++++++++++++++
>   fs/ext4/mballoc.c |  6 ++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 1f72f977c6db..d39655fb2f53 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -22,6 +22,7 @@
>   #include "mballoc.h"
>   
>   #include <trace/events/ext4.h>
> +#include <kunit/static_stub.h>
>   
>   static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
>   					    ext4_group_t block_group);
> @@ -274,6 +275,11 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	struct buffer_head *bh_p;
>   
> +#ifdef CONFIG_EXT4_KUNIT_TESTS
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
> +				   sb, block_group, bh);
> +#endif

Hi Kemeng,

I'm not a fan of adding "#ifdef" blocks in functions everywhere. The 
right thing to do is to put these "#ifdef" blocks in header files and to 
make the macro or functions empty if you want to make these codes 
conditionally-compiled out.

The standard usage in kernel looks like:

In the header file: "a.h"

#ifdef CONFIG_XXXX
void foo(struct sas_task *task);
#else
static inline void foo(struct sas_task *task)
{
}
#endif

or

#ifdef CONFIG_XXXX
#define foo()  do_something()
#else
#define foo()
#endif

And in the c file: "a.c"

#include "a.h"

void bar(void)
{
	foo();
	something_else();
}

Please refer to:
https://docs.kernel.org/process/4.Coding.html?#ifdef-and-preprocessor-use-in-general

Thanks,
Jason

