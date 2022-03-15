Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A554DA4D1
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 22:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbiCOVtX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352056AbiCOVtW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 17:49:22 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6313A185
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 14:48:07 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso280485ilu.19
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 14:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/NXOsE7z3uVlHEZWfeECLOoEsU4elOdadsf/DjJdp1g=;
        b=PgZ92ISqOyaWA8lH4zaCzwU4xB+rr8d3D7MQ02JArX48231D78ypSvY4wCYiExnY9G
         H7RiSK5w7mC2xprmyW473edTt2QVBaIc8DvHxwh0TIMNN89f7nDA6q0vP9Ajt5IKeEbh
         XeaSLs2Pp8MAJSbTo2gTXGqVvwSarwyMbXKxNp8R4Oh7SbqCGPUo6xuyzQKqAuVxdEsg
         8uxZdEVe2KS0iWaDhQkDaeKxOvV80MmgiN+ZHZC9pE7J+uvU80w8BWhqWMBy/vKbRSzk
         vlWl1Axp4uiQsCWW1MEFwFb3dvTqZWcC3PuzbGH1wfBxSWRoqs6Y5H+2w/nzhEZFeToe
         GvIw==
X-Gm-Message-State: AOAM532Y1BKgX4gs8CG7qFi8/b10ocQZz0A+zWDG2H8w08HT7ap47l7k
        1Xmd0yWWNtNY425av/8YIN+3R1aPWd8eNsHmf0H5FvU5vbcg
X-Google-Smtp-Source: ABdhPJy0xgkoDa/Sf+32yrs/MfimjSHymorxymsIiMJKkDCg6hCFnEsVOHYtq1302tSPoMvHp/u3UD1uya773MCNXl7/Exu8s3kX
MIME-Version: 1.0
X-Received: by 2002:a6b:1495:0:b0:645:b115:611c with SMTP id
 143-20020a6b1495000000b00645b115611cmr23535947iou.199.1647380887291; Tue, 15
 Mar 2022 14:48:07 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:48:07 -0700
In-Reply-To: <20220315213857.268414-1-tadeusz.struk@linaro.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098ccfd05da48c056@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com

Tested on:

commit:         56e337f2 Revert "gpio: Revert regression in sysfs-gpio..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1131f2c5700000

Note: testing is done by a robot and is best-effort only.
