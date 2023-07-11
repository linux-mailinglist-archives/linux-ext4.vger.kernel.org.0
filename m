Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098874F333
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jul 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGKPTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Jul 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGKPTg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Jul 2023 11:19:36 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE72100
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jul 2023 08:19:35 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a3b8b73cbeso4079607b6e.1
        for <linux-ext4@vger.kernel.org>; Tue, 11 Jul 2023 08:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088775; x=1691680775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTtBSm5A66Jo82Yazz35b6XHkBkcKwYtbgU11r2+uAY=;
        b=SoQTa42NHihujfmx/zdnvGxJJ9Q2qbDBx80U5Gv8LPPCxwwKMmOi63/wTUILyJrtHL
         oGKiP+aGXFq2sFDgcGSEiX74spKCkOrbuLQBsvGnVeUlHvPsww2Fl4tgtuk32wd/tm+v
         U1Ikjn+5vvnzkyjA7R+pCutFPdRNQoFnOBf4LTjcXe33GwqIHj6zHPMmjPtuhGa/hEmJ
         XKgJWZxl2t/XDxJk2mOko9LyWzy6ZAqzbMODii35xYpD1uEnPUb4qtRn7jnaH7H1sEJ9
         VJIx+TP2Vukr5xyKC2Wjohai+dCmjj6VocbqvEL9sc4bhris6wzEYaNqQHO9RUb5/e50
         d4vw==
X-Gm-Message-State: ABy/qLaZVKDHGNSSj5PaoHH7iqjOkTRWmxmCdGMmdSh+Ej9Okb3IQ3p8
        BWIq5jVnMJxOZ+XDAfTWNSSbJ7H6OlgXb5VZGFB0ib49TkEd
X-Google-Smtp-Source: APBJJlEHVpKNs8sWL9JLFboB6JbTMukgEFC+f6weICeuWD+h2WkluGryx6SaGSJvxSySUZqP8Aq+bTVJw2kCn/BGwduQA1aoRIAf
MIME-Version: 1.0
X-Received: by 2002:aca:3443:0:b0:39e:ced7:602b with SMTP id
 b64-20020aca3443000000b0039eced7602bmr1872936oia.2.1689088773399; Tue, 11 Jul
 2023 08:19:33 -0700 (PDT)
Date:   Tue, 11 Jul 2023 08:19:33 -0700
In-Reply-To: <000000000000e55d2005fd59d6c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000552b56060037a019@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From:   syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this issue to:

commit aff3bea95388299eec63440389b4545c8041b357
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed May 24 03:49:51 2023 +0000

    ext4: add lockdep annotations for i_data_sem for ea_inode's

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14abf682a80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16abf682a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12abf682a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d8f2b0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1061e6b0a80000

Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com
Fixes: aff3bea95388 ("ext4: add lockdep annotations for i_data_sem for ea_inode's")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
