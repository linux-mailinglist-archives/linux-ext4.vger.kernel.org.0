Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB2697C1B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 13:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBOMpx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 07:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBOMpw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 07:45:52 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E7BB81
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 04:45:51 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z25-20020a6be019000000b00716eaf80c1dso11804028iog.3
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 04:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=VIAYnCO9P6cbB+OvgG0TSM/IyHAIv9vEnqW8AktQXqqxG00xtv9BL57Z3NNxyDBDrn
         danJHYqWFANog62QPBdKcU3G2pUgBwiA7edZEHFg4bD9XnQK4FvL44OOQJgaPDQuO3dF
         Ht05ayVX+hza6g//rcZLo5wivES/Hy2eEY/clNOlx2gLJYZC+AMH21AkftVa5QYhuQYN
         0Wb/voSlsT/bdX2RVnGsV57LQMBPeMaL61YTnZlSYrzjYsFquxrkePCEH4LYqtMGBejx
         sHsetEaIpxvunTYBoUikJrKy+PuQTm+to8djXzNR3YTZNx5ObvmAssosedkKyp4LplAg
         OBqg==
X-Gm-Message-State: AO0yUKVjQLeTzXy41sMqkxy8RubLooveYyQ8C1EmNDNkCGfeO9BpORHs
        2z4o3f15Og3qXgaRWGd2nV3rSPh8/qxhycoarmeKuH/AG1v5
X-Google-Smtp-Source: AK7set9TjvisiTIRVmOM6kk7oWlt9QxFsyDansPcekDaE9vTb1o4Jz8iKYvVdAHKEnBGb6wJBTvmELx9OL90n9hUVjrG8BHZYbwh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e0f:b0:3c4:a4d1:cc49 with SMTP id
 co15-20020a0566383e0f00b003c4a4d1cc49mr886208jab.3.1676465151294; Wed, 15 Feb
 2023 04:45:51 -0800 (PST)
Date:   Wed, 15 Feb 2023 04:45:51 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d245a705f4bc75b4@google.com>
Subject: Re: [Android 5.10] kernel BUG in ext4_free_blocks (2)
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
