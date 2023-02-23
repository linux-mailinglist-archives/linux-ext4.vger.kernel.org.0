Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97DA6A0BDD
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Feb 2023 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjBWO1G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Feb 2023 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjBWO1F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Feb 2023 09:27:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D23B584A9
        for <linux-ext4@vger.kernel.org>; Thu, 23 Feb 2023 06:27:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso13199376pjb.5
        for <linux-ext4@vger.kernel.org>; Thu, 23 Feb 2023 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DCQFD2Dh0lZQd5GvH7lUOncayBxZLYLWWC9OtgSZifM=;
        b=CCJOKDcIy2fOB+gOn+TmdyB57h2u2/1JEHA2mPFWE69aFfK5qPDL6IVDFisHQITSfh
         2tPXdsMWxec/pwyPU1+zw8GNyBQxRManzHiXMhUJbUb/ol8o5q+T+XMKGb7LcPr0cM2T
         WsCmoniCs5iXLrAPd+xEFmzoYrZAZfR+8WdfwEWUxhcw4V64TUeWdx52ORFW2c4Z3Qoz
         skQ1iNnW61tfINZo4mYBOnwNmT0/izUtmzKbxq9VndvgiuDSU3Eap1Lz19M7pZOoB02n
         VcdKZHlB4b6SLsMBnk2Kq7M9R2xFMzWlCg3thJk1JG+O91KHgMIFC8/2bkI1iHk5/jqE
         X/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCQFD2Dh0lZQd5GvH7lUOncayBxZLYLWWC9OtgSZifM=;
        b=UYtweCbbK/Up0AEKghfio6XTXHStSryHl+i6WlsYcYZvuqYXPbpvY6f9db4sTnnugD
         zTjtt13U7GDxM5TyCPklGKnP5YklanxbA7sV8QTq5Kmg6JtEc6eYQskXFpm+rbuvMqex
         9tQAbsG1BSYLe6VO7uqLOYugFMSXAVsdcIpwFFEXMzFNksMfXSSThMhLisRKfAtgliyB
         xq8/vk/xhz7/WcVkz3ykdzgfktL6hhvS7RQHM7TN1I3rt3fem/G0N4yPHD+P8YisUT3e
         CjO+K+GiEqvUbuaKIRm0z8P4zbcr/ClBxqUptw+koqGk9qOqnfz+AWQQ396IJtFQOS/I
         ZN3w==
X-Gm-Message-State: AO0yUKXrcnAZRv0k10+QSb4OloD34X3IqvCEuDOs4Samgbmpe46N28kh
        CSFLUyH9eYrm2fNuXWJ9siM=
X-Google-Smtp-Source: AK7set9rKvtVvwQIeKwxTlBvws/EX33RFDI7hR5IRVPzhEWXo47ay35HVHDQ4EyCFm3WO8pern98/Q==
X-Received: by 2002:a17:903:244c:b0:19a:d453:4ac with SMTP id l12-20020a170903244c00b0019ad45304acmr15086615pls.61.1677162419395;
        Thu, 23 Feb 2023 06:26:59 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id m1-20020a1709026bc100b00192aa53a7d5sm2811246plt.8.2023.02.23.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:26:58 -0800 (PST)
Date:   Fri, 24 Feb 2023 01:25:02 +0530
Message-Id: <87ttzctaw9.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
In-Reply-To: <Y/UhBdnKh/WST81A@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Whitney <enwlinux@gmail.com> writes:

> * Ritesh Harjani <ritesh.list@gmail.com>:
>> Eric Whitney <enwlinux@gmail.com> writes:
>>
>> > A significant number of xfstests can cause ext4 to log one or more
>> > warning messages when they are run on a test file system where the
>> > inline_data feature has been enabled.  An example:
>> >
>> > "EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
>> >  #16385: comm fsstress: No space for directory leaf checksum. Please
>> > run e2fsck -D."
>> >
>> > The xfstests include: ext4/057, 058, and 307; generic/013, 051, 068,
>> > 070, 076, 078, 083, 232, 269, 270, 390, 461, 475, 476, 482, 579, 585,
>> > 589, 626, 631, and 650.
>>
>> So, I guess since these were only ext4 warnings hence maybe these were
>> getting ignored? Because the tests were never failing?
>> Should we do something for such cases? Maybe adding this warning
>> detection in xfstests to fail the test case when these warnings are not
>> intended? e.g. such warnings should make the test fail by saying
>> something detected in dmesg. Except when these are expected for I/O error
>> injection tests, etc...
>>
>
> Hi, Ritesh:
>
> Thanks for taking a look at this patch.
>
> Right, the tests never failed.  I was aware of the warning messages because
> I routinely check the captured system log output from my upstream regression
> runs.  The messages weren't so much ignored as being set aside for the time
> being.  They have been appearing for some years, and I'd mentioned them in
> past concalls. Since the warning messages simply suggest a recovery action
> that's appropriate in some cases - running "e2fsck -D" - there wasn't much
> interest in pursuing them, given there was no evidence of actual file system
> damage or misbehavior.   After becoming much more familiar with the inline_data
> code myself recently I got suspicious and took a closer look.
>
> I don't know that I've got a strong opinion about this, but I think that adding
> the EXT4-fs warning and error message prefixes to the set of strings searched
> for by _check_dmesg, say, to force a test failure might be more trouble than
> it's worth (at least, in comparison with periodically grepping through the
> logs).  Adding ext4-specific filters to individual xfstests as needed,
> including maintaining them over time and extending the coverage to new tests as
> they appear, sounds like a lot of ongoing work for what might be a modest

ok, sure. But let me keep an eye out for this... Let me watch out for any
such bugs in my internal tests run to see whether adding such a check can
help us catch any hidden problems. I was thinking this need not be done
in one shot but can be done incrementally/individually for many tests.
Hence it should be relatively easy if we do that on the need basis
maybe.
I am not sure though of the returns/benefits from this work at this point in
time, until I have reviewed the list of failures.

> return.  IIRC, we haven't had a significant number of bugs associated with
> EXT4-fs messages without test failures in the last several years, at least.

ok. Let me also take a look at it. Thanks!

>
>> >
>> > In this situation, the warning message indicates a bug in the code that
>> > performs the RENAME_WHITEOUT operation on a directory entry that has
>> > been stored inline.  It doesn't detect that the directory is stored
>> > inline, and incorrectly attempts to compute a dirent block checksum on
>> > the whiteout inode when creating it.  This attempt fails as a result
>> > of the integrity checking in get_dirent_tail (usually due to a failure
>> > to match the EXT4_FT_DIR_CSUM magic cookie), and the warning message
>> > is then emitted.
>> >
>> > Fix this by simply collecting the inlined data state at the time the
>> > search for the source directory entry is performed.  Existing code
>> > handles the rest, and this is sufficient to eliminate all spurious
>> > warning messages produced by the tests above.  Go one step further
>> > and do the same in the code that resets the source directory entry in
>> > the event of failure.  The inlined state should be present in the
>> > "old" struct, but given the possibility of a race there's no harm
>> > in taking a conservative approach and getting that information again
>> > since the directory entry is being reread anyway.
>>
>> Thanks for the detailed explaination. This makes sense to me.
>>
>> >
>> > Fixes: b7ff91fd030d ("ext4: find old entry again if failed to rename whiteout")
>>
>> So for your changes in ext4_resetent(), your above fixes tags make sense.
>> But what about the changes in ext4_rename() function. That was always
>> passing NULL as the last argument since the begining no?
>> Thinking from the backport perspective if and when required ;)
>>
>
> I'm guessing the intersection of the set of inline data and whiteout (overlayfs)
> users is sufficiently small that this patch won't need backporting anytime
> soon.  :-)
>
> The reason I picked that tag is that it's a fix for a fix to the patch that
> originally added whiteout support to ext4. I wanted to convey that those
> fixes should be applied in addition to this patch to get fully functional code.

Sure. Thanks for the explaination.

-ritesh
