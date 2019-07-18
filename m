Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB26D115
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfGRP0c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 11:26:32 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35709 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbfGRP0c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 11:26:32 -0400
Received: by mail-ot1-f46.google.com with SMTP id j19so29469672otq.2
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jul 2019 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qyf+XAiV/reiT/HM3oIbITqFG3mjYMfRC5OyrXlRTn4=;
        b=bJIHLpdj6j5Te8Z1keo8v9ZCNaxcFQFUtNu92+EqAWnr0xCeCXXcoffXKqsBTvsnFx
         87ExVRb+f0n2Zb2oVBu0pciCZbNqWbT/ThrvPjsja/S/KlYBeUOk4END+oARbePSn1+6
         e4daR22fGmXXs5dHTezf9mbvFr4yguJSwISRxk61hvh65avH5F51uHIhN/xsE7ONwObv
         8liiTSqj9VlunLsunxOS11ZeSmNeVUEZK77L214fUvU6KXPHcJnhzFMSh7Y61Ge7X0Pn
         wsAwPAxK+RZl/46MHdVOrCcoBpsrGMg9P1ruXtuZTFZw1TTgGKtNlsfCDr6VzoZTTlbp
         iTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qyf+XAiV/reiT/HM3oIbITqFG3mjYMfRC5OyrXlRTn4=;
        b=D8a9MBc5Qpom76FcuIIN/edmn/OyVbV5MFWywGNUEGjII6UDUYuCe9IeaOOBBA+J1X
         vIiGN9UozESwliyD0rjpNfnxAqA3U/VVuCpUDRCWxhUn0A6plNTfQrRwyH4uUq5QZUM/
         VEu9dM2Wx6oXSELLsukgJI0pNjTa/k0N9XTD7ZZavrENYzOE0nvpiKDgD5wI4NtB4h8g
         EVWiNqCncJyGvGY/TI6kMjt8zz4UlnVEF5X4PsqB2eBGeCzesTeYFVvp7Lb5jX9YsVlv
         CQ8Vkw1XnJjzKGYRm+VioVC2hnl8eFc/k3Z3FGyn/nn02NUDhl/3f0t/3l2T9uTmLnAE
         LS7g==
X-Gm-Message-State: APjAAAV4I2zDANmm5uCJL8jI6t1o3jD4pPTPbd5ecp7h06+qllevonVN
        uIjH+/upI695yWCwRJc1UUgDDATFPNmh1Xjd1zP5lszXNg==
X-Google-Smtp-Source: APXvYqxAB1k7O5eUK4RgAfJURNzhnhtzQA9ZKcy0MGLdNQpg5v0XRJGOQUPkEDXkibbx6jUyNpNqJ34IbvC/fT4e3Vk=
X-Received: by 2002:a9d:6742:: with SMTP id w2mr25837974otm.371.1563463591165;
 Thu, 18 Jul 2019 08:26:31 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Malone <ibmalone@gmail.com>
Date:   Thu, 18 Jul 2019 16:26:19 +0100
Message-ID: <CAL3-7Mp_0=tMReTRGB0u0OxynKXjLkCkr1X7d-+JwhwZpVfvvg@mail.gmail.com>
Subject: ext4 reserved blocks not enforced?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

We've got a number of ext4 fs on a LVM logical volume. When they get
'full' (0 available space according to df, normal user can't place any
more files), or ideally slightly before, we use lvm's lvextend command
with the -r option, which invokes fsadm, which I guess in turn uses
resize2fs.

Recently we extended a ~1.9TB filesystem by 20GB, however afterwards
df reported 0 available bytes. The LV had been increased and running
resize2fs reported that the fs was already the full size of the
device. tune2fs showed fewer free blocks than reserved blocks. Despite
this, normal users could create files on the filesystem (via nfs) and
copy several GB of data on without trouble. Forced fsck found no
issues, though with fragcheck enabled it reported plenty of blocks
that were not the expected length (and 9.4% non-contiguous).

Further, copying data on did not appear to change the reported free
nodes from tune2fs, though we didn't attempt to completely fill the
drive. We've since manually lowered the reserved blocks count below
the free blocks count in case the inverted situation was somehow
causing this behaviour.

Is this a bug? Normally once df reports 0 available normal users are
not able to add more data, regardless of remaining reserved space. If
it's expected behaviour can someone clarify what's happening?

This is the current tune2fs, reserved blocks was previously about
24924508, free blocks was already around 17315627 when we lowered the
reserved blocks:
tune2fs 1.42.9 (28-Dec-2013)
Filesystem volume name:   <none>
Last mounted on:          /mnt/research/ftd
Filesystem UUID:          0e4e6c45-a11b-43ff-84c8-ed21fbbde460
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg sparse_super large_file
huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              126623744
Block count:              506472448
Reserved block count:     13107200
Free blocks:              17315627
Free inodes:              124820983
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      795
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    4096
Filesystem created:       Wed Jun 24 15:05:23 2015
Last mount time:          Thu Jul 18 13:23:59 2019
Last write time:          Thu Jul 18 13:23:59 2019
Mount count:              1
Maximum mount count:      -1
Last checked:             Thu Jul 18 13:21:25 2019
Check interval:           0 (<none>)
Lifetime writes:          12 TB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:              256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      a5f445de-e71e-4601-9014-c82b8c8ec89e
Journal backup:           inode blocks


-- 
imalone
http://ibmalone.blogspot.co.uk
