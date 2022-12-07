Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194CE6454F0
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLGHyU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLGHyT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:54:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B930577;
        Tue,  6 Dec 2022 23:54:18 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRqFW1LCXzpW8C;
        Wed,  7 Dec 2022 15:50:07 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 15:53:42 +0800
Subject: Re: [PATCH v2] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
To:     Jun Nie <jun.nie@linaro.org>, Ye Bin <yebin@huaweicloud.com>
References: <20221206144134.1919987-1-yebin@huaweicloud.com>
 <CABymUCN-WC5aCpVestRFpXVgZobxs48crUDX2419yvXxLgyjRQ@mail.gmail.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>,
        <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63904686.3010903@huawei.com>
Date:   Wed, 7 Dec 2022 15:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CABymUCN-WC5aCpVestRFpXVgZobxs48crUDX2419yvXxLgyjRQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/12/7 14:44, Jun Nie wrote:
> Hi Bin,
>
> Thanks for the patch! The bug is reproduced with this patch. I can
> help trigger another
> test when you have new patch.
> https://syzkaller.appspot.com/text?tag=CrashLog&x=16760797880000

The cause of this issue is different from that of the previous issue.
I analyze that the issue 
"https://syzkaller.appspot.com/text?tag=CrashLog&x=16760797880000 "
is caused by the concurrency of  inline data conversion and buffer 
write. To be honest, I haven't
thought of any good solution.

>
> Regards,
> Jun
> .

