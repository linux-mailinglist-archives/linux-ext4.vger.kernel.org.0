Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047E05B068E
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIGO2s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIGO2g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 10:28:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04D784EE0
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 07:28:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so14974590pji.1
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=12IUsA/cMwBIxeadxv4/3ocGPLCW9oxNtzio7zkZo5s=;
        b=EntiqgPBDNS4gM6mqwS15o/ZX0gKmm835b1vEUMAL3kN0DIcQ0TfIg1MORJ3FeqgAq
         ZXxqYa6Cy02HRnxgKj/6++outami4aDrHHYS5dKlD86Aza/Xo44TR2n1/6Ch8iacRBAG
         4Gkg4OCvdrBo5jkfVDk8Mz/XUPGnHEas1WY8NtCiFP5/xyH3j4Rm70tG9dvGd58nctM6
         545c3F+zjqfCQZYoVJNjSeDxn47ZczpXy2ZHJjPMh2nS84YowlJOVGptBybBKSpJ1pAn
         f9k1xno5iAlicUXxVOl3pbCKLytYf2ZalL8oLj++bNM719ZRPcgt6YiV4zsMFiS9Wetg
         yNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=12IUsA/cMwBIxeadxv4/3ocGPLCW9oxNtzio7zkZo5s=;
        b=Aw8VGmW2zeeyQYwEKmcAYQkGjDb++URn8nIi0jxSDrl6M2rokj7wIYUxHnvgUYd3h2
         7ObGK1jrVESwbfKgsvZV76iZPEvFI0uFKdIK+ZDlQPtCqO82XNrTh6U/U7tU52Xbe1Oz
         raO21NyvEGEcw7zid2lf9m+05FnYqAuxGVyJgj/hmcb6AdxbeXxwIW8etrGNecOpm9jx
         E9kDR9UmEq3L16xY8W7zGe91th3u8ZHq9GKVCKZIU2BWxm1OH81MK4UI5L0M/5ILoJvq
         vnGZ7+RArpL/pggYjA0kharssWjKCZW3jHV/MysXsjYRceIzCCKnjDpfPAIQERCofevK
         lTGQ==
X-Gm-Message-State: ACgBeo1D0u9YsaZFSPSKrJpfSXXJr/N5Yu2GVX7a8hGsidIUf8Ccz562
        PnGeX490vIbMPFm352Dwl6t8kk6F9dYppIvUkIUZFtH3
X-Google-Smtp-Source: AA6agR6gn5iGsng7/8Z4oaqqBpruhE2SWx5AEpupp26ppwI/Mqr5uLIJpl/K4kpjwlr6dsv7tA3KI9hxsVxGWSdmfK0=
X-Received: by 2002:a17:903:1250:b0:172:614b:5f01 with SMTP id
 u16-20020a170903125000b00172614b5f01mr4162412plh.103.1662560868490; Wed, 07
 Sep 2022 07:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJJqR23jhPAgPQQ0F=3L4QG7gu7EqyocUyzRTRftEWAGQqHVQA@mail.gmail.com>
In-Reply-To: <CAJJqR23jhPAgPQQ0F=3L4QG7gu7EqyocUyzRTRftEWAGQqHVQA@mail.gmail.com>
From:   Luigi Fabio <luigi.fabio@gmail.com>
Date:   Wed, 7 Sep 2022 10:27:14 -0400
Message-ID: <CAJJqR20TR=QDnn9U7NPy=hCRbq-eMa8PjQ2-HsuRrpmybwTOpg@mail.gmail.com>
Subject: Fwd: Ext4 filesystem recovery after mdraid failure
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
