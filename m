Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3241B70
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 07:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfFLFBu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 01:01:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFLFBu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 01:01:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2A3B3263961
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding feature
Organization: Collabora
References: <20190610173541.20511-1-krisman@collabora.com>
        <20190610173541.20511-2-krisman@collabora.com>
        <20190611121546.GC2774@mit.edu>
Date:   Wed, 12 Jun 2019 01:01:46 -0400
In-Reply-To: <20190611121546.GC2774@mit.edu> (Theodore Ts'o's message of "Tue,
        11 Jun 2019 08:15:46 -0400")
Message-ID: <85y327z9ad.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, Jun 10, 2019 at 01:35:41PM -0400, Gabriel Krisman Bertazi wrote:
>> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
>> 
>> This new test implements verification for the per-directory
>> case-insensitive feature, as supported by the reference implementation
>> in Ext4.
>> 
>> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>   [Rewrite to support feature design]
>>   [Refactor to simplify implementation]
>
> I tried out this test, and it's apparently failing for me using
> e2fsprogs 1.45.2; it looks like it's a whitespace issue?

Hi Ted,

Yes, definitely just whitespace.  But i don't understand why you are
getting this behavior.  I tried both with the master branch of e2fsprogs
and the tagged commit of v1.45.2 and on both occasions the test succeed
in my system.  For sure I can use filter_spaces but I'm puzzled why I
can't reproduce this.

>
> shared/012		[08:14:07][  146.388509] run fstests shared/012 at 2019-06-11 08:14:07
>  [08:14:08]- output mismatch (see /results/ext4/results-4k/shared/012.out.bad)
>     --- tests/shared/012.out	2019-06-10 00:02:54.000000000 -0400
>     +++ /results/ext4/results-4k/shared/012.out.bad	2019-06-11 08:14:08.487418272 -0400
>     @@ -1,8 +1,8 @@
>      QA output created by 012
>     -SCRATCH_MNT/basic           Extents, Casefold
>     -SCRATCH_MNT/basic           Extents
>     -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
>     -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
>     +SCRATCH_MNT/basic                   Extents, Casefold
>     +SCRATCH_MNT/basic                   Extents
>     ...
>     (Run 'diff -u /root/xfstests/tests/shared/012.out /results/ext4/results-4k/shared/012.out.bad'  to see the entire diff)
> Ran: shared/012
> Failures: shared/012
> Failed 1 of 1 tests
> Xunit report: /results/ext4/results-4k/result.xml
>
> root@kvm-xfstests:~# diff -u /root/xfstests/tests/shared/012.out /results/ext4/results-4k/shared/012.out.bad
> --- /root/xfstests/tests/shared/012.out	2019-06-10 00:02:54.000000000 -0400
> +++ /results/ext4/results-4k/shared/012.out.bad	2019-06-11 08:14:08.487418272 -0400
> @@ -1,8 +1,8 @@
>  QA output created by 012
> -SCRATCH_MNT/basic           Extents, Casefold
> -SCRATCH_MNT/basic           Extents
> -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
> -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
> +SCRATCH_MNT/basic                   Extents, Casefold
> +SCRATCH_MNT/basic                   Extents
> +SCRATCH_MNT/casefold_flag_removal   Extents, Casefold
> +SCRATCH_MNT/casefold_flag_removal   Extents, Casefold
>  SCRATCH_MNT/flag_inheritance/d1/d2/d3 Extents, Casefold
>  SCRATCH_MNT/symlink/ind1/TARGET
>  mv: cannot stat 'SCRATCH_MNT/rename/rename': No such file or directory

-- 
Gabriel Krisman Bertazi
