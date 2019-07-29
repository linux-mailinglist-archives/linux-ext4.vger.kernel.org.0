Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8778A80
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2019 13:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfG2L15 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jul 2019 07:27:57 -0400
Received: from de1.gusev.co ([84.16.227.28]:37532 "EHLO mail.gusev.co"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbfG2L14 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jul 2019 07:27:56 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 07:27:54 EDT
Received: from [10.0.0.5] (78-57-160-222.static.zebra.lt [78.57.160.222])
        by mail.gusev.co (Postfix) with ESMTPSA id DEFF823D96;
        Mon, 29 Jul 2019 14:18:20 +0300 (EEST)
Subject: ext4 file system is constantly writing to the block device with no
 activity from the applications, is it a bug?
To:     "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>
Cc:     'Theodore Ts'o' <tytso@mit.edu>
References: <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com> <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu> <20190712191903.GP2772@twosigma.com>
 <20190712202827.GA16730@mit.edu>
 <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
 <865a6dad983e4dedb9836075c210a782@EXMBDFT11.ad.twosigma.com>
 <20190729100914.GB17833@quack2.suse.cz>
From:   Dmitrij Gusev <dmitrij@gusev.co>
Message-ID: <b19e976b-097e-0b94-23c3-e0f27a97a64c@gusev.co>
Date:   Mon, 29 Jul 2019 14:18:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729100914.GB17833@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello.

A ext4 file system is constantly writing to the block device with no 
activity from the applications, is it a bug?

Write speed is about 64k bytes (almost always exactly 64k bytes) per 
second every 1-2 seconds (I've discovered it after a RAID sync 
finished). Please the check activity log sample below.

I could not find out which process was writing constantly, so I rebooted 
to a rescue mode and mounted FS with no activity guaranteed - the same 
activity has started about at 64kB/s every 1-2 seconds.

The file system was created with the latest e2fsprogs, here are the details:

Linux nexus 4.19.62 #2 SMP Sun Jul 28 17:18:10 CDT 2019 x86_64 AMD 
Athlon(tm) Dual Core Processor 5050e AuthenticAMD GNU/Linux

# tune2fs -l /dev/<XXXXXXvg>/home
tune2fs 1.43.1 (08-Jun-2016)  // file system was created in other system 
with the latest version tools
Filesystem volume name:   home
Last mounted on:          /home
Filesystem UUID:          XXXXXXXXXXXXXXXXXX
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index 
filetype needs_recovery extent 64bit flex_bg sparse_super large_file 
huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              21644032
Block count:              2770432000
Reserved block count:     0
Free blocks:              2095699032
Free inodes:              21205431
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      726
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         256
Inode blocks per group:   16
RAID stride:              128
RAID stripe width:        384
Flex block group size:    16
Filesystem created:       Sat Jul 27 16:41:21 2019
Last mount time:          Mon Jul 29 13:47:33 2019
Last write time:          Mon Jul 29 13:47:33 2019
Mount count:              10
Maximum mount count:      -1
Last checked:             Sat Jul 27 16:41:21 2019
Check interval:           0 (<none>)
Lifetime writes:          2615 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      XXXXXXXXXXXXXXXXXXXXXXX
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x7f0fb170


BlockDev Activity log:

# iostat -kdt 1 /dev/XXXXXXvg/home
Linux 4.19.62 (XXXXX)   07/29/2019      _x86_64_        (2 CPU)

07/29/2019 02:08:03 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.91        15.40        37.77      19309 47364

07/29/2019 02:08:04 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:05 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:06 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:07 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:08 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:09 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:10 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:11 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:12 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:13 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:14 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:15 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:16 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:17 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:18 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:19 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:20 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:21 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:22 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64

07/29/2019 02:08:23 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              0.00         0.00         0.00 0          0

07/29/2019 02:08:24 PM
Device:            tps    kB_read/s    kB_wrtn/s    kB_read kB_wrtn
dm-5              1.00         0.00        64.00 0         64


Thank you,

---

Dmitrij Gusev

Systems architect


