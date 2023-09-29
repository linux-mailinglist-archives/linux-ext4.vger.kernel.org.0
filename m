Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD97B3AC1
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjI2TkR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjI2TkR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 15:40:17 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1EE7
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 12:40:15 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af5aa51bacso8727564b6e.3
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 12:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016414; x=1696621214;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNQrYT3OQogUofuWRz+a50kX9hRE740B4AHi5pXpdRg=;
        b=Gstl290Ag4u6445empJmZD/YZQWBHHkpJWH17legaIpAds/oHRScFo+c1Ikgvt5xeJ
         M2YIRgSDsiowizSNQEXMSE2w7U0pvoj08qjEOSCkNsqeCyku5FPjjaiRjIJEp3P8DfRE
         fl1oYKN2Vr02rYOM48EgkRyLgYbkkew4wNPo4u90mQYkCaa9QxvQCmUGtEZjS4sWLut6
         5b9ywVmFDfPpt8qaU1B2N1nYlbgSCa5eRkc27/kbMT2Id45oHZ4UgeH9hMMSAIOpu7PS
         EO1wibumUU5pjqC1pr8fX0xyEoRyX/+BtBr6I0DCwc5woenJn5Wl9bkw1fFyMWnLmQJi
         YeJw==
X-Gm-Message-State: AOJu0YwMMd6GQRlf8EdAIrEhaZetj8Rf9BP4qMu8GKWflC9iKeI1KDXu
        PhN3BttbgNiU4JnoGiGlk+XysmBj8yE1jfuj1mecwdzu4Fvr
X-Google-Smtp-Source: AGHT+IFiwUGf+jG97GaXyxAkwck3lvq4H8gPUJ0fFioe1Yvel8cKli2upeOYy+T9Qj1i7mECBKXqTq3KLvmYI4jh+hJrj5qkJ7wZ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1891:b0:3ad:f838:d02b with SMTP id
 bi17-20020a056808189100b003adf838d02bmr2427847oib.0.1696016414386; Fri, 29
 Sep 2023 12:40:14 -0700 (PDT)
Date:   Fri, 29 Sep 2023 12:40:14 -0700
In-Reply-To: <ZRcjWomEnypTpDja@bfoster>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9b196060684972c@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
From:   syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
To:     bfoster@redhat.com, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com

Tested on:

commit:         1c84724c Merge tag 'slab-fixes-for-6.6-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a06bae680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=307da6ca5cb0d01d581a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160c17c6680000

Note: testing is done by a robot and is best-effort only.
