Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1463F554
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiLAQee (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 11:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAQed (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 11:34:33 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9AA9E83
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 08:34:32 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso2029440iod.5
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 08:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=UcaRqwxPI02qxvCXLaW2yDxbr3tfkQuwQA+Y2mzUsCq4KRIFRLXCi5EMp8yqglhLzz
         yEUDs0fPBOzbC5HIKNgQL3JTIQtQuM1RplFM7ijRnd2qvuOEGbhECxKBaLXKqZiZr9d/
         soly6vKgGPn6LyG4/i2p1pi+MW0q+PNKXgUq3YnBrajkhRUYK9SrayAAV3VMo+pT2YW1
         F3cMXvpkBsfVpzqfCBrRq85rkQodeU0ld3kexKtd6TrpNdEg8jNen/rM3kL8z05nKf8Z
         ge0C6UmraYJhaLsKfXSKE0HV7sMrN9v6DPW+Z3lWw1dZkJcWCfYL/CvBcL3jFFwgzWpa
         3g4g==
X-Gm-Message-State: ANoB5pmMEeypJUEv91EdqPd9qnJpk9PaExCh4cbD5NsbExgvHSX91k0+
        vnRe2ujF+/JQHuwXxclbmH86wLPpyMcnGZPM0ApdmRlNA7wP
X-Google-Smtp-Source: AA0mqf4QsSf1RfaffekqeYnhim3TQSpIXqCXD7AhIKoXzfukEk/NduogwSXw23qNdA3B36SI0rQ3mzU6CxJ96hdkg4dHKHsaUPFE
MIME-Version: 1.0
X-Received: by 2002:a92:cbcd:0:b0:302:a682:4867 with SMTP id
 s13-20020a92cbcd000000b00302a6824867mr28386527ilq.214.1669912471753; Thu, 01
 Dec 2022 08:34:31 -0800 (PST)
Date:   Thu, 01 Dec 2022 08:34:31 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af5eb905eec6cb85@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
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
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
