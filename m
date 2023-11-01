Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059E47DDDE3
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjKAItU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjKAItS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 04:49:18 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2DDF
        for <linux-ext4@vger.kernel.org>; Wed,  1 Nov 2023 01:49:12 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e98eca4206so840878fac.0
        for <linux-ext4@vger.kernel.org>; Wed, 01 Nov 2023 01:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698828552; x=1699433352;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=vQBuompJRrNMn7oM++0z7dJ2XcdxMkHoROYGlM+O3L3G6z4XL2MsGMF2oYCIeZitny
         x9HNpwvE4pLWiOAlKoHNd2+QAX5McaYegbGfrZv4PA77RBop0NaS7R5LpIMJf8vxT0ch
         b7Ij8JgbU+UZdIoMqjxXn8jR0W9sH9qCk7BMQnsZaI18wrZUF5029CnqL9LSotjrER4M
         o7lTiDHnBFj0+Qm6DeiGNUM6aMR7ODOj5fqdFnNITHuXEkkXDQdYGBI4yYTRUmK84a5C
         VLAM3bzCjdWB1vMc33c4osdVCVzDRPFpLGqkJFLfxLoie2j9CKM1vRU10aB7x70oWpVh
         RGeg==
X-Gm-Message-State: AOJu0YzOMKoiae00956plfsyR6Zr+QhCBhnwXUbbOsIl6eHhT9aX3aZ9
        F8+dckt4t22R8zoN6Kqc2H8GDR4Ae1tqKnWKOICUVzVjEfWe
X-Google-Smtp-Source: AGHT+IHcunDBTKsdG6HwYObTbjW7yGSIe6O+NrfxyuISaXIumOCLSA0dGIIBR7P65cCYIijfOW6pKSYaHy1p0BDbBWsjpQmK0Rfl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1f06:b0:1ef:afd3:813f with SMTP id
 pd6-20020a0568701f0600b001efafd3813fmr1126528oab.5.1698828551901; Wed, 01 Nov
 2023 01:49:11 -0700 (PDT)
Date:   Wed, 01 Nov 2023 01:49:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed5bf06091358dd@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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
