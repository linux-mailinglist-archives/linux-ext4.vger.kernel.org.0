Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA94EB723
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 01:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiC2Xxv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 19:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiC2Xxk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 19:53:40 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C62A215928;
        Tue, 29 Mar 2022 16:51:44 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 880CFC020; Wed, 30 Mar 2022 01:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648597903; bh=jLOdyVM2slFwDQ6ud3EEJpcePnsBDvL67+l3rWTkEK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpnOrvYuaFA3wQMV1QjxFc8hS9HuoBPuPaq5FjOsy05p2Ql45LIYYqk4ONVkk19jd
         X3qUe8g6050dw+ebDxZUC2yskbMFRLDT2vIglWTIIR4oe9o+glMUkrQf/oht/3YHGS
         gAG6IqwtisESrx1Jn/rxirNjq3O7S/smEY3hjJynBuXIBwFYNeng4ltVP3X9gks7l+
         10Qd6ZRZldcIxofUXcx+xq+9WdXZQugWuYwzYGCFpydTWIMZgjC6k+d5j5H44XXKE2
         EbHi28+pi9NDTq2S+DXTbYkzTJZG+zHf06YV8Xz0EkZ/w7k8OB0R+PcahMAHd1Dq+c
         eNoFTMWf9sLyQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1FEACC009;
        Wed, 30 Mar 2022 01:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648597902; bh=jLOdyVM2slFwDQ6ud3EEJpcePnsBDvL67+l3rWTkEK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtVWwq7Fo8GoQcPMIfURyPC1Sxs2eFO7I9eHzWRfkrBqQ1/Tp+ZokCO8TkM6rUnBx
         bh7zXNjZp12DBuR+nOfVujMJowryR1AG3JUusOdB9CZ5bRClxCVAN5nYlQ5YC+gCY7
         c44Uff4jSsNNN0bh/hSpK7MxecqojFAX8YwJrPFKPRzf0oB7kU6NXhUdjrWllu35E0
         e5KeOsEaHU6fawu/Cwctv91iZ3cdbLVMHSJSrZHsbKIFMmrLLoLJ2gfkXvMEg08aON
         u6/oEp3yNAtlLTrBIYnq4RrREgHuajzFphEfg2z/2OQQGIceem5EcZi5mYQ3bYNQ2s
         4VUbim3sqct5A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1051c843;
        Tue, 29 Mar 2022 23:51:36 +0000 (UTC)
Date:   Wed, 30 Mar 2022 08:51:21 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Andrew Perepechko <andrew.perepechko@hpe.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>,
        syzbot <syzbot+bde0f89deacca7c765b8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>
Subject: Re: [syzbot] possible deadlock in p9_write_work
Message-ID: <YkObebLZMp5AyRpr@codewreck.org>
References: <0000000000009523b605db620972@google.com>
 <385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Tetsuo Handa wrote on Wed, Mar 30, 2022 at 07:35:47AM +0900:
> This seems to be an example of
> https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> introduced by "ext4: truncate during setxattr leads to kernel panic".

Thanks for the pointer

> Please don't use schedule_work() if you need to use flush_scheduled_work().

In this case we don't call flush_scheduled_work -- ext4 does.
The problem is mixing in the two subsystems when someone (e.g. syzbot)
opens an ext4 file and passes that fd to 9p when mounting with e.g.
mount -t 9p -o rfdno=<no>,wfdno=<no>

Frankly that's just not something I consider useful, interacting through
9p to a local file doesn't make sense except for testing.

If that is a real problem, the simplest way out would be to just forbid
non-socket FDs if it's something we can check.
-- 
Dominique
