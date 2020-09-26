Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC98279867
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Sep 2020 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIZK1z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Sep 2020 06:27:55 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39128 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZK1z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Sep 2020 06:27:55 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 709473AA882
        for <linux-ext4@vger.kernel.org>; Sat, 26 Sep 2020 10:25:37 +0000 (UTC)
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 311F920003;
        Sat, 26 Sep 2020 10:25:14 +0000 (UTC)
Date:   Sat, 26 Sep 2020 03:25:12 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org
Cc:     971014@bugs.debian.org
Subject: Reproducible bug in inline_data handling with ACL
Message-ID: <20200926102512.GA11386@localhost>
References: <160110861360.7199.11561753808099731033.reportbug@s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160110861360.7199.11561753808099731033.reportbug@s>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Adding CC to linux-ext4@.

On Sat, Sep 26, 2020 at 01:23:33AM -0700, Josh Triplett wrote:
> In the course of creating some filesystems containing Debian
> installations using `mke2fs -d`, I managed to find a bug in the
> `inline_data` handling, which seems to apply to files containing ACLs.
> On a default Debian installation, /var/log/journal triggered this
> problem.
> 
> I managed to create a minimal test case. To reproduce:
> 
> mkdir -p target/testdir
> setfacl --restore=- <<EOF
> # file: target/testdir/
> user::rwx
> group::r-x
> group:adm:r-x
> mask::r-x
> other::r-x
> default:user::rwx
> default:group::r-x
> default:group:adm:r-x
> default:mask::r-x
> default:other::r-x
> EOF
> mke2fs -b 4096 -I 256 -O sparse_super2,inline_data,^has_journal -d target disk.img 8M
> 
> and then run:
> 
> e2fsck -n -f disk.img
> 
> This will show:
> 
> e2fsck 1.46-WIP (03-Oct-2019)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 12 has INLINE_DATA_FL flag but extended attribute not found.  Truncate? no
> 
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> 
> disk.img: ********** WARNING: Filesystem still has errors **********
> 
> disk.img: 12/2048 files (0.0% non-contiguous), 137/2048 blocks
> 
> 
> And the kernel ext4 implementation will fail to handle that inode, with
> a message like this:
> 
> EXT4-fs error (device loop0): __ext4_iget:4776: inode #3215: block 56: comm ls: invalid block
> 
> 
> The size of 8M doesn't matter; the issue reproduces with other sizes.
> /etc/mke2fs.conf is unchanged from the defaults. `tune2fs -l disk.img`
> shows the following:
> 
> tune2fs 1.46-WIP (03-Oct-2019)
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          931e3151-83db-4c33-be5f-655c9323fab4
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      ext_attr resize_inode dir_index sparse_super2 filetype inline_data sparse_super large_file
> Filesystem flags:         signed_directory_hash 
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              2048
> Block count:              2048
> Reserved block count:     102
> Free blocks:              1911
> Free inodes:              2036
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         2048
> Inode blocks per group:   128
> Filesystem created:       Sat Sep 26 00:50:53 2020
> Last mount time:          n/a
> Last write time:          Sat Sep 26 00:50:53 2020
> Mount count:              0
> Maximum mount count:      -1
> Last checked:             Sat Sep 26 00:50:53 2020
> Check interval:           0 (<none>)
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:	          256
> Required extra isize:     32
> Desired extra isize:      32
> Default directory hash:   half_md4
> Directory Hash Seed:      df46d104-ed26-4cea-ac61-0feff2a54622
