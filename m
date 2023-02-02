Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3C687CF1
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Feb 2023 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBBMK1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Feb 2023 07:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBBMKZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Feb 2023 07:10:25 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1EC8AC26
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 04:10:24 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id v17-20020a92ab11000000b00310c6708243so1074694ilh.23
        for <linux-ext4@vger.kernel.org>; Thu, 02 Feb 2023 04:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWayKF5ggK69XyoBZToPMEIyZDoGPPBLOVHjV6MNQU=;
        b=jA0EtCmP4arJRkurIPA38D0PsZWnCF28o3UQ6esielyA2o73rKTlzqTNWn4SaeQ9/w
         Abz/igyMGGovZ8FrcBSkPg/P1wI4BFMKEP3wIQ/6oCNveA7XG0NdVTdF+GcXnKlCwhSy
         qauGkRgZbjb+QgD2c5Q33lSqkK6tVKiG6ap/SkYHqH8DMygRIXWuchW+k1jgQN9KnRRQ
         9++ifvEiA+O3dFwpapd0UpUVC4RIIWsDatrI31m3CioRvjYHYSJxV9sac4NIrpwfjOaz
         I7xfaAMOKW02awVznGsFiesdg4TRN9bc89/HzQDtRds252tkcL1NQM9qzUTaAkTWwts8
         w4lg==
X-Gm-Message-State: AO0yUKUXRLvoioXaupiVOQ/aXAjlWo5gYKAXDFHtb856VmqZzS6Z/kx0
        rbnWqcGzu3RsUh6VrjS3JlDAI1ciZ4QH9M1aOp9kXYlLdArC
X-Google-Smtp-Source: AK7set9AbnNoYKjx/qSkKWWOgIpAdmAM+7Lz7wDL1WptOFcb+5ZDCwCqkslyhwjhRXyLIy+Mfl08lwSTXn8Ea+H5lnxWbsrRqyOy
MIME-Version: 1.0
X-Received: by 2002:a6b:a07:0:b0:6df:2c9f:f8fc with SMTP id
 z7-20020a6b0a07000000b006df2c9ff8fcmr1297397ioi.4.1675339824005; Thu, 02 Feb
 2023 04:10:24 -0800 (PST)
Date:   Thu, 02 Feb 2023 04:10:23 -0800
In-Reply-To: <000000000000befd1d05eeb5af30@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000168a9205f3b6738f@google.com>
Subject: Re: [syzbot] WARNING in ext4_expand_extra_isize_ea
From:   syzbot <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bagasdotme@gmail.com,
        ebiggers@kernel.org, guohanjun@huawei.com, jack@suse.cz,
        johnny.chenyi@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
        miaoxie@huawei.com, patchwork@huawei.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        weiyongjun1@huawei.com, yanaijie@huawei.com, yebin10@huawei.com,
        yebin@huaweicloud.com, yuehaibing@huawei.com
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

commit cc12a6f25e07ed05d5825a1664b67a970842b2ca
Author: Ye Bin <yebin10@huawei.com>
Date:   Thu Dec 8 02:32:31 2022 +0000

    ext4: allocate extended attribute value in vmalloc area

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e7b9a5480000
start commit:   644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=4d99a966fd74bdeeec36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f49603880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfb9b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: allocate extended attribute value in vmalloc area

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
