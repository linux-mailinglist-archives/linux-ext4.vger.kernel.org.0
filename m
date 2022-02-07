Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8864AB8C6
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiBGKe1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiBGKaw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 05:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60975C043181
        for <linux-ext4@vger.kernel.org>; Mon,  7 Feb 2022 02:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644229850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cyRyCr5+eamib5wZIABy4k0pAM0GRsoTKR73ge8vW8=;
        b=J2fuIImWfLzNTFAohZVOd4YyNgnSNtbZM2xe8dz6fMd+iMd3vXW6PDNcsbWZCDeoNooeQ2
        gQXjwtI5Zt+r223vupHu5FLn7Ciwompb2pTzGDK8VKQ2Z3Jv/2zJcNMbLOW20+Iab1nBzf
        F7q9HJdqVISZ+uauPAOpdbgjYKmEyxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-UDBsiRaoM2S6ps60GOiWsQ-1; Mon, 07 Feb 2022 05:30:48 -0500
X-MC-Unique: UDBsiRaoM2S6ps60GOiWsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 209C21800D50;
        Mon,  7 Feb 2022 10:30:47 +0000 (UTC)
Received: from work (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8AE7D704;
        Mon,  7 Feb 2022 10:30:12 +0000 (UTC)
Date:   Mon, 7 Feb 2022 11:30:09 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     syzbot <syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] general protection fault in ext4_fill_super
Message-ID: <20220207103009.id72sr4dtghgzp5f@work>
References: <0000000000001e0ba105d5c2dede@google.com>
 <000000000000fbf22d05d74d08fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fbf22d05d74d08fb@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 05, 2022 at 02:39:06PM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit cebe85d570cf84804e848332d6721bc9e5300e07
> Author: Lukas Czerner <lczerner@redhat.com>
> Date:   Wed Oct 27 14:18:56 2021 +0000
> 
>     ext4: switch to the new mount api
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14902978700000
> start commit:   0457e5153e0e Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16902978700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12902978700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd57c0f940a9a1ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=138c9e58e3cb22eae3b4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7004fb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cf108700000
> 
> Reported-by: syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com
> Fixes: cebe85d570cf ("ext4: switch to the new mount api")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

I believe that this has been fixed with upstream commit

commit 7c268d4ce2d3761f666a9950b029c8902bfab710
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Wed Jan 19 14:02:09 2022 +0100

    ext4: fix potential NULL pointer dereference in ext4_fill_super()

    By mistake we fail to return an error from ext4_fill_super() in case
    that ext4_alloc_sbi() fails to allocate a new sbi. Instead we just set
    the ret variable and allow the function to continue which will later
    lead to a NULL pointer dereference. Fix it by returning -ENOMEM in the
    case ext4_alloc_sbi() fails.

    Fixes: cebe85d570cf ("ext4: switch to the new mount api")
    Reported-by: kernel test robot <lkp@intel.com>
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Lukas Czerner <lczerner@redhat.com>
    Link: https://lore.kernel.org/r/20220119130209.40112-1-lczerner@redhat.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cc: stable@kernel.org

Thanks!
-Lukas

