Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F773FA9C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jun 2023 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjF0K5o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jun 2023 06:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF0K5j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jun 2023 06:57:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563971BE7
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 03:57:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qr1rY2thZz4f3jLc
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 18:57:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBHZjCawJpkLx3aLw--.8238S2;
        Tue, 27 Jun 2023 18:57:31 +0800 (CST)
Subject: Re: mkfs.ext4 failed when orphan_file is enabled
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <3f0c3d5c-3dbf-6e9e-962b-616016c7427e@huaweicloud.com>
 <20230626180001.GA225716@mit.edu>
 <3536fd3e-95d8-e062-32ae-a4add83e1ea5@huaweicloud.com>
Message-ID: <08c8618c-9573-35ca-f498-9e09520cf86f@huaweicloud.com>
Date:   Tue, 27 Jun 2023 18:57:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3536fd3e-95d8-e062-32ae-a4add83e1ea5@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgBHZjCawJpkLx3aLw--.8238S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1fArWUuFW5tr4UWr18AFb_yoWrCr1Upa
        yxJF98KrW8Xa4F9a92yw10qa4aqw40yrs8XryUWwn2v345WFn2qrs3KFyUJFyqkrs3A3WY
        vFyDt3yUW340yFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 6/27/2023 10:46 AM, Kemeng Shi wrote:
> 
> 
> on 6/27/2023 2:00 AM, Theodore Ts'o wrote:
>> On Mon, Jun 26, 2023 at 08:48:23PM +0800, Kemeng Shi wrote:
>>> Hi all, I find that "kvm-xfstests -c ext4/1k ext4/049" is failed on
>>> current dev branch because of mkfs.ext4 failure.
>>
>> Hmm, I'm not seeing this mkfs.ext4 failure using 1.47.0.  I have two
>> cherry-picks on top of 1.47, but neither relate to mkfs.ext4:
>>
>>   24a11cc371a4 ("e2fsck: Suppress "orphan file is clean" message in preen mode")
>>
>> and
>>
>>   8798bbb81687 ("e2fsck: fix handling of a invalid symlink in an inline_data directory")
>>
>> See:
>>
>> root@kvm-xfstests:~# /sbin/mkfs.ext4  -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/vdc
>> mke2fs 1.47.0 (5-Feb-2023)
>> /dev/vdc contains a ext4 file system
>>         last mounted on /vdc on Sun Jun 25 22:14:30 2023
>> Discarding device blocks: done                            
>> Creating filesystem with 1310720 4k blocks and 1280 inodes
>> Filesystem UUID: 127d490e-6caa-45cf-b5da-5616c5564a1a
>> Superblock backups stored on blocks: 
>>         8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552, 
>>         1024000
>>
>> Allocating group tables: done                            
>> Writing inode tables: done                            
>> Creating journal (16384 blocks): done
>> Writing superblocks and filesystem accounting information: done   
>>
>> Can you confirm what version of e2fsprogs you are using?  Is it
>> exactly 1.47.0, or do you have some additional commits (either from
>> the upstream master or maint branches) applied?
> For virutal machine, I use built-in e2fsprogs in image[1]. For host mahcine, I build mke2fs
> from the upstream master branch with commit e76886f76dfca ("Merge branch 'maint' into next").
> I find some more clues that rename from mke2fs to mkfs.ext4 will cause this issue:
> 
> /* make sure mkfs.ext4 and mke2fs is renamed */
> root@kvm-xfstests:~# md5sum /sbin/mkfs.ext4
> 746f94dbfef93ed68bd760530613b176  /sbin/mkfs.ext4
> root@kvm-xfstests:~# md5sum /sbin/mke2fs
> 746f94dbfef93ed68bd760530613b176  /sbin/mke2fs
> 
> /* /sbin/mkfs.ext4 failed */
> root@kvm-xfstests:~# /sbin/mkfs.ext4 -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/vdc
> mke2fs 1.47.0 (5-Feb-2023)
> /dev/vdc contains a ext2 file system
>         created on Tue Jun 27 10:28:17 2023
> Discarding device blocks: done
> Creating filesystem with 1310720 4k blocks and 1280 inodes
> Filesystem UUID: d7287d23-c4fa-42da-8d53-14078dec8d70
> Superblock backups stored on blocks:
>         8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552,
>         1024000
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (16384 blocks): done
> * mkfs.ext4: Inode checksum does not match inode while creating orphan file *
> 
> /* /sbin/mke2fs successed */
> root@kvm-xfstests:~# /sbin/mke2fs -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/vdc
> mke2fs 1.47.0 (5-Feb-2023)
> Discarding device blocks: done
> Creating filesystem with 1310720 4k blocks and 1280 inodes
> Filesystem UUID: 0e01e99b-52bf-4c2c-b986-fb497780bf40
> Superblock backups stored on blocks:
>         8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552,
>         1024000
> 
> Allocating group tables: done
> Writing inode tables: done
> Writing superblocks and filesystem accounting information: done
> 
> This can be reproduced in my host machine too.
> 
> [1]https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/root_fs.img.amd64
> 
There are some updates for the issue. After a quick look at mke2fs.c,
I think the bug is triggered as following:
main
  ...

  /* unused inode is not zeroed dute as lazy_itable_init is set */
  write_inode_tables(fs, lazy_itable_init, itable_zeroed) (lazy_flag=1,
  itable_zeroed=0)

  ...

  ext2fs_create_orphan_file
    /* get a new uninitialized inode */
    ext2fs_new_inode
    /* read and check checksum of uninitialized inode */
    ext2fs_read_inode
      /* read uninitialized inode from disk */
      io_channel_read_blk64
      /* check checksum of non zeroed inode and failed here*/
      ext2fs_inode_csum_verify

I disable lazy_itable_init by force lazy_flag=0 when calling
write_inode_tables to prove this and the problem is solved
as expected.

Wish this help and correct me if I missed anything.

-- 
Best wishes
Kemeng Shi

