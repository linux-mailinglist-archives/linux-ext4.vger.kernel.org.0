Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C426CA23E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC0LRx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0LRw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 07:17:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555AF423A
        for <linux-ext4@vger.kernel.org>; Mon, 27 Mar 2023 04:17:51 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PlVbg3lb0zKt1Y;
        Mon, 27 Mar 2023 19:15:27 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:17:48 +0800
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
To:     Chung-Chiang Cheng <shepjeng@gmail.com>, Jan Kara <jack@suse.cz>
CC:     Chung-Chiang Cheng <cccheng@synology.com>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <kernel@cccheng.net>,
        Robbie Ko <robbieko@synology.com>
References: <20230324092907.1341457-1-cccheng@synology.com>
 <20230327092914.mzizhh52izbvjhhv@quack3>
 <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <08c67287-53d8-58ce-e4bb-b1656bc6013e@huawei.com>
Date:   Mon, 27 Mar 2023 19:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/3/27 18:28, Chung-Chiang Cheng wrote:
> On Mon, Mar 27, 2023 at 5:29 PM Jan Kara <jack@suse.cz> wrote:
>>
>> As Zhang Yi already noted in his review, this is expected at least with
>> data=writeback mount option. With data=ordered this should not happen
>> though as the commit of the transaction with i_disksize update will wait
>> for page writeback to complete (this is exactly the reason why data=ordered
>> exists after all). Are you able to observe this problem with data=ordered
>> mount option?
>>
>>                                                                 Honza
> 
> It's a pity that this issue also occurs with data=ordered due to delayed
> allocation being enabled by default. If delayed allocation were disabled,
> it would not be as easy to reproduce.
> 
> This is because if data is written to the end of a file and the block is
> allocated, the new i_disksize will be immediately committed to the journal
> at ext4_da_write_end(), but the writeback procedure is not yet triggered.
> By default, ext4 commits the journal every 5 seconds, but a dirty page may
> not be written back until 30 seconds later. This is not a short time window,
> and any improper shutdown during this time may lead to the issue :(
> 

It seems that the case you've mentioned is intra-block append write (no?),
current data=ordered mount option doesn't work in this case because
ext4_map_blocks() doesn't attach inode to the t_inode_list of the running
transaction. If delayed allocation were disabled, the lose data window is still
there, because ext4_write_end()->ext4_update_inode_size() is also updating
i_disksize before writing data back. This is at least guarantee no store data.
We had discussed this in [1].

[1]. https://lore.kernel.org/linux-ext4/1554370192-113254-1-git-send-email-yi.zhang@huawei.com/

Thanks,
Yi.
