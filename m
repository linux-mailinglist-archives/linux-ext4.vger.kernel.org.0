Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6C2A1F65
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Nov 2020 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgKAQEF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Nov 2020 11:04:05 -0500
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:56011 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKAQEF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Nov 2020 11:04:05 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07738414|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0063493-0.00161519-0.992036;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IrDNSlR_1604246637;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IrDNSlR_1604246637)
          by smtp.aliyun-inc.com(10.147.44.118);
          Mon, 02 Nov 2020 00:03:57 +0800
Date:   Mon, 2 Nov 2020 00:03:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests: Fix tests which checks for swapfile support
Message-ID: <20201101160357.GE3853@desktop>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604000570.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 01:22:50AM +0530, Ritesh Harjani wrote:
> For more details, pls refer commit msg of each patch.
> 
> Patch-1: modifies _require_scratch_swapfile() to check swapon only for btrfs

I don't think it's a good idea, if a new fs without swapfile support is
tested by fstests, test would get false failure, where it should
_notrun. And making a generic requirement check to fs-specific doesn't
seem quite right either.

> Patch-2: adds a swapfile test for fallocate files for ext4, xfs (assuming
> both FS supports and thus should pass).

As Brian mentioned in his review, we're in the process to convert all
shared tests to generic or fs-specific tests (very slow though), that
said we don't want new shared tests.

I think we could whitelist fs types in _require_scratch_swapfile() and
don't _notrun for such filesystems, something like what we did in
_fstyp_has_non_default_seek_data_hole(), so that we won't miss silent
regressions on sucn filesystems, and we'll do sanity check as well on
other filesystems.

> Patch-3: added to support tests to run when multiple config section present
> in local.config file.

I have a patch[1] that should fix the issue 3 years ago, but it never
got reviewed, would you please check and see if it fixed the bug for you?

[1] https://patchwork.kernel.org/project/fstests/patch/20171117070022.14002-1-eguan@redhat.com/

Thanks,
Eryu

> 
> Ritesh Harjani (3):
>   common/rc: Make swapon check in _require_scratch_swapfile() specific to btrfs
>   shared/001: Verify swapon on fallocated files for supported FS
>   common/rc: source common/xfs and common/btrfs
> 
>  common/rc            | 20 +++++----
>  tests/shared/001     | 97 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/shared/001.out |  6 +++
>  tests/shared/group   |  1 +
>  4 files changed, 116 insertions(+), 8 deletions(-)
>  create mode 100755 tests/shared/001
>  create mode 100644 tests/shared/001.out
> 
> --
> 2.26.2
