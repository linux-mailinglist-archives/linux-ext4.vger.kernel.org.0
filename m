Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC23ED8F8
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhHPO3k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 10:29:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13331 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHPO3g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 10:29:36 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GpGkJ3QLLz85pq;
        Mon, 16 Aug 2021 22:28:56 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 16 Aug 2021 22:29:01 +0800
Subject: Re: [PATCH 3/3] ext4: prevent getting empty inode buffer
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-4-yi.zhang@huawei.com>
 <20210813134440.GE11955@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <ab186083-8c08-2d74-dd63-673e918e6fa0@huawei.com>
Date:   Mon, 16 Aug 2021 22:29:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210813134440.GE11955@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/8/13 21:44, Jan Kara wrote:
> On Tue 10-08-21 22:27:22, Zhang Yi wrote:
>> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
>> inode buffer when the inode monopolize an inode block for performance
>> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
>> buffer to make it fine, but we could miss this call if something bad
>> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
>> empty inode buffer and trigger ext4 error.
>>
>> For example, if we remove a nonexistent xattr on inode A,
>> ext4_xattr_set_handle() will return ENODATA before invoking
>> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
>> will get checksum error message in ext4_iget() when getting inode again.
>>
>>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
>>
>> Even worse, if we allocate another inode B at the same inode block, it
>> will corrupt the inode A on disk when write back inode B.
>>
>> So this patch clear uptodate flag and mark buffer new if we get an empty
>> buffer, clear it after we fill inode data or making read IO.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for the fix! Really good catch! The patch looks correct but
> honestly, I'm not very happy about the special buffer_new handling. It
> looks correct but I'm a bit uneasy that e.g. the block device code can
> access this buffer and manipulate its state. Cannot we instead e.g. check
> whether the buffer is uptodate in ext4_mark_iloc_dirty(), if not, lock it,
> if still not uptodate, zero it, mark as uptodate, unlock it and then call
> ext4_do_update_inode()? That would seem like a bit more foolproof solution
> to me. Basically the fact that the buffer is not uptodate in
> ext4_mark_iloc_dirty() would mean that nobody else is past
> __ext4_get_inode_loc() for another inode in that buffer and so zeroing is
> safe.
> 

Thanks for your suggestion! I understand what you're concerned and your
approach looks fine except mark buffer uptodate just behind zero buffer
in ext4_mark_iloc_dirty(). Because I think (1) if ext4_do_update_inode()
return error before filling the inode, it will still left an uptodate
but zero buffer, and it's not easy to handle the error path. (2) it is
still not conform the semantic of buffer uptodate because it it not
contain an uptodate inode information. How about move mark as uptodate
into ext4_do_update_inode(), something like that（not tested）？

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eae1b2d0b550..99ccba8d47c6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4368,8 +4368,6 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
                brelse(bitmap_bh);
                if (i == start + inodes_per_block) {
                        /* all other inodes are free, so skip I/O */
-                       memset(bh->b_data, 0, bh->b_size);
-                       set_buffer_uptodate(bh);
                        unlock_buffer(bh);
                        goto has_buffer;
                }
@@ -5132,6 +5130,9 @@ static int ext4_do_update_inode(handle_t *handle,
        if (err)
                goto out_brelse;
        ext4_clear_inode_state(inode, EXT4_STATE_NEW);
+       if (!buffer_uptodate(bh))
+               set_buffer_uptodate(bh);
+
        if (set_large_file) {
                BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
                err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
@@ -5712,6 +5713,13 @@ int ext4_mark_iloc_dirty(handle_t *handle,
        /* the do_update_inode consumes one bh->b_count */
        get_bh(iloc->bh);

+       if (!buffer_uptodate(bh)) {
+               lock_buffer(iloc->bh);
+               if (!buffer_uptodate(iloc->bh))
+                       memset(iloc->bh->b_data, 0, iloc->bh->b_size);
+               unlock_buffer(iloc->bh);
+       }
+
        /* ext4_do_update_inode() does jbd2_journal_dirty_metadata */
        err = ext4_do_update_inode(handle, inode, iloc);
        put_bh(iloc->bh);


Thanks,
Yi.
