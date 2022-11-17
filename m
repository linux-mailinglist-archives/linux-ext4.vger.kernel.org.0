Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BB62E4B7
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiKQSpe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 13:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbiKQSpZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 13:45:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BF8A147
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 10:45:24 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j12so2452427plj.5
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZYs0tD5VPyy93Ads630jaf2LNyYFWG138gSfeaPw24=;
        b=gixku23UgKRkbhGe5AiDlVZZRW6zDUuTRcmelSR2oAI0t77E7K8kFWz9li1UOsal3+
         +KohQU1L+my9u67QAdvNYrY74mkNTScefVl1bl5iUKEOQbaXdWQ8u+o6NPOsSHlRswJ6
         ebIfNIw0bxDm84g/Boai9URnqIfA+ji/RG0GoBzBus8eAydsneZQ0SvvXPixCVp+9dqz
         cX68BpHFyNjzNPWsgowxdWuWScmivrd1L5h6jqMwvO+lPGG+J9iy56uymt+ICJNCJeF9
         iGnfwAq/Gvo8IJlpe48gCoQc8nSvblpmx/uKaCgkNQMT+i6Nwefy8zHwLSI9NY4hNC/V
         WzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZYs0tD5VPyy93Ads630jaf2LNyYFWG138gSfeaPw24=;
        b=hIPg8jaTtnMmDe6sbKUgnTFuerRqPtYL0+9wYFmrpeZOl1dueiVY6yenEyY2Pud8T+
         mlJwOktZqvUt8dgloYD92oFJwrLvOprY0QfBywtKmr2buvSyzF83lePwxeLQ8cRVKcfR
         eZ45VfrMQQseGGzDwpqMuRQdco1eFaso4FAQsR8zcrmDG7MNmvFulvYbunkgbEzkiSI8
         qlxxNe7kLv7DVRS05zFyNX5/aOX7jRju5s0yhT4+iORu2mlxgFk4hWYXvA6wrszluEG/
         4fQE10HsqDtwU91LloUBZx8GaiCIp2TEONFSQMQbQ8lS2EmB9zbSeGtaKBrKcPO3s0G/
         rW+g==
X-Gm-Message-State: ANoB5pmXBw39s76j5+AxQD67Y2ZysuRrH416mh2YnlsE2W+s1pgRqbuB
        9hcCzUWCtKesMQ3Il+P8Rlw=
X-Google-Smtp-Source: AA0mqf6g+cwzg6XpIuVV98kBMf6gBazrR/wEhoDtzQxWsOFf/pjqGP8TBMBmw6a0KF2bdFYiXo9GIg==
X-Received: by 2002:a17:902:ab0f:b0:188:f4f4:2000 with SMTP id ik15-20020a170902ab0f00b00188f4f42000mr2593068plb.173.1668710723952;
        Thu, 17 Nov 2022 10:45:23 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id x11-20020aa79acb000000b00561d79f1064sm1507811pfp.57.2022.11.17.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:45:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:15:17 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Message-ID: <20221117184517.rzwt2ba7tqjbhjnq@riteshh-domain>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
 <Y3ZbMdL/wbeYNRgH@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ZbMdL/wbeYNRgH@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/17 11:02AM, Theodore Ts'o wrote:
> On Mon, Nov 07, 2022 at 05:50:49PM +0530, Ritesh Harjani (IBM) wrote:
> > f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=yes due to unbalanced
> > mutex unlock in below path.
> > 
> > This patch fixes it.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> This has been fixed in upstream (for a while, actually); 

Hello Ted, 

I think you are speaking about this patch here [1], which prevents the race
of using the fd by multiple threads at a time, by using BOUNCE_MTX lock.

The current patch on the other hand fixes the unbalanced mutex_unlock(), which 
can be reproduced with f_crashdisk test with UNIX_IO_FORCE_BOUNCE=yes.
(when tested with --enable-threadsan)

Below is the threadsan warning that I see.

WARNING: ThreadSanitizer: unlock of an unlocked mutex (or by a wrong thread) (pid=135059)
    #0 pthread_mutex_unlock <null> (libtsan.so.0+0x3b64a)
    #1 mutex_unlock ../../../lib/ext2fs/unix_io.c:161 (e2fsck+0x5b392b)
    #2 raw_read_blk ../../../lib/ext2fs/unix_io.c:331 (e2fsck+0x5b392b)
    #3 unix_read_blk64 ../../../lib/ext2fs/unix_io.c:1001 (e2fsck+0x5b4981)
    #4 unix_read_blk ../../../lib/ext2fs/unix_io.c:1053 (e2fsck+0x5b5171)
    #5 ext2fs_open2 ../../../lib/ext2fs/openfs.c:228 (e2fsck+0x579e5c)
    #6 try_open_fs ../../e2fsck/unix.c:1242 (e2fsck+0x424e63)
    #7 main ../../e2fsck/unix.c:1604 (e2fsck+0x41a1d2)

  Location is heap block of size 376 at 0x7b4800000000 allocated by main thread:
    #0 malloc <null> (libtsan.so.0+0x32919)
    #1 ext2fs_get_mem ../../../lib/ext2fs/ext2fs.h:1944 (e2fsck+0x5aec30)
    #2 unix_open_channel ../../../lib/ext2fs/unix_io.c:698 (e2fsck+0x5aec30)
    #3 unix_open ../../../lib/ext2fs/unix_io.c:910 (e2fsck+0x5afd67)
    #4 ext2fs_open2 ../../../lib/ext2fs/openfs.c:175 (e2fsck+0x579918)
    #5 try_open_fs ../../e2fsck/unix.c:1242 (e2fsck+0x424e63)
    #6 main ../../e2fsck/unix.c:1604 (e2fsck+0x41a1d2)

  Mutex M22 (0x7b4800000128) created at:
    #0 pthread_mutex_init <null> (libtsan.so.0+0x49603)
    #1 unix_open_channel ../../../lib/ext2fs/unix_io.c:827 (e2fsck+0x5af5ef)
    #2 unix_open ../../../lib/ext2fs/unix_io.c:910 (e2fsck+0x5afd67)
    #3 ext2fs_open2 ../../../lib/ext2fs/openfs.c:175 (e2fsck+0x579918)
    #4 try_open_fs ../../e2fsck/unix.c:1242 (e2fsck+0x424e63)
    #5 main ../../e2fsck/unix.c:1604 (e2fsck+0x41a1d2)

SUMMARY: ThreadSanitizer: unlock of an unlocked mutex (or by a wrong thread) (/lib64/libtsan.so.0+0x3b64a) in pthread_mutex_unlock

[1]: https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?id=d557b9659ba97e093f842dcc7e2cfe9a7022c674

> what commit is your patches based upon?

1. This series is rebased on the latest e2fsprogs master branch.
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/log/

Cover letter might provide some more details on how the patch series is broken
into. The github link of the series can be found at 
https://github.com/riteshharjani/e2fsprogs/commits/pfsck-RFCv1

Note: I have provided some details in the cover letter about Patch-073 i.e.
("tests: Add multi-thread tests framework"). But putting it once again here... 
You can ignore this ^^^ last patch in the github link.
This was added to tests all existing e2fsck test with pfsck mode.
But later I realized that it will require more work then how it is in the current
form. Since I didn't want to hold the patch series any longer and I wanted this
series to go through the initial round of review, before it becomes any
bigger and difficult to review, hence I decided to drop the last patch from
sending it to mailing list.

Please let me know if you have any queries on any patch/series.

-ritesh
