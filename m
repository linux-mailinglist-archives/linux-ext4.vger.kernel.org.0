Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108C6F2983
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjD3QeQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3QeQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 12:34:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A21992
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 09:34:14 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UGY1ga023705
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 12:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682872444; bh=daAet6FPuur0yMX2pnkPYpb+BJN0RIXr+ldUhubDhHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LVqLcgbiGFlC4KF2IW4r0hLrbQOBH4tj8n2LlFEWtF1j1S0dqSnOgw2SS+R8J3ocE
         iiVqMct6KJwWNT+0joP1OJRTpMAJnvY5BORVbTOBRIjk8b0/rhjGYsBKlHP6MY5FFD
         gWGvV5aeFr2GCliarkSlbAc1peXSr7wwuU0HvgBA17FOwe+4kdA3D7RDXwIBQB0Urz
         N2OZViG52TqO7/l8VvD+xiKfsAOYYNd7oLORyPXbB1YGm9vNkUBkvmDY3eakwvSIVi
         S96sq8NuJYblZCzbIDTw0SP7jsTmNu2kzkKGCARioBaGyjfZX9+JlEWxC+BU1I0lhH
         m60wF5Yoq0eaw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9BB698C023E; Sun, 30 Apr 2023 12:34:00 -0400 (EDT)
Date:   Sun, 30 Apr 2023 12:34:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        syzbot+aacb82fca60873422114@syzkaller.appspotmail.com,
        syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix lockdep warning when enabling MMP
Message-ID: <ZE6YeCaQa01nAWYT@mit.edu>
References: <20230411121019.21940-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411121019.21940-1-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 11, 2023 at 02:10:19PM +0200, Jan Kara wrote:
> When we enable MMP in ext4_multi_mount_protect() during mount or
> remount, we end up calling sb_start_write() from write_mmp_block(). This
> triggers lockdep warning because freeze protection ranks above s_umount
> semaphore we are holding during mount / remount. The problem is harmless
> because we are guaranteed the filesystem is not frozen during mount /
> remount but still let's fix the warning by not grabbing freeze
> protection from ext4_multi_mount_protect().
> 
> Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com

I believe this is the wrong Reported-by.  The correct one looks like
it should be:

Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ab7e5b6f400b7778d46f01841422e5718fb81843

It's also helpful to add a Link line to the Syzkaller dashboard to
make it easier to find the relevant Syzbot report.

I'll put this on my todo list to grab for the next batch of ext4
fixups.

						- Ted
