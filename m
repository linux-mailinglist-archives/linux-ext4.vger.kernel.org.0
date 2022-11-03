Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F3618B34
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Nov 2022 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKCWOn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Nov 2022 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKCWOm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Nov 2022 18:14:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1021263
        for <linux-ext4@vger.kernel.org>; Thu,  3 Nov 2022 15:14:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so1920596ioj.21
        for <linux-ext4@vger.kernel.org>; Thu, 03 Nov 2022 15:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+vj0ESjG5r4BIvswDDDboZ1laiioRVaHJ/TmUfSzc4=;
        b=aX4gqyhlsHfzX3UVmSm+pxnn+rqLpBcpTZAgZL2RbtoNyKM2QpfxNsrbSTkh3sBlX5
         5x2FRl8ARjUZ6V0fGSXaP8kXp0mMTKZASso9w/WWgIHCufccYiCUymAsSkr8owfVzQIB
         605N7rJQhl/QtBG2LpiIc910seFX4+LfpAsb8ZsjArmtW3yVQ6Rka/yi9zTpprpKXXVn
         FrT2/9bHeotns/VdTuijh439sj+fUUVY+087uuWNYNqKoLQ3nVBx6Hu5j0zwrEJZFcd0
         TdVD1JNi35RzCj6vstMoNcFVQazH6ABR9UL3V+by831ooRFX8PgRNp1EUX7xTnPC+cBj
         nj/w==
X-Gm-Message-State: ACrzQf2hXFHSJ3nPWyJfPca6QLeKWWz4olf5j82ofPNeJZZw0IVHFP00
        qVKVPBiVeLE6bX4eRkKZR1BsPOmd7wYDFRJsb5EdSu9wSZPW
X-Google-Smtp-Source: AMsMyM4eMH14ozcQ0xczpTX2Mp2+FyiTYDUqAsExiEsaPiJ+i/x28Ew3iMKu6PAmTQRewZIp/QUUaNy5gfLO2HTUW9p3AQjJYRzg
MIME-Version: 1.0
X-Received: by 2002:a02:6a2e:0:b0:363:a0a4:bf24 with SMTP id
 l46-20020a026a2e000000b00363a0a4bf24mr19955068jac.204.1667513679569; Thu, 03
 Nov 2022 15:14:39 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:14:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000876b4405ec984835@google.com>
Subject: [syzbot] memory leak in __insert_pending
From:   syzbot <syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    882ad2a2a8ff Merge tag 'random-6.1-rc3-for-linus' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14aad446880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e0c1dbca40c1f1d
dashboard link: https://syzkaller.appspot.com/bug?extid=05a0f0ccab4a25626e38
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dc2096880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a9300a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8f0ce1c9534/disk-882ad2a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/206eb0f33f01/vmlinux-882ad2a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13e639ad2934/bzImage-882ad2a2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7347d92c0f64/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111c8a1e0 (size 32):
  comm "syz-executor114", pid 3614, jiffies 4294956785 (age 12.710s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8178729a>] __insert_pending.isra.0+0xaa/0xf0 fs/ext4/extents_status.c:1895
    [<ffffffff8178b044>] ext4_es_insert_delayed_block+0x224/0x230 fs/ext4/extents_status.c:2018
    [<ffffffff817a7ae5>] ext4_insert_delayed_block fs/ext4/inode.c:1704 [inline]
    [<ffffffff817a7ae5>] ext4_da_map_blocks fs/ext4/inode.c:1796 [inline]
    [<ffffffff817a7ae5>] ext4_da_get_block_prep+0x3a5/0x7e0 fs/ext4/inode.c:1860
    [<ffffffff81653016>] __block_write_begin_int+0x1d6/0x9d0 fs/buffer.c:1991
    [<ffffffff8179cf7b>] ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:877 [inline]
    [<ffffffff8179cf7b>] ext4_da_write_inline_data_begin+0x39b/0xb10 fs/ext4/inline.c:939
    [<ffffffff817b0307>] ext4_da_write_begin+0x477/0x4e0 fs/ext4/inode.c:2986
    [<ffffffff8148755f>] generic_perform_write+0xff/0x2b0 mm/filemap.c:3753
    [<ffffffff8178c54b>] ext4_buffered_write_iter+0xbb/0x1d0 fs/ext4/file.c:285
    [<ffffffff8178c71f>] ext4_file_write_iter+0xbf/0xbf0 fs/ext4/file.c:700
    [<ffffffff815d8517>] call_write_iter include/linux/fs.h:2191 [inline]
    [<ffffffff815d8517>] do_iter_readv_writev+0x147/0x210 fs/read_write.c:735
    [<ffffffff815d9afc>] do_iter_write+0xdc/0x300 fs/read_write.c:861
    [<ffffffff815d9d59>] vfs_iter_write+0x39/0x60 fs/read_write.c:902
    [<ffffffff8163eb44>] iter_file_splice_write+0x434/0x660 fs/splice.c:686
    [<ffffffff8163c57b>] do_splice_from fs/splice.c:764 [inline]
    [<ffffffff8163c57b>] direct_splice_actor+0x4b/0x70 fs/splice.c:931
    [<ffffffff8163cd19>] splice_direct_to_actor+0x149/0x350 fs/splice.c:886
    [<ffffffff8163d008>] do_splice_direct+0xe8/0x150 fs/splice.c:974

BUG: memory leak
unreferenced object 0xffff888111c8a260 (size 32):
  comm "syz-executor114", pid 3618, jiffies 4294957317 (age 7.390s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8178729a>] __insert_pending.isra.0+0xaa/0xf0 fs/ext4/extents_status.c:1895
    [<ffffffff8178b044>] ext4_es_insert_delayed_block+0x224/0x230 fs/ext4/extents_status.c:2018
    [<ffffffff817a7ae5>] ext4_insert_delayed_block fs/ext4/inode.c:1704 [inline]
    [<ffffffff817a7ae5>] ext4_da_map_blocks fs/ext4/inode.c:1796 [inline]
    [<ffffffff817a7ae5>] ext4_da_get_block_prep+0x3a5/0x7e0 fs/ext4/inode.c:1860
    [<ffffffff81653016>] __block_write_begin_int+0x1d6/0x9d0 fs/buffer.c:1991
    [<ffffffff8179cf7b>] ext4_da_convert_inline_data_to_extent fs/ext4/inline.c:877 [inline]
    [<ffffffff8179cf7b>] ext4_da_write_inline_data_begin+0x39b/0xb10 fs/ext4/inline.c:939
    [<ffffffff817b0307>] ext4_da_write_begin+0x477/0x4e0 fs/ext4/inode.c:2986
    [<ffffffff8148755f>] generic_perform_write+0xff/0x2b0 mm/filemap.c:3753
    [<ffffffff8178c54b>] ext4_buffered_write_iter+0xbb/0x1d0 fs/ext4/file.c:285
    [<ffffffff8178c71f>] ext4_file_write_iter+0xbf/0xbf0 fs/ext4/file.c:700
    [<ffffffff815d8517>] call_write_iter include/linux/fs.h:2191 [inline]
    [<ffffffff815d8517>] do_iter_readv_writev+0x147/0x210 fs/read_write.c:735
    [<ffffffff815d9afc>] do_iter_write+0xdc/0x300 fs/read_write.c:861
    [<ffffffff815d9d59>] vfs_iter_write+0x39/0x60 fs/read_write.c:902
    [<ffffffff8163eb44>] iter_file_splice_write+0x434/0x660 fs/splice.c:686
    [<ffffffff8163c57b>] do_splice_from fs/splice.c:764 [inline]
    [<ffffffff8163c57b>] direct_splice_actor+0x4b/0x70 fs/splice.c:931
    [<ffffffff8163cd19>] splice_direct_to_actor+0x149/0x350 fs/splice.c:886
    [<ffffffff8163d008>] do_splice_direct+0xe8/0x150 fs/splice.c:974



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
