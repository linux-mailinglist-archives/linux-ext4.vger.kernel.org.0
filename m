Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028B61F373
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiKGMhd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiKGMha (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:37:30 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A521B9FC
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:37:29 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id h8-20020a05660224c800b006d8de87e192so3039875ioe.6
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4j4i1D9g/K0Cayton2okA3A9p6eYtwnuNOgUF/2ByQ=;
        b=aM5Lg3IDxDxCD8uzSQoWjBOA+97/lss3JJkCcWwv7TIyFYcW4tD2cj9pCDg4UjPyod
         Xi0kcy/6lZzGAq/wEZ7+1jsL3LeZEWQVTCsGo4wh6aDay5M88YzoSaPlYvt1iYRGPgGY
         S31P4jC2NNG6YbIS7r1yj+iMjWX9pzOqztYafE2dzsO3BbT1jz0dWbCvhmdta8MmAalJ
         gbAbwU/5owuNqSw63kPchQjd2sgTCLQ/+BJLOeN6X9Hm6kKV+eui27oFWxAMTgeDptqs
         W5URYO1O28AzUXK9/A5Wf+VE8m0M1SDb52/P6clKT7i4QinZH7bkY3Uyjw3FYBl/1Jir
         c+NQ==
X-Gm-Message-State: ACrzQf32UfTXarvHbmw0iXdGaXDsXtEY8Mcy2oAyiZ232tw6iUFU6okw
        Nk9gEyfSlsm7cERZvuWYjt46a2i2y5WBTivNNnFbDxtmZLEI
X-Google-Smtp-Source: AMsMyM7hL2RBAgD8t+s2gyQ+GiR0UO0q3NHbLXrJlSmqrZh6R4WmKFa8dNIEZN8EXbW1Ib8B16CXhBZMKKoRRN9U5sAUb6W/TsYn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1586:b0:6d8:22c5:102a with SMTP id
 e6-20020a056602158600b006d822c5102amr9042086iow.156.1667824648749; Mon, 07
 Nov 2022 04:37:28 -0800 (PST)
Date:   Mon, 07 Nov 2022 04:37:28 -0800
In-Reply-To: <000000000000c3a53d05de992007@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc92bf05ece0af6f@google.com>
Subject: Re: kernel BUG in ext4_writepages
From:   syzbot <syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
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
ext4: Avoid crash when inline data creation follows DIO write
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
