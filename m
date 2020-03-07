Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4817D089
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2020 00:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCGXRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 18:17:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34640 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgCGXRZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 18:17:25 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 027NHJKL003345
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 18:17:20 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4AD7342045B; Sat,  7 Mar 2020 18:17:19 -0500 (EST)
Date:   Sat, 7 Mar 2020 18:17:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] e2fsck: Fix indexed dir rehash failure with
 metadata_csum enabled
Message-ID: <20200307231719.GE99899@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-3-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:15:57AM +0100, Jan Kara wrote:
> E2fsck directory rehashing code can fail with ENOSPC due to a bug in
> ext2fs_htree_intnode_maxrecs() which fails to take metadata checksum
> into account and thus e.g. e2fsck can decide to create 1 indirect level
> of index tree when two are actually needed. Fix the logic to account for
> metadata checksum.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied with a minor change; I didn't want to make this change:

> -_INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
> +static inline int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)

... because it would make ext2fs_htree_intmode_maxrecs disappear from libext2fs.so.

So I changed this:

> +	if (ext2fs_has_feature_metadata_csum(fs->super))

to this:

+       if ((EXT2_SB(fs->super)->s_feature_ro_compat &
+            EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) != 0)

to fix the inline related compilation errors.

					- Ted
