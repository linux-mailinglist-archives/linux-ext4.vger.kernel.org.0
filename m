Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E63D460C
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhGXHCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXHCX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F5C061575;
        Sat, 24 Jul 2021 00:42:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso6864364pjs.2;
        Sat, 24 Jul 2021 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=twUaPKjfnsTbPfe/CmNFMyhlSHASSr5iLxR8bOidA5A=;
        b=o7mQ8POD3B3LbIiiTNfgjfHjEJJogE3MNiEH8WwLDkynOD/iMguWhoOIUu5m3ClKor
         PbdSuui+Pb/CWwk6K29Q13d4AszKVMVxk+lFEZmRKM1mT7NyPG9S4UsNsuTZiWOvQhf3
         QvXtnUo8GndHhzG7HwaJ9KHQ0zWQ0gHEtHTNMB6ekDc4OGYKjzdth0bXLWItSgJMJj4z
         PsrQG+moazZ0lrQZDNGnpWJTGoECvT2kGyGv6JNcDx+MFtKqdO4Q2lu0GkuE9zgNOemk
         O+kozV8fmoCB75z4IMG1NRK1+1DeqMEh4ZSiCLna5JM+2+MlMjjwhH7YNYDpdlSd0IW8
         4i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=twUaPKjfnsTbPfe/CmNFMyhlSHASSr5iLxR8bOidA5A=;
        b=jW7i3uvXZJBU3rQx2kZghprFVDiZUJsW0gRKbGFKtpNk3Jp4xlgLSkiSOxhzhUbX+Z
         hgJVzwqecQB3OHFmlIj/wyh9zkQxBVPPXaT0VVblqMzkb+6npVf7XkgP+UgrLs7+yZlh
         702W2LRXBeUG129gpV7HvsDlSfDGPiGcUaVToPQT52jVdysEm5C+yJWRCW5WP8g2Dh5k
         lwqMcX36SF4xu0THxoF/01KQOEt4Gbxuy5jkzNohhe0uLyQFQgf8qQ4JjHtHf4a1QC/L
         m25BxKP0rflGJBp2WxW4INjKp8TUMxxNnXZQ59NUUiI/xj5RPd5DoqdX7ao3ouqMyGao
         aWJA==
X-Gm-Message-State: AOAM530copv/+7LLoGs5vp0CZmvtfsNbpFgvyWNxoUtA25nGBUSzfb2Z
        RVHzZZcoPq1y6lEQLVhs0oTW4tC/h/XdMg==
X-Google-Smtp-Source: ABdhPJx67yoa5VljBj999Top9MVf3CXKUPoisfSsgHr11I5Ygn1GmNXA9Ba6C25yTO0N1appt03jGQ==
X-Received: by 2002:a63:5903:: with SMTP id n3mr8506382pgb.104.1627112575474;
        Sat, 24 Jul 2021 00:42:55 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:42:55 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 0/5] ext4: get discard out of jbd2 commit context
Date:   Sat, 24 Jul 2021 15:41:19 +0800
Message-Id: <20210724074124.25731-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all

This is the version 3 patch set that attempts to get discard out of the jbd2
commit kthread. When the user delete a lot data and cause discard flooding,
the jbd2 commit kthread can be blocked for very long time and then all of
the metadata operations are blocked due to no journal space.

The xfstest with following parameters,
MODULAR=0
TEST_DIR=/mnt/test
TEST_DEV=/dev/nbd37p1
SCRATCH_MNT=/mnt/scratch
SCRATCH_DEV=/dev/nbd37p2
MOUNT_OPTIONS="-o discard"
has passed. The result is consistent w/ or w/o this patch set.

There are 5 patches,

Patch 1 ~ 3, there are no functional changes in them, but just some preparation
for following patches

Patch 4 introduces a async kworker to do discard in fstrim fation which implements
the core idea of this patch set.

Patch 5 let the fallocate retry when err is ENOSPC. This fix the generic/371

Any comments are welcome ;)

V2 -> V3
 - Get rid of the per block group rb tree which carries freed entry. It is not neccesary
   because we have done aggregation when wait for journal commit. Just use a list
   to carry the free entries.

V1 -> V2
 - free the blocks back to mb buddy after commit and then do ftrim fashion discard

 fs/ext4/ext4.h    |   2 +
 fs/ext4/extents.c |   6 ++-
 fs/ext4/mballoc.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 3 files changed, 151 insertions(+), 80 deletions(-)

