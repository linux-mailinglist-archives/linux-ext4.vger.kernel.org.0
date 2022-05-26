Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B553510B
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiEZOyK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 May 2022 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiEZOyJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 May 2022 10:54:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502C2BB36;
        Thu, 26 May 2022 07:54:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so1896999pfb.4;
        Thu, 26 May 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zzUSbIDV6VxR0GTJ7iXm248cpfjhPV72ZVfhqRHwKw=;
        b=W14ahi10HyfOmAwUNM5TYQN+QVo3/aZSEbExUD/Itx/DPz0rxxr+OIjPXCYzMw9sGa
         XSHgcYDaASuy/rdpm254Rw6tEUPL2pNRIC7Q/Fe3qh+9OsK3vVzzfYEa1lMF+qXJ5bsj
         KRMPs7ksEjmV/jD4PRO52J8T+XEPy3DFMQBdKNyP+9s/+Z7KeywgjRwH4/7ppi3HqeSN
         +25vRfQwvGYOQw29IJyK1PBV5Bx3brF57Yjek2H5LaHskx7Ru4cmEPiD++LZM3LHRJkz
         WsSi1gXfO+BhUHqFM7qabO85jpeDeGMMUHcVhOH2CuFdig5XTIa0Q5dRT/JrLFOwEoPN
         SQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zzUSbIDV6VxR0GTJ7iXm248cpfjhPV72ZVfhqRHwKw=;
        b=ib2B8w+D4t3YKfHpqXaiePSJKV7sPEbqgH7zCpSxWTd5jXQRaqwyU/rU2/JVf2L2QO
         pejU3sHx2oViST5DwgFc8Rya5uz1rAKxWa68JRx0fbqFa+rjyApHXI4/jjvNTsORqA1G
         vtWwP0DIh/wQMrMrwKdaGTUaGYL/vrR1v2yVI08GW3c2P+eEJ8MvbHRKMW6gwC5WMbnE
         //Vo9yGYcWNbYbyPYNm2RC6n4y4Ry5OVcYtN0f50f/8DV5kAyJU617mIkB+0VRQFsh7r
         JJPczz+DgMEVoG9sGt0yTWx9NXYg3VX+Fcd5R4nuIY2pt0RX5CQ9PFvAVWgM/yYO/NHh
         mK6w==
X-Gm-Message-State: AOAM531f+sHKX7UWNCjwZlIDfBG2Vved7YoWeYQ7+oydfUKr/FwgI4ll
        YfIv4bOrbN/ZPjITlOAs9a4=
X-Google-Smtp-Source: ABdhPJzrTF02sZBmXr4xnKQtYHxMvtldEBdVSiPm7U6LIHz7+h9ETJKFVE+RfcWF0dULQUPrfoCr3A==
X-Received: by 2002:a65:4185:0:b0:399:4c59:e3b1 with SMTP id a5-20020a654185000000b003994c59e3b1mr32707007pgq.154.1653576847796;
        Thu, 26 May 2022 07:54:07 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b0050dc7628137sm1660528pfo.17.2022.05.26.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:54:07 -0700 (PDT)
Date:   Thu, 26 May 2022 20:24:02 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: EXT4-fs error (device sda5) in ext4_update_backup_sb:165:
 Filesystem failed CRC
Message-ID: <20220526145402.slc4ve5vrlewyutm@riteshh-domain>
References: <YmqOqGKajOOx90ZY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqOqGKajOOx90ZY@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/04/28 02:55PM, Borislav Petkov wrote:
> Hi,
>
> the errors at the end of this mail come from one of my test boxes booted
> with latest Linus:
>
> 8f4dd16603ce ("Merge branch 'akpm' (patches from Andrew)")
>
> + tip/master.
>
> A second boot into the same kernel says:
>
> [    5.427329] EXT4-fs (sda5): warning: mounting fs with errors, running e2fsck is recommended
> [    5.435681] EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
> ...
>
> [  316.621377] EXT4-fs (sda5): error count since last fsck: 14
> [  316.621645] EXT4-fs (sda5): initial error at time 1651146136: ext4_update_backup_sb:165
> [  316.621948] EXT4-fs (sda5): last error at time 1651146136: ext4_update_backup_sb:165

Could you please help us understand little more about your setup. Is this (sda5)
somehow a backup image saved/restored using e2image?

>
>
> And it used to work fine with rc3:
>
> EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
>
> so before I go and fsck the partition, I thought I should report it
> first - maybe something new in ext4 land is not behaving as it should...
>
> And since rc3 I see:
>
> $ git log --oneline v5.18-rc3.. fs/ext4/
> c00c5e1d157b Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> eb7054212eac ext4: update the cached overhead value in the superblock
> 85d825dbf489 ext4: force overhead calculation if the s_overhead_cluster makes no sense
> 10b01ee92df5 ext4: fix overhead calculation to account for the reserved gdt blocks

^^^ looks like these patches might have triggered the check on the backup
superblock if the on-disk s_overhead_cluster doesn't match with in kernel
calculation.

> 2da376228a24 ext4: limit length to bitmap_maxbytes - blocksize in punch_hole
> c186f0887fe7 ext4: fix use-after-free in ext4_search_dir
> b98535d09179 ext4: fix bug_on in start_this_handle during umount filesystem
> a2b0b205d125 ext4: fix symlink file size not match to file content
> ad5cd4f4ee4d ext4: fix fallocate to use file_modified to update permissions consistently
>
> so there is something which just got applied...
>
> [    4.742960] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
> [    4.766518] loop: module loaded
> [    4.836287] EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
> [    4.840733] EXT4-fs (sda5): Invalid checksum for backup superblock 32768
>
> [    4.843142] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.844802] EXT4-fs (sda5): Invalid checksum for backup superblock 98304
>
> [    4.847239] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.848942] EXT4-fs (sda5): Invalid checksum for backup superblock 163840
>
> [    4.851344] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.852919] EXT4-fs (sda5): Invalid checksum for backup superblock 229376
>
> [    4.855270] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.856910] EXT4-fs (sda5): Invalid checksum for backup superblock 294912
>
> [    4.859279] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.860946] EXT4-fs (sda5): Invalid checksum for backup superblock 819200
>
> [    4.863429] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.865182] EXT4-fs (sda5): Invalid checksum for backup superblock 884736
>
> [    4.867793] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.869583] EXT4-fs (sda5): Invalid checksum for backup superblock 1605632
>
> [    4.872285] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.874109] EXT4-fs (sda5): Invalid checksum for backup superblock 2654208
>
> [    4.877056] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC
> [    4.878751] EXT4-fs error (device sda5) in ext4_update_backup_sb:165: Filesystem failed CRC

All of the prints above shows the prints coming from ext4_update_backup_sb()
which is getting called during mount from ext4_fill_super() -> ext4_update_overhead()

So, recently I have also been reported with a similar problem, where in filesystem
image which was saved using e2image on v5.17 kernel (with e2fsck 1.45.5 (07-Jan-2020)).
Then on upgrading the kernel to v5.18, when this FS image (via e2image) was mounted
using loop device (or restored to a block device), the above error messages
were observed.

My theory so far is, that somehow the s_overhead_cluster calculation saved on
the disk was not correct (since I guess earlier version of e2fsprog 1.45.5 might
not be storing s_overhead_cluster information on disk durnig mkfs??).
Then on upgrading the kernel, the 3 patches mentioned would recalculate the
sbi->s_overhead for non-bigalloc filesystem during mount and if it doesn't match
the on disk es->s_overhead_cluster value, it will try to update all superblocks
via (ext4_update_overhead())

why CRC checksum failure -
	...Before updating backup superblock it will check the checksum to make sure
	that the superblock backup copy is not corrupt.
	And I guess e2image doesn't stores the backup superblocks while saving the
	image. So those blocks are all zeroed. Hence the superblock checksum problem
	is getting reported with the case which I am seeing it internally.

So, putting down my thoughts here for discussion -

- 1st is this consider a valid usecase to use e2image save/restore of disk image
  (users could backup using "-a" option which will also take the backup of all the FS
  data + critical metadata).

- Given we might use this way of updating backup superblock copies in kernel for
  even other values in future and users could upgrade their kernels but might
  still use older e2fsprogs, does it make sense to provide an option in e2image
  to save copies of backup superblocks too?

- I haven't yet spend much time for a solution for above problem. i.e. What
  should we do for users who might still might take up backup w/o this
  additional option to save backup superblocks. With this kernel thinks that the
  backup superblock is corrupt, since it's checksum doesn't match.

-ritesh
