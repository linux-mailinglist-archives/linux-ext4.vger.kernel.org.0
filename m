Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32777634A6
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGZLTu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGZLTt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 07:19:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54497
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jul 2023 04:19:48 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9rvp6zf6zLnsR;
        Wed, 26 Jul 2023 19:17:10 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 19:19:45 +0800
Subject: Re: [PATCH] jbd2: Remove unused t_handle_lock
To:     Wang Jianjian <wangjianjian0@foxmail.com>,
        <linux-ext4@vger.kernel.org>
References: <tencent_CB3115278E9ED6BD081097E5753433452107@qq.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <8138c559-325c-a4e3-1018-ca76ba185081@huawei.com>
Date:   Wed, 26 Jul 2023 19:19:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <tencent_CB3115278E9ED6BD081097E5753433452107@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/24 22:58, Wang Jianjian wrote:
> Since commit 4f98186848('jbd2: refactor wait logic for transaction
> updates into a common function'), this lock has been no use.

Hi, I don't think the commit is correct, it should be
f7f497cb7024 ("jbd2: kill t_handle_lock transaction spinlock").

Thanks,
Yi.

> ---
>  include/linux/jbd2.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index d860499e15e4..8199235dbaf3 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -636,11 +636,6 @@ struct transaction_s
>  	 */
>  	struct list_head	t_inode_list;
>  
> -	/*
> -	 * Protects info related to handles
> -	 */
> -	spinlock_t		t_handle_lock;
> -
>  	/*
>  	 * Longest time some handle had to wait for running transaction
>  	 */
> 
