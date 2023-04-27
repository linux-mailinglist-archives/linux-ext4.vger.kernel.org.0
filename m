Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C26EFEFA
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 03:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjD0BcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 21:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjD0BcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 21:32:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4326BC
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 18:32:07 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6J5j3wTszpSx7;
        Thu, 27 Apr 2023 09:28:09 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:32:03 +0800
Subject: Re: [PATCH] fs/ext4/super.c : fix two compile errors
To:     Chris Clayton <chris2553@googlemail.com>,
        "tytso@mit.edu >> Theodore Y. Ts'o" <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>
References: <7ca8f790-c14e-6449-f3b5-4214d3fb1e61@googlemail.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <130cdccf-5bd6-bf67-4a2b-7f13fda0de3a@huawei.com>
Date:   Thu, 27 Apr 2023 09:32:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7ca8f790-c14e-6449-f3b5-4214d3fb1e61@googlemail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/27 5:20, Chris Clayton wrote:
> dcbf87589d90 results in 2 build errors in fs/ext4/super.c because, in both affected
> functions, a variable is left unused if CONFIG_QUOTA is not defined. The patch
> below fixes this. It is compile tested only.
> 
> ...
>    CC      fs/ext4/super.o
> fs/ext4/super.c: In function 'ext4_put_super':
> fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
>   1262 |         int i, err;
>        |             ^
> fs/ext4/super.c: In function '__ext4_fill_super':
> fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
>   5200 |         unsigned int i;
>        |                      ^
> cc1: all warnings being treated as errors
> ...
> 
> Fixes:  dcbf87589d90 (ext4: factor out ext4_flex_groups_free())
> Signed-off-by: Chris Clayton<chris2553@googlemail.com>

There are already fixes. But still thank you for the patch.

http://patchwork.ozlabs.org/project/linux-ext4/patch/20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org/
http://patchwork.ozlabs.org/project/linux-ext4/patch/20230421070815.2260326-1-arnd@kernel.org/

Best wishes,
Jason

