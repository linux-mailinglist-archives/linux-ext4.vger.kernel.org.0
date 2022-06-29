Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3133B55FF0E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiF2Lu7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiF2Lu6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 07:50:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739723F309
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 04:50:57 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LY0Bt2V44z9std;
        Wed, 29 Jun 2022 19:50:14 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 19:50:54 +0800
Subject: Re: [PATCH] ext4: Read inlined symlink targets using
 ext4_readpage_inline.
To:     Torge Matthies <openglfreak@googlemail.com>,
        <linux-ext4@vger.kernel.org>
References: <20220628033446.285207-1-openglfreak@googlemail.com>
 <9b675cca-7ace-4f5f-a57b-ebddb091bf75@huawei.com>
 <CAKtYR9O9+dMdzid2s1uthKkv5x4bU9J3rbfe_YdGVsDtQFNh4g@mail.gmail.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <e42f2390-f2f5-693a-c74b-ffb58804c9be@huawei.com>
Date:   Wed, 29 Jun 2022 19:50:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAKtYR9O9+dMdzid2s1uthKkv5x4bU9J3rbfe_YdGVsDtQFNh4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/6/28 17:53, Torge Matthies wrote:
> Hello Yi,
> 
> On Tue, 28 Jun 2022 at 10:40, Zhang Yi <yi.zhang@huawei.com> wrote:
>>
>> Hi, Torge.
>>
>> On 2022/6/28 11:34, Torge Matthies wrote:
>>> Instead of using ext4_bread/ext4_getblk.
>>>
>>> When I was trying out Linux 5.19-rc3 some symlinks became inaccessible to
>>> me, with the error "Structure needs cleaning" and the following printed in
>>> the kernel message log:
>>>
>>> EXT4-fs error (device nvme0n1p1): ext4_map_blocks:599: inode #7351350:
>>> block 774843950: comm readlink: lblock 0 mapped to illegal pblock
>>> 774843950 (length 1)
>>>
>>> It looks like the ext4_get_link function introduced in commit 6493792d3299
>>> ("ext4: convert symlink external data block mapping to bdev") does not
>>> handle links with inline data correctly. I added explicit handling for this
>>> case using ext4_readpage_inline. This fixes the bug and the affected
>>> symlinks become accessible again.
>>>
>>> Fixes: 6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
>>> Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
>>
>> Thanks for the fix patch! I missed the inline_data case for the symlink inode
>> in commit 6493792d3299.
>>
>>> ---
>>>  fs/ext4/symlink.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
>>> index d281f5bcc526..ec4fc2d23efc 100644
>>> --- a/fs/ext4/symlink.c
>>> +++ b/fs/ext4/symlink.c
>>> @@ -19,7 +19,10 @@
>>>   */
>>>
>>>  #include <linux/fs.h>
>>> +#include <linux/gfp.h>
>>> +#include <linux/mm.h>
>>>  #include <linux/namei.h>
>>> +#include <linux/pagemap.h>
>>>  #include "ext4.h"
>>>  #include "xattr.h"
>>>
>>> @@ -65,6 +68,37 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
>>>       return fscrypt_symlink_getattr(path, stat);
>>>  }
>>>
>>> +static void ext4_free_link_inline(void *folio)
>>> +{
>>> +     folio_unlock(folio);
>>> +     folio_put(folio);
>>> +}
>>> +
>>> +static const char *ext4_get_link_inline(struct inode *inode,
>>> +                                     struct delayed_call *callback)
>>> +{
>>> +     struct folio *folio;
>>> +     char *ret;
>>> +     int err;
>>> +
>>> +     folio = folio_alloc(GFP_NOFS, 0)> +     if (!folio)
>>> +             return ERR_PTR(-ENOMEM);
>>> +     folio_lock(folio);
>>> +     folio->index = 0;
>>> +
>>> +     err = ext4_readpage_inline(inode, &folio->page);
>>> +     if (err) {
>>> +             folio_put(folio);
>>> +             return ERR_PTR(err);
>>> +     }
>>> +
>>
>> We need to handle the case of RCU walk in pick_link(), almost all above
>> functions could sleep. The inline_data is a left over case, we cannot create
>> new inline symlink now, maybe we can just disable the RCU walk for simple?
>> or else we have to introduce some other no sleep helpers to get raw inode's
>> cached buffer_head.
> 
> I'mma be honest, I don't know what most of that means, I barely managed
> to scrape together this patch with the limited kernel knowledge I have.
> If you know how to fix these things I'd prefer if you (or someone else)
> could  send a proper fix in. Consider my first mail as just a bug
> report, I was prepared to fix simple problems with my patch, but this
> is out of my league.
> 

The RCU walk means walk_component() in LOOKUP_RCU mode, we cannot call functions that
would sleep. And it looks that ext4_encrypted_get_link() has the same problem, I will
send a fix later.

Thanks,
Yi.
