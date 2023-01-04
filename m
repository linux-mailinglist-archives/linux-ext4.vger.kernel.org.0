Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8C65CA9F
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 01:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjADAJE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 19:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjADAI7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 19:08:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37F14023
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 16:08:57 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30408IRA015473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Jan 2023 19:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672790909; bh=ALtAqJM3Wx45sHnWFvBnJn73zqSfwhn12OmzEU3j3nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XvZ/szbp4LO2MJek2jxvKd9zSrTRq4/ah2n0S0d0hsxl/gubg6CZ71ddRUPxTQ79s
         stC5q+/e7FYCiBf91Uq3FtlQrIlebABfKK+fNVpCl+7lCXavKmQz4UmAc4IrrqET0g
         KOiGoo8JUk2H5CLaFHAe4Oaz+B8hqYQQCwslED34tYPI6R6Rsegogx268XoK23ii4b
         gp0kG6HtJRqFnGySACT+wiZ3yEv1UTe+oGqSEgbF5n4I/O4P/b55c9bDhtAeurCgTf
         Jih/kW3x3mdCpjmWHZm1KTNC8FqjAiMPG1qBXfBJfpfVC3nxrWvSHIZ5/nXq6kJ1wa
         Js7LLSz3GkZcw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id C4C478C0C2E; Tue,  3 Jan 2023 19:08:05 -0500 (EST)
Date:   Tue, 3 Jan 2023 19:08:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (2)
Message-ID: <Y7TDZRpDVysLdq+N@mit.edu>
References: <000000000000e6c7b005f0e90bf1@google.com>
 <Y6zN/Q3glUcbty+c@mit.edu>
 <CANp29Y7yH6LeeHMX-joXgr7duZzs2p3j08qZzS6WGwBJDDq+PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y7yH6LeeHMX-joXgr7duZzs2p3j08qZzS6WGwBJDDq+PA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 03, 2023 at 12:22:53PM +0100, Aleksandr Nogikh wrote:
> Hi Ted,
> 
> Syzkaller already tries to avoid such situations, but in this
> particular case, it has corrupted the mount options[1] and did not
> recognize the problem. Though, as I understand, this string was
> nevertheless valid to the kernel. Otherwise it would have aborted the
> mount early (?).
> 
> [1] grpjquota=Jnoinit_itable(errors=remount-ro,minixdf,jqfmt=vfsv0,usrjquota=."

Yes, it's considered valid with the name of the journaled group quota
file being "Jnoinit_itable(errors=remount-ro".  Which is very odd, but
in theory, if that file existed, quotaon would have tried to find that
file and used it as the group quota.

(Old-style quota files, which we still support because (a) there might
be RHEL users using system setups that haven't been updated since the
RHEL3/RHEL4 days and (b) there are still stackoverflow answers and
other FAQ posts on the web telling people how to enable quota using
these ancient schemes, are passed into kernel, but aren't actually
used by the kernel; instead the userspace quota tools parse either
/etc/mtab or /proc/mounts to find the relevant mount option and then
try to use the named file as the user or group quota file.)

> I've sent a PR that should make the syzkaller logic more robust to
> such broken options strings:
> https://github.com/google/syzkaller/pull/3604

Thanks for fixing this so promptly!

						- Ted
						
