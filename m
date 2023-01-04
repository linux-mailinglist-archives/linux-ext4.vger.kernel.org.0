Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F765D181
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 12:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjADLek (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 06:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjADLej (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 06:34:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601B1B9C0
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 03:34:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so6021090ild.16
        for <linux-ext4@vger.kernel.org>; Wed, 04 Jan 2023 03:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=F4paLlhYOFNDmvYWPV+vpvgEv3hxK+lS/3bLn5qm8JDxScgpAHhVBS/sDV/7W/pPc4
         jrkl/Ja9CVHmiutGm8CE3AYfCiqY5ufWt/oTxA+BAx4z+3Xzb5rjOjS/w1JHtLWQNs5s
         4vE3GXRdYwvYG/Ma/1leMWXQKTiDM0ykxZrjsFBDEP3rNih3qGVXV5afORMxXa/MpwAN
         qbhDLBVipD/cFKwWxqfgT5+NIb4gDs6KAttJFSgM5WNU7mbzoKhZfxSqeElZn3hNBdXL
         lrpsjhaPrRTcRCZqzoPvsNzPoY4o5iqMlGaeS6CBFBJIBcjM6Uk21dIsYuRzZLRj13QS
         HjwQ==
X-Gm-Message-State: AFqh2krg690nSsz6ARvLZ4wR3ZR+lPso96KLBJtG2YZ9htTQfpqZaPV9
        UKXNzft+dFdWPUfVYLJdMi6M0Gx4pkIyKodJSQdVVhArH8PF
X-Google-Smtp-Source: AMrXdXtYnU0n+7Mz66+jF3YyEbOSXpsWchRQh4OWWMAkTgA+jN6H8D5b4L843NTdw6V/0AriGfmSejO1PiEbK7VCcfnaujakKtak
MIME-Version: 1.0
X-Received: by 2002:a02:c728:0:b0:399:6200:63dc with SMTP id
 h8-20020a02c728000000b00399620063dcmr4409365jao.194.1672832078148; Wed, 04
 Jan 2023 03:34:38 -0800 (PST)
Date:   Wed, 04 Jan 2023 03:34:38 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c97b2a05f16e91c5@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, lee@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-android-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
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

This bug is marked as fixed by commit:
ext4: block range must be validated before use in ext4_mb_clear_bb()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Android 5.10
Dashboard link: https://syzkaller.appspot.com/bug?extid=15cd994e273307bf5cfa

---
[1] I expect the commit to be present in:

1. android12-5.10-lts branch of
https://android.googlesource.com/kernel/common
