Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751D60E239
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiJZNgX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 09:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZNgV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 09:36:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB35604BC;
        Wed, 26 Oct 2022 06:36:18 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4My8w31Cm1zHvCp;
        Wed, 26 Oct 2022 21:36:03 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 21:36:15 +0800
Subject: Re: [PATCH -next v2] jbd2: use the correct print format
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <bvanassche@acm.org>, <axboe@kernel.dk>,
        <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>
References: <1665488024-95172-1-git-send-email-cuibixuan@linux.alibaba.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <60a7370a-0b7f-1f56-0fa4-08a96138b1cd@huawei.com>
Date:   Wed, 26 Oct 2022 21:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1665488024-95172-1-git-send-email-cuibixuan@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2022/10/11 19:33, Bixuan Cui wrote:
> The print format error was found when using ftrace event:
>      <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
>      <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0
> 
> Use the correct print format for transaction, head and tid.
> 
> Fixes: 879c5e6b7cb4 ('jbd2: convert instrumentation from markers to tracepoints')
> Signed-off-by: Bixuan Cui<cuibixuan@linux.alibaba.com>
> ---
> v1->v2: Make all the tid tracing consistent.
> 
>   include/trace/events/jbd2.h | 44 ++++++++++++++++++++++----------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Jason Yan <yanaijie@huawei.com>
