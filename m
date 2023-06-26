Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4ED73E02D
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFZNGR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFZNGN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 09:06:13 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5271E7B
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 06:05:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqSLv2CkKz4f3lxD
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 20:48:23 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgA3LRsYiZlkhiOjLg--.9627S2;
        Mon, 26 Jun 2023 20:48:25 +0800 (CST)
To:     tytso@mit.edu, linux-ext4@vger.kernel.org
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Subject: mkfs.ext4 failed when orphan_file is enabled
Message-ID: <3f0c3d5c-3dbf-6e9e-962b-616016c7427e@huaweicloud.com>
Date:   Mon, 26 Jun 2023 20:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgA3LRsYiZlkhiOjLg--.9627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48Kr1rCry8WrWUArWkZwb_yoW8CrWUpw
        43JFn0gFWkXa4fCa92yw4xWa4Sgr4Iy398X34jg3s7tFy3Gas2ywsxKa4UtFykKrnxAa12
        9F9Fqryjq3yUtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all, I find that "kvm-xfstests -c ext4/1k ext4/049" is failed on
current dev branch because of mkfs.ext4 failure.
I can simply reproduce the failure by:
 # kvm-xfstests shell
 # /sbin/mkfs.ext4  -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/vdc
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 1310720 4k blocks and 1280 inodes
Filesystem UUID: a202296a-c5dd-495c-8aee-4bc92983083a
Superblock backups stored on blocks:
        8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552,
        1024000

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
*mkfs.ext4: Inode checksum does not match inode while creating orphan file*

I also try this on my host machine with old version mke2fs. The orphan_file
feature is not set in old version /etc/mke2fs.conf and the mkfs.ext4 works
fine. After orphan_file added to /etc/mke2fs.conf, mkfs.ext4 failed as
following:
 # mkfs.ext4  -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda1
mke2fs 1.45.6 (20-Mar-2020)
/dev/sda1 contains a ext4 file system
        created on Tue Jun 27 03:49:19 2023
Invalid filesystem option set: has_journal,extent,huge_file,
flex_bg,metadata_csum,64bit,dir_nlink,extra_isize,orphan_file

It's likely orphan_file is not supported by old version.

After install new version mke2fs on my host machine. The checksum failure
appears again:
mkfs.ext4  -F  -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda1
mke2fs 1.47.0 (5-Feb-2023)
/dev/sda1 contains a ext4 file system
        created on Tue Jun 27 03:49:19 2023
Creating filesystem with 1310720 4k blocks and 1280 inodes
Filesystem UUID: 6ea06e27-5d56-4389-afaf-a99055fa85fd
Superblock backups stored on blocks:
        8192, 24576, 40960, 57344, 73728, 204800, 221184, 401408, 663552,
        1024000

Can anyone help with this?

-- 
Best wishes
Kemeng Shi

