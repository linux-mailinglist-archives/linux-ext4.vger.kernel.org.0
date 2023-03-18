Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA26BF75F
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 03:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCRCZX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 22:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCZW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 22:25:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8E23C41
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 19:25:19 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdlDz5cnczrSQH;
        Sat, 18 Mar 2023 10:24:19 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 10:25:15 +0800
Subject: Re: [PATCH v3 1/2] jbd2: continue to record log between each mount
To:     Jan Kara <jack@suse.cz>
CC:     Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>,
        <ocfs2-devel@oss.oracle.com>
References: <20230314140522.3266591-1-yi.zhang@huaweicloud.com>
 <20230314140522.3266591-2-yi.zhang@huaweicloud.com>
 <20230315094826.okdarxaapjyqmlhq@quack3>
 <8c4ff3ab-4af2-58ed-4d08-3050c044f445@huawei.com>
 <20230315172817.egezft3msc5z4omm@quack3>
 <20230317112528.cig7fczuoezn23wy@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <6769d7eb-35bc-fbc1-0c15-a62309fbdb81@huawei.com>
Date:   Sat, 18 Mar 2023 10:25:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230317112528.cig7fczuoezn23wy@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/17 19:25, Jan Kara wrote:
> On Wed 15-03-23 18:28:17, Jan Kara wrote:
>> On Wed 15-03-23 20:37:32, Zhang Yi wrote:
>>> On 2023/3/15 17:48, Jan Kara wrote:
>>>> On Tue 14-03-23 22:05:21, Zhang Yi wrote:
>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>
>>>>> For a newly mounted file system, the journal committing thread always
>>>>> record new transactions from the start of the journal area, no matter
>>>>> whether the journal was clean or just has been recovered. So the logdump
>>>>> code in debugfs cannot dump continuous logs between each mount, it is
>>>>> disadvantageous to analysis corrupted file system image and locate the
>>>>> file system inconsistency bugs.
>>>>>
>>>>> If we get a corrupted file system in the running products and want to
>>>>> find out what has happened, besides lookup the system log, one effective
>>>>> way is to backtrack the journal log. But we may not always run e2fsck
>>>>> before each mount and the default fsck -a mode also cannot always
>>>>> checkout all inconsistencies, so it could left over some inconsistencies
>>>>> into the next mount until we detect it. Finally, transactions in the
>>>>> journal may probably discontinuous and some relatively new transactions
>>>>> has been covered, it becomes hard to analyse. If we could record
>>>>> transactions continuously between each mount, we could acquire more
>>>>> useful info from the journal. Like this:
>>>>>
>>>>>  |Previous mount checkpointed/recovered logs|Current mount logs         |
>>>>>  |{------}{---}{--------} ... {------}| ... |{======}{========}...000000|
>>>>>
>>>>> And yes the journal area is limited and cannot record everything, the
>>>>> problematic transaction may also be covered even if we do this, but
>>>>> this is still useful for fuzzy tests and short-running products.
>>>>>
>>>>> This patch save the head blocknr in the superblock after flushing the
>>>>> journal or unmounting the file system, let the next mount could continue
>>>>> to record new transaction behind it. This change is backward compatible
>>>>> because the old kernel does not care about the head blocknr of the
>>>>> journal. It is also fine if we mount a clean old image without valid
>>>>> head blocknr, we fail back to set it to s_first just like before.
>>>>> Finally, for the case of mount an unclean file system, we could also get
>>>>> the journal head easily after scanning/replaying the journal, it will
>>>>> continue to record new transaction after the recovered transactions.
>>>>>
>>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> I like this implementation! I even think we could perhaps make ext4 always
>>>> behave this way to not increase size of the test matrix. Or do you see any
>>>> downside to this option?
>>>>
>>>
>>> Thanks for your suggestion. Indeed, I don't find any side effect on this
>>> option both in theory and in the actual use tests on ext4, I added a new
>>> option was just from the safe point of view and let user could disable it if
>>> they don't want it. I also prefer to make ext4 always behave this way.:)
>>>
>>> I would like to keep the JBD2_CYCLE_RECORD flag(ocfs2 also use jbd2, I don't
>>> want to disturb it until it needs), remove EXT4_MOUNT2_JOURNAL_CYCLE_RECORD
>>> and always set JBD2_CYCLE_RECORD on ext4 in patch 2 in the next iteration.
>>
>> Yes, that makes sense.
> 
> FWIW yesterday I'v spoken with Ted and he also agrees that we don't need
> ext4 mount option for this.
> 

Thanks! I've removed this mount option in v4.

Yi.
