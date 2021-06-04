Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721BD39AF04
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFDAS3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 20:18:29 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45855 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAS2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 20:18:28 -0400
Received: by mail-pg1-f180.google.com with SMTP id q15so6409945pgg.12;
        Thu, 03 Jun 2021 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXGpL8wHnLMV2he26F4BduzLjdLWy3J18wWv3N009v4=;
        b=lzOMxC5cYfyBKFEjWTPRGV7koyCy2neNiJDJkiGjoYdPrcv36dzPxfmKgaCWN+bdaz
         gBfzExfZt8IL9kQU99K+p6KyEsuhIu2Qt+fIJ8NFiCAmJo39b15qUkP1LmA7OHKvDZeo
         Ci1WSIypG+mfwvDpO+TzTID8IiL5qKdxXqB5+erY8KDsbYiXrgXmiEdHRchgasNxyYt7
         g+PxlXwQVaujkzUFkfqRuHgy+WhXwnGAczGcS6AZX+rq+616pio8g8agdkmBHVATIryK
         T9qdFKkNA5JkjniNMPowVBAqjBIbZBex3i/G0Ws7XWSYACxYCA9w47wloK02guPIaSB0
         6KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXGpL8wHnLMV2he26F4BduzLjdLWy3J18wWv3N009v4=;
        b=q2BuKHk/gJTNAXPcar6E4RBKc/NsXNlNImKhHfHJkclkvvN+5+hCmZ2TNp9s1BvUc5
         tZuECZ6XQQ80JS1EPucT1KzmICuhZoURToAAawENmHAfX3b02hsyZE5x/p4WT6wlDQM9
         +1E/DArUQNINE0bel6zRa5I/QT70+CAFpwq4Q6K5G7dBQZ8t3NKuwQ7AwXnYvA/UzoXi
         nzrojhwb/KwQFy9b518hruLUnuvtRfLTOq/kowNjd6VVKD4pcuUKj8n4KorrKgsi8YyK
         JJus29HyUT1h2pKp5hW32mUbLx/fBF3YT7KCT9/5Yv86trO/LIoP6W8PgR4zx5Fc2V/r
         fF5w==
X-Gm-Message-State: AOAM533zaPayEHU+W3vp09yNXKX/ADg1NWF0uGB7h92aDqRIIYPNGhOI
        eKkv8Lhc6ne2YldxCKXmqes=
X-Google-Smtp-Source: ABdhPJxAWjxvSfzAP3hidBHzNHxF9yJxLFyBBKDABrRGQJOir9XayYjp+dg1vXir1XWGdZosS0/HQA==
X-Received: by 2002:aa7:8c02:0:b029:2e9:c513:1e10 with SMTP id c2-20020aa78c020000b02902e9c5131e10mr1929723pfd.2.1622765726825;
        Thu, 03 Jun 2021 17:15:26 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:130f:bbd8:4051:7dc3])
        by smtp.gmail.com with ESMTPSA id 136sm163429pfu.195.2021.06.03.17.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 17:15:26 -0700 (PDT)
Date:   Thu, 3 Jun 2021 17:15:24 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4/309: add test for ext4_dir_entry2 wipe
Message-ID: <YLlwnOe59O6m+82u@google.com>
References: <20210517144849.867688-1-leah.rumancik@gmail.com>
 <60B86910.6040909@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60B86910.6040909@fujitsu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 03, 2021 at 05:30:18AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2021/5/17 22:48, Leah Rumancik wrote:
> > From: Leah Rumancik<lrumancik@google.com>
> > 
> > Check wiping of dir entry data upon removing a file, converting to an
> > htree, and splitting htree nodes.
> > 
> > Tests commit 6c0912739699d8e4b6a87086401bf3ad3c59502d ("ext4: wipe
> > ext4_dir_entry2 upon file deletion").
> > 
> > Signed-off-by: Leah Rumancik<leah.rumancik@gmail.com>
> > 
> > Changes in v2:
> > - fix formatting
> > - use _get_block_size instead of manually finding blocksize
> > - change scratch_dir to testdir to avoid confusion
> > ---
> >   tests/ext4/309     | 191 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/ext4/309.out |   5 ++
> >   tests/ext4/group   |   1 +
> >   3 files changed, 197 insertions(+)
> >   create mode 100755 tests/ext4/309
> >   create mode 100644 tests/ext4/309.out
> > 
> > diff --git a/tests/ext4/309 b/tests/ext4/309
> > new file mode 100755
> > index 00000000..a4f74e7f
> > --- /dev/null
> > +++ b/tests/ext4/309
> > @@ -0,0 +1,191 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Google, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test No. 309
> > +#
> > +# Test wiping of ext4_dir_entry2 data upon file removal, conversion
> > +# to htree, and splitting of htree nodes
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +status=1       # failure is the default!
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
> > +
> > +_require_scratch
> > +_require_command "$DEBUGFS_PROG" debugfs
> > +
> > +testdir="${SCRATCH_MNT}/testdir"
> > +
> > +# get block number filename's dir ent
> > +# argument 1: filename
> > +get_block() {
> > +	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>>  $seqres.full | grep -o -m 1 "phys [0-9]\+" | cut -c 6-)
> > +}
> > +
> > +# get offset of filename's dirent within the block
> > +# argument 1: filename
> > +get_offset() {
> > +	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>>  $seqres.full | grep -o -m 1 "offset [0-9]\+" | cut -c 8-)
> > +}
> > +
> > +# get record length of dir ent at specified block and offset
> > +# argument 1: block
> > +# argument 2: offset
> > +get_reclen() {
> > +	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An  --endian=little | tr -d ' \t\n\r')
> When I test this case on centos7, it will report non-supported --endian
> option for od command because old od doesn't support this option before
> the following patch.
> https://github.com/coreutils/coreutils/commit/b370924c03adaef222859061c61be06fc30c9a3e#diff-1cfd938943be810271354b667b12b6ed6ec85481d3fabb6f85d94193bd201235
> 
> Is this option neccessary?
> 
> Best Regards
> Yang Xu.

I have added a check to skip the test if the od version is before the
endian flag was introduced. Please let me know if you still have issues.
-Leah
