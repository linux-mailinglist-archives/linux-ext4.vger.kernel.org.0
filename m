Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C851F537394
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 04:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiE3CfR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiE3CfQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 22:35:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9662272E17;
        Sun, 29 May 2022 19:35:15 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBKGS6xxyzbbYT;
        Mon, 30 May 2022 10:33:36 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 10:35:13 +0800
Message-ID: <9ee160e1-a0e7-1d7f-040f-1bcaa581ecd1@huawei.com>
Date:   Mon, 30 May 2022 10:35:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/3] ext4: support flex_bg in ext4_mb_normalize_request
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-4-libaokun1@huawei.com>
 <20220528150906.om746qfxoxu7svzx@riteshh-domain>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220528150906.om746qfxoxu7svzx@riteshh-domain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/28 23:09, Ritesh Harjani 写道:
> On 22/05/28 07:00PM, Baokun Li wrote:
>> In ext4_mb_normalize_request, the size of the allocation request is
>> limited to no more than EXT4_BLOCKS_PER_GROUP. Ritesh mentions that this
>> does not take into account the case of flex_bg groups. So we should add
>> support for flex_bg to make the physical blocks of large files contiguous.
> My only concern here was that what if we are at the flex group end boundary and
> decide to take the size as of flex group size. How are we detecting that case.
>
> But, I haven't yet looked at this patch of yours (as I am on travel for next few days),
> but if this requires further discussion, we can work on this seperately and let
> the other two patches go in as those are part of the bug fixes which you
> identified (just my thoughts).
>
> -ritesh
> .

All right, work on this separately.

Have a nice trip!

-- 
With Best Regards,
Baokun Li

