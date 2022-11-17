Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AE62E209
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 17:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiKQQfr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 11:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbiKQQfL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 11:35:11 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B722B3B
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 08:34:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id i12-20020a5d840c000000b006de8b8c5746so540785ion.22
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 08:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=QrYKvRoRxKk+vpXI3rl10NGRYOkN/H0kwkZxDVHT4I9yjUx+JJzD5TVtyHLmMLMysm
         pZjst9f5IDBN7HbGBYUCIGC1xs0tOL2FrdrUr+hWbjDnqlQUTDEfL6ssxYesBGPqSwvP
         t3Kuq291xZ4xf8y1Em0hUh0p6R+tivVtbhbQSf09lr1wGmmYMoSJPrlB+OxPL0pNkDwN
         FgxRPW9DaU2g6lFAYStMemsvKHiqvL91xc7H2HMeGQNTOqgiZtn7c/U6gT07VhIbO4B6
         atpgGfNEwV1KLnCFK05J6NHUYxaY6R7MDLxA99NeQVW8clpDVoaw2yUkMvJKTNrcMItF
         0IZQ==
X-Gm-Message-State: ANoB5pn/RTEk6OARjGCMcNKMg97vX7+5jWKoIpSqfbejBtH9y9GSYRNS
        +7Dsek6AzgOZhD8EuwsaVZ13Vg6GRM6PexECdoOirNeLFHNZ
X-Google-Smtp-Source: AA0mqf5cB8zjsOSC8LHfvAYaU0F7H15UOWRCuC2r5ny9Tj6mj8hA5jpRHTg/4LdRqCujB/GD3+SOVZwgGwscKi4bxIBPLJ2kZP0a
MIME-Version: 1.0
X-Received: by 2002:a6b:c990:0:b0:6dd:807d:89a3 with SMTP id
 z138-20020a6bc990000000b006dd807d89a3mr1779863iof.33.1668702866278; Thu, 17
 Nov 2022 08:34:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 08:34:26 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000949d0805edad29fc@google.com>
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
