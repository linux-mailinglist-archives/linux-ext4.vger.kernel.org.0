Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6144EB6416
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfIRNJM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 09:09:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728633AbfIRNJM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Sep 2019 09:09:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7BF227C0BEE53F1BEF2A;
        Wed, 18 Sep 2019 21:09:10 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 21:09:01 +0800
Subject: Re: [PATCH] ext4: fix a bug in ext4_wait_for_tail_page_commit
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>, <houtao1@huawei.com>
References: <20190917084814.40370-1-yangerkun@huawei.com>
 <20190918104535.GC25056@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <71e28624-214c-f676-b215-19f78266de84@huawei.com>
Date:   Wed, 18 Sep 2019 21:09:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918104535.GC25056@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2019/9/18 18:45, Jan Kara wrote:
> On Tue 17-09-19 16:48:14, yangerkun wrote:
>> No need to wait when offset equals to 0. And it will trigger a bug since
>> the latter __ext4_journalled_invalidatepage can free the buffers but leave
>> page still dirty.
>>
>> [   26.057508] ------------[ cut here ]------------
>> [   26.058531] kernel BUG at fs/ext4/inode.c:2134!
>> ...
>> [   26.088130] Call trace:
>> [   26.088695]  ext4_writepage+0x914/0xb28
>> [   26.089541]  writeout.isra.4+0x1b4/0x2b8
>> [   26.090409]  move_to_new_page+0x3b0/0x568
>> [   26.091338]  __unmap_and_move+0x648/0x988
>> [   26.092241]  unmap_and_move+0x48c/0xbb8
>> [   26.093096]  migrate_pages+0x220/0xb28
>> [   26.093945]  kernel_mbind+0x828/0xa18
>> [   26.094791]  __arm64_sys_mbind+0xc8/0x138
>> [   26.095716]  el0_svc_common+0x190/0x490
>> [   26.096571]  el0_svc_handler+0x60/0xd0
>> [   26.097423]  el0_svc+0x8/0xc
>>
>> Run below parallel can reproduce it easily(ext3):
>> void main()
>> {
>>          int fd, fd1, fd2, fd3, ret;
>>          void *addr;
>>          size_t length = 4096;
>>          int flags;
>>          off_t offset = 0;
>>          char *str = "12345";
>>
>>          fd = open("a", O_RDWR | O_CREAT);
>>          assert(fd >= 0);
>>
>>          ret = ftruncate(fd, length);
>>          assert(ret == 0);
>>
>>          fd1 = open("a", O_RDWR | O_CREAT, -1);
>>          assert(fd1 >= 0);
>>
>>          flags = 0xc00f;/*Journal data mode*/
>>          ret = ioctl(fd1, _IOW('f', 2, long), &flags);
>>          assert(ret == 0);
>>
>>          fd2 = open("a", O_RDWR | O_CREAT);
>>          assert(fd2 >= 0);
>>
>>          fd3 = open("a", O_TRUNC | O_NOATIME);
>>          assert(fd3 >= 0);
>>
>>          addr = mmap(NULL, length, 0xe, 0x28013, fd2, offset);
> 
> Ugh, these mmap flags look pretty bogus. Were they generated by some
> fuzzer?
Yeah, generated by syzkaller.
> 
>>          assert(addr != (void *)-1);
>>          memcpy(addr, str, 5);
> 
> Also the O_TRUNC open above will truncate "a" to 0 so the mapping is
> actually beyond i_size and this memcpy should fail with SIGBUS. So I'm
> surprised your test program gets up to mbind()...

We run the program parallel, sometimes will run as below:

reproduce1                         reproduce2

...                            |   ...
truncate to 4k                 |
change to journal data mode    |
                                |   memcpy(set page dirty)
truncate to 0:                 |
ext4_setattr:                  |
...                            |
ext4_wait_for_tail_page_commit |
                                |   mbind(trigger bug)
truncate_pagecache(clean dirty)|   ...
...                            |
Reproduce2 will mark page as dirty by memcpy, then mbind run between 
ext4_wait_for_tail_page_commit and truncate_pagecache in ext4_setattr 
can trigger the bug with page still be dirty but buffer head has been free.

So sorry for the incomprehensible description! I will reorganize and 
resend the patch!

Thanks a lot.
> 
>>          mbind(addr, length, 0, 0, 0, 2);
>>
>>          close(fd);
>>          munmap(addr, length);
>> }
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> I agree that there's no need to wait for transaction commit when offset ==
> 0. So your patch is correct in that regard. What still escapes me is why
> this is necessary. I have a feeling that it just papers over the real
> problem.  You mention crash in ext4_writepage() because page is dirty but
> has no buffers - but how come the page is dirty? If offset == 0 for a page,
> truncate_inode_pages() should have cleaned PageDirty flag so the page
> should never get to ext4_writepage() in the first place. Together with my
> comments about the test case this is still a bit mystery to me... I guess
> I'll try to reproduce this to understand this better.
> 
> 								Honza
> 
>> ---
>>   fs/ext4/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 006b7a2070bf..a9943ae4f74d 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5479,7 +5479,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>>   	 * do. We do the check mainly to optimize the common PAGE_SIZE ==
>>   	 * blocksize case
>>   	 */
>> -	if (offset > PAGE_SIZE - i_blocksize(inode))
>> +	if (!offset || offset > PAGE_SIZE - i_blocksize(inode))
>>   		return;
>>   	while (1) {
>>   		page = find_lock_page(inode->i_mapping,
>> -- 
>> 2.17.2
>>

