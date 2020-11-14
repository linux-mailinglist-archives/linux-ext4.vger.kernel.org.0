Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE82B2C1B
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Nov 2020 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKNISW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Nov 2020 03:18:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7499 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgKNISW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Nov 2020 03:18:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CY7WS0NGrzhl09;
        Sat, 14 Nov 2020 16:18:12 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Nov 2020 16:18:12 +0800
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Hou Tao <houtao1@huawei.com>, <zhangxiaoxu5@huawei.com>,
        Ye Bin <yebin10@huawei.com>, <hejie3@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Subject: [Bug report] journal data mode trigger panic in
 jbd2_journal_commit_transaction
Message-ID: <68b9650e-bef2-69e2-ab5e-8aaddaf46cfe@huawei.com>
Date:   Sat, 14 Nov 2020 16:18:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

While using ext4 with data=journal(3.10 kernel), we meet a problem that 
we think may never happend...

[421306.834334] JBD2: Spotted dirty metadata buffer (dev = vda2, blocknr 
= 5092931). There's a risk of filesystem corruption in case of system crash.
[421306.834375] JBD2: Spotted dirty metadata buffer (dev = vda2, blocknr 
= 5092931). There's a risk of filesystem corruption in case of system crash.
[421306.841728] JBD2: Spotted dirty metadata buffer (dev = vda2, blocknr 
= 5092931). There's a risk of filesystem corruption in case of system crash.
[421306.859799] ------------[ cut here ]------------
[421306.860616] kernel BUG at fs/jbd2/commit.c:1030!
[421306.861285] invalid opcode: 0000 [#1] SMP
[421306.861996] CPU: 3 PID: 1594 Comm: jbd2/vda2-8 Kdump: loaded
...
[421306.877080] Call Trace:
[421306.877406]  [<ffffffffc045d069>] kjournald2+0xc9/0x260 [jbd2]
[421306.878133]  [<ffffffff914c16c0>] ? wake_up_atomic_t+0x30/0x30
[421306.878851]  [<ffffffffc045cfa0>] ? commit_timeout+0x10/0x10 [jbd2]
[421306.879609]  [<ffffffff914c06a1>] kthread+0xd1/0xe0
[421306.880200]  [<ffffffff914c05d0>] ? insert_kthread_work+0x40/0x40
[421306.880949]  [<ffffffff91b3965d>] ret_from_fork_nospec_begin+0x7/0x21
[421306.881737]  [<ffffffff914c05d0>] ? insert_kthread_work+0x40/0x40

Crash code in jbd2_journal_commit_transaction:

jbd2_journal_commit_transaction(...)
{
     ...
     while (commit_transaction->t_forget) {
     ...
     if (buffer_jbddirty(bh)) {
         ...
     } else {
         J_ASSERT_BH(bh, !buffer_dirty(bh));
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         ...
     }
}

1. the warning and the panic show that someone can dirty buffer directly;
2. the state in buffer and page show that we may call ext4_punch_hole or 
zero_range just before now;

crash> buffer_head ffff971220f3caf8
struct buffer_head {
   b_state = 5308419, BH_State|BH_RevokeValid|BH_JBD|BH_Uptodate|BH_Dirty
   b_this_page = 0xffff971220f3caf8,
   b_page = 0xffffdb4e8e897cc0,
   b_blocknr = 5092931,
   b_size = 4096,
   b_data = 0xffff9711a25f3000 ...
   b_bdev = 0x0,
   b_end_io = 0x0,
   b_private = 0xffff97114c04faf0,
   b_assoc_buffers = {
     next = 0xffff971220f3cb40,
     prev = 0xffff971220f3cb40
   },
   b_assoc_map = 0x0,
   b_count = {
     counter = 2
   }
}

crash> page 0xffffdb4e8e897cc0
struct page {
   flags = 31525193096628284,
   mapping = 0x0,
   {
     {
       index = 766,
     ...
     private = 0xffff971220f3caf8,
     ...
}

3. the b_blocknr in buffer_head and index in page show that the buffer 
wont be a metadata block.

For now, what I have seen that can dirty buffer directly is 
ext4_page_mkwrite(64a9f1449950 ("ext4: data=journal: fixes for 
ext4_page_mkwrite()")), and runing ext4_punch_hole with keep_size 
/ext4_page_mkwrite parallel can trigger above warning easily.

a. first, file with 4K size punch hole to 0 with keep size

mmap1:                     mmap2:                  commit:
ext4_page_fault
  create new page
  and lock page
...
unlock page
                            ext4_page_fault
                             find and lock the
                             page mmap1 create
                            ...
                            unlock_page

ext4_page_mkwrite
  lock page
  (has buffer&&unmap)
  or goto out
  unlock page
                            ext4_page_mkwrite
                             lock_page
                             (has buffer&&unmap)
                             or goto out
                             unlock page
  start handle(trans 1)
  __block_page_mkwrite
   lock page
   (page->mapping==
   inode->mapping) or
   goto out
   block_commit_write
    set_buffer_dirty
  ext4_walk_page_buffers
   do_journal_get_write_access
    clear_buffer_dirty
...
unlock_page
                              start_handle(trans 2)
                               __block_page_mkwrite
                                lock page
                                ...(same as mmap1)
                                 set_buffer_dirty  trans1 1 commit:
                                ...                bh moving from one
                                                   list to other list
                                                   (like shadow), and
                                                   warn_dirty_buffer!
                                unlock page



However, the same testcase won't trigger the panic. We can seen that 
ext4_punch_hole and ext4_page_mkwrite all will try to lock page. So, if 
punch_hole first, we won't set buffer dirty since page->mapping has been 
set to NULL. And if ext4_page_mkwrite first, we won't seen buffer dirty 
since do_journal_get_write_access will clear it.

Besides, the panic code was protected by jbd_lock_bh_state, and the 
information of bh show that we has call journal_unmap_buffer for it. So, 
the panic code may never be trigger...

punch hole:
ext4_punch_hole
   ...
   lock_page
   truncate_inode_page
     truncate_complete_page
       do_invalidatepage
         ...
         journal_unmap_buffer
       delete_from_page_cache
         remove page from radix tree, and set page->mapping = NULL,
         so we won't find this page
   unlock_page


mmap:
ext4_page_fault
   find and create new page(without bh)
...
unlock_page

ext4_page_mkwrite
   lock_page
   (has buffer && unmap) or will go out
   unlock_page
   start_handle
   __block_page_mkwrite
     lock_page
     (page->mapping != inode->i_mapping) or go out
     block_commit_write
       set_buffer_dirty
   ext4_walk_page_buffers
     do_journal_get_write_access
       clear_buffer_dirty =========> after unlock page, wont seen dirty
...
unlock_page



The above assumption was based on we can only dirty buffer directly by 
ext4_page_mkwrite. Maybe there exists other way too? Or, the analysis 
above exists some bug...


Thanks,
Kun.



