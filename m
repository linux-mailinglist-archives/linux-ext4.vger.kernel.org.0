Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735321AB2AF
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636977AbgDOUcy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506473AbgDOUb4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 16:31:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13BC061A0F
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 13:31:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y19so675024qvv.4
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nuwGMvQLq8or7PSxB9QLqkVgVx418FK4SPPGWPWlhPo=;
        b=b0tMKhL68bjzHBT4DZUynDVrp/BjHDdx4rRGGpbRrut4DPJ6v6wJVaxy3KV5+WR/PX
         4PPwjhyVnAvfCwUQWJNn87PUACn4Imr1YigT+wm+LDw4D7t9zb8+1FO5Ou7LYwSN4ygJ
         oTPOBnprB7jrIUUHUz4rt8V5gclmyffXBFD0rCt5weI191xqGN1b/uq+zmqLORTTGpzl
         kqe7B0Q1bhtAhaCnTJ+niQ5HqPwJfaacKo6fmOZNoY+yI3Q2iUbLP2E/XNbOEhtRtdP/
         dz/GAhPj+lMNRshnWLXRTx9K8ot+AYHhqV7m1i+WFuHPietJi5/o8n0jeKRe7Ym1C3Cs
         kCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nuwGMvQLq8or7PSxB9QLqkVgVx418FK4SPPGWPWlhPo=;
        b=gOrm/27/wvRo7nfAPEjZ62g19+kR/zK2VKxgcTPMEbijUC4lqma7z2Qm+O5r+mTRop
         pb3qCIwvCjtGiTsU6vguv+235IJ0xZgollgcBOn+2cd6feyTtGdPhJC60RcQYDaIhOUX
         Z2peRgkaAvZ0NZpyAz49W98O0n6Bk7kn6cs+HRsM9L+nDgtVeDv+f/IjzhJNneoJOzIE
         9XJ+2I/Ww8uO5x4NV6PrjkorPdJJMNO0528DX3UHMfbj+oj/8jwYkh+LD3rfW61VhmXV
         MWLpS4UEOG6Is4SyicDgtOPTU5E0gogfoAfJLCKd3zv0vySWM4bbJU/D/vRuhCR6YJk/
         B8tA==
X-Gm-Message-State: AGi0PuY/9HRHOg73no8ec9ArAPvmHc5fT+aL95N3gy+3j8gBZ+NKSJOA
        wMLLvjDH7Mi/up5zysDYqKYYgCR+
X-Google-Smtp-Source: APiQypLEHjziPR4FDhizC/1ZA6E9dbsYCXER4ld0/ZGGfK/nObAoh9Ls9GhkgQi8ZF3NHOTTmAoWDA==
X-Received: by 2002:a05:6214:1804:: with SMTP id o4mr6864260qvw.10.1586982715010;
        Wed, 15 Apr 2020 13:31:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id x8sm13198305qti.51.2020.04.15.13.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 13:31:54 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 0/2] remove EXT4_GET_BLOCKS_KEEP_SIZE flag, etc.
Date:   Wed, 15 Apr 2020 16:31:38 -0400
Message-Id: <20200415203140.30349-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some code was left behind after removing EXT4_EOFBLOCKS_FL and the code
associated with it in order to minimize the amount of change in that
earlier patch and to make it easier to revert in the event that proved
necessary.  The first patch in this series cleans that up.  While
writing that patch I noticed that there were some ext4_map_blocks()
flag translations missing, and the second patch in the series fixes
that.  I've bundled them together here to aid merging, as there's
a common dependency in ext4.h.

Eric Whitney (2):
  ext4: remove EXT4_GET_BLOCKS_KEEP_SIZE flag
  ext4: translate a few more map flags to strings in tracepoints

 fs/ext4/ext4.h              |  2 --
 fs/ext4/extents.c           |  4 ----
 fs/ext4/inode.c             | 12 ++++--------
 include/trace/events/ext4.h |  6 ++++--
 4 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.11.0

