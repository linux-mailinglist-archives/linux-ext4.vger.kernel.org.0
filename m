Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F36065D9
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Oct 2022 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJTQcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Oct 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJTQcd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Oct 2022 12:32:33 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17D1AA26B
        for <linux-ext4@vger.kernel.org>; Thu, 20 Oct 2022 09:32:32 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so305270ilv.8
        for <linux-ext4@vger.kernel.org>; Thu, 20 Oct 2022 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=GM0KQTjVZx7ceSAEtnHUBubynHqVdg6MeqVqxRqBrThdhqfNLyevdh5H8Avbi+OZFw
         N/qo5U9jw7jSprijw7afTOYma7BlAVIfEs1AhxDgKt2yOpsHv/6TcqnFgy6G3O4ypkvH
         HoQJU5Bd4pjPuNDArr4MBRZS3Z8jV+nsipOhrE8R1nnr2XXpmcUtIg3DAaEJZsf5QWxt
         Lwfr86r4l/kL04rkIWbkcfXqCNL/LAN8WbLtu2sQY9Q81sh3S/re4g0/ZPGlQt2tlw6m
         0snXywtBBLk0eLlifdBNzjGLO8mNfLlQqYLy5Rfg5ChTxowheApqqaJ8jJ87buzrn8y9
         vBYg==
X-Gm-Message-State: ACrzQf2XA4lEPGjBc2MtECXgl06C3ZBVdcE1fkTt8dAcYGRpodJ4d3b0
        q+YNantmCJlbj+skXfnJcot1blFrA0f3+rZa9fRFLXHe2Dzr
X-Google-Smtp-Source: AMsMyM4FPk0iRiokf85qWc1ZXECTEgMCQq+Q8VRal+EfXVpDu+LSoILYcUwg/tzPl125RD3+HZ/hveGyU+kyJ/AQ4rT8VBRuhcH/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:2fa:e426:dc5e with SMTP id
 s4-20020a056e02216400b002fae426dc5emr10321935ilv.213.1666283551925; Thu, 20
 Oct 2022 09:32:31 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:32:31 -0700
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000352cf605eb79dfde@google.com>
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
