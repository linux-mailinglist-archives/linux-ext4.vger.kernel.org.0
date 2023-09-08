Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDD7984C9
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjIHJ23 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJ22 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 05:28:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413011B
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 02:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 790B1C433CA
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694165304;
        bh=CAJQ5M2YfV4UhIKVfcCErwIvVsW/mmBhwZAEwJoRaAs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BVjG1DInEFiHJ0foIc0m3werUsnhatgRQNGi9MSCHAxAiurVzpS78YpW8SiJvQt/a
         IuChjlYZE0KeQTW2OaZ7hFapbVE39KpXaZTEmVjzyDP7QkrCXkiIF3DUSYFIUQa2w4
         XCjpTiRXwzFpPq4pWAP4TUWuyzxr4Rg2IXxWIS6OE9M6vckeqIaIo2yZM1Aa+/aOdr
         uTFmKljV5shObzgyR/ewYbJCr2g4hZ10uBnsV3W3jM25Fybt3z86T3HTUJTLKAM40p
         Vgzlwm0gv5IrqmBrraeOiHm6MQD7zmAZTu5VskOFVIXm+p7yqHz+8d2x1l3/FSbeg4
         EGMBi9+ulnW+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F0B2C53BCD; Fri,  8 Sep 2023 09:28:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217888] jbd2: potential data lost in recovering journal raced
 with synchronizing fs bdev
Date:   Fri, 08 Sep 2023 09:28:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217888-13602-EMgyxMQCPa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217888-13602@https.bugzilla.kernel.org/>
References: <bug-217888-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217888

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
1. Apply diff_v2 and compile kernel
2. dd if=3Ddisk of=3D/dev/sda bs=3D1M
3. mount /dev/sda temp # will stuck
4. sync /dev/sda # Type this command in another terminal, finish it in 5s w=
hen
you see "wait sync" from dmesg.
4. umount temp
5. fsck.ext4 -fa /dev/sda
/dev/sda: Unattached inode 13


/dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
'touch file' is recorded in journal of sda, and the journal is not replayed
yet.

journal in sda:

Journal starts at block 1, transaction 2
Found expected sequence 2, type 1 (descriptor block) at block 1
Dumping descriptor block, sequence 2, at block 1:
  FS block 84 logged at journal block 2 (flags 0x0)
  FS block 2 logged at journal block 3 (flags 0x2)
  FS block 89 logged at journal block 4 (flags 0x2)  # new inode
  FS block 86 logged at journal block 5 (flags 0x2)
  FS block 726 logged at journal block 6 (flags 0x2) # new dentry
  FS block 1 logged at journal block 7 (flags 0x2)
  FS block 83 logged at journal block 8 (flags 0xa)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
