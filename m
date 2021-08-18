Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978473F039C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhHRMQh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 08:16:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8878 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhHRMQg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Aug 2021 08:16:36 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GqRbK13H3z8sZL;
        Wed, 18 Aug 2021 20:11:57 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 18 Aug 2021 20:15:59 +0800
Subject: Re: [PATCH 3/3] ext4: prevent getting empty inode buffer
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-4-yi.zhang@huawei.com>
 <20210813134440.GE11955@quack2.suse.cz>
 <ab186083-8c08-2d74-dd63-673e918e6fa0@huawei.com>
 <20210816171457.GL30215@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <268a052a-e288-2e11-ec54-7210a47e44e2@huawei.com>
Date:   Wed, 18 Aug 2021 20:15:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210816171457.GL30215@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/8/17 1:14, Jan Kara wrote:
> On Mon 16-08-21 22:29:01, Zhang Yi wrote:
>> On 2021/8/13 21:44, Jan Kara wrote:
>>> On Tue 10-08-21 22:27:22, Zhang Yi wrote:
>>>> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
>>>> inode buffer when the inode monopolize an inode block for performance
>>>> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
>>>> buffer to make it fine, but we could miss this call if something bad
>>>> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
>>>> empty inode buffer and trigger ext4 error.
>>>>
>>>> For example, if we remove a nonexistent xattr on inode A,
>>>> ext4_xattr_set_handle() will return ENODATA before invoking
>>>> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
>>>> will get checksum error message in ext4_iget() when getting inode again.
>>>>
>>>>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
>>>>
>>>> Even worse, if we allocate another inode B at the same inode block, it
>>>> will corrupt the inode A on disk when write back inode B.
>>>>
>>>> So this patch clear uptodate flag and mark buffer new if we get an empty
>>>> buffer, clear it after we fill inode data or making read IO.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Thanks for the fix! Really good catch! The patch looks correct but
>>> honestly, I'm not very happy about the special buffer_new handling. It
>>> looks correct but I'm a bit uneasy that e.g. the block device code can
>>> access this buffer and manipulate its state. Cannot we instead e.g. check
>>> whether the buffer is uptodate in ext4_mark_iloc_dirty(), if not, lock it,
>>> if still not uptodate, zero it, mark as uptodate, unlock it and then call
>>> ext4_do_update_inode()? That would seem like a bit more foolproof solution
>>> to me. Basically the fact that the buffer is not uptodate in
>>> ext4_mark_iloc_dirty() would mean that nobody else is past
>>> __ext4_get_inode_loc() for another inode in that buffer and so zeroing is
>>> safe.
>>>
>>
>> Thanks for your suggestion! I understand what you're concerned and your
>> approach looks fine except mark buffer uptodate just behind zero buffer
>> in ext4_mark_iloc_dirty(). Because I think (1) if ext4_do_update_inode()
>> return error before filling the inode, it will still left an uptodate
>> but zero buffer, and it's not easy to handle the error path. (2) it is
>> still not conform the semantic of buffer uptodate because it it not
>> contain an uptodate inode information. How about move mark as uptodate
>> into ext4_do_update_inode(), something like that（not tested）？
> 
> OK, but this way could loading of buffer from the disk race with
> ext4_do_update_inode() and overwrite its updates? You have to have buffer
> uptodate before you start modifying it or you have to keep the buffer
> locked all the time while you are updating it to avoid such races.

Indeed.

> 
> Luckily the only place where ext4_do_update_inode() can fail before copying
> data to the buffer is due to ext4_inode_blocks_set() which should never
> happen because we set s_maxsize so that i_blocks cannot overflow. So maybe
> we can just get rid of that case and keep the uptodate setting with the
> zeroing?
> 

It's fine, Let's fix it this way now.(But I guess it's fragile because we have
to prevent modify ext4_do_update_inode() return before filling data into inode
buffer cautiously in the future.)

BTW, could we also add a patch to just remove the ext4_has_feature_huge_file()
check in ext4_inode_blocks_set() or move it to ext4_mark_iloc_dirty() before
ext4_mark_iloc_dirty()? Or else we may get confused and have to add comments to
explain it.

Thanks,
Yi.
