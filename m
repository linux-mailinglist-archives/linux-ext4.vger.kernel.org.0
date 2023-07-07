Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF94A74AD6E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jul 2023 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGGIz0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jul 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGGIz0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jul 2023 04:55:26 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07652107
        for <linux-ext4@vger.kernel.org>; Fri,  7 Jul 2023 01:55:24 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b8a7735231so17774895ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jul 2023 01:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688720124; x=1691312124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP9O7wz2wVY1uz0Tz+tNVR7jOVmsLzGbSd5qvYHHqCA=;
        b=AMFb86pTXbEZjXftk/zKA/C5+W7Y0DOFKiBktaDpVXsrFgnm8TZeofJRazfdHe3aRq
         juGu0HBgyTVnsBayCxqgqSC1tCDIVCzyOLrZLVUVILSImTUUCfL7s1XtsLxVDXg+OKLg
         OUtAol38BPRKYluZTri1HW7D4wJ+jZw7//ds+prMKJEi4txK4x049ZZaLQlsRVAY2Atj
         xOBpVG2QapXi2mr3tfOR4/fjKgpM7GyKc2uXqg4fOSAC2idwMJ8kXUms8pjYiC6czqPL
         xrZi8knkHagfw855TUsvI0ogARhKUYtmb1PaS9WhL3R46yxFwvmGRuGynjW1YoTC9zLI
         ECSw==
X-Gm-Message-State: ABy/qLahCoL48gUdSNpUgKFtpyo+I5IiEa58UXY82OnPuwhHo4d09vXC
        XT8PyYSr+V2ZzSMt9/bOalXN4ghQKqVRFE/yn4TC6aRV38No
X-Google-Smtp-Source: APBJJlE3GQMXl1cHyHg5lh6Nt6ubMsGnT10l3ez2+JBHtCWT+vZpFky6rzT2FyrUgqeF+q0zYYmCWBHisoQaeXrNjkKwW/DiQAaD
MIME-Version: 1.0
X-Received: by 2002:a17:902:c1cd:b0:1b3:bfa6:d064 with SMTP id
 c13-20020a170902c1cd00b001b3bfa6d064mr3877302plc.1.1688720124415; Fri, 07 Jul
 2023 01:55:24 -0700 (PDT)
Date:   Fri, 07 Jul 2023 01:55:24 -0700
In-Reply-To: <2225033.1688717605@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024166c05ffe1cbb0@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From:   syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, boqun.feng@gmail.com,
        dhowells@redhat.com, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com

Tested on:

commit:         5133c9e5 Merge tag 'drm-next-2023-07-07' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124f34d8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f6b0c7ae2c9c303
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1624cf4f280000

Note: testing is done by a robot and is best-effort only.
