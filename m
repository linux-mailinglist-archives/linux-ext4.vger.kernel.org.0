Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF3686631
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 13:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBAMpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 07:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjBAMpo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 07:45:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD712DE4F
        for <linux-ext4@vger.kernel.org>; Wed,  1 Feb 2023 04:45:40 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id k7-20020a056e02156700b0030f025aeca3so11343139ilu.12
        for <linux-ext4@vger.kernel.org>; Wed, 01 Feb 2023 04:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=b/4w3Z/85tQVX9mXlKD+p9dlmYuAVr/yb7GGORazQhem52e0XUrl2QoJgEB7bkLTqa
         e96Fa0Mw71is8R3s2+Rg33VaOzh/R+Ij58cHjSPqIrdVW18j3OfokPjY/q/NzQNSketG
         kNm+zjc+ptGQGHD6q0xlj39PVjm9/Ouzhg0Hnd0VlrWBa4mHvFxlc8yZYfFZLPkmFywI
         je40lxoSxCl2DTfhgTXzvbURIrWtE/TPB+FJ+39qPAXjVlrwesmifpetsLXznMyjXLxE
         Rs+zHMXFQPlhqWr+eJOWGrbG8n4wVBHRl8D5k7GQcQe2bQogtzhmhb3CgkdpOZBZB3M0
         1Bnw==
X-Gm-Message-State: AO0yUKXVBE9vYgJq4NSoljApgIMSej/UJpnL6hebbw8YsJ/AYn2gkpYF
        tTb52yj0489yha6w0Eet+HD0izbSNCh4vKmdvQIEvUg7bWh0
X-Google-Smtp-Source: AK7set8i4uvYg6+GpTdMSIzx6vtF835rmgFlCdJGSpv7rq6MO3NDFTCc1cgEiGwQuSXfchipNn98YjYUH3i1f67LYl1nHTfNNSY5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a0f:b0:3a9:611a:928b with SMTP id
 cn15-20020a0566383a0f00b003a9611a928bmr461546jab.55.1675255539387; Wed, 01
 Feb 2023 04:45:39 -0800 (PST)
Date:   Wed, 01 Feb 2023 04:45:39 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005555f005f3a2d3da@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        joneslee@google.com, lczerner@redhat.com, lee@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, sashal@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tudor.ambarus@linaro.org, tytso@mit.edu
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
