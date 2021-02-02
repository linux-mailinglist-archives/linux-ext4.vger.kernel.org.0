Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987B830C791
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhBBRYK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 12:24:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48721 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237310AbhBBRVg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 12:21:36 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 112HKjim018133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 12:20:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 93B8C15C39E2; Tue,  2 Feb 2021 12:20:45 -0500 (EST)
Date:   Tue, 2 Feb 2021 12:20:45 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: e2fsprogs 1.45.7 & 1.46.0?
Message-ID: <YBmJ7ZIbQP5R1zgo@mit.edu>
References: <20210202163827.GA7186@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202163827.GA7186@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 02, 2021 at 08:38:27AM -0800, Darrick J. Wong wrote:
> Hi Ted,
> 
> So... I see in the e2fsprogs git repo that the release notes and
> version.h that the maint branch is now at  1.45.7 and master is at
> 1.46.0.  There's a tag for 1.45.7 but no tag for 1.46.0.
> 
> Are those releases official, and did I miss the announcement on the
> list?

Um, sorry, I forgot to push out the tag.  I was going to send the
announcement to the list, but got caught up with other things.

One of those things is apparently we have a bug which is causing the
regression test suite to fail on big endian systems, including s390x
and powerpc[1] (although not ppc64el, naturally).  I'm working on
getting Harshad access to Debian's porter boxes, so he can debug it
directly.  He spotted one bug already (where a le16_to_cpu should have
been le32_to_cpu in e2fsck/journal.c:822), but there is still an
incorrect block bitmap checksum after a fc replay which is causing
j_recover_fast_commit to fail.

[1] https://buildd.debian.org/status/fetch.php?pkg=e2fsprogs&arch=powerpc&ver=1.46.0-1&stamp=1611976060&raw=0

In any case, yes, these releases are official, are up on kernel.org.
I've pushed out the tag for v1.46.0.  When we fix the BE fast commit
bug, I'll release e2fsprogs v1.46.1.  (There's also a configure script
bug which causes build failures on systems w/o FUSE which is already
fixed in the git tree that will be included in v1.46.1.)

					- Ted
