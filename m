Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9B336C5
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 19:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfFCRb1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 13:31:27 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42619 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFCRb1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 13:31:27 -0400
Received: by mail-wr1-f50.google.com with SMTP id o12so5845388wrj.9
        for <linux-ext4@vger.kernel.org>; Mon, 03 Jun 2019 10:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HKyy0bUQJyGH48FPfMWvN+BTxNgYXMYj9gqGc8wD2l8=;
        b=IdBQ6wVCcFZbCkzYDRnrjNuNHh4ffTySsn2DRTI9X5D6OSwUctgSdIYqpG+DAAcqCa
         iv9usG3HsRg5gUXIjYda4ztShY8iMPjyGISN6D52b+O5BPDFsfIB4djsKcRUf6VlNL2W
         7TVe/FmLJWblqpZG5RYN0t2bi9cPpaLQGraS14UtGNoPjsAVtt1XdJTnHtKHzN0khEwI
         UYmsbMx4CGgMDrvUDWOtPXCzDBWcoOEpHEpa37tuM5/u8/7G87gkCtpSsaVvIYH9I0gu
         VEitoiNg4BDwDREzmjJyATXYp9nysNh8FfP56BN8zZdDqN89xy5Bxg86ULyITMsf/yQs
         i0Ww==
X-Gm-Message-State: APjAAAUHpDQ0KhBeiqDIpDko3cxIuOesgA5SDXvCKspsnIyOBoRDOKGu
        VEM7qf4eANST2rMRCY3bHYA5lBrzB3nIxBPIzjv7l1LN7X8=
X-Google-Smtp-Source: APXvYqz3lmlg1Zar7QhZ4jS8B4jk0Azy48anjsgTppKJ45dmfkusKIIgA+OG8Tn8lRDnYaOIKNaVbUBwwS6fLafWQzk=
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr10093272wru.161.1559583085071;
 Mon, 03 Jun 2019 10:31:25 -0700 (PDT)
MIME-Version: 1.0
From:   Ross Boylan <rossboylan@stanfordalumni.org>
Date:   Mon, 3 Jun 2019 10:30:24 -0700
Message-ID: <CAK3NTRACxpsHNtPEz0xDMkQepV+5+zpf4Xv5=v3HpGbFOX99sw@mail.gmail.com>
Subject: ext4 shows file system is 4G, df says 3G
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dumpe2fs (1.44.5), resize2fs and e2fsck all say my file system is
1048576 blocks with block size 4096, i.e. roughly 4GB.
df says it is 3GB.
However, they agree at least roughly on how much free space is available.
Linux kernel: Linux barley 4.19.0-5-amd64 #1 SMP Debian 4.19.37-3
(2019-05-15) x86_64 GNU/Linux

What is going on and how can I fix it?

The problem is undoubtedly related to history:
1. Created an LVM logical volume of 4TB (T, not G--a mistake).
2. mkfs.ext4 that volume. Used it a bit.
3. resize2fs to 3GB*
4. resize the logical volume to 4GB (lvresize)
5. resize2fs the volume with no space argument, i.e., fill available space.

The current reported 3GB by df exactly matches the size at step 3.
When it still showed 3GB after step 5, I had hoped this was a
transient problem.  But it continues to show 3G after reboot. e2fsck
says all is well.

I can imagine that the metadata structures for 4TB ended up eating a
huge fraction of the space after the resize but a) it seems quite a
coincidence that would lead to exactly the size in step 3 and b) I
don't see it in any of the reported info, e.g., reserved blocks,
except for the fact that the blocks available is quite low given the
size of the files on the file system.  Actually, maybe I do see it:
the journal size is 1024M = 1G (if the units are bytes; if the units
are blocks then the journal would be bigger than the whole filesystem)
so that could account for the difference.  And I need to resize the
journal?  Or would it be better just to make a new volume and file
system and copy?

* I was concerned that if I resized directly to 4GB and then resized
the LV to 4GB I might actually step on the end of the file system.

Thanks.
Ross Boylan

Some diagnostics:
# df -h /var/local/cache/
Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/vgbarley-cache  3.0G  721M  2.1G  26% /var/local/cache
root@barley:~/tempserver/root# lvs vgbarley  # LVM also agrees volume is 4GB
  LV      VG       Attr       LSize   Pool Origin Data%  Meta%  Move
Log Cpy%Sync Convert
  cache   vgbarley -wi-ao----   4.00g
## etc
# resize2fs /dev/vgbarley/cache
resize2fs 1.44.5 (15-Dec-2018)
The filesystem is already 1048576 (4k) blocks long.  Nothing to do!
# So both LVM and e2fs utilities see 4G , even though df reports 3G

# somewhat later
# dumpe2fs -h /dev/vgbarley/cache
dumpe2fs 1.44.5 (15-Dec-2018)
Filesystem volume name:   <none>
Last mounted on:          /var/local/cache
Filesystem UUID:          0601d7dc-2efe-46c7-9cac-205a761b70ef
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              131072
Block count:              1048576
Reserved block count:     52428
Free blocks:              621488
Free inodes:              122857
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         4096
Inode blocks per group:   256
Flex block group size:    16
Filesystem created:       Mon May 27 11:54:50 2019
Last mount time:          Thu May 30 17:06:02 2019
Last write time:          Thu May 30 17:06:02 2019
Mount count:              2
Maximum mount count:      -1
Last checked:             Mon May 27 14:17:18 2019
Check interval:           0 (<none>)
Lifetime writes:          35 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:              256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      24162063-f4a6-4420-b79b-3ad4f9b71ab7
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x48ff013b
Journal features:         journal_64bit journal_checksum_v3
Journal size:             1024M
Journal length:           262144
Journal sequence:         0x000005be
Journal start:            1
Journal checksum type:    crc32c
Journal checksum:         0xb7b54059
