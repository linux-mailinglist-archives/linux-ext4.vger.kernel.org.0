Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AAD3942B2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 May 2021 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhE1Mjh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 May 2021 08:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhE1MjH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 May 2021 08:39:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD9AC06138A;
        Fri, 28 May 2021 05:36:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r8so5267428ybb.9;
        Fri, 28 May 2021 05:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3z2LGAPQrN69UISXkjED3WBRx+qDX0JpGZaWUXIkD3g=;
        b=i7MsIyHP3ZH9OjOBQYunWyvVT7uzAnE+EDEhyow7/ejuBc0pcVRK2MEWCB3JILsja2
         +o4vm+Clw56z2ofRP7XlltHNxUftkaapQa9AL03QZ5xp3Ju8s8nL57ZiLaxFExdOfVjH
         7BAuaxsm/5dNqV3wcb0xHHzoOuIC6GmbTvJYpEfdF9Vqb+qehuNJk8A6EorY/w439OPY
         fhzLrm9T0xpgCzRPzW01r2FDmXWm8F4WLtyWEuE7JxBo9/d+E6pmfKFMrz26zJycgg9q
         Ay7k/kxarJTXv9aqZIMbSp8Ilq6bjtJXRRqcKEtVepzr5f0CmkIUe2jJbLOtbcJYX+pu
         dpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3z2LGAPQrN69UISXkjED3WBRx+qDX0JpGZaWUXIkD3g=;
        b=O2Vg2T6d8FnxceG4fBLsmCvs7B6/u3ih9KBIwVQ8dVhqvsXWAz3fm48Vu76hoBd5Ry
         kOuROO7lRC0rkcrWV37+IlEYLTt4jvoyNunQSShHLiXoOHzyGclA2b9k+5afD+bfXxTS
         q4ctCjm7Cr4vKy2S/8WS2B6luRb/UbSZKwXXb35+xW9TPfbSy7AFFRz3KX0jKJQ6wnOq
         5Gj9re+lMjkKxaA4Dvj6QWLRhmsHaQQ2KcMTZrLZOQd7Cwx/Z6vHhXgoEajwKuU/fBRx
         wYVEK7hJfoFyDKetoMJMbswZqj8eVhHYVKdB3knmTNrNGXDglwYFEMsCMTsC/IQWi47S
         9pQw==
X-Gm-Message-State: AOAM530eYwqIRCU/0IfM5X0H9wEDg3qYUzHGLgezOPBo6sIm2uPkZPFH
        0daGmJEu5Aipj91IGKQArFQBB8MKEp+K4JwThTo=
X-Google-Smtp-Source: ABdhPJzoYiBFfgpk5e+stz+oeAIsAI94tkVFcAPTaEfemNmodU29WVhN2WfUzk1F6CKW946D+fleMG5O7f23He6a5vg=
X-Received: by 2002:a25:1009:: with SMTP id 9mr12051107ybq.386.1622205389298;
 Fri, 28 May 2021 05:36:29 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 28 May 2021 08:36:17 -0400
Message-ID: <CAMdYzYqvT+X9C_YZ+DtspgHLSeb=RVHLeS2-0pEHeotyvb+iXQ@mail.gmail.com>
Subject: ext4_xattr_ibody_find:2180: inode #2669312: comm systemd-journal:
 corrupted in-inode xattr
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Good Morning,

I have run into a fun issue where I have the follow error on boot,
which causes the device to drop to read only mode:
ext4_xattr_ibody_find:2180: inode #2669312: comm systemd-journal:
corrupted in-inode xattr
It marks the file system as unclean, which forces a fsck, but it seems
that even as of v1.46.2 e2fsprogs does not have the ability to resolve
this issue.
Any attempts to touch the corrupted files (I've found two so far)
leads to the same error, and I cannot find a way to remove or repair
the affected inodes without wiping the entire file system.

Any insight you can provide would be much appreciated.
Thanks,
Peter Geis
