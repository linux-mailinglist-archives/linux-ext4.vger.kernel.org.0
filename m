Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CB6A6A7F
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCAKIq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCAKIU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 05:08:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2D1C596
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 02:08:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id b4-20020a92c844000000b00317983ace21so504875ilq.6
        for <linux-ext4@vger.kernel.org>; Wed, 01 Mar 2023 02:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTSQYNOg9OZQxBXRQdwYpLcJKsFubqAo72NPGlg9CpM=;
        b=LQnDcvC3PhYUC0ic6qFSCWf3n8IEU81OMiwTB7ufNohPTXnhxzzA79XhVRRcJnMmSB
         r5rEa44vn90sClcQlkV1sBhRVACVDyt+GP4Tp/pLCKsC1PzC7ZWR+EzN0DuhqQubVUm9
         ekRT/wS9KLUX5TFtRXRfb9J1qUMv4evB9wRcENj/KGWOJtz7W9jEq3tB7uUIT9Bnu+Ob
         RTqjKTHQaLu1Z1NH8wERzQXsbFafnfL+4v83qN0OhB/lE+QjEvaEplFq0guOlUgcDWuI
         HuZGttedJzfoYSGXoq1uajKAPuSIEIry351+xuHlnNW0R7PahO7hdE5YEVaM+npLhV9I
         ZIRA==
X-Gm-Message-State: AO0yUKV+ZsI1sH//x3Xj0cQflotXqRFwKdVz/YMvsf+aCI68KnZjDs6d
        ed/jIl/Y5w/1xnq5juO/ML5m65UZc8g2lj5NhU9nUO0Kt6Ib
X-Google-Smtp-Source: AK7set+9+5X/rmiwzS5y9zd/polCDgC1mf5cojHMVCq+fi5kymlSfbpp3XXnKUbMuUR5F04OX2n/O6uA1Abba2gonsivBHeDDaEE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:151:b0:745:c41a:8f0f with SMTP id
 v17-20020a056602015100b00745c41a8f0fmr2577531iot.2.1677665299348; Wed, 01 Mar
 2023 02:08:19 -0800 (PST)
Date:   Wed, 01 Mar 2023 02:08:19 -0800
In-Reply-To: <00000000000052865105f5c8f2c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003845ba05f5d3e416@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
From:   syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
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

syzbot has bisected this issue to:

commit 0813299c586b175d7edb25f56412c54b812d0379
Author: Jan Kara <jack@suse.cz>
Date:   Thu Jan 26 11:22:21 2023 +0000

    ext4: Fix possible corruption when moving a directory

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14845d50c80000
start commit:   e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16845d50c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12845d50c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d96208c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176d917f480000

Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com
Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
