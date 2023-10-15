Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37647C9823
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Oct 2023 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjJOGUs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Oct 2023 02:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJOGUr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Oct 2023 02:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B12DC
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 23:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A6F4C433CA
        for <linux-ext4@vger.kernel.org>; Sun, 15 Oct 2023 06:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697350845;
        bh=4Sj8hCo4JrkI2UMsf/Lve7wZfhT3+I4rOuP7NcMzJM0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UstnW18lMS+L3zgJJBFPYTID+ZoeeQgeOTAaNnafHnGIiuxoRLBANR+8XwDOamX2L
         dcPaGZLRej5nvwD7wZybpNFr36VJ/sf2OS3iN401gUBU7OsGCUGiwUBxnggKCQ3ou+
         ljXtoodWXyOLoIxJ5t190zGxYNEIjy2x64HcRQFECY9JXkHC9UK7s2+izuvbULFQ9B
         LCpjbIeCSjaVnd3MOwQQbkUb0cWCCKTbr7KQdO0TyngmvtrbHAT4kniAJSpM573Khb
         4qJzvpH44DisthkjLCUZ9Kuk/d8QfhFct76VlpDnF/Hbr/uHbJ0itmbeu7NAKtf4Lq
         vf5MEgZmuuPZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 62BA0C53BD2; Sun, 15 Oct 2023 06:20:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sun, 15 Oct 2023 06:20:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaak+bugzilla.kernel.org@ristioja.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218011-13602-0R7d32lSdz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218011-13602@https.bugzilla.kernel.org/>
References: <bug-218011-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218011

--- Comment #5 from jaak+bugzilla.kernel.org@ristioja.ee ---
The new root filesystem was created with mkfs.ext4 with no special options.
Here is the relevant /etc/mke2fs.conf:

[defaults]
        base_features =3D
sparse_super,large_file,filetype,resize_inode,dir_index,ext_attr
        default_mntopts =3D acl,user_xattr,journal_data
        enable_periodic_fsck =3D 0
        blocksize =3D 4096
        inode_size =3D 256
        inode_ratio =3D 16384

[fs_types]
        ext3 =3D {
                features =3D has_journal
        }
        ext4 =3D {
                features =3D
has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_is=
ize
        }
        small =3D {
                blocksize =3D 1024
                inode_ratio =3D 4096
        }
        floppy =3D {
                blocksize =3D 1024
                inode_ratio =3D 8192
        }
        big =3D {
                inode_ratio =3D 32768
        }
        huge =3D {
                inode_ratio =3D 65536
        }
        news =3D {
                inode_ratio =3D 4096
        }
        largefile =3D {
                inode_ratio =3D 1048576
                blocksize =3D -1
        }
        largefile4 =3D {
                inode_ratio =3D 4194304
                blocksize =3D -1
        }
        hurd =3D {
             blocksize =3D 4096
             inode_size =3D 128
             warn_y2038_dates =3D 0
        }

And the dumpe2fs -h output from the currently failing system:

dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   root
Last mounted on:          /
Filesystem UUID:          b7112037-b835-45ac-b3b3-4d9250c53503
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_n=
link
extra_isize metadata_csum
Filesystem flags:         signed_directory_hash=20
Default mount options:    journal_data user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2621440
Block count:              10485760
Reserved block count:     524288
Overhead clusters:        242376
Free blocks:              6899974
Free inodes:              2208475
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Sat Oct 14 18:03:49 2023
Last mount time:          Sat Oct 14 18:16:50 2023
Last write time:          Sat Oct 14 18:16:48 2023
Mount count:              2
Maximum mount count:      -1
Last checked:             Sat Oct 14 18:03:49 2023
Check interval:           0 (<none>)
Lifetime writes:          26 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      bf662df3-a40b-4276-905e-70bb51bfd867
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0xdf22e900
Journal features:         journal_64bit journal_checksum_v3
Total journal size:       256M
Total journal blocks:     65536
Max transaction length:   65536
Fast commit length:       0
Journal sequence:         0x00001f33
Journal start:            18150
Journal checksum type:    crc32c
Journal checksum:         0x70a695b1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
