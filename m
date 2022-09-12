Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B35B52CB
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 05:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiILDM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Sep 2022 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILDMy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Sep 2022 23:12:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8A24F13
        for <linux-ext4@vger.kernel.org>; Sun, 11 Sep 2022 20:12:51 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MQs4k3S5Mz14QPy;
        Mon, 12 Sep 2022 11:08:54 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 11:12:48 +0800
Subject: Re: [PATCH v2 07/13] ext4: factor out ext4_encoding_init()
From:   Jason Yan <yanaijie@huawei.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <lczerner@redhat.com>, <linux-ext4@vger.kernel.org>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-8-yanaijie@huawei.com>
 <20220908085625.r3xsfvdgn7ibykt2@riteshh-domain>
 <2ef9347c-b7b8-d219-d6bb-3c9fa611506a@huawei.com>
Message-ID: <7b5a5907-a0bf-58a5-f4d7-f42a9b4755de@huawei.com>
Date:   Mon, 12 Sep 2022 11:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2ef9347c-b7b8-d219-d6bb-3c9fa611506a@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/9/12 10:30, Jason Yan wrote:
> 
> On 2022/9/8 16:56, Ritesh Harjani (IBM) wrote:
>> On 22/09/03 11:01AM, Jason Yan wrote:
>>> Factor out ext4_encoding_init(). No functional change.
>>>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>> ---
>>>   fs/ext4/super.c | 80 +++++++++++++++++++++++++++----------------------
>>>   1 file changed, 44 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index f8806226b796..67972b0218c0 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -4521,6 +4521,48 @@ static int ext4_inode_info_init(struct 
>>> super_block *sb,
>>>       return 0;
>>>   }
>>> +static int ext4_encoding_init(struct super_block *sb, struct 
>>> ext4_super_block *es)
>>> +{
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>
>> How about simplying it like below.
>>         if (!IS_ENABLED(CONFIG_UNICODE))
>>             return 0;
>>
>>         <...>
>>
>> Then we don't need #ifdef CONFIG_UNICODE
>>
> 
> Nice idea. Will update.
> 

Sorry I tried to compile with this change but the compiler is not clever 
enough to ignore the code down if CONFIG_UNICODE is not enabled.


fs/ext4/super.c: In function ‘ext4_encoding_init’:
fs/ext4/super.c:4529:2: warning: ISO C90 forbids mixed declarations and 
code [-Wdeclaration-after-statement]
  4529 |  const struct ext4_sb_encodings *encoding_info;
       |  ^~~~~
fs/ext4/super.c:4533:42: error: ‘struct super_block’ has no member named 
‘s_encoding’
  4533 |  if (!ext4_has_feature_casefold(sb) || sb->s_encoding)
       |                                          ^~
fs/ext4/super.c:4536:18: error: implicit declaration of function 
‘ext4_sb_read_encoding’; did you mean ‘ext4_sb_bread_unmovable’? 
[-Werror=implicit-function-declaration]
  4536 |  encoding_info = ext4_sb_read_encoding(es);
       |                  ^~~~~~~~~~~~~~~~~~~~~
       |                  ext4_sb_bread_unmovable
fs/ext4/super.c:4536:16: warning: assignment to ‘const struct 
ext4_sb_encodings *’ from ‘int’ makes pointer from integer without a 
cast [-Wint-conversion]
  4536 |  encoding_info = ext4_sb_read_encoding(es);
       |                ^
fs/ext4/super.c:4543:36: error: dereferencing pointer to incomplete type 
‘const struct ext4_sb_encodings’
  4543 |  encoding = utf8_load(encoding_info->version);
       |                                    ^~
fs/ext4/super.c:4562:4: error: ‘struct super_block’ has no member named 
‘s_encoding’
  4562 |  sb->s_encoding = encoding;
       |    ^~
fs/ext4/super.c:4563:4: error: ‘struct super_block’ has no member named 
‘s_encoding_flags’
  4563 |  sb->s_encoding_flags = encoding_flags;
       |    ^~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249: fs/ext4/super.o] Error 1
make[1]: *** [scripts/Makefile.build:465: fs/ext4] Error 2
make: *** [Makefile:1852: fs] Error 2




> Thanks
> Jason
> .



