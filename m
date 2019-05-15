Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05ED1F71D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEOPH1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 11:07:27 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:37383 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEOPH1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 May 2019 11:07:27 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id x4FF7PXr023254
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 15 May 2019 10:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1557932845;
        bh=RGIPsHixgwKfwe8D6IgkE5UqjPh9RBUW8mqHqD+Co0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YPudYjMi9Rna0ivkNiTS/NVKSgY1Y9yGhqxl1Ew7WWlintl18+QgaMmNg3x7vp7lM
         h4USlnmeKcgOUpG6A3Z70pYhaZ0Oi8XwYE5A/+mgCzZtri+lRvwCjFWQe9obTMxpaA
         G2Qa0+snlNiCfPj0MkDV5YwWE7sH8WJz+3E66H4g=
Received: by mail-ot1-f47.google.com with SMTP id 66so349958otq.0
        for <linux-ext4@vger.kernel.org>; Wed, 15 May 2019 08:07:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXKa9UyzVh7+HaODolTMexfL92up8kOV0EkZvv/T03m1AWeIC2g
        ICQ3iOiAa+sHMyr+r5/phei5ltmc3LpvuPQUHxih9A==
X-Google-Smtp-Source: APXvYqyfQ2098Zp/VfIVt/oScmrIKl34Tl1aLR2uvboW7OHZOG7p3ytlb2kZKpb3/R41DsQs0D5mu/cUw8jhFGd16F8=
X-Received: by 2002:a9d:6c89:: with SMTP id c9mr6672818otr.52.1557932845205;
 Wed, 15 May 2019 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190515150221.16647-1-fdmanana@kernel.org>
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
From:   Vijay Chidambaram <vijay@cs.utexas.edu>
Date:   Wed, 15 May 2019 10:07:14 -0500
X-Gmail-Original-Message-ID: <CAHWVdUWQXDf0fDTg=43ySNEbTEqPh1ue6ZujsBX-wTsmLQGz3A@mail.gmail.com>
Message-ID: <CAHWVdUWQXDf0fDTg=43ySNEbTEqPh1ue6ZujsBX-wTsmLQGz3A@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Wed, 15 May 2019 10:07:25 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 10:02 AM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Run fsstress, fsync every file and directory, simulate a power failure and
> then verify the all files and directories exist, with the same data and
> metadata they had before the power failure.

I'm happy to see this sort of crash testing be merged into the Linux
kernel! I think something like this being run after every
merge/nightly build will make file systems significantly more robust
to crash-recovery bugs.
