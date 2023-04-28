Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733DB6F10D3
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 05:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbjD1Df0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 23:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbjD1DfX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 23:35:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435C3A86
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 20:35:19 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q6ypl5Gc9zLnyD;
        Fri, 28 Apr 2023 11:32:31 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 11:35:16 +0800
Subject: Re: [PATCH 1/3] ext4: fix lost error code reporting in
 __ext4_fill_super()
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     Andreas Dilger <adilger@dilger.ca>,
        <syzbot+bbf0f9a213c94f283a5c@syzkaller.appspotmail.com>
References: <20230428031602.242297-1-tytso@mit.edu>
 <20230428031602.242297-2-tytso@mit.edu>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cd010dd6-7322-3711-73f3-deae4050017a@huawei.com>
Date:   Fri, 28 Apr 2023 11:35:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230428031602.242297-2-tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/28 11:16, Theodore Ts'o wrote:
> When code was factored out of __ext4_fill_super() into
> ext4_percpu_param_init() the error return was discard.  This meant
> that it was possible for __ext4_fill_super() to return zero,
> indicating success, without the struct super getting completely filled
> in, leading to a potential NULL pointer dereference.
> 
> Reported-by: syzbot+bbf0f9a213c94f283a5c@syzkaller.appspotmail.com
> Fixes: 1f79467c8a6b ("ext4: factor out ext4_percpu_param_init() ...")
> Cc: Jason Yan <yanaijie@huawei.com>
> Link: https://syzkaller.appspot.com/bug?id=6dac47d5e58af770c0055f680369586ec32e144c
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   fs/ext4/super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 403cc0e6cd65..b11907e1fab2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5503,7 +5503,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   		sbi->s_journal->j_commit_callback =
>   			ext4_journal_commit_callback;
>   
> -	if (ext4_percpu_param_init(sbi))
> +	err = ext4_percpu_param_init(sbi);
> +	if (err)
>   		goto failed_mount6;
>   
>   	if (ext4_has_feature_flex_bg(sb))
> 

Reviewed-by: Jason Yan <yanaijie@huawei.com>
