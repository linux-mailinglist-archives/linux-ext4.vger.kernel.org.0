Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09E4EB84B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 04:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiC3Cbq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 22:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiC3Cbq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 22:31:46 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D747393;
        Tue, 29 Mar 2022 19:30:00 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 63CE1C01F; Wed, 30 Mar 2022 04:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648607399; bh=bdKHDKIHNDK3SV6b1Pqh98L2dlKohpJZeeDW7bMGvYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQO/bvdjVLOA7rftxN9vzdFVsLwSNkr7SIkzfOznSn9FxrYdCKnIZJEib2mP09ZwV
         ZpF3C4DvvKi+aPq2jH5g5/yigqttgPDkrjCXc4BnDa4g2H7TjeTMbYUPszNEhB0zAD
         5Zv/+qox9cJBSTGcSzxHjl1VGUuV2JnYBrIuzFY+JhEMGhE4bRDITdazD05PHRXRcF
         g0vwMYX9IEMxjlNcmOfcorfxSowWHb18B431AdW75hU9xcRVXSijw+MKsjdsSBK0gW
         GQCPAf7EPSGZyLTvnIqvSl09INYyQEBIndBzz5Jv0bwtUlK61J7kfM6NDZAd1gkQyE
         KHrBH4coLVk1Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 23616C009;
        Wed, 30 Mar 2022 04:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648607398; bh=bdKHDKIHNDK3SV6b1Pqh98L2dlKohpJZeeDW7bMGvYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSbQrrphVo5YOvwmvw1ndEiSTropwRH61zuG6mSJHUhv/+R9vdtzhRkRZMgJWQtSU
         hULss14sVow7TDWhUzdONGSe5Zk0q9qAvxTsygRBv/fhstgSOLg8KQGog/fgg9QcOg
         Je++J73BfrLLbQ2/Z5qtAUwyMZUNc+MLZIT9tFAcKCbL6D+P/B5q8uLTElCC1+49bD
         l4vctZxO3QZbPcFKBVJw2fgO/S0Kpcz3mxdTKfD5bs+QQUFn4XBzSzwCABpaEI1X9m
         mI5ccEfg9qPbugaSw0TaFP9JGtXP6gSlJ67TvudVq1N8sjDXWC6aTtMqMUxYk90KND
         AfAFDTWeI6cTA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6c549303;
        Wed, 30 Mar 2022 02:29:53 +0000 (UTC)
Date:   Wed, 30 Mar 2022 11:29:37 +0900
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
Message-ID: <YkPAkXVc4HZLUrGl@codewreck.org>
References: <0000000000009523b605db620972@google.com>
 <385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp>
 <YkObebLZMp5AyRpr@codewreck.org>
 <fb5d20c5-36a6-2c51-288a-7cc1e0a76d3e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb5d20c5-36a6-2c51-288a-7cc1e0a76d3e@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Tetsuo Handa wrote on Wed, Mar 30, 2022 at 10:57:15AM +0900:
> >> Please don't use schedule_work() if you need to use flush_scheduled_work().
> > 
> > In this case we don't call flush_scheduled_work -- ext4 does.
> 
> Yes, that's why I changed recipients to ext4 people.

Sorry, I hadn't noticed.
9p is the one calling schedule_work, so ultimately it really is the
combinaison of the two, and not just ext4 that's wrong here.

> > The problem is mixing in the two subsystems when someone (e.g. syzbot)
> > opens an ext4 file and passes that fd to 9p when mounting with e.g.
> > mount -t 9p -o rfdno=<no>,wfdno=<no>
> > 
> > Frankly that's just not something I consider useful, interacting through
> > 9p to a local file doesn't make sense except for testing.
> > 
> > If that is a real problem, the simplest way out would be to just forbid
> > non-socket FDs if it's something we can check.
> 
> Do you mean that p9_fd_open() in net/9p/trans_fd.c does not need to
> accept non-socket file descriptors?

Yes, I can't think of any valid usage that would involve non-socket fd
there.
It might be useful to leave as a test vector, but if it causes problems
I think it's perfectly OK to just refuse these.

> Then, it's something you can check. You can use S_ISSOCK() like
> e.g. netlink_getsockbyfilp() does

Thanks for the example
-- 
Dominique
