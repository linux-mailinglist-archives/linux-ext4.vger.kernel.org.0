Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC61735A7
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1Kwn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Feb 2020 05:52:43 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37996 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1Kwn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Feb 2020 05:52:43 -0500
Received: by mail-pf1-f171.google.com with SMTP id x185so1534630pfc.5
        for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2020 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=RN6zANv1wITL8TbleHGlNtV1499dl/M9eVGhJjga7t4=;
        b=L2FzD4B8aR+vxcPqD7FRaL5ipmy1Gsb+HtZ67SdK7yx0sskivNDHI2c+PMWY9lYXqt
         e6rnlrxeEP2ksHL6c9qN4u73neWNM2XNnAYZbeS0G1d71jJRfUqru+7gdmqpDbo5fNrM
         w8XKerfFgEj2bTaRYLPfNg24ntX4lDEEHjvBD6+IDrQMNmiijzI7ETMhytI7yvwS7P5P
         h3AX7+Ul5Z3vtKOcaKtBVhO+LW3ro9mScq+oPW7oZp3iGWC2ZdSNTLfCf4Sd/v/VXYyr
         Bh6KT9LHnMtSOYp0s9ThyErVnI5LezuTu4+41YR2kMoiuJPXA5Pwk1BBdEUYpkxYIdaa
         lCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=RN6zANv1wITL8TbleHGlNtV1499dl/M9eVGhJjga7t4=;
        b=cgkKAeVC9GllSgZnwUI1paxK346RWjLVuRoGpx3Hsvc35HQ69IJolC6nh2yeNmql9h
         ZPMj7eqea7CO4rgQM7w2JPgVKWUkIwssdQjVQEELunbGU6/GwWoF48EmiWvQtk6x0ijQ
         Q5+O20j0rRey1pbM6hULXA3i+nA8oqlRmLtMJwTn/9eymc0xIZKYvEDDymcuNx3SFfM5
         pvUI3YJXM2TckXhP7wkgn7ocLAsppjg4WSKyWtiYJWkKVsRM+tkvwkHx3PXQZdZSq+o4
         4DEXz76q0ZyPBVBTiktQtQr0qyhX3pkL3jai7iwspij36Cu69PWcpKB2Xp8dxGMksvD6
         pJSg==
X-Gm-Message-State: APjAAAU5E8LhSxkh6DTe7PsyU7bYbHhOJiYfPRxZBcQM6AK+5ARMWJXo
        p1a/2I6lz+2Z79ZAwnYD4jFxAbWM
X-Google-Smtp-Source: APXvYqyVk/iPSFfJv0bM4p3rz9Kom/wmWnv97J0lcgqJtthFmy55oVKOV4+fdBCxNbJbNZj2mq0LXQ==
X-Received: by 2002:a62:f251:: with SMTP id y17mr4004296pfl.204.1582887162109;
        Fri, 28 Feb 2020 02:52:42 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q25sm10757117pfg.41.2020.02.28.02.52.41
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:52:41 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:52:34 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-ext4@vger.kernel.org
Subject: ENOSPC inline_data fsck failure
Message-ID: <20200228105234.n5wt5x2vi3ftxuyh@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

With inline_data mkfs option, generic/083 can easily trigger
a fsck failure like this:

-------------------------
seed = 1583104156
_check_generic_filesystem: filesystem on /dev/loop1 is inconsistent
*** fsck.ext4 output ***
fsck 1.46-WIP (09-Oct-2019)
e2fsck 1.46-WIP (09-Oct-2019)
Pass 1: Checking inodes, blocks, and sizes
Inode 94 extent tree (at level 1) could be shorter.  Optimize? no
...
Pass 2: Checking directory structure
Entry 'c6b' in /p2/d6/d100 (32920) has an incorrect filetype (was 3,
should be 1).
Fix? no
Entry 'ca4' in /pa/d0/d4/d34/d26/dde (75) has an incorrect filetype (was
3, should be 1).
Fix? no
...
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Inode 107 ref count is 2, should be 1.  Fix? no
Unattached inode 119
Connect to /lost+found? no
...
-------------------------

The testcase is doing a simple testing: make a small(256M) fs,
run fsstress in it,  make it out of space. Then fsck.

Not sure about is this an issue of ext4 filesystem or e2fsck
needs more options.

Thanks!

-- 
Murphy
