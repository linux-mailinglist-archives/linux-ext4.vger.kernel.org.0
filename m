Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3B513442
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Apr 2022 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346716AbiD1M6a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbiD1M63 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 08:58:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E2949264;
        Thu, 28 Apr 2022 05:55:13 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 881A91EC04A6;
        Thu, 28 Apr 2022 14:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651150508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=crCnnWzrAN8x51FVwXTmr/bjEfSC5i6u3ErOccjZXEE=;
        b=N/QJVCaSj/s2DWZH0C8ol6WCxLpZTPmjSVPQft7LW+e8eHWyIEEkJdtnVRet3959sMLL5a
        TyRTiSXetS5UKiPD/IYWwoO5dp6AvLzC+rijJCHb8bFtJuLEkGuSnwWqyGLG5qOxjGTR0m
        F6Mmm02GyvxeTN/GzhxdYAc+JtIZtcA=
Date:   Thu, 28 Apr 2022 14:55:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-ext4@vger.kernel.org
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem
 failed CRC
Message-ID: <YmqOqGKajOOx90ZY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

the errors at the end of this mail come from one of my test boxes booted
with latest Linus:

8f4dd16603ce ("Merge branch 'akpm' (patches from Andrew)")

+ tip/master.

A second boot into the same kernel says:

[    5.427329] EXT4-fs (sda5): warning: mounting fs with errors, running e2fsck is recommended
[    5.435681] EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
...

[  316.621377] EXT4-fs (sda5): error count since last fsck: 14
[  316.621645] EXT4-fs (sda5): initial error at time 1651146136: ext4_update_backup_sb:165
[  316.621948] EXT4-fs (sda5): last error at time 1651146136: ext4_update_backup_sb:165


And it used to work fine with rc3:

EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.

so before I go and fsck the partition, I thought I should report it
first - maybe something new in ext4 land is not behaving as it should...

And since rc3 I see:

$ git log --oneline v5.18-rc3.. fs/ext4/
c00c5e1d157b Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
eb7054212eac ext4: update the cached overhead value in the superblock
85d825dbf489 ext4: force overhead calculation if the s_overhead_cluster makes no sense
10b01ee92df5 ext4: fix overhead calculation to account for the reserved gdt blocks
2da376228a24 ext4: limit length to bitmap_maxbytes - blocksize in punch_hole
c186f0887fe7 ext4: fix use-after-free in ext4_search_dir
b98535d09179 ext4: fix bug_on in start_this_handle during umount filesystem
a2b0b205d125 ext4: fix symlink file size not match to file content
ad5cd4f4ee4d ext4: fix fallocate to use file_modified to update permissions consistently

so there is something which just got applied...

[    4.742960] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    4.766518] loop: module loaded
[    4.836287] EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
[    4.840733] EXT4-fs (sda5): Invalid checksum for backup superblock 32768

[    4.843142] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.844802] EXT4-fs (sda5): Invalid checksum for backup superblock 98304

[    4.847239] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.848942] EXT4-fs (sda5): Invalid checksum for backup superblock 163840

[    4.851344] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.852919] EXT4-fs (sda5): Invalid checksum for backup superblock 229376

[    4.855270] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.856910] EXT4-fs (sda5): Invalid checksum for backup superblock 294912

[    4.859279] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.860946] EXT4-fs (sda5): Invalid checksum for backup superblock 819200

[    4.863429] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.865182] EXT4-fs (sda5): Invalid checksum for backup superblock 884736

[    4.867793] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.869583] EXT4-fs (sda5): Invalid checksum for backup superblock 1605632

[    4.872285] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.874109] EXT4-fs (sda5): Invalid checksum for backup superblock 2654208

[    4.877056] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
[    4.878751] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
