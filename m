Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930DB4E51C7
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbiCWMCa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbiCWMC3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 08:02:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A57A9B2;
        Wed, 23 Mar 2022 05:00:57 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KNn2f5cQyzfYmZ;
        Wed, 23 Mar 2022 19:59:22 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 20:00:55 +0800
Subject: Re: [PATCH -next] ext4: fix use-after-free in ext4_search_dir
To:     Jan Kara <jack@suse.cz>
References: <20220323034304.3597652-1-yebin10@huawei.com>
 <20220323104745.76u3uhdn745jaw4j@quack3.lan>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lczerner@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <623B0BF7.3050907@huawei.com>
Date:   Wed, 23 Mar 2022 20:00:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220323104745.76u3uhdn745jaw4j@quack3.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/3/23 18:47, Jan Kara wrote:
> On Wed 23-03-22 11:43:04, Ye Bin wrote:
>> We got issue as follows:
>> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
>> ==================================================================
>> BUG: KASAN: use-after-free in ext4_search_dir fs/ext4/namei.c:1394 [inline]
>> BUG: KASAN: use-after-free in search_dirblock fs/ext4/namei.c:1199 [inline]
>> BUG: KASAN: use-after-free in __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
>> Read of size 1 at addr ffff8881317c3005 by task syz-executor117/2331
>>
>> CPU: 1 PID: 2331 Comm: syz-executor117 Not tainted 5.10.0+ #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:83 [inline]
>>   dump_stack+0x144/0x187 lib/dump_stack.c:124
>>   print_address_description+0x7d/0x630 mm/kasan/report.c:387
>>   __kasan_report+0x132/0x190 mm/kasan/report.c:547
>>   kasan_report+0x47/0x60 mm/kasan/report.c:564
>>   ext4_search_dir fs/ext4/namei.c:1394 [inline]
>>   search_dirblock fs/ext4/namei.c:1199 [inline]
>>   __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
>>   ext4_lookup_entry fs/ext4/namei.c:1622 [inline]
>>   ext4_lookup+0xb8/0x3a0 fs/ext4/namei.c:1690
>>   __lookup_hash+0xc5/0x190 fs/namei.c:1451
>>   do_rmdir+0x19e/0x310 fs/namei.c:3760
>>   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x445e59
>> Code: 4d c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007fff2277fac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
>> RAX: ffffffffffffffda RBX: 0000000000400280 RCX: 0000000000445e59
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000002
>> R10: 00007fff2277f990 R11: 0000000000000246 R12: 0000000000000000
>> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>>
>> The buggy address belongs to the page:
>> page:0000000048cd3304 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1317c3
>> flags: 0x200000000000000()
>> raw: 0200000000000000 ffffea0004526588 ffffea0004528088 0000000000000000
>> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff8881317c2f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff8881317c2f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff8881317c3000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>                     ^
>>   ffff8881317c3080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>   ffff8881317c3100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ==================================================================
>>
>> ext4_search_dir:
>>    ...
>>    de = (struct ext4_dir_entry_2 *)search_buf;
>>    dlimit = search_buf + buf_size;
>>    while ((char *) de < dlimit) {
>>    ...
>>      if ((char *) de + de->name_len <= dlimit &&
>> 	 ext4_match(dir, fname, de)) {
>> 	    ...
>>      }
>>    ...
>>      de_len = ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize);
>>      if (de_len <= 0)
>>        return -1;
>>      offset += de_len;
>>      de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
>>    }
>>
>> Assume:
>> de=0xffff8881317c2fff
>> dlimit=0x0xffff8881317c3000
>>
>> If read 'de->name_len' which address is 0xffff8881317c3005, obviously is
>> out of range, then will trigger use-after-free.
>> To solve this issue, 'dlimit' must reserve 8 bytes, as we will read
>> 'de->name_len' to judge if '(char *) de + de->name_len' out of range.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Oh, good catch.
>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 3f87cca49f0c..276683f7ab77 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2273,6 +2273,10 @@ static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
>>    * Structure of a directory entry
>>    */
>>   #define EXT4_NAME_LEN 255
>> +/*
>> + * Base length of ext4_dir_entry_2 and ext4_dir_entry exclude name
>> + */
>> +#define EXT4_BASE_DIR_LEN 8
> I'd rather use (sizeof(struct ext4_dir_entry_2) - EXT4_NAME_LEN) here...
>
>>   struct ext4_dir_entry {
>>   	__le32	inode;			/* Inode number */
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index e37da8d5cd0c..4739a5aa13aa 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -1465,7 +1465,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
>>   	int de_len;
>>   
>>   	de = (struct ext4_dir_entry_2 *)search_buf;
>> -	dlimit = search_buf + buf_size;
>> +	dlimit = search_buf + buf_size - EXT4_BASE_DIR_LEN;
>>   	while ((char *) de < dlimit) {
>>   		/* this code is executed quadratically often */
>>   		/* do minimal checking `by hand' */
> This looks wrong because a bit later we use dlimit to verify
> de+de->name_len and that can certainly go upto bufsize. You need to modify
> only the condition in the while loop like:
>
>    	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
>
> 									Honza
I think  'dlimit' also need to minus EXT4_BASE_DIR_LEN when verify 
'de+de->name_len' .
Assume:
de = 0xffff8881317c2ff7
dlimit = 0x0xffff8881317c3000
de->name_len = 8

=>
de + de->name_len = 0xffff8881317c2fff  ( <= dlimit=0x0xffff8881317c3000)
de->name = 'de' address  + EXT4_BASE_DIR_LEN  = 0xffff8881317c2ff7 + 8 = 
0xffff8881317c2fff
If we read 8 bytes form 0xffff8881317c2fff will read out of range.


