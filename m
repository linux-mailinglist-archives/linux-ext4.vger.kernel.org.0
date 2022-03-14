Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F44D7ACE
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Mar 2022 07:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiCNGap (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Mar 2022 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiCNGao (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Mar 2022 02:30:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95AE5FC5
        for <linux-ext4@vger.kernel.org>; Sun, 13 Mar 2022 23:29:34 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KH66Z4hkHzfYv7;
        Mon, 14 Mar 2022 14:28:06 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 14:29:32 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 14:29:32 +0800
Message-ID: <cf5601f9-8f98-a133-8c02-0208d4b70d17@huawei.com>
Date:   Mon, 14 Mar 2022 14:29:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [bug report] e2fsck: Error in deleting parent extent
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100006.china.huawei.com (7.185.36.169) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Tytso,
I find a error in ext2fs_extent_delete when node has no entries left.
A ext4 filesystem have a file whose extent looks like this:

debugfs: ex <950>
Level Entries Logical Physical Length Flags
0/ 1 1/ 1 102 - 102 32910 1
1/ 1 1/ 6 102 - 104 196802 - 196804 3
1/ 1 2/ 6 105 - 140 230934 - 230969 36
1/ 1 3/ 6 154 - 159 199322 - 199327 6
1/ 1 4/ 6 393 - 405 197123 - 197135 13
1/ 1 5/ 6 541 - 553 230439 - 230451 13
1/ 1 6/ 6 1058 - 1088 196640 - 196670 31

In the program, call scan_extent_node recursively to find the leaf entry 
of level 1,
the variable "problem" will be assigned PR_1_EXTENT_END_OUT_OF_BOUNDS
because the extent of level 0 has a problem with the range.
so the program thinks this extent is wronged and call 
ext2fs_extent_delete to delete it.
But when the entry is the last entry of level 1,
the program will run handle->level-- get parent entry and delete it in 
ext2fs_extent_delete.
However scan_extent_node is a recursive call, after the function returns,
handle->level is not restored to the value of the current 
level(handle->level is equal 0 new).
So calling ext2fs_extent_get(ehandle, EXT2_EXTENT_UP, &extent) again 
will return EXT2_ET_EXTENT_NO_UP,
and then print failed.

Command output:
[root@localhost ~]# e2fsck -a ram1gdb
ram1gdb: recovering journal
ram1gdb contains a file system with errors, check forced.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 102, physical block 196802, len 3)
CLEARED.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 105, physical block 230934, len 36)
CLEARED.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 154, physical block 199322, len 6)
CLEARED.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 393, physical block 197123, len 13)
CLEARED.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 541, physical block 230439, len 13)
CLEARED.
ram1gdb: Inode 950, end of extent exceeds allowed value
(logical block 1058, physical block 196640, len 31)
CLEARED.
ram1gdb: Failed to iterate extents in inode 950
(op EXT2_EXTENT_UP, blk 196640, lblk 1058): No 'up' extent
ram1gdb: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
(i.e., without -a or -p options)

/etc/e2fsck.conf:
[root@localhost ~]# cat /etc/e2fsck.conf
[problems]
...
0x01006e = {
preen_ok = true
}
...

gdb:
(gdb) p *handle
$17 = {magic = 2133571346, fs = 0x5555555c7430, ino = 950, inode = 
0x5555555bd6b0, inodebuf = {i_mode = 0, i_uid = 0, i_size = 0, i_atime = 
0, i_ctime = 0, i_mtime = 0, i_dtime = 0, i_gid = 0,
i_links_count = 0, i_blocks = 0, i_flags = 0, osd1 = {linux1 = 
{l_i_version = 0}, hurd1 = {h_i_translator = 0}}, i_block = {0 <repeats 
15 times>}, i_generation = 0, i_file_acl = 0, i_size_high = 0,
i_faddr = 0, osd2 = {linux2 = {l_i_blocks_hi = 0, l_i_file_acl_high = 0, 
l_i_uid_high = 0, l_i_gid_high = 0, l_i_checksum_lo = 0, l_i_reserved = 
0}, hurd2 = {h_i_frag = 0 '\000', h_i_fsize = 0 '\000',
h_i_mode_high = 0, h_i_uid_high = 0, h_i_gid_high = 0, h_i_author = 
0}}}, type = 62218, level = 0, max_depth = 1, max_paths = 2, path = 
0x5555555db8d0}
(gdb) bt
#0 ext2fs_extent_delete (handle=0x5555555db7d0, flags=0) at extent.c:1655
#1 0x000055555556c5f9 in scan_extent_node (ctx=0x5555555ab420, pctx=, 
pb=, start_block=102, end_block=102, eof_block=102, 
ehandle=0x5555555db7d0, try_repairs=1)
at pass1.c:2965
#2 0x000055555556c513 in scan_extent_node (ctx=0x5555555ab420, pctx=, 
pb=, start_block=0, end_block=0, eof_block=102, ehandle=0x5555555db7d0, 
try_repairs=1) at pass1.c:3048
#3 0x000055555556f0bf in check_blocks_extents (pb=0x7fffffffdbb0, 
pctx=0x7fffffffddf0, ctx=0x5555555ab420) at pass1.c:3279
#4 check_blocks (ctx=0x5555555ab420, pctx=0x7fffffffddf0, 
block_buf=0x5555555b4980 "", ea_ibody_quota=0x7fffffffdd90) at pass1.c:3402
#5 0x0000555555571693 in e2fsck_pass1 (ctx=0x5555555ab420) at pass1.c:1969
#6 0x000055555556921a in e2fsck_run (ctx=0x5555555ab420) at e2fsck.c:262
#7 0x0000555555564d6e in main (argc=, argv=) at unix.c:1922


regards,
Zhan Chengbin

