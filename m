Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADB7A7645
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjITItp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjITItl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 04:49:41 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214794
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 01:49:35 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3aca0423310so9557791b6e.0
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 01:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695199775; x=1695804575;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJD7FHC2t1nFq02NE3AMgOEqkFGUcT0nwVaE8WPBzYA=;
        b=RoHqK0VsnYQCXXhOatWYZlrEohWhYL8Rs6Xso5XXMkaD3YjOmRyJlSQbmRnqp3ofHx
         0Ga7rvIy+d5yYSR7d8JimIdgJ1u31tDjB66yIi2O2/ufBkTuI5vj/+eSsiCwgGBu0sGQ
         rAGNGX8jzIb8sFklwuO94tB7V1eEcXkykqdRx/e8azZ0AHZSt0UhxJMQw7mJBoyZyXaH
         rgkf3TP0VfFdRzBPXlh6d+iOVQjEaNxq5SElUuoliglfaVoex0EYvhW66RT5q4wpVZ1z
         YPQaVSEy2/zitu+/VNoR5X8dNBzSdxYZjk8NY0wyTb8ip3NfS3UjZdPmNELkDs18T5cv
         SlsQ==
X-Gm-Message-State: AOJu0YzJ8i+6tn/BP3rc3fQNzMKu1fpiBW+cGEat4bS1gWq2mU2CLNI4
        8CzstaGp83t/EtXAQ2tPih3xcnfoTSV3nfh53jTMK9cXUCMF
X-Google-Smtp-Source: AGHT+IGms+9J52ItwC0Q1fibulOToekNFjB1LtC8gWLhv2tfIFaTHRXx5yvPz7DRNlYD16Fo5QwFQVOsrOYta/M/ozVCd3J8UDn3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:219d:b0:3a4:1e93:8988 with SMTP id
 be29-20020a056808219d00b003a41e938988mr911332oib.10.1695199775087; Wed, 20
 Sep 2023 01:49:35 -0700 (PDT)
Date:   Wed, 20 Sep 2023 01:49:35 -0700
In-Reply-To: <00000000000044b47605ee8544b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006aed130605c67464@google.com>
Subject: Re: [syzbot] kernel BUG in __ext4_journal_stop
From:   syzbot <syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, joneslee@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, syzkaller-android-bugs@googlegroups.com,
        syzkaller-bugs@googlegroups.com, tudor.ambarus@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
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
Dashboard link: https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0

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
