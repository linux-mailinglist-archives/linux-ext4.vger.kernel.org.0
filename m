Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5856B7BF734
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Oct 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjJJJXD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJJJWl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 05:22:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD9FD8
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 02:21:50 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qq8w0-0003LX-1T; Tue, 10 Oct 2023 11:21:48 +0200
Message-ID: <c9632187-bcbc-483f-8b18-1fa403b46ebb@leemhuis.info>
Date:   Tue, 10 Oct 2023 11:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Content-Language: en-US, de-DE
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Andres Freund <andres@anarazel.de>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
 <ZQjKOjrjDYsoXBXj@mit.edu>
 <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
 <20231003232505.GA444157@mit.edu>
 <20231004004247.zkswbseowwwc6vvk@alap3.anarazel.de>
 <604bc623-a090-005b-cbfc-39805a8a7b20@collabora.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <604bc623-a090-005b-cbfc-39805a8a7b20@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696929711;4a8d09ea;
X-HE-SMSGID: 1qq8w0-0003LX-1T
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 05.10.23 11:04, Shreeya Patel wrote:
> On 04/10/23 06:12, Andres Freund wrote:
>> On 2023-10-03 19:25:05 -0400, Theodore Ts'o wrote:
>>> On Tue, Oct 03, 2023 at 07:11:38AM -0700, Andres Freund wrote:
>>>> On 2023-09-18 18:07:54 -0400, Theodore Ts'o wrote:
>>>>> On Mon, Sep 18, 2023 at 08:13:30PM +0530, Shreeya Patel wrote:
>>>>>> When I tried to reproduce this issue on mainline linux kernel
>>>>>> using the
>>>>>> reproducer provided by syzbot, I see an endless loop of following
>>>>>> errors :-
>>>>>>
>>>>>> [   89.689751][ T3922] loop1: detected capacity change from 0 to 512
>>>>>> [   89.690514][ T3916] EXT4-fs error (device loop4):
>>>>>> ext4_map_blocks:577:
>>>>>> inode #3: block 9: comm poc: lblock 0 mapped to illegal pblock 9
>>>>>> (length 1)
>>>>>> [   89.694709][ T3890] EXT4-fs error (device loop0):
>>>>>> ext4_map_blocks:577:
>>>>> Please note that maliciously corrupted file system is considered low
>>>>> priority by ext4 developers.
>>>> FWIW, I am seeing occasional hangs in ext4_fallocate with 6.6-rc4 as
>>>> well,
>>>> just doing database development on my laptop.
>>> Unless you are using a corrupted file system (e.g., there are EXT4-fs
>>> error messages in dmesg), it's likely a different issue.
>> Indeed quite possibly unrelated - the only reason that I mentioned it
>> here was
>> the fact that so far I've only hit it in 6.6-rc*, not earlier.
> 
> Since the issue that I reported is not reproducable locally, to confirm
> if it happens on the mainline kernel or not,
> we did a #syz test: https://github.com/torvalds/linux master
> 
> But it wasn't reproduced on the mainline kernel so it is very unlikely
> that the issue you are seeing is same as this one.

Shreeya Patel, Andres Freund, please help me out here, as this
regression is in the list of tracked issues, but I'm a bit lost about
the state of things:

Shreeya Patel: if I understand what you wrote above right the issue
(which maybe only happened with a maliciously corrupted fs, which is
kinda unsupported) doesn't happen anymore? Then I guess I can remove
this thread from the tracking. That being said:

Andres Freund: as it seems you have a different issue, have you or
somebody else done anything to get us closer to a solution (like a
bisection)? Doesn't look like it, but it's quite possible that I missed
something. I just want to ensure that this is not lost if you care about
the problems you encountered; makes we wonder if reporting it separately
(e.g. in a new thread) might be wise.

Ciao, Thorsten


>> I've since then "downgraded" to 6.5.5, without hitting the issue so far,
>> despite continuing to run a similar workload for most of the day.
>>
>> I did actually find ext4 messages in dmesg, but only during the latest
>> boot
>> into 6.5.5, despite encountering the hang four times (resolved via
>> reboot each
>> time).
>>
>> Oct 03 07:35:16 alap5 kernel: Linux version
>> 6.5.5-andres-00001-g97e7c1c17aa1 (andres@alap5) (gcc (Debian 13.2.0-4)
>> 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #76 SMP PREEMPT_DYNAMIC
>> Tue Oct  3 07:29:10 PDT 2023
>> Oct 03 07:35:16 alap5 kernel: Command line:
>> BOOT_IMAGE=/vmlinuz-6.5.5-andres-00001-g97e7c1c17aa1
>> root=/dev/mapper/alap5-root ro apparmor=0 rd.luks.options=discard
>> systemd.show_status=1 i915.fastboot=1 i915.modeset=1
>> psmouse.synaptics_intertouch=1 systemd.unified_cgroup_hierarchy
>> nvme.poll_queues=2 nvme.write_queues=2 intel_iommu=sm_on,igfx_off
>> iommu=pt
>> ...
>> Oct 03 07:35:17 alap5 systemd[1]: Starting
>> systemd-fsck@dev-disk-by\x2duuid-b77a2f23\x2dbb0d\x2d48bf\x2d8c36\x2d327c73460cb8.service - File System Check on /dev/disk/by-uuid/b77a2f23-bb0d-48bf-8c36-327c73460cb8...
>> ...
>> Oct 03 07:35:17 alap5 systemd-fsck[705]: /dev/nvme1n1p1: recovering
>> journal
>> ...
>> Oct 03 07:35:17 alap5 systemd-fsck[705]: /dev/nvme1n1p1: clean,
>> 90863/122101760 files, 110935625/488378368 blocks
>> Oct 03 07:35:17 alap5 systemd[1]: Finished
>> systemd-fsck@dev-disk-by\x2duuid-b77a2f23\x2dbb0d\x2d48bf\x2d8c36\x2d327c73460cb8.service - File System Check on /dev/disk/by-uuid/b77a2f23-bb0d-48bf-8c36-327c73460cb8.
>> ...
>> Oct 03 07:35:18 alap5 kernel: EXT4-fs (nvme1n1p1): mounted filesystem
>> b77a2f23-bb0d-48bf-8c36-327c73460cb8 r/w with ordered data mode. Quota
>> mode: none.
>> ...
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 2240, len 32000; IO logical block 2240, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 4288, len 29952; IO logical block 4288, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 6336, len 27904; IO logical block 6336, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 8384, len 25856; IO logical block 8384, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 10432, len 23808; IO logical block 10432, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 12480, len 21760; IO logical block 12480, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 14528, len 19712; IO logical block 14528, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 16576, len 17664; IO logical block 16576, len 2048
>> Oct 03 07:38:09 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984794) finished:
>> extent logical block 18624, len 15616; IO logical block 18624, len 320
>> Oct 03 07:38:11 alap5 kernel: wl0: disconnect from AP
>> 04:62:73:d2:2f:ff for new auth to fc:5b:39:c6:6e:9f
>> ...
>> Oct 03 07:38:11 alap5 kernel: wl0: Limiting TX power to 2 dBm as
>> advertised by fc:5b:39:c6:6e:9f
>> Oct 03 07:38:22 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984800) finished:
>> extent logical block 152080, len 9856; IO logical block 152080, len 2048
>> Oct 03 07:38:22 alap5 kernel: EXT4-fs warning (device nvme1n1p1):
>> ext4_convert_unwritten_extents_endio:3743: Inode (82984800) finished:
>> extent logical block 154128, len 7808; IO logical block 154128, len 768
>>
>> I'm somewhat surprised to see the "
>>
>>
>>> Can you give us details about (a) what kind of block device; are you
>>> using dm-crypt, or just a HDD or a SSD?  If an SSD, what kind of SSD?
>> NVMe, Samsung SSD 970 EVO Plus 2TB. No dm_crypt, raid or whatever.
>>
>> smartctl / nvme smart-log indicates no data correctness errors or
>> such. Not
>> that that's a guarantee of anything.
>>
>> A forced fsck doesn't find any corruption, but did report a number of
>> Inode 82984754 extent tree (at level 2) could be narrower.  Optimize<y>?
>> style "issues".
>>
>>
>>> What CPU architecture is it?
>> x86-64 (i9-9880H in a ThinkPad X1 Extreme 2nd). The laptop does have a
>> battery
>> that's not, uhm, perfect, anymore (turning off while supposedly still
>> having
>> around 15% capacity), so there have been a few out-of-power hard
>> "shutdowns".
>>
>>
>>> And can you send me the output of dumpe2fs -h <block device>?
>> dumpe2fs 1.47.0 (5-Feb-2023)
>> Filesystem volume name:   <none>
>> Last mounted on:          /srv
>> Filesystem UUID:          b77a2f23-bb0d-48bf-8c36-327c73460cb8
>> Filesystem magic number:  0xEF53
>> Filesystem revision #:    1 (dynamic)
>> Filesystem features:      has_journal ext_attr resize_inode dir_index
>> filetype needs_recovery extent 64bit flex_bg sparse_super large_file
>> huge_file dir_nlink extra_isize metadata_csum
>> Filesystem flags:         signed_directory_hash
>> Default mount options:    user_xattr acl
>> Filesystem state:         clean
>> Errors behavior:          Continue
>> Filesystem OS type:       Linux
>> Inode count:              122101760
>> Block count:              488378368
>> Reserved block count:     0
>> Overhead clusters:        7947216
>> Free blocks:              377442743
>> Free inodes:              122010897
>> First block:              0
>> Block size:               4096
>> Fragment size:            4096
>> Group descriptor size:    64
>> Reserved GDT blocks:      1024
>> Blocks per group:         32768
>> Fragments per group:      32768
>> Inodes per group:         8192
>> Inode blocks per group:   512
>> Flex block group size:    16
>> Filesystem created:       Thu Jan  2 20:13:09 2020
>> Last mount time:          Tue Oct  3 07:35:18 2023
>> Last write time:          Tue Oct  3 07:35:18 2023
>> Mount count:              3
>> Maximum mount count:      -1
>> Last checked:             Mon Oct  2 12:55:12 2023
>> Check interval:           0 (<none>)
>> Lifetime writes:          7662 GB
>> Reserved blocks uid:      0 (user root)
>> Reserved blocks gid:      0 (group root)
>> First inode:              11
>> Inode size:              256
>> Required extra isize:     32
>> Desired extra isize:      32
>> Journal inode:            8
>> Default directory hash:   half_md4
>> Directory Hash Seed:      03b91d34-4d2d-44b4-ac94-0c055f696e8a
>> Journal backup:           inode blocks
>> Checksum type:            crc32c
>> Checksum:                 0xbee0f98e
>> Journal features:         journal_incompat_revoke journal_64bit
>> journal_checksum_v3
>> Total journal size:       1024M
>> Total journal blocks:     262144
>> Max transaction length:   262144
>> Fast commit length:       0
>> Journal sequence:         0x0004f764
>> Journal start:            23369
>> Journal checksum type:    crc32c
>> Journal checksum:         0x66761981
>>
>>
>>> And while the file system is mounted, please send the contents of
>>> /proc/fs/<block-device>/options, e.g.:
>>>
>>> % cat /proc/fs/ext4/dm-0/options
>> cat /proc/fs/ext4/nvme1n1p1/options
>> rw
>> bsddf
>> nogrpid
>> block_validity
>> dioread_nolock
>> nodiscard
>> delalloc
>> nowarn_on_error
>> journal_checksum
>> barrier
>> auto_da_alloc
>> user_xattr
>> acl
>> noquota
>> resuid=0
>> resgid=0
>> errors=continue
>> commit=5
>> min_batch_time=0
>> max_batch_time=15000
>> stripe=0
>> data=ordered
>> inode_readahead_blks=32
>> init_itable=10
>> max_dir_size_kb=0
>>
>>> And finally, how full was the file system?  What is the output of "df
>>> <mountpoint>" and "df -i <mountpoint>".
>> root@alap5:/# df /srv/
>> Filesystem      1K-blocks      Used  Available Use% Mounted on
>> /dev/nvme1n1p1 1921724608 542905720 1378802504  29% /srv
>> root@alap5:/# df -i /srv/
>> Filesystem        Inodes IUsed     IFree IUse% Mounted on
>> /dev/nvme1n1p1 122101760 91292 122010468    1% /srv
>>
>>
>> However, fullness of this filesystem varies substantially over time,
>> as I use
>> it for developing / testing postgres, albeit primarily when
>> travelling.  I was
>> e.g. benchmarking bulk-loading of data (knowingly on a mediocre SSD)
>> at the
>> time of the last crash, space usage during that goes up by a few
>> hundred GB,
>> with the data being deleted afterwards.
>>
>> Greetings,
>>
>> Andres Freund
> 
> 
