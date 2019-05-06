Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA89A154C6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFUDb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 16:03:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56195 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbfEFUDb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 May 2019 16:03:31 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x46K3Q3m002320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 May 2019 16:03:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F2BD9420024; Mon,  6 May 2019 16:03:25 -0400 (EDT)
Date:   Mon, 6 May 2019 16:03:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH xfstests 1/2] common/casefold: Add infrastructure to test
 filename casefold feature
Message-ID: <20190506200325.GA3985@mit.edu>
References: <20190506185941.10570-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506185941.10570-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 06, 2019 at 02:59:40PM -0400, Gabriel Krisman Bertazi wrote:
> +_require_test_casefold_feature () {
> +    _has_casefold_feature $TEST_DEV || \
> +	_notrun "Feature casefold required for this test"
> +}
> +_require_scratch_casefold_feature () {
> +    _has_casefold_feature $SCRATCH_DEV || \
> +	_notrun "Feature casefold required for this test"
> +}

I've just pushed out a commit to ext4.git tree which will cause
/sys/fs/ext4/features/casefold will exist iff CONFIG_UNICODE is
present.  This will allow the test to check whether or not the kernel
version and configuration will support the casefold feature.

Could you add a check for this flag if the file system type is ext4?

A file system independent way of doing this would be to create a test
file system on the test file system, calling "chattr +F" on the
directory.  If it fails, then either the file system doesn't support
it or the chattr program is too old and doesn't support casefold.  If
the chattr +F succeeds, then the test should call lsattr -d on the
directory and make sure the request to set casefold flag was actually
honored; some file systems will simply fail to set flags that they
don't support, so we do need to do a SETFLAGS followed by a GETFLAGS
to be sure that it was supported.

Speaking of file system independent casefold, I believe that it will
be likely that the casefold feature will be supported by f2fs in the
fullness of time.  If that happens, how to test for the file system
feature will be different (since dumpe2fs is ext4-specific), but I
would expect "chattr +F" interface to be the same between ext4 and
f2fs.

This might mean that we should add casefold tests to either generic/
or shared/ instead of ext4/ --- I think it would be shared since at
least initially it would only be ext4 and f2fs, and I haven't seen any
indication than other file systems would be interested in adding
casefold support.  Or we can move the casefold tests later from ext4/
to shared/ once the f2fs support materializes.

Cheers,

						- Ted
