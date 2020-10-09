Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE60E2890C5
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbgJIS2x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 14:28:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50230 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388092AbgJIS2x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 14:28:53 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 099ISZgf003072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Oct 2020 14:28:36 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A39D0420107; Fri,  9 Oct 2020 14:28:35 -0400 (EDT)
Date:   Fri, 9 Oct 2020 14:28:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
Message-ID: <20201009182835.GN235506@mit.edu>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919005451.3899779-2-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 05:54:43PM -0700, Harshad Shirwadkar wrote:
> This patch adds necessary documentation for fast commits.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
>  Documentation/filesystems/journalling.rst  | 28 +++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> index ea613ee701f5..c2e4d010a201 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -609,3 +620,58 @@ bytes long (but uses a full block):
>       - h\_commit\_nsec
>       - Nanoseconds component of the above timestamp.
>  
> +Fast commits
> +~~~~~~~~~~~~
> +
> +Fast commit area is organized as a log of tag tag length values. Each TLV has

s/tag tag/tag/

> +
> +File system is free to perform fast commits as and when it wants as long as it
> +gets permission from JBD2 to do so by calling the function
> +:c:func:`jbd2_fc_start()`. Once a fast commit is done, the client
> +file  system should tell JBD2 about it by calling :c:func:`jbd2_fc_stop()`.
> +If file system wants JBD2 to perform a full commit immediately after stopping
> +the fast commit it can do so by calling :c:func:`jbd2_fc_stop_do_commit()`.
> +This is useful if fast commit operation fails for some reason and the only way
> +to guarantee consistency is for JBD2 to perform the full traditional commit.

One of the things which is a bit confusing is that there is a
substantial part of the fast commit functionality which is implemented
in ext4, and not in the jbd2 layer.

We can't just talk about ext4_fc_start_update() and
ext4_fc_stop_update() here, since it would be a vit of a layering
violation.  But some kind of explanation of how a file system would
use the jbd2 fast commit framework would be useful, and the big
picture view of how the ext4 fast commit infrastruction (which is
currently documented in the top-level comments of
fs/ext4/fast_commit.c) fit into jbd2 infrastructure.

Maybe put the big picture explanation in fs/ext4/fast_commit.c and
then put a pointer in journaling.rst to the comments in
fs/ext4/fast_commit.c as an example of how the jbd2 fast_commit
infrastructure would get used (for example, if ocfs2 ever got
interested in doing something similar)?  Or maybe we need to move some
of the description from comments in fast_commit.c to a file in
Documentation/filesystems/ext4/fast_commit.rst, perhaps?

						- Ted
