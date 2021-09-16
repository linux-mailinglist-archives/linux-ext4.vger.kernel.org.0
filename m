Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510F840D6C3
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhIPJ5R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 05:57:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbhIPJ5M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 05:57:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A90B22351;
        Thu, 16 Sep 2021 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631786151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fyfkYb5NKRXBms3DZ0DwWO8JEbA7jaDli8GMKM1CaCY=;
        b=fp61maMOqc4Ndik6PNRMzbjd3bFn/rOjuSgz/d7U8Jw6C3uEFqX5/E3bRZUxOwUPovg/UO
        us5h8qbz6LiW0y4d3V5P7SgoQv92+SHXKlbil+WZUAhZk85kTgYCzJfat7zZWaCrMLpiZQ
        hBeRSNhMEa/rrlnYO8ZGDMgiJzOHBKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631786151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fyfkYb5NKRXBms3DZ0DwWO8JEbA7jaDli8GMKM1CaCY=;
        b=++AD1Jg3Hq+mR10f1Oz/vsf1RlM1G3hJ4lPI+pf6jVptPtDwUKxlJ0RNKzEfzLO5JODx7y
        atWyWMbPG5DeUIBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B1DA2A3B8F;
        Thu, 16 Sep 2021 09:55:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D07C11E0C04; Thu, 16 Sep 2021 11:55:50 +0200 (CEST)
Date:   Thu, 16 Sep 2021 11:55:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: docs: Take out unneeded escaping
Message-ID: <20210916095550.GF10610@quack2.suse.cz>
References: <20210902220854.198850-1-corbet@lwn.net>
 <20210902220854.198850-3-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902220854.198850-3-corbet@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 02-09-21 16:08:54, Jonathan Corbet wrote:
> The new file Documentation/orphan/ext4.rst escapes underscores ("\_")
> throughout.  However, RST doesn't actually require that, so the escaping
> only succeeds in making the document less readable.  Remove the unneeded
> escapes.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/filesystems/ext4/orphan.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Hum, probably I saw underscores escaped somewhere and didn't check whether
it is necessary. Thanks for fixing this. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/Documentation/filesystems/ext4/orphan.rst b/Documentation/filesystems/ext4/orphan.rst
> index d096fe0ba19e..03cca178864b 100644
> --- a/Documentation/filesystems/ext4/orphan.rst
> +++ b/Documentation/filesystems/ext4/orphan.rst
> @@ -12,31 +12,31 @@ track the inode as orphan so that in case of crash extra blocks allocated to
>  the file get truncated.
>  
>  Traditionally ext4 tracks orphan inodes in a form of single linked list where
> -superblock contains the inode number of the last orphan inode (s\_last\_orphan
> +superblock contains the inode number of the last orphan inode (s_last_orphan
>  field) and then each inode contains inode number of the previously orphaned
> -inode (we overload i\_dtime inode field for this). However this filesystem
> +inode (we overload i_dtime inode field for this). However this filesystem
>  global single linked list is a scalability bottleneck for workloads that result
>  in heavy creation of orphan inodes. When orphan file feature
> -(COMPAT\_ORPHAN\_FILE) is enabled, the filesystem has a special inode
> -(referenced from the superblock through s\_orphan_file_inum) with several
> +(COMPAT_ORPHAN_FILE) is enabled, the filesystem has a special inode
> +(referenced from the superblock through s_orphan_file_inum) with several
>  blocks. Each of these blocks has a structure:
>  
>  ============= ================ =============== ===============================
>  Offset        Type             Name            Description
>  ============= ================ =============== ===============================
> -0x0           Array of         Orphan inode    Each \_\_le32 entry is either
> -              \_\_le32 entries entries         empty (0) or it contains
> +0x0           Array of         Orphan inode    Each __le32 entry is either
> +              __le32 entries   entries         empty (0) or it contains
>  	                                       inode number of an orphan
>  					       inode.
> -blocksize-8   \_\_le32         ob\_magic       Magic value stored in orphan
> +blocksize-8   __le32           ob_magic        Magic value stored in orphan
>                                                 block tail (0x0b10ca04)
> -blocksize-4   \_\_le32         ob\_checksum    Checksum of the orphan block.
> +blocksize-4   __le32           ob_checksum     Checksum of the orphan block.
>  ============= ================ =============== ===============================
>  
>  When a filesystem with orphan file feature is writeably mounted, we set
> -RO\_COMPAT\_ORPHAN\_PRESENT feature in the superblock to indicate there may
> +RO_COMPAT_ORPHAN_PRESENT feature in the superblock to indicate there may
>  be valid orphan entries. In case we see this feature when mounting the
>  filesystem, we read the whole orphan file and process all orphan inodes found
>  there as usual. When cleanly unmounting the filesystem we remove the
> -RO\_COMPAT\_ORPHAN\_PRESENT feature to avoid unnecessary scanning of the orphan
> +RO_COMPAT_ORPHAN_PRESENT feature to avoid unnecessary scanning of the orphan
>  file and also make the filesystem fully compatible with older kernels.
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
