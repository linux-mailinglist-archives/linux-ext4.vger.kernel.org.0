Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181AA61A583
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Nov 2022 00:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKDXP3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 19:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKDXP2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 19:15:28 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6382664
        for <linux-ext4@vger.kernel.org>; Fri,  4 Nov 2022 16:15:28 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so4824132ila.3
        for <linux-ext4@vger.kernel.org>; Fri, 04 Nov 2022 16:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh6VHIpm1eezFlTH8nL0qyHX0V1j8bdMOwrcsVM6rA8=;
        b=BCkvDwLqPh35KcAq2eA6J3pdbPX94I7JRdXPEoh2LILRyP47acYGRKYVYsukAg5Ly0
         iVZoTw9+JpZAdIPS7YAdVRisI9EeTVQ6mdhHFiAVULBuN6La8Vr+n70IDhTx8c1Pq4Iy
         mi4iG2QbQ76jJ2KPacGc+TAWsN+Vzye0wyl618EqEfoQAzZptllAR94yKkp2Z3VCF8eH
         voVNUeRK51JF/YOnf4cE2Pih4OdM7O0X3Figx7E409eyUBKS7M6h3+C6wNZUWgt7T6jb
         xiySpSIjPtzJ2QcUoPpnLRzDOz9kFldqeyj2Vqa3EF/nPm3oZ0Bmg+prG+eED1BHfqBj
         uvAw==
X-Gm-Message-State: ACrzQf0fi47HGV8dizQVI7uI1O+1LyNMW8tpiiVSuzOt9tnogRPeiAGI
        kuZx06rJ53IJVjFAygQ0M3SlViIj0vVsRjU8AtEVQkn5BxaT
X-Google-Smtp-Source: AMsMyM6Yhhk6S7iWVKjK0DufhE4CY5LjPiIvqTntkN0077ZdHDFfJb4pnUCW2o7r/3LujeDACdaHe1t1hKvTl8SoUx9p1Kuq5wbH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b09:b0:67f:c159:91b9 with SMTP id
 p9-20020a0566022b0900b0067fc15991b9mr22856707iov.182.1667603727430; Fri, 04
 Nov 2022 16:15:27 -0700 (PDT)
Date:   Fri, 04 Nov 2022 16:15:27 -0700
In-Reply-To: <00000000000082ed3805ea318a4a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccbdf705ecad3fda@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_mb_use_inode_pa
From:   syzbot <syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4bb26f2885ac6930984ee451b952c5a6042f2c0e
Author: Jan Kara <jack@suse.cz>
Date:   Wed Jul 27 15:57:53 2022 +0000

    ext4: avoid crash when inline data creation follows DIO write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eb2fb6880000
start commit:   4fe89d07dcc2 Linux 6.0
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
dashboard link: https://syzkaller.appspot.com/bug?extid=4998f18bcd5fc7e40c8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bc15c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d97bc0880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: avoid crash when inline data creation follows DIO write

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
