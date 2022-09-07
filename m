Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC85B098F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIGQEd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGQEE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 12:04:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8119A5C7E
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 09:02:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 65so4851698pfx.0
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=12IUsA/cMwBIxeadxv4/3ocGPLCW9oxNtzio7zkZo5s=;
        b=iLmbipR98L0CUjb8dbJDqB4BFFegLd3o46lQmJv/oUKKR6MYjTvTI6TbdmUnlZUsMB
         1e6ZPjpZ7WaYuzfcR19RLDfGQwGfSgqCHfYc2ycU078nuMEULAMNMvmJwl//yvrjdTOx
         kLJ2mSCQdVE8a+TMW3N9iq7qut+2br5cDf1qbxWxHKKtQRtlNfeywsg72m95ZamLm+Jb
         NNTLVeDBaIoaJWrn0qeIHqBwdp13fx0j9k3FZ3+1CbzoVTEPensfG+DMHWCEri7LSOCZ
         IvmZPUqKA5IVjCRYrxN0h2Ovj8Hv7MU0KcEmiT+5O5QJJeKqFXa0U0g6i1vyYM8pC7xV
         iI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=12IUsA/cMwBIxeadxv4/3ocGPLCW9oxNtzio7zkZo5s=;
        b=qfc7gSJN6i3pnf5XEmuLUr8zvKBQdYIbVQydhj5KvIYGB1H9jMGkkmftKaZDaydPCN
         weqNe8ONakK/Mljvucvl/GOydF0Pc7cJ3NRVMaFXkUv0sv28XftNFxzNQydDtv4HjDk0
         VpioboHQtZGmeqwqlChDnx7bRxVZveq6dC2WipySsw+UAIvUJLCAPGk5jK7RS2riMn7t
         4x6klTvruIQDuVctDR7r9B2fL31vnwxLVGVN5LwetrhuakU+oUzO4F4DP2ffHqViguLK
         S9/TCT/EwiCrBVFJRt41qtoBVjwsmyOylbKjegHROHX3k76XDPl4sQlwtRTOLGKU4z9a
         /E+A==
X-Gm-Message-State: ACgBeo1aftzAwWVw/qYABlvvENbudLM3/h2QvLYblmq3OFgKE9lsPatd
        84aswiUtN/LsfqeWg/sNOFcw9/KA8HQzP143dRlQl1eYMlU=
X-Google-Smtp-Source: AA6agR4j6iFKRk59npYGg1dIx4kt8YC4qjfdMVfbKycTBsi6/0NPkLWmb0jTab4Bsmd2cZiim9nBBIdNyqYsWCXUpBI=
X-Received: by 2002:aa7:9532:0:b0:53e:7875:39e1 with SMTP id
 c18-20020aa79532000000b0053e787539e1mr3253419pfp.82.1662566539868; Wed, 07
 Sep 2022 09:02:19 -0700 (PDT)
MIME-Version: 1.0
From:   Luigi Fabio <luigi.fabio@gmail.com>
Date:   Wed, 7 Sep 2022 12:01:45 -0400
Message-ID: <CAJJqR22VOFHTrvE6uc02bcoCsSFck7JX-bJYr4TbJCVhpftCwg@mail.gmail.com>
Subject: Ext4 filesystem recovery after mdraid failure -2
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I am encountering an unusual problem after an mdraid failure, I'll
summarise briefly and can provide further details as required.

First of all, the context. This is happening on a Debian 11 system,
amd64 arch, with current updates (kernel 5.10.136-1, util-linux
2.36.1).

The system has a 12 drive mdraid RAID5 for data, recently migrated to
LSI 2308 HBAs.
This is relevant because yesterday, at around 13,00 local (EST), four
drives, an entire HBA channel, decided to drop from the RAID.

Of course, mdraid didn't like that and stopped the arrays. I reverted
to best practice and shut down the system first of all.

Further context: the filesystem in the array is ancient - I am vaguely
proud of that - from 2001.
It started as ext2, grew to ext3, then to ext4 and finally to ext4 with 64 bits.
Because I am paranoid, I always mount ext4 with nodelalloc and data=journal.
The journal is external on a RAID1 of SSDs.
I recently (within the last ~3 months) enabled metadata_csum, which is
relevant to the following - the filesystem had never had metadata_csum
enabled before.

Upon reboot, the arrays would not reassemble - this is expected,
because 4/12 drives were marked faulty. So I re--created the array
using the same parameters as were used back when the array was built.
Unfortunately, I had a moment of stupid and didn't specify metadata
0.90 in the re--create, so it was recreated with metadata 1.2... which
writes its data block at the beginning of the components, not at the
end. I noticed it, restopped the array and recreated with the correct
0.90, but the damage was done: the 256 byte + 12 * 20 header was
written at the beginning of each of the 12 components.
Still, unless I am mistaken, this just means that at worst 12x (second
block of each component) were damaged, which shouldn't be too bad. The
only further possibility is that mdraid also zeroed out the 'blank
space' that it puts AFTER the header block and BEFORE the data, but
according to documentation it shouldn't do that.
In any case, I subsequently reassembled the array 'correctly' to match
the previous order and settings and I believe I got it right. I kept
the array RO and tried fsck -n, which gave me this:

ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext4: Group descriptors look bad... trying backup blocks...

It then warns that it won't attempt journal recovery because it's in
RO mode and declares the fs clean - with a reasonable looking number
of files and blocks.

If I try to mount -t ext4 -o ro, I get :

mount: /mnt: mount(2) system call failed: Structure needs cleaning.

so before anything else, I tried fsck -nf to make sure that the REST
of the filesystem is in one logical piece.
THAT painted a very different picture:
On pass 1, I get approximately 980k (almost 10^6) of
Inode nnnnn passes checks, but checksum does not match inode
and ~ 2000
Inode nnnnn contains garbage
Plus some 'tree not optimised' which are technically not errors, from
what I understand.
After ~11 hours, it switches to 1b, tells me that inode 12 has a long
list of duplicate blocks

Running additional passes to resolve blocks claimed by more than one inode...
Pass 1B: Rescanning for multiply-claimed blocks
Multiply-claimed block(s) in inode 12: 2928004133 [....]

And ends after the list of multiply claimed blocks with:

e2fsck: aborted
Error while scanning inodes (8193): Inode checksum does not match inode

/dev/md123: ********** WARNING: Filesystem still has errors **********


/dev/md123: ********** WARNING: Filesystem still has errors **********

So, what is my next step? I realise I should NOT have touched the
original drives and dd-ed images to a separate array to work on those,
but I believe the only writing that occurred were the mdraid
superblocks.

Where do I go from here?

Thanks!
