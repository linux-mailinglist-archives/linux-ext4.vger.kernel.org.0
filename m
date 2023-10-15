Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24057C9817
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Oct 2023 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjJOGFr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Oct 2023 02:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOGFq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Oct 2023 02:05:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05FCA6
        for <linux-ext4@vger.kernel.org>; Sat, 14 Oct 2023 23:05:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55519C433C8
        for <linux-ext4@vger.kernel.org>; Sun, 15 Oct 2023 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697349944;
        bh=oEnI3oHaMEi3bJIcP4olykd8Z8OVZV6hmet1jF8XHQ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h0KDFA5OeENoo5M6yNRzQLYobsdNn5M/HYKw3dosrJ1Thvi/3YmPuMfkbU9AWu58N
         dtFLWU8cnc2YQisLwU13D8Zhazx54eRBBZHrEiWL+0oMXXRkeufGUwEPVtAZ0KPIyo
         eA3XS4tBHa1cQt8AoegaIb0ArFGL4YHtlz8HPpT828uN2LYaikbi5kSNyeyKgIlmIs
         KBJC2frS/AAnvLz/bbvo2dYKdHJpB+9GqQnUil4sI+INbFcByPBNRbChZAgIh2zTMH
         B6fN2XbaMHXIYwT82eHAk14qwb5oFh21u54YUkQcgohS7kwX3C59rYzm2EgepWSS0n
         pOhNwVOeW+hOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3DB98C53BD2; Sun, 15 Oct 2023 06:05:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218011] ext4 root filesystem related hangs on 6.5 kernels
Date:   Sun, 15 Oct 2023 06:05:43 +0000
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
Message-ID: <bug-218011-13602-rS3oJf4YsL@https.bugzilla.kernel.org/>
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

--- Comment #3 from jaak+bugzilla.kernel.org@ristioja.ee ---
The mount line for root I already posted was this:

/dev/nvme0n1p2 on / type ext4
(rw,noatime,nodiratime,nodioread_nolock,discard,nodelalloc)

I'm sorry, but I recreated the root partition for safety. However, here's t=
he
dumpe2fs output on a binary copy of the old failing partition (only label
changed with tune2fs -L):

# dumpe2fs -h /dev/vg/root-old
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   root-old
Last mounted on:          /
Filesystem UUID:          febed35b-df13-4e6a-a9de-4ae17673322a
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize
metadata_csum
Filesystem flags:         signed_directory_hash=20
Default mount options:    journal_data user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2621440
Block count:              10485760
Reserved block count:     1048576
Free blocks:              5921591
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
Filesystem created:       Sat Apr 25 15:02:31 2020
Last mount time:          Sat Oct 14 17:49:31 2023
Last write time:          Sat Oct 14 17:49:24 2023
Mount count:              133
Maximum mount count:      -1
Last checked:             Thu Nov 11 15:55:30 2021
Check interval:           0 (<none>)
Lifetime writes:          79 TB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      764a85fe-24b0-4a45-96d7-7b43a75d90a2
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0xc4176fe3
Journal features:         journal_64bit journal_checksum_v3
Total journal size:       256M
Total journal blocks:     65536
Max transaction length:   65536
Fast commit length:       0
Journal sequence:         0x0080d73c
Journal start:            0
Journal checksum type:    crc32c
Journal checksum:         0x6d8e4ded

dumpe2fs: Superblock checksum does not match superblock while trying to open
/dev/vg/root-old
*** Run e2fsck now!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
