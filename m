Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046EA6587D3
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Dec 2022 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiL1XOj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Dec 2022 18:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1XOi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Dec 2022 18:14:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E260E1
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 15:14:36 -0800 (PST)
Received: from letrec.thunk.org ([172.102.10.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BSNEEsa004537
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 18:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672269258; bh=LXKS/ahxqLfQUkNJ4Z0fI/tr5BsFkHuEpYjkPn4Nhgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FjwcaE9miaagM6TdRTQ3A6esjnDUUCl7cA216/QG328iOWM3fXO8E7bVHBx1+4jms
         YjY6Qj8vgvC+4xuQ+hE7rk4sOEnUVo54qIhbiMT0uT0jl6igfq8AdbYYsLY5mPKJfb
         B0oxwSBgIqcMtSwCyly/vCUbemLN6vd2V+8XXtEDyMdbQOdGJveaq5e+WZu2ArdLb1
         w7oFy6o3nwZnmY/4R+yVWFBJ2T/2PbSCtaNTwT2Mkl1xhTmiPxIiJPctct7AzekLNm
         edpxocecGLw6VxKtkdP1Qb8heGiF4rjlYmwKaFq4lAGcRvJLV0mYlERDaGFcr1p9Sz
         bit99nbh8fMtQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 15D078C0904; Wed, 28 Dec 2022 18:15:09 -0500 (EST)
Date:   Wed, 28 Dec 2022 18:15:09 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (2)
Message-ID: <Y6zN/Q3glUcbty+c@mit.edu>
References: <000000000000e6c7b005f0e90bf1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e6c7b005f0e90bf1@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 28, 2022 at 12:16:41PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13527f8c480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c45794f522ad93b0eb6
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d7f2e4480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c8d2ac480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/510d16df06c8/disk-72a85e2b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/50ef5477a1d4/vmlinux-72a85e2b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f2acd6f1189a/bzImage-72a85e2b.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/6f0bbc430a64/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 512
> EXT4-fs error (device loop0): ext4_map_blocks:607: inode #2: block 2: comm syz-executor170: lblock 0 mapped to illegal pblock 2 (length 1)
> Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error

So this is a totally bogus Syzbot report.  If you use the mount option
"errors=panic", and you feed ext4 a corrupted file system, then it
*will* issue an "Ext4-fs error" message, and if you tell it to panic,
it will panic.

So *please* let's not have some crazy Red Hat principal engineer try
to file this as a high severity CVE....

This is Working As Intended.  And it is Not A Bug.

     		   	      	     	- Ted
