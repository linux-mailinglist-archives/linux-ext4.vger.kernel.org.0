Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0022CC547
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgLBSeT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 13:34:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51393 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728153AbgLBSeQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 13:34:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2IXRx5008698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 13:33:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E79A420136; Wed,  2 Dec 2020 13:33:27 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:33:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/15] mke2fs, tune2fs: update man page with fast commit
 info
Message-ID: <20201202183327.GI390058@mit.edu>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191606.2224881-6-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:56AM -0800, Harshad Shirwadkar wrote:
> This patch adds information about fast commit feature in mke2fs and
> tune2fs man pages.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

So this is a bit more of a personal preference thing, but I like to
keep the libext2fs changes from the changes to the userspace
applications, and then combine the changes to the userspace progams
(mke2fs and tune2fs in this case) with the man page updates.

So you might want to consider moving the mke2fs and tune2fs changes
from the previous patch and then combining them with this patch, and
adjusting the commit message appropriately?

> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index e6bfc6d6..2833b408 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -521,6 +521,27 @@ The size of the journal must be at least 1024 filesystem blocks
>  and may be no more than 10,240,000 filesystem blocks or half the total
>  file system size (whichever is smaller)
>  .TP
> +.BI fast_commit_size= fast-commit-size
> +Create an additional fast commit journal area of size
> +.I fast-commit-size
> +kilobytes.
> +This option is only valid if
> +.B fast_commit
> +feature is enabled
> +on the file system. If this option is not specified and if
> +.B fast_commit
> +feature is turned on, fast commit area size defaults to
> +.I journal-size
> +/ 64 megabytes. The total size of the journal with
> +.B fast_commit
> +feature set is
> +.I journal-size
> ++ (
> +.I fast-commit-size
> +* 1024) megabytes. The total journal size may be no more than
> +10,240,000 filesystem blocks or half the total file system size
> +(whichever is smaller).
> +.TP

So as I recall, aren't we currently calculating the fast commit size
as a fraction of the total journal size?  I'm not sure this is in sync
with was in the last patch.

					- Ted
