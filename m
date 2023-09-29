Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1A7B34E7
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjI2O3W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2O3V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 10:29:21 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE41AC
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c4b9cab821so26632499a34.0
        for <linux-ext4@vger.kernel.org>; Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997758; x=1696602558;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLNYUvgMbabObe54YV0karBMGjsfh+7I5wYZ60IM97s=;
        b=lNObq8KUmM1+9DoxN9DwML40yXRl9e8jeNxDH9Vu028y0/0sLTRX9vAD+s7oW+DfqL
         sl93QioKrlEC6SNGZU+OR4vb9dULvVj359RMgXE+7behoo4H4jHIrpKBXK5DxXjxtqMp
         TeitPrhfqgr06K46QLDlkcXaUEsv595QfrC4dppHcn1rPoJGu13T9KqUYO4CA6/+prIj
         pBPdWTSkTZd5hBGCdlI5mI6yiNc+f+AmB+NKxF9QDniQiC2f2EAlHH4WSBpDiB6W3jed
         wrY0KgKicEtSK9KawwxtB5NOk5necDUK8K86Z0I4sasPoTETJWmn09vLHWF0CUQ7ufAK
         IAsw==
X-Gm-Message-State: AOJu0Yxbz4YdfrBv2Zfmp71f2mzbN06Pj4b6W1VHeTGEI9ZBHw0KzUhr
        mp0EbkaY5f9wysCORtMmQDT7f3WYoZMuwnxLz4yJSVLEk/t1
X-Google-Smtp-Source: AGHT+IG9OxQod939WyJcDOMakaPerThj04UyypSfq5sPAWlD5D37uESD2tGQLWQZKBYvHdw4rTZ+6ZUDvxSn+5Ah0pz7GJKY3YKo
MIME-Version: 1.0
X-Received: by 2002:a9d:6a50:0:b0:6c0:a3e0:f9e9 with SMTP id
 h16-20020a9d6a50000000b006c0a3e0f9e9mr1165244otn.4.1695997758619; Fri, 29 Sep
 2023 07:29:18 -0700 (PDT)
Date:   Fri, 29 Sep 2023 07:29:18 -0700
In-Reply-To: <0000000000005697bd05fe4aea49@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f147d80606803f1d@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
From:   syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bfoster@redhat.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has bisected this issue to:

commit 310ee0902b8d9d0a13a5a13e94688a5863fa29c2
Author: Brian Foster <bfoster@redhat.com>
Date:   Tue Mar 14 13:07:59 2023 +0000

    ext4: allow concurrent unaligned dio overwrites

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a8442a680000
start commit:   9ed22ae6be81 Merge tag 'spi-fix-v6.6-rc3' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a8442a680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8442a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=307da6ca5cb0d01d581a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb672e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16219bc6680000

Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
