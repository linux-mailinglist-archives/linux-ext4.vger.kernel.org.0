Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264F72E628
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbjFMOq7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjFMOq6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 10:46:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1210F4;
        Tue, 13 Jun 2023 07:46:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgWbb10xPz4f3pBY;
        Tue, 13 Jun 2023 22:46:51 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgC3nQtWgYhkMiMAKw--.54737S2;
        Tue, 13 Jun 2023 22:46:48 +0800 (CST)
Subject: Re: [PATCH 4/7] ext4: remove unnecessary check in
 ext4_bg_num_gdb_nometa
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
 <20230221115919.1918161-5-shikemeng@huaweicloud.com>
 <20230613131507.0ce55666@mir>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <60d81a63-4e8e-690d-b0c2-3c20c780a5d6@huaweicloud.com>
Date:   Tue, 13 Jun 2023 22:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230613131507.0ce55666@mir>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgC3nQtWgYhkMiMAKw--.54737S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4kuF4rJrWrZw43GFy8Xwb_yoWDGw47pr
        s7Cr15KrW8Xa4kuan29a429FWfX340yFsxua4Uur15AFZ8Gr1IqF43ury3XFyDKrZ8uF1Y
        qFWYvr98uw1q93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
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



on 6/13/2023 7:15 PM, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2023-02-21, Kemeng Shi wrote:
>> We only call ext4_bg_num_gdb_nometa if there is no meta_bg feature or group
>> does not reach first_meta_bg, so group must not reside in meta group. Then
>> group has a global gdt if superblock exists. Just remove confusing branch
>> that meta_bg feature exists.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/balloc.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
>> index 9b8a32b90ddc..08f1692f7d2f 100644
>> --- a/fs/ext4/balloc.c
>> +++ b/fs/ext4/balloc.c
>> @@ -844,10 +844,7 @@ static unsigned long ext4_bg_num_gdb_nometa(struct super_block *sb,
>>  	if (!ext4_bg_has_super(sb, group))
>>  		return 0;
>>
>> -	if (ext4_has_feature_meta_bg(sb))
>> -		return le32_to_cpu(EXT4_SB(sb)->s_es->s_first_meta_bg);
>> -	else
>> -		return EXT4_SB(sb)->s_gdb_count;
>> +	return EXT4_SB(sb)->s_gdb_count;
>>  }
>>
>>  /**
> 
> This change as part of v6.4-rc6-26-gfb054096aea0 seems to cause a
> regression for mounting a (large, lvm2 backed, grown several times,
> probably also shrunk at least once) ext4 filesystem for me (other,
> smaller/ simpler ext4 filesystems mount fine).
> 
Hi Stefan, thank you for let me know the issue. It seems that s_gdb_count
is block number used for both non-meta and meta block group descriptors.
However we should return block number used for non-meta block group in
ext4_bg_num_gdb_nometa.

Sorry for this problem, I will send a revert patch to fix this.
> # LANG= mount /dev/vg-trident/storage /mnt/
> mount: /mnt: mount(2) system call failed: Structure needs cleaning.
>        dmesg(1) may have more information after failed mount system call.
> 
> [  569.576241] EXT4-fs (dm-6): ext4_check_descriptors: Inode table for group 2 overlaps block group descriptors
> [  569.576251] EXT4-fs (dm-6): group descriptors corrupted!
> 
> e2fsck (1.47.0-2, Debian/unstable, amd64) does not find any problems
> about this fs.
> 
> # fsck -f /dev/vg-trident/storage
> fsck from util-linux 2.38.1
> e2fsck 1.47.0 (5-Feb-2023)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> storage: 1274324/595369984 files (0.4% non-contiguous), 4194120223/4762936320 blocks
> 
> Bisecting leads me to this patch:
> 
> $ git bisect log
> git bisect start
> # Status: warte auf guten und schlechten Commit
> # good: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
> git bisect good 457391b0380335d5e9a5babdec90ac53928b23b4
> # Status: warte auf schlechten Commit, 1 guter Commit bekannt
> # bad: [fb054096aea0576f0c0a61c598e5e9676443ee86] Merge tag 'mm-hotfixes-stable-2023-06-12-12-22' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad fb054096aea0576f0c0a61c598e5e9676443ee86
> # bad: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 6e98b09da931a00bf4e0477d0fa52748bf28fcce
> # good: [088e0c188513b58a0056a488cf5b7df094a8a48a] Merge tag 'platform-drivers-x86-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> git bisect good 088e0c188513b58a0056a488cf5b7df094a8a48a
> # good: [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag 'wireless-next-2023-04-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
> git bisect good ca288965801572fe41386560d4e6c5cc0e5cc56d
> # bad: [94fc0792661a96d64a4bb79cf10d0793ecadf76e] Merge tag 'fs_for_v6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> git bisect bad 94fc0792661a96d64a4bb79cf10d0793ecadf76e
> # good: [4173cf6fb6b7d1b4569cca08af318c4561356fb5] Merge tag 'hwmon-for-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> git bisect good 4173cf6fb6b7d1b4569cca08af318c4561356fb5
> # good: [98f99e67a1dc456e9a542584819b2aa265ffc737] Merge tag 'flex-array-transformations-6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
> git bisect good 98f99e67a1dc456e9a542584819b2aa265ffc737
> # good: [ba24b8eb3ef676cb7d6cef4a2a53f3624f880d42] crypto: testmgr - Add some test vectors for cmac(camellia)
> git bisect good ba24b8eb3ef676cb7d6cef4a2a53f3624f880d42
> # bad: [4d934a5e6caa6dcdd3fbee7b96fe512a455863b6] ext4: Convert ext4_write_begin() to use a folio
> git bisect bad 4d934a5e6caa6dcdd3fbee7b96fe512a455863b6
> # bad: [78dc9f844f4ec999a30517313040948a4c4bbc00] ext4: use best found when complex scan of group finishs
> git bisect bad 78dc9f844f4ec999a30517313040948a4c4bbc00
> # bad: [b83acc77718644b2c19832226ca284ce01efc550] ext4: remove unused group parameter in ext4_inode_bitmap_csum_verify
> git bisect bad b83acc77718644b2c19832226ca284ce01efc550
> # good: [e6c28a26b799c7640b77daff3e4a67808c74381c] ext4: Fix warnings when freezing filesystem with journaled data
> git bisect good e6c28a26b799c7640b77daff3e4a67808c74381c
> # good: [a38627f14356f505f621b31197fd872b99a10563] ext4: call ext4_bg_num_gdb_[no]meta directly in ext4_num_base_meta_clusters
> git bisect good a38627f14356f505f621b31197fd872b99a10563
> # bad: [f567ea7843562b7d7dfe1e6cfea455a1e9623208] ext4: remove stale comment in ext4_init_block_bitmap
> git bisect bad f567ea7843562b7d7dfe1e6cfea455a1e9623208
> 
> # tune2fs -l /dev/vg-trident/storage
> tune2fs 1.47.0 (5-Feb-2023)
> Filesystem volume name:   storage
> Last mounted on:          /srv/storage
> Filesystem UUID:          ad4e7e8d-f375-491f-a5dd-6251d32229e6
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr dir_index filetype meta_bg extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              595369984
> Block count:              4762936320
> Reserved block count:     0
> Overhead clusters:        37571453
> Free blocks:              568816097
> Free inodes:              594095660
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         4096
> Inode blocks per group:   256
> First meta block group:   1453
> Flex block group size:    16
> Filesystem created:       Tue Dec 16 03:26:32 2014
> Last mount time:          Tue Jun 13 08:54:33 2023
> Last write time:          Tue Jun 13 08:55:57 2023
> Mount count:              0
> Maximum mount count:      -1
> Last checked:             Tue Jun 13 08:55:57 2023
> Check interval:           0 (<none>)
> Lifetime writes:          145 TB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               256
> Required extra isize:     28
> Desired extra isize:      28
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      3e89594a-1c09-4c46-bb6e-402ad3d697b8
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0xa57a2ce7
> 
> -- dumpe2fs --
> 
> dumpe2fs 1.47.0 (5-Feb-2023)
> Filesystem volume name:   storage
> Last mounted on:          /srv/storage
> Filesystem UUID:          ad4e7e8d-f375-491f-a5dd-6251d32229e6
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr dir_index filetype meta_bg extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              595369984
> Block count:              4762936320
> Reserved block count:     0
> Overhead clusters:        37571453
> Free blocks:              568816097
> Free inodes:              594095660
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         4096
> Inode blocks per group:   256
> First meta block group:   1453
> Flex block group size:    16
> Filesystem created:       Tue Dec 16 03:26:32 2014
> Last mount time:          Tue Jun 13 08:54:33 2023
> Last write time:          Tue Jun 13 09:07:45 2023
> Mount count:              0
> Maximum mount count:      -1
> Last checked:             Tue Jun 13 09:07:45 2023
> Check interval:           0 (<none>)
> Lifetime writes:          145 TB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:	          256
> Required extra isize:     28
> Desired extra isize:      28
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      3e89594a-1c09-4c46-bb6e-402ad3d697b8
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0xf32a54d5
> Journal features:         journal_incompat_revoke journal_64bit journal_checksum_v3
> Total journal size:       128M
> Total journal blocks:     32768
> Max transaction length:   32768
> Fast commit length:       0
> Journal sequence:         0x0074096a
> Journal start:            0
> Journal checksum type:    crc32c
> Journal checksum:         0x478ec5ac
> 
> [... cut, the full dumpe2fs is ~60 MB, and even xz -9 compressed
>      still ~6 MB large ...]
> 
> Reverting (just) ad3f09be6cfe332be8ff46c78e6ec0f8839107aa from
> v6.4-rc6-27-ge328c473340c allows me to mount this filesystem again.
> 
> This seems to be the same issue as:
> https://bugzilla.kernel.org/show_bug.cgi?id=217534
> https://lkml.kernel.org/r/<17d7e7f8-ad8d-1696-32b7-3ff9fd4548c1@gmail.com>
> 
> Regards
> 	Stefan Lippers-Hollmann
> 

-- 
Best wishes
Kemeng Shi

