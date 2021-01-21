Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9179F2FF122
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbhAUQzM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 11:55:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42618 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388216AbhAUQzE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 11:55:04 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LGs6Dr028604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 11:54:07 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F2A115C35F5; Thu, 21 Jan 2021 11:54:06 -0500 (EST)
Date:   Thu, 21 Jan 2021 11:54:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 08/15] e2fsck: add fast commit setup code
Message-ID: <YAmxrkT81IdsSXe4@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
 <20210120212641.526556-9-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-9-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:34PM -0800, Harshad Shirwadkar wrote:
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index fdcb28f6..eb2e6549 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -2148,4 +2148,7 @@ static inline unsigned int ext2_dir_htree_level(ext2_filsys fs)
>  }
>  #endif
>  
> +/* Commonly used helpers */
> +#define max(a, b) ((a) > (b) ? (a) : (b))
> +
>  #endif /* _EXT2FS_EXT2FS_H */

It's better not to add this to a publically exported file, such as
lib/ext2fs/ext2fs.h, since it may conflict with other userspace
application which may define their own max file.

Something which we might want to do is to add something like
linux/minmax.h from the kernel sources to libsupport.  This defines a
max() macro which does paranoid typechecking to make sure we don't
accidentally compare an unsigned int to an signed int, which can
potential security problems with maliciously fuzzed file system
images.  :-)

						- Ted
