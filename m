Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD32770916
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHDTdd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHDTdb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 15:33:31 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCA10CA
        for <linux-ext4@vger.kernel.org>; Fri,  4 Aug 2023 12:33:29 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a337ddff03so4228631b6e.0
        for <linux-ext4@vger.kernel.org>; Fri, 04 Aug 2023 12:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691177608; x=1691782408;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzdUh++BJHrDuPKKRsf91LqaxIwO2TOS3oi8qx0FkeQ=;
        b=CPIufxYWcMGL3qLwLRJnrlN4eS0HGmBayJDK4lxcp7lFyLIJVoxd5X+EILLueD98Sd
         QZ94ZPgwNw4oRdcNgnBYBbw0kkjgdfdIt77r4oyzWQXNOo2tEYxF8xwZtC4R/4RYpHbN
         +WzLEG6bU+e/a480gGhnIZAuuP9acnsthoufSdcfqqE1w9pJm1dsDUleoYiX9FF5wzWy
         1JhGbV9zQTgNbJd7oB+IiwmJhNOfgJFKZpie/s+x3uJ6YMxzi48Je9vDfiyEtwwLeeP9
         swXsU8nqaUwhFMXFMZFb1c93AGuaE+uqG7bKWHDtsNmOhzZpQ097SqfKr6A0cQfbvJGb
         KIxg==
X-Gm-Message-State: AOJu0Ywgnhj4nyxidedjEoDZmR9zzfG1Xn/GSmPF9NSUqq2IKOl5IfHL
        43UDb8phCHrMKUqthCCMX68Hn1swKOymCVxYk9USoy0ZLJTe
X-Google-Smtp-Source: AGHT+IE+uQbIEhy2R5HscVPIfDERmS/Z5ubsvQH9vXigB2rqmjC4PZYfB10LSrC2OFow0FSLOH22ATCKT35uQSYQr1S7oVNCWdi3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1690:b0:3a7:49f1:1d86 with SMTP id
 bb16-20020a056808169000b003a749f11d86mr3819035oib.11.1691177608173; Fri, 04
 Aug 2023 12:33:28 -0700 (PDT)
Date:   Fri, 04 Aug 2023 12:33:28 -0700
In-Reply-To: <ZM0H65+xL7aZOtK3@bfoster>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000965f0206021df8d4@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
From:   syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>
To:     bfoster@redhat.com, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com

Tested on:

commit:         c1a515d3 Merge tag 'perf-tools-fixes-for-v6.5-2-2023-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17939bc1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df103238a07f256e
dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115d865da80000

Note: testing is done by a robot and is best-effort only.
