Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA8790BC9
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Sep 2023 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjICMAQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjICMAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 08:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32973C6;
        Sun,  3 Sep 2023 05:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9798C611BF;
        Sun,  3 Sep 2023 12:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D895BC433C7;
        Sun,  3 Sep 2023 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693742408;
        bh=ooi1guXjA+D27+7nG22HBgG5lzzdFZJw+iui0pknYsI=;
        h=Date:From:To:Cc:Subject:From;
        b=KJEX4fYOzowyEQOjuWHnHe1/8oeAYUTxTCK2GFRa1KF+DGzK5A0AQM3MHhpSk6wPZ
         0mkmvnn+g1LUiuiTZynv2Myn3q1Kp52FePricU+xhN2uDGIDM398izU0+8ZWlbWAuo
         1u98BQxuzhq2TaBgiJwi/01FYKcSLPgj1hfiadj9REBx51iWgsO2IzvYc6qk08coui
         SiWVPrTo8mJC5D25jLchcRI2rAfyFgKePZG3en/7cIwIM3tdC6yAgbj9BP8T+wvO2G
         St0/FVXlAkQcTDfmJ3+M9XStvux8SDf0jBcexAksvITiObV/NNxExxOTm9yCnrGlwA
         zqUG5PTggcLsA==
Date:   Sun, 3 Sep 2023 20:00:01 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     fstests@vger.kernel.org
Subject: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test
 fails
Message-ID: <20230903120001.qjv5uva2zaqthgk2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi ext4 folks,

Recently I found lots of fstests cases which belong to "recoveryloop" (e.g.
g/388 [1], g/455 [2], g/475 [3] and g/482 [4]) or does fs shutdown/resize test
(e.g. ext4/059 [5], g/530 [6]) failed ext4 with 1k blocksize, the kernel is
linux v6.6-rc0+ (HEAD=b84acc11b1c9).

I tested with MKFS_OPTIONS="-b 1024", no specific MOUNT_OPTIONS. I hit these
failure several times, and I didn't hit them on my last regression test on
v6.5-rc7+. So I think this might be a regression problem. And I didn't hit
this failures on xfs. If this's a known issue will be fixed soon, feel free
to tell me.

There's not .dmesg file, but I got part of related dmesg output as [7].

Thanks,
Zorro

[1]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

generic/388       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/388.out.bad)
    --- tests/generic/388.out	2023-09-01 18:42:54.987584713 -0400
    +++ /var/lib/xfstests/results//generic/388.out.bad	2023-09-02 03:01:15.475746583 -0400
    @@ -1,2 +1,5 @@
     QA output created by 388
     Silence is golden.
    +mount: /mnt/xfstests/scratch: mount(2) system call failed: Structure needs cleaning.
    +cycle mount failed
    +(see /var/lib/xfstests/results//generic/388.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/388.out /var/lib/xfstests/results//generic/388.out.bad'  to see the entire diff)
Ran: generic/388
Failures: generic/388
Failed 1 of 1 tests

[2]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

generic/455       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/455.out.bad)
    --- tests/generic/455.out	2023-09-01 18:42:58.775558885 -0400
    +++ /var/lib/xfstests/results//generic/455.out.bad	2023-09-02 04:05:54.867731920 -0400
    @@ -1,2 +1,4 @@
     QA output created by 455
    -Silence is golden
    +md5sum: /mnt/xfstests/scratch/testfile1: Structure needs cleaning
    +testfile1.mark8 md5sum mismatched
    +(see /var/lib/xfstests/results//generic/455.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/455.out /var/lib/xfstests/results//generic/455.out.bad'  to see the entire diff)
Ran: generic/455
Failures: generic/455
Failed 1 of 1 tests

[3]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

generic/475       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/475.out.bad)
    --- tests/generic/475.out	2023-09-01 18:42:59.847941016 -0400
    +++ /var/lib/xfstests/results//generic/475.out.bad	2023-09-02 04:19:05.105706247 -0400
    @@ -1,2 +1,6 @@
     QA output created by 475
     Silence is golden.
    +mount: /mnt/xfstests/scratch: cannot mount; probably corrupted filesystem on /dev/mapper/error-test.
    +mount failed
    +(see /var/lib/xfstests/results//generic/475.full for details)
    +umount: /mnt/xfstests/scratch: not mounted.
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/475.out /var/lib/xfstests/results//generic/475.out.bad'  to see the entire diff)
Ran: generic/475
Failures: generic/475
Failed 1 of 1 tests

[4]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

generic/482       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/482.out.bad)
    --- tests/generic/482.out	2023-09-01 18:43:00.246338844 -0400
    +++ /var/lib/xfstests/results//generic/482.out.bad	2023-09-02 05:23:00.179371438 -0400
    @@ -1,2 +1,3 @@
     QA output created by 482
    -Silence is golden
    +_check_generic_filesystem: filesystem on /dev/mapper/thin-vol is inconsistent
    +(see /var/lib/xfstests/results//generic/482.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/482.out /var/lib/xfstests/results//generic/482.out.bad'  to see the entire diff)
Ran: generic/482
Failures: generic/482
Failed 1 of 1 tests

[5]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

ext4/059       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//ext4/059.out.bad)
    --- tests/ext4/059.out	2023-09-01 18:41:56.462732307 -0400
    +++ /var/lib/xfstests/results//ext4/059.out.bad	2023-09-01 19:27:23.435239204 -0400
    @@ -1,2 +1,5 @@
     QA output created by 059
     Reserved GDT blocks:      100
    +mount: /mnt/xfstests/scratch: mount(2) system call failed: Structure needs cleaning.
    +mount -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch failed
    +(see /var/lib/xfstests/results//ext4/059.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/ext4/059.out /var/lib/xfstests/results//ext4/059.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      b55c3cd102a6 ext4: add reserved GDT blocks check

Ran: ext4/059
Failures: ext4/059
Failed 1 of 1 tests

[6]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385pg8-09 6.5.0+ #1 SMP PREEMPT_DYNAMIC Fri Sep  1 17:48:42 EDT 2023
MKFS_OPTIONS  -- -F -b 1024 /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

generic/530       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/530.out.bad)
    --- tests/generic/530.out	2023-09-01 18:43:02.968101577 -0400
    +++ /var/lib/xfstests/results//generic/530.out.bad	2023-09-02 05:40:51.047479015 -0400
    @@ -1,2 +1,5 @@
     QA output created by 530
     silence is golden
    +mount: /mnt/xfstests/scratch: mount(2) system call failed: Structure needs cleaning.
    +mount -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch failed
    +(see /var/lib/xfstests/results//generic/530.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/530.out /var/lib/xfstests/results//generic/530.out.bad'  to see the entire diff)
Ran: generic/530
Failures: generic/530
Failed 1 of 1 tests


[7]
# dmesg
[ 3881.516118] run fstests ext4/059 at 2023-09-01 19:27:19 
[ 3884.695217] EXT4-fs (sda4): failed to initialize system zone (-117) 
[ 3884.696103] EXT4-fs (sda4): mount failed 
[ 3884.888820] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[ 3885.757259] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none. 
[ 3907.019968] EXT4-fs (sda4): mounted filesystem 0336869b-572b-4e59-b73e-ac93af30fe2b r/w with ordered data mode. Quota mode: none. 
[ 3907.048644] EXT4-fs (sda4): unmounting filesystem 0336869b-572b-4e59-b73e-ac93af30fe2b. 
[ 3907.221590] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[ 3907.864579] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none.
...
...
[35741.177294] run fstests generic/475 at 2023-09-02 04:18:20 
[35748.598756] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35750.773819] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 880, block_bitmap = 7208961 
[35750.774700] Buffer I/O error on dev dm-0, logical block 36, lost async page write 
[35750.774812] Aborting journal on device dm-0-8. 
[35750.774984] EXT4-fs error (device dm-0) in ext4_iomap_alloc:3320: IO failure 
[35750.775304] Buffer I/O error on dev dm-0, logical block 7741441, lost sync page write 
[35750.775411] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35750.776103] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35750.776387] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 880, block_bitmap = 7208961 
[35750.777034] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35750.777075] EXT4-fs (dm-0): I/O error while writing superblock 
[35750.777241] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35750.777256] EXT4-fs (dm-0): I/O error while writing superblock 
[35750.777728] Buffer I/O error on dev dm-0, logical block 106, lost async page write 
[35750.777770] Buffer I/O error on dev dm-0, logical block 386, lost async page write 
[35750.777813] Buffer I/O error on dev dm-0, logical block 4456450, lost async page write 
[35750.777856] Buffer I/O error on dev dm-0, logical block 4456465, lost async page write 
[35750.777936] Buffer I/O error on dev dm-0, logical block 4456481, lost async page write 
[35750.777966] Buffer I/O error on dev dm-0, logical block 4456482, lost async page write 
[35750.778006] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35750.780652] EXT4-fs (dm-0): I/O error while writing superblock 
[35750.781201] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35750.781507] EXT4-fs (dm-0): Remounting filesystem read-only 
[35750.793993] EXT4-fs (dm-0): I/O error while writing superblock 
[35750.794092] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35750.795498] EXT4-fs (dm-0): I/O error while writing superblock 
[35751.812380] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35752.695235] EXT4-fs (dm-0): 1 truncate cleaned up 
[35752.696080] EXT4-fs (dm-0): recovery complete 
[35752.735519] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35752.867597] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278557 starting block 4472833) 
[35752.867605] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35752.868078] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35752.868296] buffer_io_error: 640 callbacks suppressed 
[35752.868301] Buffer I/O error on device dm-0, logical block 4472833 
[35752.868634] Aborting journal on device dm-0-8. 
[35752.870097] Buffer I/O error on device dm-0, logical block 4472834 
[35752.870105] Buffer I/O error on device dm-0, logical block 4472835 
[35752.870935] Buffer I/O error on device dm-0, logical block 4472836 
[35752.871229] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35752.871783] Buffer I/O error on device dm-0, logical block 4472837 
[35752.875031] Buffer I/O error on device dm-0, logical block 4472838 
[35752.876023] Buffer I/O error on device dm-0, logical block 4472839 
[35752.876851] Buffer I/O error on device dm-0, logical block 4472840 
[35752.877731] Buffer I/O error on device dm-0, logical block 4472841 
[35752.878442] Buffer I/O error on device dm-0, logical block 4472842 
[35752.879453] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245782 starting block 3940356) 
[35752.880460] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245781 starting block 67688) 
[35752.881433] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245785 starting block 71774) 
[35752.882247] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245785 starting block 71834) 
[35752.882991] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245785 starting block 72821) 
[35752.882999] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35752.884013] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245784 starting block 75471) 
[35752.884651] EXT4-fs (dm-0): I/O error while writing superblock 
[35752.885399] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35752.885839] EXT4-fs (dm-0): Remounting filesystem read-only 
[35753.601844] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35754.100398] EXT4-fs (dm-0): recovery complete 
[35754.101096] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35756.265146] Aborting journal on device dm-0-8. 
[35756.265859] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35756.265878] buffer_io_error: 24 callbacks suppressed 
[35756.265884] Buffer I/O error on dev dm-0, logical block 7741441, lost sync page write 
[35756.266024] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35756.267187] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35756.268590] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35756.272124] EXT4-fs (dm-0): I/O error while writing superblock 
[35756.272185] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35756.272913] EXT4-fs (dm-0): Remounting filesystem read-only 
[35756.273425] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35756.274712] EXT4-fs (dm-0): I/O error while writing superblock 
[35756.332216] Buffer I/O error on dev dm-0, logical block 15728576, async page read 
[35756.333139] Buffer I/O error on dev dm-0, logical block 15728577, async page read 
[35756.334151] Buffer I/O error on dev dm-0, logical block 15728578, async page read 
[35756.335046] Buffer I/O error on dev dm-0, logical block 15728579, async page read 
[35757.122800] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35757.947682] EXT4-fs (dm-0): recovery complete 
[35757.957726] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35760.241303] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278589 starting block 1346794) 
[35760.242054] buffer_io_error: 432 callbacks suppressed 
[35760.242059] Buffer I/O error on device dm-0, logical block 1346794 
[35760.243052] Buffer I/O error on device dm-0, logical block 1346795 
[35760.243764] Buffer I/O error on device dm-0, logical block 1346796 
[35760.244551] Buffer I/O error on device dm-0, logical block 1346797 
[35760.245262] Buffer I/O error on device dm-0, logical block 1346798 
[35760.246193] Buffer I/O error on device dm-0, logical block 1346799 
[35760.246912] Buffer I/O error on device dm-0, logical block 1346800 
[35760.247661] Buffer I/O error on device dm-0, logical block 1346801 
[35760.248645] Buffer I/O error on device dm-0, logical block 1346802 
[35760.249395] Buffer I/O error on device dm-0, logical block 1346803 
[35760.250335] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278597 starting block 1433857) 
[35760.251113] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278598 starting block 13692220) 
[35760.251986] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278599 starting block 4465588) 
[35760.252883] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278597 starting block 1349627) 
[35760.253656] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278597 starting block 1436065) 
[35760.254404] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278597 starting block 1436609) 
[35760.255264] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278595 starting block 1451398) 
[35760.256777] Buffer I/O error on dev dm-0, logical block 7743076, lost sync page write 
[35760.259850] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35760.260914] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35760.262186] Aborting journal on device dm-0-8. 
[35760.262918] Buffer I/O error on dev dm-0, logical block 7741441, lost sync page write 
[35760.262920] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35760.263669] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35760.265606] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35760.266729] EXT4-fs (dm-0): I/O error while writing superblock 
[35760.267488] EXT4-fs (dm-0): Remounting filesystem read-only 
[35761.130037] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35762.001088] EXT4-fs (dm-0): recovery complete 
[35762.011888] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35764.250404] buffer_io_error: 4 callbacks suppressed 
[35764.250414] Buffer I/O error on dev dm-0, logical block 13631542, lost async page write 
[35764.251619] Buffer I/O error on dev dm-0, logical block 13631545, lost async page write 
[35764.252131] Buffer I/O error on dev dm-0, logical block 13633590, lost async page write 
[35764.253503] EXT4-fs error (device dm-0): __ext4_find_entry:1678: inode #852043: comm fsstress: reading directory lblock 0 
[35764.253527] Buffer I/O error on dev dm-0, logical block 13633594, lost async page write 
[35764.254920] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35764.255800] Aborting journal on device dm-0-8. 
[35764.256566] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852052 starting block 110737) 
[35764.257236] Buffer I/O error on dev dm-0, logical block 7741441, lost sync page write 
[35764.258505] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35764.258511] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35764.259064] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35764.259288] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35764.259360] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35764.259580] EXT4-fs (dm-0): ext4_do_writepages: jbd2_start: 2017 pages, ino 852052; err -5 
[35764.260286] EXT4-fs (dm-0): I/O error while writing superblock 
[35764.261228] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35764.264422] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35764.265664] EXT4-fs (dm-0): I/O error while writing superblock 
[35764.265675] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35764.266523] EXT4-fs (dm-0): Remounting filesystem read-only 
[35764.267096] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35764.268115] EXT4-fs (dm-0): I/O error while writing superblock 
[35764.321584] Buffer I/O error on dev dm-0, logical block 15728576, async page read 
[35764.322502] Buffer I/O error on dev dm-0, logical block 15728577, async page read 
[35765.112893] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35765.955813] EXT4-fs (dm-0): recovery complete 
[35765.961733] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35767.098045] Aborting journal on device dm-0-8. 
[35767.098835] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35767.099371] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35767.101491] EXT4-fs (dm-0): I/O error while writing superblock 
[35767.102259] EXT4-fs (dm-0): Remounting filesystem read-only 
[35767.855929] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35768.570841] EXT4-fs (dm-0): recovery complete 
[35768.576985] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35768.725066] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 174, block_bitmap = 1310735 
[35768.725934] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 175, block_bitmap = 1310736 
[35768.726066] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35768.726822] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35768.727049] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm kworker/u50:1: Cannot read block bitmap - block_group = 174, block_bitmap = 1310735 
[35768.727104] Aborting journal on device dm-0-8. 
[35768.727203] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm kworker/u50:1: Cannot read block bitmap - block_group = 175, block_bitmap = 1310736 
[35768.727665] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852010 starting block 1332745) 
[35768.727749] buffer_io_error: 522 callbacks suppressed 
[35768.727760] Buffer I/O error on device dm-0, logical block 1332745 
[35768.727776] Buffer I/O error on device dm-0, logical block 1332746 
[35768.727819] Buffer I/O error on device dm-0, logical block 1332747 
[35768.727832] Buffer I/O error on device dm-0, logical block 1332748 
[35768.727976] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 174, block_bitmap = 1310735 
[35768.729159] Buffer I/O error on device dm-0, logical block 1332749 
[35768.729169] Buffer I/O error on device dm-0, logical block 1332750 
[35768.729176] Buffer I/O error on device dm-0, logical block 1332751 
[35768.729183] Buffer I/O error on device dm-0, logical block 1332752 
[35768.729201] Buffer I/O error on device dm-0, logical block 1332753 
[35768.729210] Buffer I/O error on device dm-0, logical block 1332754 
[35768.729307] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35768.729343] EXT4-fs (dm-0): I/O error while writing superblock 
[35768.729446] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35768.730981] EXT4-fs (dm-0): I/O error while writing superblock 
[35768.732162] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35768.732429] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852010 starting block 1360623) 
[35768.734186] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35768.734807] EXT4-fs (dm-0): I/O error while writing superblock 
[35768.746665] EXT4-fs (dm-0): Remounting filesystem read-only 
[35769.449359] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35769.949999] EXT4-fs (dm-0): recovery complete 
[35769.950713] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35772.084650] Aborting journal on device dm-0-8. 
[35772.085397] buffer_io_error: 25 callbacks suppressed 
[35772.085401] Buffer I/O error on dev dm-0, logical block 7741441, lost sync page write 
[35772.085653] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35772.086186] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35772.086677] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35772.086693] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35772.086935] Buffer I/O error on dev dm-0, logical block 4498087, async page read 
[35772.087180] Buffer I/O error on dev dm-0, logical block 4498088, async page read 
[35772.087307] Buffer I/O error on dev dm-0, logical block 4498087, async page read 
[35772.087350] Buffer I/O error on dev dm-0, logical block 4498088, async page read 
[35772.087416] Buffer I/O error on dev dm-0, logical block 4498087, async page read 
[35772.087458] Buffer I/O error on dev dm-0, logical block 4498088, async page read 
[35772.088077] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35772.088208] EXT4-fs (dm-0): I/O error while writing superblock 
[35772.088216] EXT4-fs (dm-0): Remounting filesystem read-only 
[35772.088222] EXT4-fs (dm-0): ext4_do_writepages: jbd2_start: 9223372036854775807 pages, ino 278631; err -30 
[35772.088611] Buffer I/O error on dev dm-0, logical block 1, lost sync page write 
[35772.088755] Buffer I/O error on dev dm-0, logical block 13762562, lost async page write 
[35772.090413] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35772.100864] EXT4-fs (dm-0): I/O error while writing superblock 
[35772.100885] EXT4-fs (dm-0): I/O error while writing superblock 
[35772.956603] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35773.824386] EXT4-fs (dm-0): 3 truncates cleaned up 
[35773.825283] EXT4-fs (dm-0): recovery complete 
[35773.915764] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35775.102896] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278633 starting block 13779933) 
[35775.104737] buffer_io_error: 179 callbacks suppressed 
[35775.104741] Buffer I/O error on device dm-0, logical block 13779933 
[35775.105788] Buffer I/O error on device dm-0, logical block 13779934 
[35775.106532] Buffer I/O error on device dm-0, logical block 13779935 
[35775.107435] Buffer I/O error on device dm-0, logical block 13779936 
[35775.108894] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35775.108995] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 112, block_bitmap = 917505 
[35775.109139] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 112, block_bitmap = 917505 
[35775.114548] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278633 starting block 13779844) 
[35775.115472] Buffer I/O error on device dm-0, logical block 13779844 
[35775.115991] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 240, block_bitmap = 1966081 
[35775.116622] Buffer I/O error on device dm-0, logical block 13779845 
[35775.117877] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 240, block_bitmap = 1966081 
[35775.118554] Buffer I/O error on device dm-0, logical block 13779846 
[35775.118564] Buffer I/O error on device dm-0, logical block 13779847 
[35775.118610] Buffer I/O error on device dm-0, logical block 13779848 
[35775.121950] Buffer I/O error on device dm-0, logical block 13779849 
[35775.123055] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35775.123888] Aborting journal on device dm-0-8. 
[35775.124056] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278642 starting block 13813397) 
[35775.124597] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm ext4lazyinit: Cannot read block bitmap - block_group = 368, block_bitmap = 3014657 
[35775.124660] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35775.124889] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35775.125051] EXT4-fs (dm-0): I/O error while writing superblock 
[35775.125062] EXT4-fs (dm-0): Remounting filesystem read-only 
[35775.125374] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35775.125427] EXT4-fs (dm-0): ext4_do_writepages: jbd2_start: 1014 pages, ino 278642; err -5 
[35775.126753] EXT4-fs (dm-0): I/O error while writing superblock 
[35775.904912] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35776.701465] EXT4-fs (dm-0): 1 truncate cleaned up 
[35776.702282] EXT4-fs (dm-0): recovery complete 
[35776.755936] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35776.884339] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 482, block_bitmap = 3932163 
[35776.884347] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 13748970) 
[35776.886429] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 4345) 
[35776.887849] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 4790) 
[35776.888106] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 482, block_bitmap = 3932163 
[35776.890080] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 482, block_bitmap = 3932163 
[35776.890315] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278650 starting block 10873) 
[35776.893040] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278650 starting block 10957) 
[35776.893793] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278650 starting block 11107) 
[35776.895056] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35776.895080] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:224: comm fsstress: Error while async write back metadata 
[35776.895475] Aborting journal on device dm-0-8. 
[35776.897553] EXT4-fs error (device dm-0) in ext4_evict_inode:226: Journal has aborted 
[35776.897586] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35776.897625] EXT4-fs (dm-0): I/O error while writing superblock 
[35776.897811] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35776.898653] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35776.901252] EXT4-fs (dm-0): I/O error while writing superblock 
[35776.901319] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35776.902063] EXT4-fs (dm-0): Remounting filesystem read-only 
[35776.902587] EXT4-fs (dm-0): I/O error while writing superblock 
[35777.627679] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35778.121113] EXT4-fs (dm-0): recovery complete 
[35778.121802] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35779.238712] buffer_io_error: 49 callbacks suppressed 
[35779.238723] Buffer I/O error on dev dm-0, logical block 1313739, async page read 
[35779.238733] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 1686, block_bitmap = 13762567 
[35779.239110] Buffer I/O error on dev dm-0, logical block 1313740, async page read 
[35779.240108] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 1686, block_bitmap = 13762567 
[35779.240590] Buffer I/O error on dev dm-0, logical block 1313741, async page read 
[35779.241712] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 1686, block_bitmap = 13762567 
[35779.242346] Buffer I/O error on dev dm-0, logical block 1313739, async page read 
[35779.243136] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 92365) 
[35779.243453] EXT4-fs error (device dm-0): ext4_wait_block_bitmap:574: comm fsstress: Cannot read block bitmap - block_group = 1686, block_bitmap = 13762567 
[35779.244019] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 13824120) 
[35779.244469] Buffer I/O error on dev dm-0, logical block 1313740, async page read 
[35779.244595] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 95858) 
[35779.245083] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 13822300) 
[35779.245604] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245878 starting block 13822412) 
[35779.245953] Buffer I/O error on dev dm-0, logical block 1313741, async page read 
[35779.247758] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 82042 starting block 90126) 
[35779.248602] Buffer I/O error on dev dm-0, logical block 67279, async page read 
[35779.249249] Buffer I/O error on dev dm-0, logical block 1313739, async page read 
[35779.249295] Buffer I/O error on dev dm-0, logical block 1313740, async page read 
[35779.249337] Buffer I/O error on dev dm-0, logical block 1313741, async page read 
[35779.249636] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 82042 starting block 13828097) 
[35779.254841] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 278652 starting block 13828235) 
[35779.256038] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 82042 starting block 1352691) 
[35779.257868] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 82042 starting block 1352797) 
[35779.285144] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35779.286248] Aborting journal on device dm-0-8. 
[35779.286976] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35779.28741 
[35779.316758] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35779.316763] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35779.316920] EXT4-fs (dm-0): I/O error while writing superblock 
[35779.316929] EXT4-fs (dm-0): Remounting filesystem read-only 
[35779.317280] EXT4-fs (dm-0): I/O error while writing superblock 
[35779.566358] EXT4-fs (dm-0): I/O error while writing superblock 
[35779.788181] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35779.793029] EXT4-fs (dm-0): I/O error while writing superblock 
[35780.027305] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35780.766503] EXT4-fs (dm-0): recovery complete 
[35780.778784] EXT4-fs (dm-0): mounted filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a r/w with ordered data mode. Quota mode: none. 
[35776.608309] restraintd[1442]: *** Current Time: Sat Sep 02 04:19:01 2023  Localwatchdog at: Sun Sep 03 18:30:59 2023 
[35782.983326] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245908 starting block 4480114) 
[35782.983983] buffer_io_error: 2689 callbacks suppressed 
[35782.983987] Buffer I/O error on device dm-0, logical block 4480114 
[35782.985012] Buffer I/O error on device dm-0, logical block 4480115 
[35782.985743] Buffer I/O error on device dm-0, logical block 4480116 
[35782.986500] Buffer I/O error on device dm-0, logical block 4480117 
[35782.987204] Buffer I/O error on device dm-0, logical block 4480118 
[35782.988169] Buffer I/O error on device dm-0, logical block 4480119 
[35782.988920] Buffer I/O error on device dm-0, logical block 4480120 
[35782.991085] Buffer I/O error on device dm-0, logical block 4480121 
[35782.991848] Buffer I/O error on device dm-0, logical block 4480122 
[35782.992589] Buffer I/O error on device dm-0, logical block 4480123 
[35782.993532] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245921 starting block 3940559) 
[35782.994339] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 245786 starting block 4487680) 
[35782.995696] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852108 starting block 4741) 
[35782.996400] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852108 starting block 18945) 
[35782.998202] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852108 starting block 18946) 
[35782.999189] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852116 starting block 13640449) 
[35783.000337] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852101 starting block 4764) 
[35783.001289] EXT4-fs warning (device dm-0): ext4_end_bio:343: I/O error 10 writing to inode 852101 starting block 2472) 
[35783.002165] JBD2: Detected IO errors while flushing file data on dm-0-8 
[35783.003955] Aborting journal on device dm-0-8. 
[35783.004891] JBD2: I/O error when updating journal superblock for dm-0-8. 
[35783.005135] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35783.006191] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35783.006241] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm fsstress: Detected aborted journal 
[35783.007698] EXT4-fs (dm-0): I/O error while writing superblock 
[35783.007724] EXT4-fs (dm-0): previous I/O error to superblock detected 
[35783.007787] EXT4-fs (dm-0): I/O error while writing superblock 
[35783.007794] EXT4-fs (dm-0): Remounting filesystem read-only 
[35783.008496] EXT4-fs (dm-0): I/O error while writing superblock 
[35783.818178] EXT4-fs (dm-0): unmounting filesystem 51750a3d-e318-429d-b9c1-c22ff9df118a. 
[35784.346930] JBD2: Invalid checksum recovering data block 3932226 in log 
[35784.347399] JBD2: Invalid checksum recovering data block 106 in log 
[35784.585695] JBD2: journal recovery failed 
[35784.585948] EXT4-fs (dm-0): error loading journal 
[35785.236143] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[35786.132607] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none. 
[35808.615912] EXT4-fs (sda4): mounted filesystem 430aa3b6-d8c9-4f40-bf82-ca4eb95d3fa4 r/w with ordered data mode. Quota mode: none. 
[35808.646741] EXT4-fs (sda4): unmounting filesystem 430aa3b6-d8c9-4f40-bf82-ca4eb95d3fa4. 
[35808.828231] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[35810.181984] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none.
...
...
[39556.971012] run fstests generic/482 at 2023-09-02 05:21:56 
[39559.921158] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[39556.453564] restraintd[1442]: *** Current Time: Sat Sep 02 05:22:01 2023  Localwatchdog at: Sun Sep 03 18:30:59 2023 
[39561.860720] device-mapper: thin: Data device (dm-1) discard unsupported: Disabling discard passdown. 
[39563.789077] EXT4-fs (dm-4): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39603.557128] EXT4-fs (dm-4): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39606.319914] EXT4-fs (dm-3): recovery complete 
[39606.320624] EXT4-fs (dm-3): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39606.350151] EXT4-fs (dm-3): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39609.086581] EXT4-fs (dm-3): recovery complete 
[39609.091906] EXT4-fs (dm-3): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39609.119662] EXT4-fs (dm-3): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39611.692319] EXT4-fs (dm-3): 3 truncates cleaned up 
[39611.693012] EXT4-fs (dm-3): recovery complete 
[39611.764112] EXT4-fs (dm-3): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39611.792213] EXT4-fs (dm-3): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39614.643226] EXT4-fs (dm-3): 3 truncates cleaned up 
[39614.644018] EXT4-fs (dm-3): recovery complete 
[39614.712002] EXT4-fs (dm-3): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39614.740515] EXT4-fs (dm-3): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39618.096068] EXT4-fs (dm-3): 1 truncate cleaned up 
[39618.096797] EXT4-fs (dm-3): recovery complete 
[39618.144804] EXT4-fs (dm-3): mounted filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc r/w with ordered data mode. Quota mode: none. 
[39618.172712] EXT4-fs (dm-3): unmounting filesystem d62704f7-00be-4efd-aeb0-d2b7dd203ccc. 
[39621.077674] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none. 
[39616.192949] restraintd[1442]: *** Current Time: Sat Sep 02 05:23:01 2023  Localwatchdog at: Sun Sep 03 18:30:59 2023 
[39643.279212] EXT4-fs (sda4): mounted filesystem 1918324a-858b-4e7a-b0cd-1c5c046c1cf8 r/w with ordered data mode. Quota mode: none. 
[39643.310140] EXT4-fs (sda4): unmounting filesystem 1918324a-858b-4e7a-b0cd-1c5c046c1cf8. 
[39643.502308] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[39645.142999] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none.
...
...
[40656.609079] run fstests generic/530 at 2023-09-02 05:40:16 
[40663.063496] EXT4-fs (sda4): mounted filesystem 3da3ed7c-69ef-490b-963e-4538c3fe6901 r/w with ordered data mode. Quota mode: none. 
[40663.091672] EXT4-fs (sda4): shut down requested (1) 
[40663.092370] Aborting journal on device sda4-8. 
[40663.129520] EXT4-fs (sda4): unmounting filesystem 3da3ed7c-69ef-490b-963e-4538c3fe6901. 
[40667.471901] EXT4-fs (sda4): mounted filesystem 645d073f-24ff-487a-9594-c7d5d0549857 r/w with ordered data mode. Quota mode: none. 
[40681.753309] EXT4-fs (sda4): shut down requested (1) 
[40682.024481] Aborting journal on device sda4-8. 
[40688.769049] EXT4-fs (sda4): unmounting filesystem 645d073f-24ff-487a-9594-c7d5d0549857. 
[40690.222805] EXT4-fs error (device sda4): ext4_map_blocks:577: inode #8: block 7746285: comm mount: lblock 4844 mapped to illegal pblock 7746285 (length 1) 
[40690.232307] EXT4-fs (sda4): journal bmap failed: block 4844 ret -117 
[40690.232307]  
[40690.233018] JBD2: bad block at offset 4844 
[40690.513437] JBD2: journal recovery failed 
[40690.532275] EXT4-fs (sda4): error loading journal 
[40690.953437] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[40691.888572] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none. 
[40696.498115] restraintd[1442]: *** Current Time: Sat Sep 02 05:41:01 2023  Localwatchdog at: Sun Sep 03 18:30:59 2023 
[40711.632595] EXT4-fs (sda4): mounted filesystem d56c4efe-3755-47f0-abaf-e76215955957 r/w with ordered data mode. Quota mode: none. 
[40711.663482] EXT4-fs (sda4): unmounting filesystem d56c4efe-3755-47f0-abaf-e76215955957. 
[40711.845424] EXT4-fs (sda5): unmounting filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97. 
[40713.200627] EXT4-fs (sda5): mounted filesystem 8c07d08e-4e8d-4551-94f7-1fbf38d84d97 r/w with ordered data mode. Quota mode: none.
...
