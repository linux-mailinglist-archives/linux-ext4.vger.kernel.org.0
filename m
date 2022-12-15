Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51F164D7E6
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLOIlX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 03:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOIlW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 03:41:22 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644351A222
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 00:41:20 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXlzk1JzqzmWds;
        Thu, 15 Dec 2022 16:40:18 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 16:41:17 +0800
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huaweicloud.com>, <yukuai3@huawei.com>,
        <ritesh.list@gmail.com>
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3> <Y5obcGLDZuw/NWOh@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <442e060a-de74-1e54-4fa3-5e4d35597dbe@huawei.com>
Date:   Thu, 15 Dec 2022 16:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y5obcGLDZuw/NWOh@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/12/15 2:52, Theodore Ts'o wrote:
> On Wed, Dec 14, 2022 at 06:01:25PM +0100, Jan Kara wrote:
>>
>> Besides some naming nits (see below) I think this should work. But I have
>> to say I'm a bit uneasy about this because we will now be changing block
>> mapping from unwritten to written only with shared i_rwsem. OTOH that
>> happens during writeback as well so we should be fine and the gain is very
>> nice.
> 
> Hmm.... when I was looking potential impacts of the change what
> ext4_overwrite_io() would do, I looked at the current user of that
> function in ext4_dio_write_checks().
> 
> 	/*
> 	 * Determine whether the IO operation will overwrite allocated
> 	 * and initialized blocks.
> 	 * We need exclusive i_rwsem for changing security info
> 	 * in file_modified().
> 	 */
> 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> 	     !ext4_overwrite_io(inode, offset, count))) {
> 		if (iocb->ki_flags & IOCB_NOWAIT) {
> 			ret = -EAGAIN;
> 			goto out;
> 		}
> 		inode_unlock_shared(inode);
> 		*ilock_shared = false;
> 		inode_lock(inode);
> 		goto restart;
> 	}
> 
> 	ret = file_modified(file);
> 	if (ret < 0)
> 		goto out;
> 
> What is confusing me is the comment, "We need exclusive i_rwsem for
> changing security info in file_modified().".  But then we end up
> calling file_modified() unconditionally, regardless of whether we've
> transitioned from a shared lock to an exclusive lock.
> 
> So file_modified() can get called either with or without the inode
> locked r/w.  I realize that this patch doesn't change this
> inconsistency, but it appears either the comment is wrong, or the code
> is wrong.
> 
> What am I missing?
> 

IIUC, both of the comment and the code are correct, the __file_remove_privs()
in file_modified() should execute under exclusive lock, and we have already
check the IS_NOSEC(inode) and could make sure taking exclusive lock before we
remove privs. If we take share lock, __file_remove_privs() will return directly
because below check. So it's find now, but it looks that call file_update_time()
is enough for the shared lock case.

int file_update_time(struct file *file)
{
	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
		return 0;
...
}

Thanks,
Yi.
