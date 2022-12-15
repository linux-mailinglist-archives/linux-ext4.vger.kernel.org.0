Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5497064D803
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLOIuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 03:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLOIt6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 03:49:58 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D03D3A0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 00:49:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NXmBl1YWVz4f3jJF
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 16:49:51 +0800 (CST)
Received: from [10.174.178.134] (unknown [10.174.178.134])
        by APP4 (Coremail) with SMTP id gCh0CgDnV9Ww35pjHIUSCQ--.16773S3;
        Thu, 15 Dec 2022 16:49:54 +0800 (CST)
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
To:     Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yukuai3@huawei.com, ritesh.list@gmail.com
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3> <Y5obcGLDZuw/NWOh@mit.edu>
 <442e060a-de74-1e54-4fa3-5e4d35597dbe@huawei.com>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <e749fce4-4bd8-7807-aa32-1caef2509382@huaweicloud.com>
Date:   Thu, 15 Dec 2022 16:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <442e060a-de74-1e54-4fa3-5e4d35597dbe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDnV9Ww35pjHIUSCQ--.16773S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7Cr4xCw13uw15Zr4xJFb_yoW8KF48pF
        WrK3W5Kw4Dtry7urn2qF97WFyF93yktrWUZFZaq3WUAryq9rnagrnrtFWUAay0qrZ3Jayq
        vF4aqry3CFyqvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/12/15 16:41, Zhang Yi wrote:
> On 2022/12/15 2:52, Theodore Ts'o wrote:
>> On Wed, Dec 14, 2022 at 06:01:25PM +0100, Jan Kara wrote:
>>>
>>> Besides some naming nits (see below) I think this should work. But I have
>>> to say I'm a bit uneasy about this because we will now be changing block
>>> mapping from unwritten to written only with shared i_rwsem. OTOH that
>>> happens during writeback as well so we should be fine and the gain is very
>>> nice.
>>
>> Hmm.... when I was looking potential impacts of the change what
>> ext4_overwrite_io() would do, I looked at the current user of that
>> function in ext4_dio_write_checks().
>>
>> 	/*
>> 	 * Determine whether the IO operation will overwrite allocated
>> 	 * and initialized blocks.
>> 	 * We need exclusive i_rwsem for changing security info
>> 	 * in file_modified().
>> 	 */
>> 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>> 	     !ext4_overwrite_io(inode, offset, count))) {
>> 		if (iocb->ki_flags & IOCB_NOWAIT) {
>> 			ret = -EAGAIN;
>> 			goto out;
>> 		}
>> 		inode_unlock_shared(inode);
>> 		*ilock_shared = false;
>> 		inode_lock(inode);
>> 		goto restart;
>> 	}
>>
>> 	ret = file_modified(file);
>> 	if (ret < 0)
>> 		goto out;
>>
>> What is confusing me is the comment, "We need exclusive i_rwsem for
>> changing security info in file_modified().".  But then we end up
>> calling file_modified() unconditionally, regardless of whether we've
>> transitioned from a shared lock to an exclusive lock.
>>
>> So file_modified() can get called either with or without the inode
>> locked r/w.  I realize that this patch doesn't change this
>> inconsistency, but it appears either the comment is wrong, or the code
>> is wrong.
>>
>> What am I missing?
>>
> 
> IIUC, both of the comment and the code are correct, the __file_remove_privs()
> in file_modified() should execute under exclusive lock, and we have already
> check the IS_NOSEC(inode) and could make sure taking exclusive lock before we
> remove privs. If we take share lock, __file_remove_privs() will return directly
> because below check. So it's find now, but it looks that call file_update_time()
> is enough for the shared lock case.
> 
> int file_update_time(struct file *file)
static int __file_remove_privs(struct file *file, unsigned int flags)
> {
...
> 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
> 		return 0;
> ...
> }
> 
> Thanks,
> Yi.
> 

