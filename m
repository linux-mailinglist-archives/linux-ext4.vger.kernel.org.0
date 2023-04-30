Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B656F2986
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjD3Qob (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3Qoa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 12:44:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5B170A
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 09:44:28 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UGiFwF030379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 12:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682873058; bh=kjFfB0mIP3X+i0mTn18RwHwQZScw1wf5xXbUVXbjOr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YuUZ8zzX+TwdnSmsuk8s1btBU6K4j+5yLydEO1UzbBKePxnWj44zyOBsD7Gand6rN
         XyHWlZU/ToN/X8AWhlQ+g1UUIN8UQu5uSWml6yk5jZgSpPu62OVUgnmONLbexwqQdo
         M2WtmG9ZGmgPBTLBXAhHX+RLEmH4zF7RXb32KbaKId5HMSZJu/1aD7Ktf6w/azsNJG
         CSU1rA3NgGx42bfK2BXCp4Sa7XxNK1jKceDH+DHX1vTzSXO7/LGqCW6EJUBRGqHqxB
         y1zkoPAcJ427F6O7kdcYK+YoBYtuj1QNi6aJ/KTRSbwpRY8FDQ6bdsruA3GW2eP3j0
         uUAN1xUtpDbHw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 537D58C023E; Sun, 30 Apr 2023 12:44:15 -0400 (EDT)
Date:   Sun, 30 Apr 2023 12:44:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        syzbot+aacb82fca60873422114@syzkaller.appspotmail.com,
        syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: Fix lockdep warning when enabling MMP
Message-ID: <ZE6a310qzNzd40l5@mit.edu>
References: <20230411121019.21940-1-jack@suse.cz>
 <ZE6YeCaQa01nAWYT@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE6YeCaQa01nAWYT@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 30, 2023 at 12:34:00PM -0400, Theodore Ts'o wrote:
> On Tue, Apr 11, 2023 at 02:10:19PM +0200, Jan Kara wrote:
> > When we enable MMP in ext4_multi_mount_protect() during mount or
> > remount, we end up calling sb_start_write() from write_mmp_block(). This
> > triggers lockdep warning because freeze protection ranks above s_umount
> > semaphore we are holding during mount / remount. The problem is harmless
> > because we are guaranteed the filesystem is not frozen during mount /
> > remount but still let's fix the warning by not grabbing freeze
> > protection from ext4_multi_mount_protect().
> > 
> > Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
> 
> I believe this is the wrong Reported-by.  The correct one looks like
> it should be: ...

By the way, I noticed because I was browsing the syzbot dashboard for
the ext4 subsystem, and the Syzbot page for "possible deadlock in
sys_quotactl_fd"[1], I saw a discussion link to lore for the patch
"[PATCH] ext4: Fix lockdep warning when enabling MMP", and said,
"Hmm.... that looks wrong."  :-)

[1] https://syzkaller.appspot.com/bug?id=1680b22e0e5eb9245a6faff10221ed76b8c5eb81

Anyway, thanks to the Syzbot team for adding Disscusion links to the
Syzbot pages.  It makes it a lot easier to find discussions related to
a particular issue.

Note: you can also manually add a thread to the discussions section by
simply adding a CC to the Reported-by link for the particular issue (for
example, "Cc: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com").

Cheers,

						- Ted
