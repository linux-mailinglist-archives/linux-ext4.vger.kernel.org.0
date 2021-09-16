Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1A40D6A2
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhIPJ4S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 05:56:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33002 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhIPJ4S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 05:56:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72FB122376;
        Thu, 16 Sep 2021 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631786097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Hr/2iIZwIEgCfldPaWyF8ZFWOFNeO1vGU+ls4G7YRI=;
        b=mWETj69L9GUgeYnhoAaHEVHJ+GR89fRjzab/9tY2mcpPQ6CY5VzXTWoOcYirKRPtTAP/4u
        R+LOTCIU2oUSOGMVUqBWoiF0qhT5tiNFl//rzYCvYtBWi+zbp/JzD9LD+Eq1TqDCcn/fOD
        oVkycPzqVARLnHaOlqX2mwX7UJzPrdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631786097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Hr/2iIZwIEgCfldPaWyF8ZFWOFNeO1vGU+ls4G7YRI=;
        b=vdd/mdK8Kd1wgwBLy4fKohEi+Mcqx1OYk7NF9U+Q+XEN2LvGN69Q3oZuY3B+/jtKMQrkvp
        0sNiClqPglIuTHCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A5A38A3B90;
        Thu, 16 Sep 2021 09:54:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A82661E0C04; Thu, 16 Sep 2021 11:54:55 +0200 (CEST)
Date:   Thu, 16 Sep 2021 11:54:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
Message-ID: <20210916095455.GE10610@quack2.suse.cz>
References: <20210902220854.198850-1-corbet@lwn.net>
 <20210902220854.198850-2-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902220854.198850-2-corbet@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 02-09-21 16:08:53, Jonathan Corbet wrote:
> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
> a new document on orphan files, which is great.  But the use of
> "list-table" results in documents that are absolutely unreadable in their
> plain-text form.  Switch this file to the regular RST table format instead;
> the rendered (HTML) output is identical.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks! Definitely looks more readable :). You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/ext4/orphan.rst | 32 ++++++++---------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/orphan.rst b/Documentation/filesystems/ext4/orphan.rst
> index bb19ecd1b626..d096fe0ba19e 100644
> --- a/Documentation/filesystems/ext4/orphan.rst
> +++ b/Documentation/filesystems/ext4/orphan.rst
> @@ -21,27 +21,17 @@ in heavy creation of orphan inodes. When orphan file feature
>  (referenced from the superblock through s\_orphan_file_inum) with several
>  blocks. Each of these blocks has a structure:
>  
> -.. list-table::
> -   :widths: 8 8 24 40
> -   :header-rows: 1
> -
> -   * - Offset
> -     - Type
> -     - Name
> -     - Description
> -   * - 0x0
> -     - Array of \_\_le32 entries
> -     - Orphan inode entries
> -     - Each \_\_le32 entry is either empty (0) or it contains inode number of
> -       an orphan inode.
> -   * - blocksize - 8
> -     - \_\_le32
> -     - ob\_magic
> -     - Magic value stored in orphan block tail (0x0b10ca04)
> -   * - blocksize - 4
> -     - \_\_le32
> -     - ob\_checksum
> -     - Checksum of the orphan block.
> +============= ================ =============== ===============================
> +Offset        Type             Name            Description
> +============= ================ =============== ===============================
> +0x0           Array of         Orphan inode    Each \_\_le32 entry is either
> +              \_\_le32 entries entries         empty (0) or it contains
> +	                                       inode number of an orphan
> +					       inode.
> +blocksize-8   \_\_le32         ob\_magic       Magic value stored in orphan
> +                                               block tail (0x0b10ca04)
> +blocksize-4   \_\_le32         ob\_checksum    Checksum of the orphan block.
> +============= ================ =============== ===============================
>  
>  When a filesystem with orphan file feature is writeably mounted, we set
>  RO\_COMPAT\_ORPHAN\_PRESENT feature in the superblock to indicate there may
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
