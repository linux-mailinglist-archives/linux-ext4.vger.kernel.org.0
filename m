Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B66619341
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKDJQY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKDJQX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 05:16:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5386276
        for <linux-ext4@vger.kernel.org>; Fri,  4 Nov 2022 02:16:20 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N3Zjn3xf3zHtgm;
        Fri,  4 Nov 2022 17:15:57 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 17:16:17 +0800
Subject: Re: [PATCH v2] ext4: fix wrong return err in
 ext4_load_and_init_journal()
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
References: <20221025040206.3134773-1-yanaijie@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <630064d8-ea12-3bf3-bc33-c0e3a323118b@huawei.com>
Date:   Fri, 4 Nov 2022 17:16:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221025040206.3134773-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,

I am sorry that this is a regression my patch introduced in 6.1-rc1. I 
wonder if you can merge this fix for 6.1?

Thanks,
Jason

On 2022/10/25 12:02, Jason Yan wrote:
> The return value is wrong in ext4_load_and_init_journal(). The local
> variable 'err' need to be initialized before goto out. The original code
> in __ext4_fill_super() is fine because it has two return values 'ret'
> and 'err' and 'ret' is initialized as -EINVAL. After we factor out
> ext4_load_and_init_journal(), this code is broken. So fix it by directly
> returning -EINVAL in the error handler path.
> 
> Fixes: 9c1dd22d7422 ("ext4: factor out ext4_load_and_init_journal()")
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>   v2: Change fixes tag format and add Jan's tag (thanks Jan).
> 
>   fs/ext4/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 989365b878a6..89c6bad28a8a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4885,7 +4885,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>   	flush_work(&sbi->s_error_work);
>   	jbd2_journal_destroy(sbi->s_journal);
>   	sbi->s_journal = NULL;
> -	return err;
> +	return -EINVAL;
>   }
>   
>   static int ext4_journal_data_mode_check(struct super_block *sb)
> 
