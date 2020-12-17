Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A72DD84C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLQS2o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 13:28:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50528 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728192AbgLQS2o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 13:28:44 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHIRjAs031424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 13:27:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E8524420280; Thu, 17 Dec 2020 13:27:44 -0500 (EST)
Date:   Thu, 17 Dec 2020 13:27:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Richard Weinberger <richard@nod.at>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't leak old mountpoint samples
Message-ID: <X9ujIOJG/HqMr88R@mit.edu>
References: <20201201151301.22025-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201151301.22025-1-richard@nod.at>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 01, 2020 at 04:13:01PM +0100, Richard Weinberger wrote:
> As soon the first file is opened, ext4 samples the mountpoint
> of the filesystem in 64 bytes of the super block.
> It does so using strlcpy(), this means that the remaining bytes
> in the super block string buffer are untouched.
> If the mount point before had a longer path than the current one,
> it can be reconstructed.
> 
> Consider the case where the fs was mounted to "/media/johnjdeveloper"
> and later to "/".
> The the super block buffer then contains "/\x00edia/johnjdeveloper".
> 
> This case was seen in the wild and caused confusion how the name
> of a developer ands up on the super block of a filesystem used
> in production...
> 
> Fix this by clearing the string buffer before writing to it,
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Thank for reporting this issue.  In fact, the better fix is to use
strncpy().  See my revised patch for an explanation of why....

commit cdc9ad7d3f201a77749432878fb4caa490862de6
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Dec 17 13:24:15 2020 -0500

    ext4: don't leak old mountpoint samples
    
    When the first file is opened, ext4 samples the mountpoint of the
    filesystem in 64 bytes of the super block.  It does so using
    strlcpy(), this means that the remaining bytes in the super block
    string buffer are untouched.  If the mount point before had a longer
    path than the current one, it can be reconstructed.
    
    Consider the case where the fs was mounted to "/media/johnjdeveloper"
    and later to "/".  The super block buffer then contains
    "/\x00edia/johnjdeveloper".
    
    This case was seen in the wild and caused confusion how the name
    of a developer ands up on the super block of a filesystem used
    in production...
    
    Fix this by using strncpy() instead of strlcpy().  The superblock
    field is defined to be a fixed-size char array, and it is already
    marked using __nonstring in fs/ext4/ext4.h.  The consumer of the field
    in e2fsprogs already assumes that in the case of a 64+ byte mount
    path, that s_last_mounted will not be NUL terminated.
    
    Reported-by: Richard Weinberger <richard@nod.at>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 1cd3d26e3217..349b27f0dda0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -810,7 +810,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	if (err)
 		goto out_journal;
 	lock_buffer(sbi->s_sbh);
-	strlcpy(sbi->s_es->s_last_mounted, cp,
+	strncpy(sbi->s_es->s_last_mounted, cp,
 		sizeof(sbi->s_es->s_last_mounted));
 	ext4_superblock_csum_set(sb);
 	unlock_buffer(sbi->s_sbh);
