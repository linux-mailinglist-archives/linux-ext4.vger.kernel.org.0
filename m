Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E942EFA4C
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 22:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbhAHVVV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 16:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbhAHVVT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 16:21:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13104C061786
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jan 2021 13:20:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so6909809pjl.0
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jan 2021 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj0bwaI1Yg9SJ8+KthhKFiHsft2v7jMXKdNfXLE27cs=;
        b=ob6U9DHAEvzAi1bufn6CgxcWd8olQiKbbPIAhZYPKeH/oVeN5oyMN2OEI6dmw5TIhh
         BY5fJgwOqDbjlwpZR1dpmELMl9YbkTUkmEYGQomZszYJXllERB2W7HHSOQvFlJUg0VdA
         c5ZqNwgBNpbw3LV4lEzN7Jx1Io4TRzpINw14w5im+H0Ga1oMTqybejMcj03ZNDb7Eyn0
         9rXONMLgNn1iC2hfEEtPRvQ6wSVwgoq1fNxYHeu+PA8aLdsxGXvaowSJSsNmtj1LdCLm
         mhTETI6t/NaWlfOQ0PEyDqNtz1GgzGvQRac4UQbqQ9eL5rFt1IBsa3x8Wrg8NvTnrQ9r
         0H9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj0bwaI1Yg9SJ8+KthhKFiHsft2v7jMXKdNfXLE27cs=;
        b=BWb4orzsOZbjUO9hDCXIVQdmbdIJQDGGRpmufy/cPJlxQUyo5fkBpl3xNlCSsWWsv1
         rd30NIEeOH5m2jaWRSZ+lbsDg6sz+U+kM6RdKxcNKPOZ6nSbPrSfQVRXC4FG/q86h4CV
         TD6enNU7KlpfmwG0fZattCTgIdo2FnHbFrUrEcU781Vhyu13DWwd4VN0VfqHT78tNxMX
         T5cg4vhzfMbuPBn8dXAyTkXf6m2Kqga7WLnTNz3VC1+scRiTsgwtsFX4q9inklWO6oR1
         +0g580LHRJoGMpIRHPsb3aeWNZj5251nigb+g57pudIPctNZVkhhxm51JFpvlgWQs8di
         tkUA==
X-Gm-Message-State: AOAM531L12SIB5xcbsJRrQPq+RUAHOu/xHSp4cRr8jCvF1OSoPXc/FxT
        9fvxvP9ZwuZAjUgXIQ3IPXeVsHMufQSqzKNr8wa4+Q==
X-Google-Smtp-Source: ABdhPJw4+Aw9i9bi7y60gChG4h4UFGLR+2cSCCczj94KdWXiDg5keuXXDluFhcCGMaGsn7ykhskIUZLD7FurfLRUKhQ=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr5582833pjf.25.1610140838310;
 Fri, 08 Jan 2021 13:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20210106115359.GB26994@C02TD0UTHF1T.local> <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck> <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk> <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net> <20210108092655.GA4031@willie-the-truck>
 <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com> <CAK8P3a2w2u8pcQJue3OveDckJNkGmwzVdfOM-VEXShQEw8EOzw@mail.gmail.com>
In-Reply-To: <CAK8P3a2w2u8pcQJue3OveDckJNkGmwzVdfOM-VEXShQEw8EOzw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jan 2021 13:20:27 -0800
Message-ID: <CAKwvOdmcKjwJkiu+VDWrjQO9RYjv-WEqepQJnLZrY2wtBmEwmg@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 8, 2021 at 12:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jan 8, 2021 at 9:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Jan 8, 2021 at 1:27 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, Jan 08, 2021 at 10:21:54AM +0100, Peter Zijlstra wrote:
> > > > On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> > > > > On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
> >
> > I appreciate Arnd pointing out "--std=gnu11", though. What are the
> > actual relevant language improvements?

It's hard to say, since a lot of new language features were already
GNU C extensions.

The only semantic difference I'm aware of is the semantics of `extern
inline` changed 100% from c89 to c99 (so jumping from gnu89 to gnu11
would change that).  We already #define inline to
__attribute__((__gnu_inline)) (there's also a -fgnu-inline flag), but
I worry for places that don't include that header or drop
KBUILD_CFLAGS (like every vdso), though `extern inline` is awful (and
I should be put in jail for introducing it to the kernel; now we have
__attribute__((no_stack_protector)) in both toolchains, and should be
using that instead, but we don't have it yet for all supported
compiler versions).

A quick grep through clang's sources shows mostly parser changes for
_Noreturn, _Alignof and friends etc..  New to me are unicode literal
strings (u or U suffix or prefix?) and something about loops expected
to make forward progress???

Another thing I've been worried about is Makefiles that reset
KBUILD_CFLAGS, since that's a constant source of pain/breakage for
cross compiling from Clang.  That tends to drop -std=gnu89.  For
instance:

$ make LLVM=1 -j71 defconfig
$ make LLVM=1 -j71 V=1 &>log.txt
$ grep -v std=gnu89 log.txt | grep clang | rev | cut -d ' ' -f 1 | rev
| grep -v \\.S
arch/x86/realmode/rm/wakemain.c
arch/x86/realmode/rm/video-mode.c
arch/x86/realmode/rm/regs.c
arch/x86/realmode/rm/video-vga.c
arch/x86/realmode/rm/video-vesa.c
arch/x86/realmode/rm/video-bios.c
drivers/firmware/efi/libstub/efi-stub-helper.c
drivers/firmware/efi/libstub/gop.c
drivers/firmware/efi/libstub/secureboot.c
drivers/firmware/efi/libstub/tpm.c
drivers/firmware/efi/libstub/file.c
drivers/firmware/efi/libstub/mem.c
drivers/firmware/efi/libstub/random.c
drivers/firmware/efi/libstub/randomalloc.c
drivers/firmware/efi/libstub/pci.c
drivers/firmware/efi/libstub/skip_spaces.c
lib/cmdline.c
lib/ctype.c
drivers/firmware/efi/libstub/alignedmem.c
drivers/firmware/efi/libstub/relocate.c
drivers/firmware/efi/libstub/vsprintf.c
drivers/firmware/efi/libstub/x86-stub.c
arch/x86/boot/a20.c
arch/x86/boot/cmdline.c
arch/x86/boot/cpuflags.c
arch/x86/boot/cpucheck.c
arch/x86/boot/early_serial_console.c
arch/x86/boot/edd.c
arch/x86/boot/main.c
arch/x86/boot/memory.c
arch/x86/boot/pm.c
arch/x86/boot/printf.c
arch/x86/boot/regs.c
arch/x86/boot/string.c
arch/x86/boot/tty.c
arch/x86/boot/video.c
arch/x86/boot/video-mode.c
arch/x86/boot/version.c
arch/x86/boot/video-vga.c
arch/x86/boot/video-vesa.c
arch/x86/boot/video-bios.c
arch/x86/boot/cpu.c
arch/x86/boot/compressed/string.c
arch/x86/boot/compressed/cmdline.c
arch/x86/boot/compressed/error.c
arch/x86/boot/compressed/cpuflags.c
arch/x86/boot/compressed/early_serial_console.c
arch/x86/boot/compressed/kaslr.c
arch/x86/boot/compressed/ident_map_64.c
arch/x86/boot/compressed/idt_64.c
arch/x86/boot/compressed/pgtable_64.c
arch/x86/boot/compressed/acpi.c
arch/x86/boot/compressed/misc.c

So it looks like parts of the tree are already built with -std=gnu11
or -std=gnu17, as they rely on the implicit default C language mode
when unspecified.  Oops?
-- 
Thanks,
~Nick Desaulniers
