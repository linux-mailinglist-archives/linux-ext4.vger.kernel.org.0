Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C696CD898
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC2LiE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 07:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjC2LiD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 07:38:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D811BDD
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 04:37:59 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pmkww3fc1zgZcK;
        Wed, 29 Mar 2023 19:34:40 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 19:37:56 +0800
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
To:     Chung-Chiang Cheng <shepjeng@gmail.com>, Jan Kara <jack@suse.cz>
CC:     Chung-Chiang Cheng <cccheng@synology.com>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <kernel@cccheng.net>,
        Robbie Ko <robbieko@synology.com>
References: <20230324092907.1341457-1-cccheng@synology.com>
 <20230327092914.mzizhh52izbvjhhv@quack3>
 <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
 <08c67287-53d8-58ce-e4bb-b1656bc6013e@huawei.com>
 <CAHuHWtnPtMscpO+fxYncQ_K+T+j2AGxG75kimoL6gp5Q__GfTw@mail.gmail.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <9019a6c4-c45d-98ab-153b-e9a248c4b8bd@huawei.com>
Date:   Wed, 29 Mar 2023 19:37:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHuHWtnPtMscpO+fxYncQ_K+T+j2AGxG75kimoL6gp5Q__GfTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/29 11:36, Chung-Chiang Cheng wrote:
> On Mon, Mar 27, 2023 at 7:17 PM Zhang Yi <yi.zhang@huawei.com> wrote:
>>
>> On 2023/3/27 18:28, Chung-Chiang Cheng wrote:
>>> It's a pity that this issue also occurs with data=ordered due to delayed
>>> allocation being enabled by default. If delayed allocation were disabled,
>>> it would not be as easy to reproduce.
>>>
>>> This is because if data is written to the end of a file and the block is
>>> allocated, the new i_disksize will be immediately committed to the journal
>>> at ext4_da_write_end(), but the writeback procedure is not yet triggered.
>>> By default, ext4 commits the journal every 5 seconds, but a dirty page may
>>> not be written back until 30 seconds later. This is not a short time window,
>>> and any improper shutdown during this time may lead to the issue :(
>>>
> 
> Thank you for the explanation from you and Jan. I agree that it is not the
> responsibility of ext4 to provide application consistency, but this case is
> not even crash consistent, although no sensitive data were revealed after
> crash.
> 
>> It seems that the case you've mentioned is intra-block append write (no?),
>> current data=ordered mount option doesn't work in this case because
>> ext4_map_blocks() doesn't attach inode to the t_inode_list of the running
>> transaction. If delayed allocation were disabled, the lose data window is still
>> there, because ext4_write_end()->ext4_update_inode_size() is also updating
>> i_disksize before writing data back. This is at least guarantee no store data.
>> We had discussed this in [1].
> 
> Yes, you're right. I've reconfirmed my experiment and determined that this
> issue can be reproduced with or without delayed allocation.
> 
> I've tried your previous solution of adding the required inode to the current
> transaction's ordered data list. It seems to work perfectly for me and simply
> solves the issue, but the journal handling needs to be added back to the
> delayed allocation write. Does it really have an obvious performance impact?
> 

It depends on the writing behavior (proportion of partial block write), I had
test fio sequence write with bs=1K[1] on the default 4K block size file system
(the cases were not enough, I hope that will be helpful to you), it's have
about 30% degradation at that time. I haven't test it recently, maybe it could
have more degradation than before at the delayed allocation write since we
removed the journal handling. Or you can test it on your products.

Thanks,
Yi.

[1] fio --name=foo --size=5G --bs=1k --numjobs=24 --iodepth=1 --rw=write \
        --norandommap --group_reporting --runtime=100 --time_based \
        --nrfiles=3 --directory=/mnt/ --fallocate=none --fsync=1
