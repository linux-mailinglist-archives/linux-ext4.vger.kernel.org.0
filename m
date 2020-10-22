Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDC2963DE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369251AbgJVRqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900872AbgJVRqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Oct 2020 13:46:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F0C0613CE
        for <linux-ext4@vger.kernel.org>; Thu, 22 Oct 2020 10:46:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c21so2839023ljn.13
        for <linux-ext4@vger.kernel.org>; Thu, 22 Oct 2020 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8DYedgE68XpH6Jv2OIAu/pGOnfmiwDd3xlQqa3m/TJg=;
        b=djYP5VsrmppzGS2CsHb7ZslNEI18qN69EdtZw4yeFtn2WuWc+Z5OQiIXvmTQR4mUSY
         alnVvHWlwrRQ0pORAt/Ax/vRDoI9mcP1KvrxV4lZX+PKh2YP8AilM84Wy3Zy5xEKnhPH
         bpHuKNoULzwVTdv9DXorGtO3RE5/iRZ31Wi8+BBIZC6mj+XVUToEFlcisNOFUnEhMojq
         wHWvJz4XVPGCT0aEKwQD4Ab519oS2USnHGyTolDB1+KLBlLQZrfuTn9S4+VKCeh98C5L
         /9Ko4B1AVo7W8tRWwPRKenJtvxJHJL39f5xWpGXCr467cQ/JTPlqJPEyCq8aXUV7kgH6
         KIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8DYedgE68XpH6Jv2OIAu/pGOnfmiwDd3xlQqa3m/TJg=;
        b=h2vlqXHQv0o+AcNe1vQU9FriFQDoLKSgYmOvfISD1E0nfSMLPGFrONS62LxHemfMbw
         7a4Im2jJ2rZrDObbyoGjpStENfDo1AAP/lTF1foNcNFwAwUGs91ZHwvHZcGqG+mafcW3
         TSjp/3ZHlt1Zv1J4iNQIwdxrwP9EIsXI5MqBbinNzqPr/1+5QOQ5+ka6xGFy6NQHQIiL
         uOzV/RN3JTiO1s+SBeSYvMwD26du2KT9z0pl0K3+t3NtnEveIKIAVIzS/BuzkePu3Lbd
         2Xs4cjOSSPdUUgrkSHaYIZQ9H8X0LreZyUmh7JnrtJcuTSQIYq05uiuqbm8tC2Y4QJ/L
         xCxA==
X-Gm-Message-State: AOAM532ymkN1LAVes8bRahg6EmyfKsLiF13UUT2k5fVkByBEyXWK2cCc
        7Z8+nji4OTDAYLZSNDb3+UDGYnjv4o++HHCaBOjOhFERBpY0IQ==
X-Google-Smtp-Source: ABdhPJxYQpa/+/ZCp/9cWdQ/PSeS3sZgImeI2xhycyknBG0Xti4Oz+mNAIbQ1XugY01iOmRsfy1Jhbgfo63jn0XIUSQ=
X-Received: by 2002:a2e:b4f8:: with SMTP id s24mr1355995ljm.399.1603388789630;
 Thu, 22 Oct 2020 10:46:29 -0700 (PDT)
MIME-Version: 1.0
From:   Radivoje Jovanovic <radivojejovanovic@gmail.com>
Date:   Thu, 22 Oct 2020 10:46:18 -0700
Message-ID: <CAJJtKouWTz2bZC8nUr4G8v=7Hh4-AbYg7Ea3yKk4Mk2gSRuP1g@mail.gmail.com>
Subject: ext4 and dd of emmc
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,
I am creating empty  4GB ext4 partition on emmc with parted like this:
parted -s -a optimal /dev/emmcblk0 mkpart data ext4 1024 5120
mkfs.ext4 /dev/mmcblk0p7 (this is the partition that was created in
the previous step)

I do not mount this partition before I do dd of the emmc.
dd of the emmc is done like this:
dd if=/dev/emmcblk0 | gzip -c | dd of=./image.bin

after this I write back the emmc with the same binary file:
dd if=./image.bin | gunzip -c | dd of=. /dev/emmcblk0

now I boot the system and mount the partition from the emmc.

at the boot the kernel reports:
EXT4-fs (mmcblk0p7): warning: mounting fs with errors, running e2fsck
is recommended

after the system is fully booted I see errors such as:
EXT4-fs error (device mmcblk0p7): ext4_journal_check_start:61:
Detected aborted journal
Buffer I/O error on dev mmcblk0p7, logical block 0, lost sync page write
EXT4-fs (mmcblk0p7): I/O error while writing superblock

All other partitions on the system are ReadOnly so probably that is
why I do not see errors for them

I am running custom Yocto build on this.
the kernel is vanilla 5.4.57 with an additional pci driver we have.

Any idea why this is happening?

Thanks
Ogi
