Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A265CD40
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 07:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjADGnt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 01:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjADGnl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 01:43:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88E1157;
        Tue,  3 Jan 2023 22:43:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338C2615B9;
        Wed,  4 Jan 2023 06:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C343C433D2;
        Wed,  4 Jan 2023 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672814619;
        bh=6N2Ke/st2hAmX2V/VgSABXPm5IauQsGR3LMjD5iJN8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoPzNQXbuZbSVda/faaYideuP/YV0mH1Cm201igkahsCYWKp/9CZ7fq67eVdgST4g
         s74JrHfPByRtGaFM+mIG3FtWZmxD1fGOwFO9AkRs1Ccu3y4HVOmKlclhv9+jqFBZaN
         YYVZo/hWZ2LpSdE8Ugql18VpQ1ap3x4vWJS8v06L/ln5EN6ugWf/2G9ZxP8riDDo/C
         sHcTLSTS/Wc9KvZgkGOeN97v4gwtOBBZI2ewMCDi2RQmzA5qMuZYtTXdRqOW8xfXui
         k21k3HSS6hCmZP037e1e4qFUKrp4pIU1DxouZeoTqncsDGUvoRNGPj9qYqjUNUoJk+
         l5xEXxAUE9TUQ==
Date:   Tue, 3 Jan 2023 22:43:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix function prototype mismatch for ext4_feat_ktype
Message-ID: <Y7UgGSoeB+3yQD8V@sol.localdomain>
References: <20230103234616.never.915-kees@kernel.org>
 <Y7THENi5v2+fgUAc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7THENi5v2+fgUAc@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 12:23:44AM +0000, Eric Biggers wrote:
> I'm also surprised that this wasn't found earlier.  Is it possible that CFI does
> not actually distinguish between the two function prototypes here?
> 

It's because this code is only reached when ext4 is a loadable module and it is
being unloaded.  I can reproduce the CFI failure by doing that.

In addition to the naming tweak I requested, can you also add Fixes and Cc
stable tags?

By the way, here's the log from the CFI failure I got:

[   16.412498] CFI failure at kobject_put+0xbb/0x1b0 (target: kfree+0x0/0x180; expected type: 0x7c4aa698)
[   16.413716] invalid opcode: 0000 [#1] PREEMPT SMP
[   16.414299] CPU: 2 PID: 179 Comm: rmmod Tainted: G                T  6.2.0-rc2 #28
[   16.415223] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.1-1-1 04/01/2014
[   16.416383] RIP: 0010:kobject_put+0xbb/0x1b0
[   16.416926] Code: df e8 f9 03 00 00 4d 85 e4 74 24 49 83 3c 24 00 74 1d 0f 1f 44 00 00 48 89 df 4d 8b 1c 24 41 ba 68 59 b5 9
[   16.419199] RSP: 0018:ffffc90000283e20 EFLAGS: 00010a13
[   16.419842] RAX: 0000000000000000 RBX: ffff88800436c9c0 RCX: 0000000000000000
[   16.420719] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800436c9c0
[   16.421595] RBP: ffffc90000283e40 R08: 0000000000000000 R09: 0000000000000000
[   16.422465] R10: 0000000017461662 R11: ffffffff81216a20 R12: ffffffffa00f9510
[   16.423330] R13: 0000000000000000 R14: ffff88800436ca80 R15: ffff888007643950
[   16.424207] FS:  00007f7bf573f740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   16.425188] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.425814] CR2: 0000561eb661f818 CR3: 00000000074c9000 CR4: 00000000003506e0
[   16.426574] Call Trace:
[   16.426862]  <TASK>
[   16.427098]  ext4_exit_sysfs+0x14/0x60 [ext4]
[   16.427604]  cleanup_module+0x67/0xedb [ext4]
[   16.428099]  __se_sys_delete_module+0x22d/0x3e0
[   16.428593]  ? syscall_enter_from_user_mode+0x2a/0x1d0
[   16.429142]  ? syscall_enter_from_user_mode+0x2a/0x1d0
[   16.429694]  __x64_sys_delete_module+0x11/0x20
[   16.430173]  do_syscall_64+0x53/0xb0
[   16.430562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   16.431151] RIP: 0033:0x7f7bf584ccfb
[   16.431544] Code: 73 01 c3 48 8b 0d 8d f0 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 8
[   16.433517] RSP: 002b:00007fff7d959068 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[   16.434327] RAX: ffffffffffffffda RBX: 0000561eb6615750 RCX: 00007f7bf584ccfb
[   16.435090] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000561eb66157b8
[   16.435852] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[   16.436617] R10: 00007f7bf58c2ac0 R11: 0000000000000206 R12: 0000000000000000
[   16.437472] R13: 00007fff7d9592d0 R14: 00007fff7d959d80 R15: 0000561eb66152a0
[   16.438307]  </TASK>
[   16.438552] Modules linked in: ext4(-) crc32c_generic mbcache crc16 jbd2
[   16.439321] ---[ end trace 0000000000000000 ]---
[   16.439829] RIP: 0010:kobject_put+0xbb/0x1b0
[   16.440294] Code: df e8 f9 03 00 00 4d 85 e4 74 24 49 83 3c 24 00 74 1d 0f 1f 44 00 00 48 89 df 4d 8b 1c 24 41 ba 68 59 b5 9
[   16.442310] RSP: 0018:ffffc90000283e20 EFLAGS: 00010a13
[   16.442960] RAX: 0000000000000000 RBX: ffff88800436c9c0 RCX: 0000000000000000
[   16.443719] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800436c9c0
[   16.444472] RBP: ffffc90000283e40 R08: 0000000000000000 R09: 0000000000000000
[   16.445231] R10: 0000000017461662 R11: ffffffff81216a20 R12: ffffffffa00f9510
[   16.446012] R13: 0000000000000000 R14: ffff88800436ca80 R15: ffff888007643950
[   16.446779] FS:  00007f7bf573f740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   16.447658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.448276] CR2: 0000561eb661f818 CR3: 00000000074c9000 CR4: 00000000003506e0
