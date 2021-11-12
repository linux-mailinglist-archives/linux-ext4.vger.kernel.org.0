Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8644EDF3
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Nov 2021 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhKLUj5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Nov 2021 15:39:57 -0500
Received: from disco.pogo.org.uk ([93.93.128.62]:10436 "EHLO disco.pogo.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhKLUj5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Nov 2021 15:39:57 -0500
X-Greylist: delayed 2667 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 15:39:56 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
        ; s=swing; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender
        :Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bYVYJKBHdigEziLfwC7nYV7nf07lzbHLwIfCH2tjsMk=; b=slgku1wsQLGi/4MelDP2Yv7Y1S
        y/A2zn4vMPTVnivKOHqJ7FPED94lmD50M5x9nKzQKbvRZZqrjfUCxWMaS+/6z2WM9bJUr97y68B98
        29OnWlcC9ft5rKBNvOpSwknCHIyi41muPnXPenhm9daRQSQAtoScVMHp6/ts7hVcbQY0=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1mlcbG-000K5k-8C
        for linux-ext4@vger.kernel.org; Fri, 12 Nov 2021 19:52:37 +0000
Received: from localhost (stax.localdomain [local])
        by stax.localdomain (OpenSMTPD) with ESMTPA id dd74b131
        for <linux-ext4@vger.kernel.org>;
        Fri, 12 Nov 2021 19:52:37 +0000 (UTC)
Date:   Fri, 12 Nov 2021 19:52:37 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     linux-ext4@vger.kernel.org
Subject: Maildir quickly hitting max htree
Message-ID: <2111121900560.16086@stax.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Surprised to hit a limit when handling a modest Maildir case; does this 
reflect a bug?

rsync'ing to a new mail server, after fewer than 100,000 files there are 
intermittent failures:

  rsync: [receiver] open "/home/mark/Maildir/.robot/cur/1633731549.M990187P7732.yello.[redacted],S=69473,W=70413:2," failed: No space left on device (28)
  rsync: [receiver] rename "/home/mark/Maildir/.robot/cur/.1624626598.M748388P84607.yello.[redacted],S=17049,W=17352:2,.oBphKA" -> ".robot/cur/1624626598.M748388P84607.yello.[redacted],S=17049,W=17352:2,": No space left on device (28)

The kernel:

  EXT4-fs warning (device dm-4): ext4_dx_add_entry:2351: Directory (ino: 225811) index full, reach max htree level :2
  EXT4-fs warning (device dm-4): ext4_dx_add_entry:2355: Large directory feature is not enabled on this filesystem

Reaching for 'large_dir' seems premature as this feature is reported as 
useful for 10M+ files, but this is much lower.

A 'bad' filename will fail consistently. Assuming the 10M+ absolute limit, 
is the tree grossly imbalanced?

Intuitively, 'htree level :2' does not sound particular deep.

The source folder is 195,000 files -- large, but not crazy. rsync 
eventually hit a ceiling having written 177,482 of the files. I can still 
create new ones on the command line with non-Maildir names.

Ruled out quotas, by disabling them with "tune2fs -O ^quota" and 
remounting.

See below for additional info.

-- 
Mark


$ uname -a
Linux floyd 5.10.78-0-virt #1-Alpine SMP Thu, 11 Nov 2021 14:31:09 +0000 x86_64 GNU/Linux

$ mke2fs -q -t ext4 /dev/vg0/home

$ rsync -va --exclude 'dovecot*' yello:Maildir/. $HOME/Maildir

$ ls | head -15
1605139205.M487508P91922.yello.[redacted],S=7625,W=7775:2,
1605139440.M413280P92363.yello.[redacted],S=7632,W=7782:2,
1605139466.M699663P92402.yello.[redacted],S=7560,W=7710:2,
1605139479.M651510P92421.yello.[redacted],S=7474,W=7623:2,
1605139508.M934351P92514.yello.[redacted],S=7626,W=7776:2,
1605139596.M459228P92713.yello.[redacted],S=7559,W=7709:2,
1605139645.M57446P92736.yello.[redacted],S=7632,W=7782:2,
1605139670.M964535P92758.yello.[redacted],S=7628,W=7778:2,
1605139697.M273694P92807.yello.[redacted],S=7632,W=7782:2,
1605139748.M607989P92853.yello.[redacted],S=7560,W=7710:2,
1605139759.M655635P92868.yello.[redacted],S=5912,W=6018:2,
1605139808.M338286P93071.yello.[redacted],S=7628,W=7778:2,
1605139961.M915501P93235.yello.[redacted],S=7625,W=7775:2,
1605140303.M219848P93591.yello.[redacted],S=6898,W=7023:2,
1605140580.M166212P93921.yello.[redacted],S=6896,W=7021:2,

$ touch abc
[success]

$ touch 1624626598.M748388P84607.yello.[redacted],S=17049,W=17352:2,
touch: cannot touch '1624626598.M748388P84607.yello.[redacted],S=17049,W=17352:2,': No space left on device

$ dumpe2fs /dev/vg0/home
Filesystem volume name:   <none>
Last mounted on:          /home
Filesystem UUID:          ad26c968-d057-4d44-bef9-1e2df347580e
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              5225472
Block count:              21229568
Reserved block count:     851459
Overhead clusters:        22361
Free blocks:              8058180
Free inodes:              4799979
First block:              1
Block size:               1024
Fragment size:            1024
Group descriptor size:    64
Reserved GDT blocks:      96
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2016
Inode blocks per group:   504
Flex block group size:    16
Filesystem created:       Mon Nov  8 13:14:56 2021
Last mount time:          Fri Nov 12 18:43:14 2021
Last write time:          Fri Nov 12 18:43:14 2021
Mount count:              27
Maximum mount count:      -1
Last checked:             Mon Nov  8 13:14:56 2021
Check interval:           0 (<none>)
Lifetime writes:          14 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      839d2871-b97e-456d-9724-096db15931b8
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x5974a8b1
Journal features:         journal_incompat_revoke journal_64bit 
journal_checksum_v3
Total journal size:       4096k
Total journal blocks:     4096
Max transaction length:   4096
Fast commit length:       0
Journal sequence:         0x00000a2a
Journal start:            702
Journal checksum type:    crc32c
Journal checksum:         0x4d693e79


