Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8422426192
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 03:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhJHBI7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 21:08:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:12072 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJHBI7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Oct 2021 21:08:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="249659991"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="249659991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 12:13:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="489135500"
Received: from roliveir-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 12:13:15 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
In-Reply-To: <20210902220854.198850-2-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210902220854.198850-1-corbet@lwn.net> <20210902220854.198850-2-corbet@lwn.net>
Date:   Thu, 07 Oct 2021 22:13:10 +0300
Message-ID: <87czogy7g9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 02 Sep 2021, Jonathan Corbet <corbet@lwn.net> wrote:
> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
> a new document on orphan files, which is great.  But the use of
> "list-table" results in documents that are absolutely unreadable in their
> plain-text form.  Switch this file to the regular RST table format instead;
> the rendered (HTML) output is identical.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
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

As a third alternative, the csv-table directive [1] is sometimes a good
choice. Picking | as the delim makes it look more like a table in the
source, and you don't have to worry about aligning everything (the
spaces before and after the delim are ignored by default). But it does
require some boilerplate and you can't wrap the lines.

The same table as an example:

.. csv-table:: Block Structure
   :delim: |
   :header-rows: 1
   :widths: auto

   Offset        | Type                    | Name                 | Description
   0x0           | Array of __le32 entries | Orphan inode entries | Each __le32 entry is either empty (0) or it contains inode number of an orphan inode.
   blocksize-8   | __le32                  | ob_magic             | Magic value stored in orphan block tail (0x0b10ca04)
   blocksize-4   | __le32                  | ob_checksum          | Checksum of the orphan block.

Obviously not the best choice for this particular table, but just so you
are aware of an alternative.


BR,
Jani.


[1] https://docutils.sourceforge.io/docs/ref/rst/directives.html#csv-table

-- 
Jani Nikula, Intel Open Source Graphics Center
