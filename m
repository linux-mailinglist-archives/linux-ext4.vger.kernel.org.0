Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83EA4142
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Aug 2019 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfHaAOh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Aug 2019 20:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbfHaAOh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Aug 2019 20:14:37 -0400
Received: from zzz.localdomain (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BF62342E;
        Sat, 31 Aug 2019 00:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567210476;
        bh=hxoitIuO4UpBEpicxxZwUpy8sls8PNk60bdTqCI4tek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wolHikVMMu9X6x2nph4qEI/9Am2PWvHhagsL9AsVf+zKGXFCPLamaHZ4xy0/gYmWE
         XFPu5MKbkRUQtX8O/VotmCoYk2Kx1+mHNO615UfcSWuN7S826Y426JoBsf/ay0n0u4
         ZmDux61LXz8b3HNpx0MnjFUgxD9ikDuoUHu7n2ho=
Date:   Fri, 30 Aug 2019 19:14:32 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzbot <syzbot+0bf8ddafbdf2c46eb6f3@syzkaller.appspotmail.com>
Subject: Re: WARNING: ODEBUG bug in ext4_fill_super
Message-ID: <20190831001432.GB22191@zzz.localdomain>
Mail-Followup-To: Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzbot <syzbot+0bf8ddafbdf2c46eb6f3@syzkaller.appspotmail.com>
References: <0000000000006fc70605915ac6ad@google.com>
 <CAKwvOdkAaFKr5gDw31uRzGoEC1JaJGNnrnAX_ysx9kH7dKx19Q@mail.gmail.com>
 <CACT4Y+aiSbZr=m0E1c2eHe6JvyNeKUDxEb2NTLxk77LsBXGVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aiSbZr=m0E1c2eHe6JvyNeKUDxEb2NTLxk77LsBXGVVg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 30, 2019 at 12:46:21PM -0700, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Fri, Aug 30, 2019 at 12:42 PM 'Nick Desaulniers' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > Dmitry,
> > Any idea how clang-built-linux got CC'ed on this?  Is syzcaller
> > running clang builds, yet?  (this looks like a GCC build)
> 
> syzbot always uses get_maintainers:
> 
> $ ./scripts/get_maintainer.pl -f fs/ext4/super.c
> "Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE SYSTEM)
> Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE SYSTEM)
> linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM)
> linux-kernel@vger.kernel.org (open list)
> clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
> 

CLANG/LLVM BUILD SUPPORT
L:	clang-built-linux@googlegroups.com
W:	https://clangbuiltlinux.github.io/
B:	https://github.com/ClangBuiltLinux/linux/issues
C:	irc://chat.freenode.net/clangbuiltlinux
S:	Supported
K:	\b(?i:clang|llvm)\b

So, clang-built-linux has volunteered to maintain every file that contains the
word "clang" or "llvm" anywhere in its contents :-)

$ grep clang fs/ext4/super.c
	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */

- Eric
