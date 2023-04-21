Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B916EA4F1
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Apr 2023 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDUHhR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Apr 2023 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjDUHhN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Apr 2023 03:37:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6B1B9;
        Fri, 21 Apr 2023 00:37:11 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q2mW75WGfzL28l;
        Fri, 21 Apr 2023 15:34:27 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 15:37:09 +0800
Subject: Re: [PATCH] ext4: avoid unused-variable warning with CONFIG_QUOTA=n
To:     Arnd Bergmann <arnd@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Ye Bin <yebin10@huawei.com>, Baokun Li <libaokun1@huawei.com>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230421070815.2260326-1-arnd@kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <6de68c52-b391-6b79-20eb-9ae7fe40e28a@huawei.com>
Date:   Fri, 21 Apr 2023 15:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230421070815.2260326-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Arnd,

On 2023/4/21 15:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After some code reshuffling, the index variables in two functions
> are only used in an #ifdef:
> 
> fs/ext4/super.c: In function 'ext4_put_super':
> fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
> fs/ext4/super.c: In function '__ext4_fill_super':
> fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
> 
> Since all supported compilers now allow having variable declarations
> inside of a for() loop, move them into the #ifdef block directly.
> 
> Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/ext4/super.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Thanks for the patch. But Nathan has already sent a patch to fix this.

http://patchwork.ozlabs.org/project/linux-ext4/patch/20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org/

Jason
