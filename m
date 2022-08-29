Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239D05A4BFB
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiH2Me1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiH2MeF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 08:34:05 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01DAB9FA6
        for <linux-ext4@vger.kernel.org>; Mon, 29 Aug 2022 05:17:45 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so5845300ilu.11
        for <linux-ext4@vger.kernel.org>; Mon, 29 Aug 2022 05:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=SrSe7jnyQyRioqnmTf2J5DXbE31vG1Xcx9SOOtFw4QU=;
        b=WcHH9CUHW4jB5vb0/ACUeFzDmcJ4Nkc9RGBf1xNkcXl2pbiLXE7nX7G3Baq95bzuJo
         Inydk+xoNeT39Tb6lOaOp1DXgNDsScbdglBXECwoRnNbbGV33lBT8vCohRiN6JnuNgVB
         BA+kLzyqSdWq38LXdKWcDU+cHbJ/0fNz5UhgqVvSbFd2ruQ3ih+EmVOwVEud12Z9aNrL
         VXpGBbwKRCq6+DbioaevCUqD+UIH6sCbNBB9P/L0zibLpbv/taGcJTDdQxxN1uCeTHuf
         rPuAENsxHvwjxmdNj3q8dWrKouSOm7Hi39+gpxNcXkRtNFR1KsDlME08mvOOnivKn9WK
         NtwQ==
X-Gm-Message-State: ACgBeo0U/rPP0XoIJbXN9oJtqEw81ksmfhczlUBrBvj31ESSawwku/Q9
        YBAY1mPj4rUf8ujpz10I4b7H4gOOwGEU7mgVeiaauptFeksZ
X-Google-Smtp-Source: AA6agR6NJ/nFYwrCtpWgTgMWS/6p1ETHt+vKzEDXDLiFJkLN/USmsAVpHed4v65z4xxkB+jvS0/m1wx9y+QIH7+nq0Vv6FTauSxF
MIME-Version: 1.0
X-Received: by 2002:a02:b60d:0:b0:343:5ddd:66b3 with SMTP id
 h13-20020a02b60d000000b003435ddd66b3mr9940739jam.8.1661775433310; Mon, 29 Aug
 2022 05:17:13 -0700 (PDT)
Date:   Mon, 29 Aug 2022 05:17:13 -0700
In-Reply-To: <0000000000004c915205b1a04ad9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000662b4a05e7603e42@google.com>
Subject: Re: [syzbot] kernel BUG at fs/ext4/inline.c:LINE!
From:   syzbot <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org, hch@lst.de,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, phil@philpotter.co.uk,
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

syzbot suspects this issue was fixed by commit:

commit 1045a06724f322ed61f1ffb994427c7bdbe64647
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jun 29 15:01:02 2022 +0000

    remove CONFIG_ANDROID

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ab0893080000
start commit:   a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ebd4b29568807bc
dashboard link: https://syzkaller.appspot.com/bug?extid=4faa160fa96bfba639f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114ae045b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1785e92bb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: remove CONFIG_ANDROID

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
