Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1C6F2426
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Apr 2023 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjD2KfU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Apr 2023 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2KfT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Apr 2023 06:35:19 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Apr 2023 03:35:15 PDT
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6A961BF7
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 03:35:15 -0700 (PDT)
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
        by pd.grulic.org.ar (Postfix) with ESMTPSA id A084080EB2
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 07:28:50 -0300 (-03)
Date:   Sat, 29 Apr 2023 12:28:49 +0200
From:   Marcos Dione <mdione@grulic.org.ar>
To:     linux-ext4@vger.kernel.org
Subject: Recover partition
Message-ID: <ZEzxYc0CaPLZ9vhK@ioniq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

    Hi all, brand new here. I'm trying to salvage an ext4 fs on an SSD that 
suddenly has 1800 bad sectors. Let's start from the partition table:

Device     Boot  Start       End   Sectors   Size Id Type
/dev/sdc1  *      2048    249855    247808   121M 83 Linux
/dev/sdc2       251902 488396799 488144898 232.8G  5 Extended
/dev/sdc5       251904 488396799 488144896 232.8G 83 Linux

    I don't know on what drugs I was on when I partitioned thid disk, but we have
/boot on /dev/sdc1 and / on /dev/sdc5. Trying to mount / gives errors about the
superblock. Also notice the gap between sdc1 and sdc2, there are 
2047 sectors/1048064 bytes unused in the middle. this is not big enough for f.i. 
a swap partition. For reference, here are the offsets in hex:

sector       offset            hex
  2048    1_048_576  0x00_10_00_00
251904  128_974_848  0x07_b0_00_00

    Weirdly, most of the bad sectors are after position 738_197_504/0x2c_00_00_00,
way past where sdc5's SB should be, and none at the exact places where the copies 
are. Because of the bas sectors, the first thing I did was to make a copy of the 
whole disk.

    This is not the first time I play with these things[1], so I know I 
should be looking for '0x53ef' in a position ending in 0x38:

# hexdump -C sdc.img | grep -E '30  .*  53 ef'
00100430  6b b3 2d 64 00 00 ff ff  53 ef 01 00 01 00 00 00  |k.-d....S.......|
00900430  09 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
01900430  09 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
02900430  09 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
03101830  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
03106830  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
0310b030  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
0310e430  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
03119030  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
033b6830  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
033bcc30  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
033d3430  f0 3e 65 5c 02 00 ff ff  53 ef 01 00 01 00 00 00  |.>e\....S.......|
035a1630  b1 d4 f9 5c 74 f8 72 30  53 ef 26 c5 ed b7 98 fb  |...\t.r0S.&.....|
03900430  09 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
04900430  09 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
067f4d30  84 6a 4f 21 e4 d3 39 af  53 ef 7d 95 1e 36 ff a2  |.jO!..9.S.}..6..|
0fb02e30  17 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
1fb02e30  17 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
2fb00030  17 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
3fb00030  17 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
4fb00030  17 94 57 5c 00 00 ff ff  53 ef 00 00 01 00 00 00  |..W\....S.......|
^C

    The output is quite troubling. It's like we have four different sets of 
superblock copies, and then some hits that are probably just random data. I say
troubling because I would have expected two sets, not four. In any case, the
ones starting at 0x0f_b0_2e_30 look quite promising. Let's see if they are in the
expected places:

# mkfs.ext4 -n /dev/sdc5
mke2fs 1.44.5 (15-Dec-2018)
Creating filesystem with 61018112 4k blocks and 15261696 inodes
Filesystem UUID: 32faf3a4-1892-4ebc-802e-fc740234bca5
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
        4096000, 7962624, 11239424, 20480000, 23887872

    Let's check those offsets:

In [2]: copies = [ 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
   ...:             4096000, 7962624, 11239424, 20480000, 23887872 ]

In [7]: for copy in copies:
   ...:     offset = copy * 4 * 1024  # 4k blocks
   ...:     disk_offset = offset + 128_974_848
   ...:     print(f'{copy:8}  {offset:16} {disk_offset:16} {disk_offset:14x}')
   ...: 
#    block  partition offset      disk offset            hex
     32768         134217728        263192576        fb00000
     98304         402653184        531628032       1fb00000
    163840         671088640        800063488       2fb00000
    229376         939524096       1068498944       3fb00000
    294912        1207959552       1336934400       4fb00000
    819200        3355443200       3484418048       cfb00000
    884736        3623878656       3752853504       dfb00000
   1605632        6576668672       6705643520      18fb00000
   2654208       10871635968      11000610816      28fb00000
   4096000       16777216000      16906190848      3efb00000
   7962624       32614907904      32743882752      79fb00000
  11239424       46036680704      46165655552      abfb00000
  20480000       83886080000      84015054848     138fb00000
  23887872       97844723712      97973698560     16cfb00000

    The numbers look promising:

* The first two entries seem to be 0x2e00 bytes off, so I'm not going to try that.
* The next three are exact matches!

    But:

mdione@diablo:~/recover$ sudo fsck.ext4 -b 163840 -n /dev/sdc5
e2fsck 1.47.0 (5-Feb-2023)
Journal superblock has an unknown read-only feature flag set.
Abort? no

Journal superblock is corrupt.
Fix? no

fsck.ext4: The journal superblock is corrupt while checking journal for /dev/sdc5
e2fsck: Cannot proceed with file system check

/dev/sdc5: ********** WARNING: Filesystem still has errors **********

    And:

mdione@diablo:~/recover$ for copy in 163840 229376 294912 819200 884736 1605632 \
            2654208 4096000 7962624 11239424 20480000 23887872; do \
        if sudo fsck.ext4 -b $copy -n /dev/sdc5 &> /dev/null; then 
            echo $copy; 
            break; 
        fi; 
    done; 
    echo failed

failed

    So we get to the questions section:

a) Does my disk math check? It took me those 2-3 weeks to figure out how to map
   the block numbers to disk offsets.

b) Besides the two random hits, why would I have what look like _four_ sets of
   superblock copies?

c) Why would copies #1 and #2 seem to be in the wrong offest? Could it be that
   the mkfs version I'm using now calculates different offsets from the one
   I used 3-4 years ago to create those filesystems?

d) The big question: Why could it be finding the SB copies corrupted?

e) Most important one: What else can I do?

    Thanks in advance any light you might shed on this. Cheers,

        -- Marcos.

--
[1] https://www.grulic.org.ar/~mdione/glob/posts/recovering-partitions-with-pen-and-paper/
