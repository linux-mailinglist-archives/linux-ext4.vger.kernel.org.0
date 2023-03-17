Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D86BDE26
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCQBbT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBbT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:31:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8896474E6
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C053B823D6
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AAC3C433EF
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679016675;
        bh=lhr/Nf5y+QVI0jnD9O6vFPHgK3Wqqc1AYO+pVn5FCJc=;
        h=From:To:Subject:Date:From;
        b=SO/9z+xVG3GKe+IHPLahEMc9p0fEciIkf8iIs2TdilSnZXlfXqG1DYP46K8PmQExK
         l1SgQVfZ0wT3MU0Nf5xx3w00x5/05s5Sgagthyn2D6QVSAG6GVvlCQBvz4jAxZ1XoW
         tQP/XiBuXx9RVmdB+y3K5bugd55RZxWCbu0J0SlFzfJ7TIn0E8udrQfDzbLLe0jZ8A
         6VaIfMxF2+UCskhWmgGu1E9txstpjN2ZEsfq4jUpFSiFyxyynxLwtkUK89h84FgB+u
         k+I5/GMHX/eSPCTbswgvTrMeOFP7O+ByGc5XDrnAsD92YhUy06Vydhr41fjYBRcKll
         sQ2lrwWmXrIPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E7DFFC43142; Fri, 17 Mar 2023 01:31:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217209] New: ext4_da_write_end: i_disksize exceeds i_size in
 paritally written case
Date:   Fri, 17 Mar 2023 01:31:14 +0000
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
Message-ID: <bug-217209-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217209

            Bug ID: 217209
           Summary: ext4_da_write_end: i_disksize exceeds i_size in
                    paritally written case
           Product: File System
           Version: 2.5
    Kernel Version: 6.3.0-rc2
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

Following process makes i_disksize exceed i_size:

    generic_perform_write
     copied =3D iov_iter_copy_from_user_atomic(len) // copied < len
     ext4_da_write_end
     | ext4_update_i_disksize
     |  new_i_size =3D pos + copied;
     |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
     | generic_write_end
     |  copied =3D block_write_end(copied, len) // copied =3D 0
     |   if (unlikely(copied < len))
     |    if (!PageUptodate(page))
     |     copied =3D 0;
     |  if (pos + copied > inode->i_size) // return false
     if (unlikely(copied =3D=3D 0))
      goto again;
     if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
      status =3D -EFAULT;
      break;
     }

We get i_disksize greater than i_size here, which could trigger WARNING che=
ck
'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:

    ext4_dio_write_iter
     iomap_dio_rw
      __iomap_dio_rw // return err, length is not aligned to 512
     ext4_handle_inode_extension
      WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
