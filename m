Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B302426F9C
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJHRfF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Oct 2021 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhJHRfF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Oct 2021 13:35:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F25C061570;
        Fri,  8 Oct 2021 10:33:08 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c7so10216177qka.2;
        Fri, 08 Oct 2021 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=90AWJge43daG8GdfTEihIy4zggiOitXVlp/QLEZrmTs=;
        b=emeolH1EP0cXhs+W7CySxz1wJ3czxvOH4TWi7/g5tMemtZk3lMKQnUZeA654Ik0ABR
         jkGJx7ZtWvDQGamcwrYMMn+zu3Vdn3iZ6ElrJv5GLsuoeTvOBdNS0EMI4IKH094IEZIh
         +6VUFkJdA8VyUhu3kYS8EFX0SjNuVv0NOoEfIhsvAVXYPZQ+rCv8I7de/DnCqXUv9Y1R
         Leln91vHhszRZBDiXj24IFbUTizk4f2nc6G9LlbBxUiSlkV8fQZhrKGZ83+ex22CNpA/
         hFJQPl8idUQ+yBcZi36SpQMBKxOxxV+JyglpUNXJnOD5zjhSnE/KS10jp9obYd2o4aCO
         7mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=90AWJge43daG8GdfTEihIy4zggiOitXVlp/QLEZrmTs=;
        b=zB0vziDxDs+MAnSZanUoOWF8IgHgmHJ25ut6FKDmr7seRPYI4p+e+Rh23d5tIpoSRo
         OHiUEn/xJ4b3rda4vDeQw9eNbEFpeHu2yiBTVgoiugjWAvZRF5ICmRrPoVwwCElRORNR
         yslDOvY6x7HXqJRmlJMBo+oyiiPyvjlOeh22DIoXXFSvjNhAXrH90lSJtyYfB8mUm8mr
         +vmUcIcPgjr8hyK10h39ucDDpPBP0fTBpsexmz01h1cHgJ235dORMw+iRV+9zHZ/EZs5
         8MR9hGuvcZ58NWyRM0PjcmAwgPelW8DAiPHdrmOcUo4pHSuBPjcwe1OT8vn525lhwvzp
         LZPA==
X-Gm-Message-State: AOAM532aa/+X4DdZR4HpASNt+HGLGyGHK6MOCrf/Qrg2yTfxcY/GqfXO
        SjeDxctC0AEF83GrrZUFrKg=
X-Google-Smtp-Source: ABdhPJzwLa5J+jZuw6g3NzLCvzGbhyTSx963xN+dkaZinR3Hl07pz8kXu84O8jNZv5Eyq8/gAYoU7Q==
X-Received: by 2002:a05:620a:5fb:: with SMTP id z27mr4048480qkg.83.1633714387626;
        Fri, 08 Oct 2021 10:33:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id m1sm2580233qtu.59.2021.10.08.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:33:07 -0700 (PDT)
Date:   Fri, 8 Oct 2021 13:33:05 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: kernel BUG at fs/ext4/inode.c:1721!
Message-ID: <20211008173305.GA28198@localhost.localdomain>
References: <YWANK0HchPv9m6hA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWANK0HchPv9m6hA@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Borislav Petkov <bp@alien8.de>:
> Hi folks,
> 
> I noticed the below splat after using my box for a while (i.e., it was
> still pretty responsive). Kernel is linus/master from the middle of this
> week + tip/master.
> 
> Lemme know if you need any other info.
> 
> Thx.
> 
> [38810.312439] ------------[ cut here ]------------
> [38810.317027] kernel BUG at fs/ext4/inode.c:1721!
> [38810.321532] invalid opcode: 0000 [#1] PREEMPT SMP
> [38810.326207] CPU: 10 PID: 24284 Comm: ThreadPoolForeg Not tainted 5.15.0-rc4+ #1
> [38810.326210] Hardware name: Micro-Star International Co., Ltd. MS-7B79/X470 GAMING PRO (MS-7B79), BIOS 1.70 01/23/2019
> [38810.326211] RIP: 0010:ext4_da_get_block_prep+0x3fd/0x440
> [38810.326218] Code: ff ff f0 80 0b 20 0f 1f 80 00 00 00 00 e9 ed fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 e8 5b 95 fe ff 41 89 c4 e9 04 fe ff ff <0f> 0b 0f 0b 48 8b 7d 28 89 04 24 45 89 e1 4c 8b 45 38 48 c7 c1 10
> [38810.367814] RSP: 0018:ffffc90002fdfc18 EFLAGS: 00010206
> [38810.367818] RAX: 0000000000000001 RBX: ffff8881773226e8 RCX: 0000000000000004
> [38810.367820] RDX: 27ffffffffffffff RSI: 0000000000000001 RDI: ffff8881dced03b8
> [38810.367821] RBP: ffff8881dced0118 R08: 0000000000000001 R09: ffff8881773226e8
> [38810.367823] R10: 0000000000001000 R11: ffff8887feeae3e0 R12: 0000000000000003
> [38810.367824] R13: ffffffffffff0000 R14: 0000000000000000 R15: 0000000000000003
> [38810.367825] FS:  00007f135f7fe700(0000) GS:ffff8887fee80000(0000) knlGS:0000000000000000
> [38810.416367] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [38810.416370] CR2: 00007f9450fd8658 CR3: 0000000103ec5000 CR4: 00000000003506e0
> [38810.416371] Call Trace:
> [38810.416373]  <TASK>
> [38810.416374]  ? alloc_buffer_head+0x1b/0x80
> [38810.416380]  __block_write_begin_int+0x171/0x650
> [38810.416384]  ? ext4_da_release_space+0x120/0x120
> [38810.446889]  ext4_da_write_begin+0x107/0x280
> [38810.446893]  ? generic_write_end+0xf6/0x150
> [38810.446896]  generic_perform_write+0xaf/0x1c0
> [38810.446899]  ext4_buffered_write_iter+0xbb/0x180
> [38810.464182]  new_sync_write+0x10b/0x190
> [38810.464187]  vfs_write+0x216/0x2d0
> [38810.464190]  ? __fget_files+0x6b/0xa0
> [38810.464193]  __x64_sys_pwrite64+0x87/0xb0
> [38810.478984]  do_syscall_64+0x3b/0x80
> [38810.478987]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [38810.478991] RIP: 0033:0x7f13a836c9c7
> [38810.478994] Code: 08 89 3c 24 48 89 4c 24 18 e8 55 f3 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 85 f3 ff ff 48 8b
> [38810.478997] RSP: 002b:00007f135f7fc840 EFLAGS: 00000293 ORIG_RAX: 0000000000000012
> [38810.509680] RAX: ffffffffffffffda RBX: 00007f135f7fc890 RCX: 00007f13a836c9c7
> [38810.509681] RDX: 000000000000051a RSI: 00007f13908549d0 RDI: 00000000000000eb
> [38810.509683] RBP: 00007f135f7fc930 R08: 0000000000000000 R09: 00007ffc27dbc090
> [38810.509684] R10: 0000000000002bff R11: 0000000000000293 R12: 0000000000002bff
> [38810.509685] R13: 00007f1344003a60 R14: 00007f13908549d0 R15: 000000000000051a
> [38810.509688]  </TASK>
> [38810.509688] Modules linked in: fuse essiv authenc nft_counter nf_tables libcrc32c nfnetlink vfat fat loop dm_crypt dm_mod amd64_edac edac_mce_amd kvm_amd snd_hda_codec_realtek snd_hda_codec_generic kvm led_class ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_pcm irqbypass crct10dif_pclmul snd_timer crc32_pclmul crc32c_intel snd ghash_clmulni_intel pcspkr k10temp soundcore gpio_amdpt gpio_generic acpi_cpufreq radeon aesni_intel crypto_simd cryptd pinctrl_amd
> [38810.598925] ---[ end trace c014409ea194e650 ]---
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Hi, Boris - thanks very much for your report.

Was your kernel configured with the CONFIG_FS_ENCRYPTION option?

Could you please provide the output of the mount command for the affected
file system?

Do you recall what sort of code might have been running on this system at
the time of failure (for example, kernel build, desktop apps, etc.)?

Thanks,
Eric



