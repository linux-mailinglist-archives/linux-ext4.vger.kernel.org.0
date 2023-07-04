Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B123C746DDB
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGDJnb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGDJms (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 05:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960BE7A
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 02:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11E86113E
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 09:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C8AEC433C7
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688463405;
        bh=ycO6mYBZi7HNFp+DufuU3G2ki2Ws1zZ/iyugkqJ82Us=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WvpPeJHiTMz/gjRS3Xwh1YM/U7kLRjFPBLVO7OmifgipqwXCBwZwfyjXFt9IkyTub
         ewQ9oCUWCCfkLH9kTjx2RUUZ//ysZFRGn035OykwWQylY81eSJzvRW1nndD3mkFCjN
         NleXRN+PyYR0qbcr8n/+FTUfPScr//Bu9Fa1Zhr6A1Kk8M/yag2/o3ahCUpHPETbGp
         +kD36PIby5mw9+adVg08Lr/eRYEtSEHU3KuxBSRqdmlGnSjVdgpBcPvErD6LPu8gk0
         QzMeLMw9V4yivEG9BPm2f/TAqTu1RGAt+j2wF6Xx+QE8yEScvTCvslgSSNDM46/8oU
         EZjm4e1UOQ0eQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 482CAC53BD0; Tue,  4 Jul 2023 09:36:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217633] the insertion of disk  to  DVD make bad remout /dev/sda
Date:   Tue, 04 Jul 2023 09:36:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: rouckat@quick.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-217633-13602-INkmHerXkA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217633-13602@https.bugzilla.kernel.org/>
References: <bug-217633-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217633

rouckat@quick.cz changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|normal                      |high

--- Comment #1 from rouckat@quick.cz ---
after the insertion goes /sda out from partitions table.

 0    7018942 sr0
 259        0  500107608 nvme0n1
 259        1     614400 nvme0n1p1
 259        2    1048576 nvme0n1p2
 259        3  497394688 nvme0n1p3
 259        4    1048576 nvme0n1p4
 252        0    8388608 zram0
   8       16   30375936 sdb
   8       17   30374912 sdb1

monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

KERNEL[10871.772732] change=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata5/host4/target4:0:0/4:0:0:=
0/block/sr0
(block)
KERNEL[10876.433514] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
KERNEL[10876.433570] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
KERNEL[10876.433597] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
KERNEL[10876.433618] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
UDEV  [10876.441039] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
UDEV  [10876.441133] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
UDEV  [10876.442675] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
UDEV  [10876.442929] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
KERNEL[10876.457419] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda/sda1
(block)
KERNEL[10876.457471] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda/sda2
(block)
UDEV  [10876.460502] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda/sda1
(block)
UDEV  [10876.460602] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda/sda2
(block)
KERNEL[10876.461050] remove   /devices/virtual/bdi/8:0 (bdi)
KERNEL[10876.461071] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda
(block)
UDEV  [10876.462135] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sda
(block)
UDEV  [10876.463158] remove   /devices/virtual/bdi/8:0 (bdi)
KERNEL[10876.473176] unbind=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10876.473201] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10876.473211] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
UDEV  [10876.474368] unbind=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10876.475291] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10876.476240] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
UDEV  [10879.958313] change=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata5/host4/target4:0:0/4:0:0:=
0/block/sr0
(block)
KERNEL[10880.138548] add      /module/crc_itu_t (module)
UDEV  [10880.144065] add      /module/crc_itu_t (module)
KERNEL[10880.157417] add      /module/udf (module)
UDEV  [10880.158763] add      /module/udf (module)
KERNEL[10880.610168] change=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata5/host4/target4:0:0/4:0:0:=
0/block/sr0
(block)
UDEV  [10881.966211] change=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata5/host4/target4:0:0/4:0:0:=
0/block/sr0
(block)
KERNEL[10917.572773] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
KERNEL[10917.572845] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10917.572868] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
KERNEL[10917.572965] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
KERNEL[10917.573952] add      /devices/virtual/bdi/8:32 (bdi)
KERNEL[10917.575162] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
KERNEL[10917.575242] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
UDEV  [10917.580543] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
UDEV  [10917.582646] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10917.584954] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
UDEV  [10917.586523] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
UDEV  [10917.587248] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
UDEV  [10917.589603] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
UDEV  [10917.595180] add      /devices/virtual/bdi/8:32 (bdi)
KERNEL[10925.177408] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
KERNEL[10925.177475] bind=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10929.265960] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
KERNEL[10929.266787] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
KERNEL[10929.266833] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
KERNEL[10929.266854] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
KERNEL[10929.266875] remove   /devices/virtual/bdi/8:32 (bdi)
KERNEL[10929.267024] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
UDEV  [10929.269365] remove   /devices/virtual/bdi/8:32 (bdi)
KERNEL[10929.278135] unbind=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10929.278166] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10929.278177] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
UDEV  [10929.306227] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
UDEV  [10929.306267] bind=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10929.307983] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
UDEV  [10929.308041] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
UDEV  [10929.308055] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
UDEV  [10929.308372] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
UDEV  [10929.308726] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
UDEV  [10929.309769] unbind=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10929.310259] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10929.310681] remove=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
KERNEL[10932.500855] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
KERNEL[10932.500944] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
KERNEL[10932.500968] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
KERNEL[10932.500997] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
KERNEL[10932.501690] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
KERNEL[10932.501756] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
KERNEL[10932.501776] add      /devices/virtual/bdi/8:32 (bdi)
UDEV  [10932.508112] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0 (scsi)
UDEV  [10932.510222] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10932.512325] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_device/1:0:0:0
(scsi_device)
UDEV  [10932.514290] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_generic/sg0
(scsi_generic)
UDEV  [10932.514937] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/scsi_disk/1:0:0:0
(scsi_disk)
UDEV  [10932.515724] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/bsg/1:0:0:0
(bsg)
UDEV  [10932.539103] add      /devices/virtual/bdi/8:32 (bdi)
KERNEL[10932.642215] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
KERNEL[10932.642271] bind=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)
UDEV  [10932.694222] add=20=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:=
0/block/sdc
(block)
UDEV  [10932.700667] bind=20=20=20=20
/devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata2/host1/target1:0:0/1:0:0:0
(scsi)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
