Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637DD63E9E8
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLAG01 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 01:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLAG01 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 01:26:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6C48419;
        Wed, 30 Nov 2022 22:26:25 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN5fq5Q42zHwM9;
        Thu,  1 Dec 2022 14:25:39 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:26:22 +0800
Message-ID: <faff95ef-7a4c-8176-4dac-aa1fb36d2bad@huawei.com>
Date:   Thu, 1 Dec 2022 14:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/2] ext4: fix a infinite loop in do_writepages after
 online resizing
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <enwlinux@gmail.com>, <jack@suse.cz>, <lczerner@redhat.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>, <yebin10@huawei.com>,
        <ritesh.list@gmail.com>, <adilger.kernel@dilger.ca>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <166975630697.2135297.7495422853696969304.b4-ty@mit.edu>
 <3cd4e5d1-4837-a569-18b4-72fcaabf103d@huawei.com> <Y4gioFteBIg2WAEJ@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Y4gioFteBIg2WAEJ@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/12/1 11:42, Theodore Ts'o wrote:
> On Wed, Nov 30, 2022 at 10:08:13AM +0800, Baokun Li wrote:
>> But I thought this patch set was discarded because there was no
>> "Reviewed-by".
> No, it had just slipped through the cracks; and when I was going back
> through patchwork to see what patches were outstanding, I came across
> the patch set which had gotten missed during the last cycle; and I
> didn't notice that it had been superceded with a newer patch which
> achieved the same goal.
>
> I'll drop it from the ext4 tree and then pick up your newer series.
>
>            	     	      	   	- Ted
>
Thank you very much! 😉

-- 
With Best Regards,
Baokun Li
.
