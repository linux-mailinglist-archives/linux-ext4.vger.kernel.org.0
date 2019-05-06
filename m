Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9ED154EB
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfEFUc2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 16:32:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUc2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 May 2019 16:32:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 55CFF26398A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH xfstests 1/2] common/casefold: Add infrastructure to test filename casefold feature
Organization: Collabora
References: <20190506185941.10570-1-krisman@collabora.com>
        <20190506200325.GA3985@mit.edu>
Date:   Mon, 06 May 2019 16:32:23 -0400
In-Reply-To: <20190506200325.GA3985@mit.edu> (Theodore Ts'o's message of "Mon,
        6 May 2019 16:03:25 -0400")
Message-ID: <875zqn1fzc.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, May 06, 2019 at 02:59:40PM -0400, Gabriel Krisman Bertazi wrote:
>> +_require_test_casefold_feature () {
>> +    _has_casefold_feature $TEST_DEV || \
>> +	_notrun "Feature casefold required for this test"
>> +}
>> +_require_scratch_casefold_feature () {
>> +    _has_casefold_feature $SCRATCH_DEV || \
>> +	_notrun "Feature casefold required for this test"
>> +}
>
> I've just pushed out a commit to ext4.git tree which will cause
> /sys/fs/ext4/features/casefold will exist iff CONFIG_UNICODE is
> present.  This will allow the test to check whether or not the kernel
> version and configuration will support the casefold feature.
>
> Could you add a check for this flag if the file system type is ext4?

Hello Ted,

I will follow up with this change on a v2.

> A file system independent way of doing this would be to create a test
> file system on the test file system, calling "chattr +F" on the
> directory.  If it fails, then either the file system doesn't support
> it or the chattr program is too old and doesn't support casefold.  If
> the chattr +F succeeds, then the test should call lsattr -d on the
> directory and make sure the request to set casefold flag was actually
> honored; some file systems will simply fail to set flags that they
> don't support, so we do need to do a SETFLAGS followed by a GETFLAGS
> to be sure that it was supported.

> Speaking of file system independent casefold, I believe that it will
> be likely that the casefold feature will be supported by f2fs in the
> fullness of time.  If that happens, how to test for the file system
> feature will be different (since dumpe2fs is ext4-specific), but I
> would expect "chattr +F" interface to be the same between ext4 and
> f2fs.

I planned to add the per-filesystem test inside common/casefold.  Not
sure how it would be done for f2fs, but i don't think we'd have a
unified interface other than SETFLAGS followed by GETFLAGS to test
this.  I think I could make this method the fallback.

>
> This might mean that we should add casefold tests to either generic/
> or shared/ instead of ext4/ --- I think it would be shared since at
> least initially it would only be ext4 and f2fs, and I haven't seen any
> indication than other file systems would be interested in adding
> casefold support.  Or we can move the casefold tests later from ext4/
> to shared/ once the f2fs support materializes.

Last thing I did before submitting this series was moving from generic/
to ext4/.  I plan to move it back into generic/ or shared/ once another
filesystem uses it.

I didn't have a chance to discuss with xfs folks yet, but I spoke to
Chris Mason and I plan to propose this feature for xfs and btrfs soon.

-- 
Gabriel Krisman Bertazi
