Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84C5B52A6
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiILCUc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Sep 2022 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiILCUb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Sep 2022 22:20:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72531DA41
        for <linux-ext4@vger.kernel.org>; Sun, 11 Sep 2022 19:20:29 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQqvZ0yy5zNm6Y;
        Mon, 12 Sep 2022 10:15:54 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 10:20:27 +0800
Subject: Re: [PATCH v2 03/13] ext4: factor out ext4_set_def_opts()
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <lczerner@redhat.com>, <linux-ext4@vger.kernel.org>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-4-yanaijie@huawei.com>
 <20220908084426.w4ltd7cotudoykyw@riteshh-domain>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <5000fb7d-21ce-ed5c-a621-6f91dec527e0@huawei.com>
Date:   Mon, 12 Sep 2022 10:20:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220908084426.w4ltd7cotudoykyw@riteshh-domain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh, thanks for the review.

On 2022/9/8 16:44, Ritesh Harjani (IBM) wrote:
> On 22/09/03 11:01AM, Jason Yan wrote:
>> Factor out ext4_set_def_opts(). No functional change.
>         if (blocksize == PAGE_SIZE)
>                 set_opt(sb, DIOREAD_NOLOCK);
> The patch looks good however, even this ^^ could be moved in
> ext4_set_def_opts() via some refactoring.
> 
> If required you could even submit a seperate change for above.
> 

Yes, this needs some refactoring. I would like to make a separate patch 
in my next series.

Jason

> Otherwise this change looks good to me.
> Reviewed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> 
> 
