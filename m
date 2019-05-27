Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20E2B8D4
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2019 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfE0QQt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 12:16:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33156 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfE0QQt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 12:16:49 -0400
Received: by mail-it1-f193.google.com with SMTP id j17so368631itk.0;
        Mon, 27 May 2019 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9xDAwoI14/9ZYf/NXEzFCRhJD2vdXKzdCYZgn3dwG9c=;
        b=fioESLalSZte/6pGVrPhmwkcedTyJNAh21o0VvUXg/NCVTVLWZrDZVHqiqCmo41BjF
         zujazUnpEbpaS+2DaHH3r6u/SxOunOMFdB3ObQZQODVDBMw7iKSHDPWwOS3DFfhlxcxW
         xjfx/l5kEBTdYobSUKh5VTUr5a2+558Aeyr6lKGOH7iTRpKP6Y85Mq2YZdKJ/o1CGrwc
         eRBZer0e6cjWPs5cPpA87TXf7uoYCUhzv/4ABrXwcSIVhwNlLxu33Ty4WhtnbLKT6j84
         MfdD+wLYUGNs7n84Q248bReDfjvuKlByQQ5HMhslGu1XIk/jN+ZIuHymMy2Hi2XYLflz
         hz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9xDAwoI14/9ZYf/NXEzFCRhJD2vdXKzdCYZgn3dwG9c=;
        b=q3NnNmTWJ9aYFPYSV4IPVmtFoKd7dJJ3j59GqA8U2ot6j41k8OtZs7pxkPA1ghBf3V
         an0EY0XoO1XKRCn2pcwwGgV9pbrvoU5TXuw62mCHOPK3gYviAhhBEFxGd7XUzdS7kFJR
         qxBxhqzkFBfcE8Efe29TUDiLSAb8pdlVg9DQVzKjJtiOK7nl4NQ8eazKVAklW2cNUq2s
         fsDcQ7oPywd5cjD/aSBRXciY57eD2RqyG4w7wom8cX2RwsDU9Q+ymS605tX0v4YCLONb
         wshgUrMVyjvYrZEQqjGKCNlcLWX/DbdlcESXEUtQghPkkPqBP1BYjfO/8m6huWXewWoR
         YIwA==
X-Gm-Message-State: APjAAAVAm29vlh+jcOBwWBEq66tSlNYivF1Yw0tvlEJddULYtEoixitJ
        YRBUPQhnAsOZvopgo8MeFSPbF+euH6Q5s1H3o5co8bOfrWw=
X-Google-Smtp-Source: APXvYqzRXf38xNC+au+U1m814eLrxKw2rddbi7IL09Ns5wR82DpB0x50xtGD7bLMglfxOckXxjtoDpxOqRUZL4EsfZg=
X-Received: by 2002:a02:bb05:: with SMTP id y5mr5651010jan.93.1558973807970;
 Mon, 27 May 2019 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNPMSQgBjnFarYaxuQEGpA1G=U4U9OHqT0E53pNL2BK8g@mail.gmail.com>
 <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com>
In-Reply-To: <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 27 May 2019 21:16:36 +0500
Message-ID: <CABXGCsNvYVL6SMO_0PXxiZwWJyBi3rD-jjxnmnY3KL0M7haJbA@mail.gmail.com>
Subject: Re: [bugreport] kernel 5.2 pblk bad header/extent: invalid extent entries
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 18 May 2019 at 16:07, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> It happens today again.
>
> [18018.969636] EXT4-fs error (device nvme0n1p2): ext4_find_extent:908:
> inode #8: comm jbd2/nvme0n1p2-: pblk 23101439 bad header/extent:
> invalid extent entries - magic f30a, entries 8, max 340(340), depth
> 0(0)
> [18018.970071] jbd2_journal_bmap: journal block not found at offset
> 4799 on nvme0n1p2-8
> [18018.970076] Aborting journal on device nvme0n1p2-8.
> [18018.970269] EXT4-fs error (device nvme0n1p2):
> ext4_journal_check_start:61: Detected aborted journal
> [18018.970316] EXT4-fs (nvme0n1p2): Remounting filesystem read-only
>

I am bisected issue. I hope it help understand what is happened on my computer.

$ git bisect log
git bisect start
# good: [e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd] Linux 5.1
git bisect good e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
# bad: [7e9890a3500d95c01511a4c45b7e7192dfa47ae2] Merge tag
'ovl-update-5.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
git bisect bad 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
# good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
# good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag
'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
# good: [ea5aee6d97fd2d4499b1eebc233861c1def70f06] Merge tag
'clk-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good ea5aee6d97fd2d4499b1eebc233861c1def70f06
# good: [47782361aca21a32ad4198f1b72f1655a7c9f7e5] Merge tag
'tag-chrome-platform-for-v5.2' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
git bisect good 47782361aca21a32ad4198f1b72f1655a7c9f7e5
# bad: [55472bae5331f33582d9f0e8919fed8bebcda0da] Merge tag
'linux-watchdog-5.2-rc1' of
git://www.linux-watchdog.org/linux-watchdog
git bisect bad 55472bae5331f33582d9f0e8919fed8bebcda0da
# good: [4dbf09fea60d158e60a30c419e0cfa1ea138dd57] Merge tag
'mtd/for-5.2' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect good 4dbf09fea60d158e60a30c419e0cfa1ea138dd57
# good: [44affc086e6d5ea868c1184cdc5e1159e90ffb71] watchdog:
ts4800_wdt: Convert to use device managed functions and other
improvements
git bisect good 44affc086e6d5ea868c1184cdc5e1159e90ffb71
# good: [5c09980d9f9de2dc6b255f4f0229aeff0eb2c723] watchdog:
imx_sc_wdt: drop warning after calling watchdog_init_timeout
git bisect good 5c09980d9f9de2dc6b255f4f0229aeff0eb2c723
# good: [345f16251063bcef5828f17fe90aa7f7a5019aab] watchdog: Improve
Kconfig entry ordering and dependencies
git bisect good 345f16251063bcef5828f17fe90aa7f7a5019aab
# good: [988bec41318f3fa897e2f8af271bd456936d6caf] ubifs: orphan:
Handle xattrs like files
git bisect good 988bec41318f3fa897e2f8af271bd456936d6caf
# good: [a65d10f3ce657aa4542b5de78933053f6d1a9e97] ubifs: Drop
unnecessary setting of zbr->znode
git bisect good a65d10f3ce657aa4542b5de78933053f6d1a9e97
# good: [a9f0bda567e32a2b44165b067adfc4a4f56d1815] watchdog: Enforce
that at least one pretimeout governor is enabled
git bisect good a9f0bda567e32a2b44165b067adfc4a4f56d1815
# bad: [d7a02fa0a8f9ec1b81d57628ca9834563208ef33] Merge tag
'upstream-5.2-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect bad d7a02fa0a8f9ec1b81d57628ca9834563208ef33
# good: [04d37e5a8b1fad2d625727af3d738c6fd9491720] ubi: wl: Fix
uninitialized variable
git bisect good 04d37e5a8b1fad2d625727af3d738c6fd9491720
# first bad commit: [d7a02fa0a8f9ec1b81d57628ca9834563208ef33] Merge
tag 'upstream-5.2-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs


--
Best Regards,
Mike Gavrilov.
