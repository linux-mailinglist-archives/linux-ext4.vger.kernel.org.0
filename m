Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC27A121B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Sep 2023 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjIOACv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Sep 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIOACv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Sep 2023 20:02:51 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD72102
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 17:02:47 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b728bfb372so2272580fac.2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 17:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694736166; x=1695340966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=DYmeXRxDrXF2XPm571iWmU1dz9/DAlsDJ/WZC/k49W8eerMrJT/uPo52AGRSbsSJ1F
         SYSkUCc6JmWlBhkok/4ocz3L0ALD824pwQ5Qq4eNVbDqTAhcoNH1jr1rHbEwJyq3QkN4
         iNDXEn6SaahmNHXAHrhT/quVH3qeDWsc2+L8Gd9hCxhgOv0Tucz5WBRExivqMyAlr4TY
         ISdZSZhvqzyVjZh0clc8+K/Neti+Ju1gEpYaO29Hz4+LUKnRqn9Cgk5ORJhGdh2DDw58
         MevGd6g/ayiEmXioYqnYhBhpwJ87C6chQxjw+cUi6R1Ykh8UrzvtZai2Q9gLcpcPLxp5
         aJ8w==
X-Gm-Message-State: AOJu0YwKP7ULiRqMDqgccCFoHhUhP+RKvejAVURP+f+51+rkb+2dFObm
        reKT/GNQNjmAW+ij9aEniXoBy0lijcwv7bUgOVmU163paeDY
X-Google-Smtp-Source: AGHT+IEoZjyeZ6CTIG7y++SgKlzykQNAg6H+0yvywZdubZ437bwRx4asTTHPb6+zOeYXI2J5lX6LWU4XPv294wX0CAqXMMPmLYm4
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b17:b0:1c8:bae6:5305 with SMTP id
 ds23-20020a0568705b1700b001c8bae65305mr59426oab.2.1694736166146; Thu, 14 Sep
 2023 17:02:46 -0700 (PDT)
Date:   Thu, 14 Sep 2023 17:02:46 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bd90a06055a831d@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
