Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67258674BEF
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jan 2023 06:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjATFPI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Jan 2023 00:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjATFOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Jan 2023 00:14:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855E45216
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 21:03:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A0D9B826F6
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2290C433D2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674152743;
        bh=VZ4zy8w3DrCA6zSoyAD6X1i8oJ8Q1eFp3hYs1V8ecpc=;
        h=From:To:Subject:Date:From;
        b=UZdNSg0dG75NHNQr5RFEnXLa7I7csldfr5+J5r8hAyFAFhC11Q216Xk56cdb0r9Vo
         2fE8RwuxqZgciuEM4KUMDf8unLTCRgft6W2USNRDAPQDH985fbLXhKYmuL4/vTEOr4
         QW+KJjituStg4HTmbH6TNKzC4PFRx9nIPAeIE54PSJ9vHHNos7Ldqm0iz+V317nT5/
         lu+IHaQIdPodLKExhWTum7YAHurlU06EKwVwb+Yjdxo2qkrUcMHY8q+NVuYTMxAgD7
         fEtdJHziVlpohGI2nIAet0OVYL69tcB2ZspKEh68LDUE26EVZCU6M8Y6NOkFY7BsPU
         HEfmW3pdwzQbQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AA63DC43143; Thu, 19 Jan 2023 18:25:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216953] New: BUG: kernel NULL pointer dereference, address:
 0000000000000008
Date:   Thu, 19 Jan 2023 18:25:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gjunk2@sapience.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216953-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216953

            Bug ID: 216953
           Summary: BUG: kernel NULL pointer dereference, address:
                    0000000000000008
           Product: File System
           Version: 2.5
    Kernel Version: 6.1.7
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: gjunk2@sapience.com
        Regression: No

Created attachment 303627
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303627&action=3Dedit
kernel config

System has RAID6 with ext4 filesystem - 6 x 8TB drives.

Attached are config used to build kernel, output of ver_linux, the raw jour=
nal
as well as same run through scripts/decode_stacktrace.sh.

Note that while selinux is in kernel, there it is not being used.

thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
