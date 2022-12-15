Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C585564DEB9
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 17:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLOQei (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 11:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLOQeh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 11:34:37 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8521055F
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 08:34:36 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so8102160ilu.4
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 08:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=WVhYXMl5P4Vp2gyr7NtvPnykM4WltcqmpAU/fPUmAeEgo0gyJsiEWvFilYwKTioQ0j
         ClX+jv6Lw9wWjSYpEuuydgPdxk1eLtae1NALlKYX7A0qMFyVDjW8EvStV8TQfIfrb8of
         oAZ5oUwSf1n910CaMF9EHu0X0O3lXIpOoMma/cY2uMTI750RQ1Wl5hA0HFpz3v9yTuGQ
         uEFnif/kB3MHys1a0P8urSbuP4oViLFcQpEqfk8oJH+tAAAG/WlIytfCZbFfrR0VoFjO
         EBvGGc0bICNhVEgxAGwk/Wbi2iwuXGTKF0Nqb2AMZApyrJ47bBKOZdQ4VXYxY7eE6acp
         RLXQ==
X-Gm-Message-State: ANoB5pkmqB/LnIsi/39tvuOrG4Oo6b4dl3gco9mWZC2A5I/0c531mPTU
        OLPaahyFCmN8wNTu06RKQAl4g8uf46/ORC6SMziqBcTbQ3DM
X-Google-Smtp-Source: AA0mqf5FzknCTRgZ5/NnD2luL2tffHnVuVk1MAMWE1nMsEVq82UTqE43Kw9M0nei31X8BWp1l13rVJn/Sof8OhGcbC4QuC/fffzN
MIME-Version: 1.0
X-Received: by 2002:a92:dc04:0:b0:303:1c4d:d32e with SMTP id
 t4-20020a92dc04000000b003031c4dd32emr23700450iln.286.1671122075910; Thu, 15
 Dec 2022 08:34:35 -0800 (PST)
Date:   Thu, 15 Dec 2022 08:34:35 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b60c1105efe06dea@google.com>
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
