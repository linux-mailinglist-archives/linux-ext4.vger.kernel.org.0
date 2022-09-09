Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624D5B2C15
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 04:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIICVk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 22:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIICVk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 22:21:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A3B07E0
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 19:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2421B8227A
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85163C433D7
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 02:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662690096;
        bh=uo+NiEsglhQ//gD+sKYuxRoUpzML/ff/hAZyAe0Pubs=;
        h=From:To:Subject:Date:From;
        b=RZo7wLHbgjVRtGyOp8pp2Ko3U9xH24gOaDjun/TfaJFMdh/a/D1ZU8ZpOH2DDl7dL
         e/nJcplG6VXWPzA6fZbJOwpoKN0mTW/0int1ZlYoRm/ikwYIJeTH31eR70DbNZR1Th
         8grSi0Y9IYnNcusMoczTLEvERxx7X2do39wR39lvMJRFeEZYBuX3EuZahDdrn3sEVt
         b+f1fwJgfMDcmzPk8xsw6609iTursNTzcBy79iMF89UmGsn03Se4EFtvJRsxFbl9oa
         C4wzjaZ1JRdwZfQx+ye7tSLwC2dgO7y/NnuRHjxXHDVSN1puQCiH5oJ2SgHkjrXlNE
         2v2SUsujJ6gPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 698DDC433E7; Fri,  9 Sep 2022 02:21:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216466] New: ext4: dir corruption when ext4_dx_add_entry()
 fails
Date:   Fri, 09 Sep 2022 02:21:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216466-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216466

            Bug ID: 216466
           Summary: ext4: dir corruption when ext4_dx_add_entry() fails
           Product: File System
           Version: 2.5
    Kernel Version: 6.0.0-rc4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

Following process may lead to fs corruption:
    1. ext4_create(dir/foo)
     ext4_add_nondir
      ext4_add_entry
       ext4_dx_add_entry
         a. add_dirent_to_buf
          ext4_mark_inode_dirty
          ext4_handle_dirty_metadata   // dir inode bh is recorded into jou=
rnal
         b. ext4_append    // dx_get_count(entries) =3D=3D dx_get_limit(ent=
ries)
           ext4_bread(EXT4_GET_BLOCKS_CREATE)
            ext4_getblk
             ext4_map_blocks
              ext4_ext_map_blocks
                ext4_mb_new_blocks
                 dquot_alloc_block
                  dquot_alloc_space_nodirty
                   inode_add_bytes    // update dir's i_blocks
                ext4_ext_insert_extent
                 ext4_ext_dirty  // record extent bh into journal
                  ext4_handle_dirty_metadata(bh)   // record new block into
journal
           inode->i_size +=3D inode->i_sb->s_blocksize   // new size(in mem)
         c. ext4_handle_dirty_dx_node(bh2)  // record dir's new block(dx_no=
de)
into journal
         d. ext4_handle_dirty_dx_node((frame - 1)->bh)
         e. ext4_handle_dirty_dx_node(frame->bh)
         f. do_split    // ret err!
         g. add_dirent_to_buf
             ext4_mark_inode_dirty(dir)  // udpate raw_inode on disk(skippe=
d)
    2. fsck -a /dev/sdb
     drop last block(dx_node) which beyonds dir's i_size.
      /dev/sdb: recovering journal
      /dev/sdb contains a file system with errors, check forced.
      /dev/sdb: Inode 12, end of extent exceeds allowed value
            (logical block 128, physical block 3938, len 1)
    3. fsck -fn /dev/sdb
    dx_node->entry[i].blk > dir->i_size
      Pass 2: Checking directory structure
      Problem in HTREE directory inode 12 (/dir): bad block number 128.
      Clear HTree index? no
      Problem in HTREE directory inode 12: block #3 has invalid depth (2)
      Problem in HTREE directory inode 12: block #3 has bad max hash
      Problem in HTREE directory inode 12: block #3 not referenced

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
