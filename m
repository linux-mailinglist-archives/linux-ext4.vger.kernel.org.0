Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF772F520
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbjFNGqJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 02:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbjFNGqI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 02:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D2E41
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 23:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DF2637DB
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 06:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EFE6C433C0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 06:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686725166;
        bh=L+gqNNg0wWwUIoTLzLylpOKazoaoO40XGGst0KTZlpA=;
        h=From:To:Subject:Date:From;
        b=frBSN+qq4vZC5MHJsZcpUGZiobOgC9EEzutzcP+JZ5u+FPKDspgru4XY1a34v5SV8
         1vnJd2U2yV1TWRd6naqaBx1L4FhqNwNyK1lZTwXEkVinLUxhCueR+CbaVelavkqp/N
         JwRyXChgffSKcLfXHHUhShJe+qU48MZZAakh909vSRMYRizMb2saEIx5ml5EtUloV0
         nyZN6mc+qRamB0Z4YYtLcd1sk0xQ3+8LP/M9FcP85vNSHcnkLNg+QjJse8igtUlJzi
         poWVh9FNqvH1eode6PjKnFa4jrIRSD4LdILxjvLWyEvFuZkcIHvbdXaIBAot+Phrul
         rKdyXcLwued+Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6BF04C53BD0; Wed, 14 Jun 2023 06:46:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217551] New: Unable to umount block device
Date:   Wed, 14 Jun 2023 06:46:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: barhatesw09@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217551-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217551

            Bug ID: 217551
           Summary: Unable to umount block device
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: barhatesw09@gmail.com
        Regression: No

Unable to umount the block device because it is still in use by jbd2 proces=
s.



ps command output.

root     131678  0.0  0.0      0     0 ?        S    May19   0:10  \_
[jbd2/nvme4n1-8]

This process is in sleep state for long time and not leaving the device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
