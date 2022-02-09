Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACC54AEB8C
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiBIHzK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 02:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiBIHzK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 02:55:10 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D1C05CB80
        for <linux-ext4@vger.kernel.org>; Tue,  8 Feb 2022 23:55:13 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n20-20020a6bed14000000b0060faa0aefd3so1217067iog.20
        for <linux-ext4@vger.kernel.org>; Tue, 08 Feb 2022 23:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UtEHDx2/SDtUWhjFiOkqioSqjTgEfgWZaCkVNfs3Q+A=;
        b=TFsotZH7JZLwGE6mBLkG2QktcKqDb6dOHkgicgW2MBeUnpTty55yxToiJDviqEalvN
         8OmBiZCfqKXBbd5sVnsankjAhR7V8IUF1ngK5jfQeAI8UE0MM3xhEKq0HIoKM3NKEUBs
         cB+Gd0pVyzfxgAm2TTDV8aRPuQo5U1RM0ZGHCrMUNET5UkXSTaEx0ITeI/sDnvRfGIWm
         0K+q+iaewFZ9LInBSTwonBbsf7jmoK9ZhuYUHRFd/gkhzRjt3VQzEQ14e7rqbXOpMnDh
         rHQeWm0wW8Krdkf0G9ElJOAZhUKZRB8fX0z2ZesXM+iRhRwx5CnLxyWOHB4E8AgEPcuV
         HLiA==
X-Gm-Message-State: AOAM533LFnF5NHfcg9M3gxc/3CD5cnp0h56JGK+/IFs3w62J0+RDuX/d
        hp05XnpaCgDvCr3EAXkJ9XGGbTjdgD9Sju8tvbxwkuowTiZ1
X-Google-Smtp-Source: ABdhPJxTiND/YMKyiFm0ggyZBFIDxDVQgbKIe1A0qrUTf80Goj1N/PGkmq+Kz1wBKQu3w76vPZ0n7I1tPyBPOGq6MC80jWI0Lvfz
MIME-Version: 1.0
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr520244ila.112.1644393313139;
 Tue, 08 Feb 2022 23:55:13 -0800 (PST)
Date:   Tue, 08 Feb 2022 23:55:13 -0800
In-Reply-To: <20220209074137.linx5qyi43hkclss@riteshh-domain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d049f05d7912725@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
From:   syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
To:     jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com

Tested on:

commit:         54ccc072 jbd2: Remove CONFIG_JBD2_DEBUG to update t_ma..
git tree:       https://github.com/riteshharjani/linux.git jbd2-kill-t-handle-lock-t2
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
