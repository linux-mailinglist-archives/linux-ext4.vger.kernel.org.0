Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BA9A5F9
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2019 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404163AbfHWDSM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 23:18:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36606 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404154AbfHWDSL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Aug 2019 23:18:11 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7N3I2Hw005113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 23:18:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0DDCB42049E; Thu, 22 Aug 2019 23:18:02 -0400 (EDT)
Date:   Thu, 22 Aug 2019 23:18:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ayush Ranjan <ayushr2@illinois.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Ext4 documentation fixes.
Message-ID: <20190823031801.GD8130@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ayush Ranjan <ayushr2@illinois.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 15, 2019 at 09:11:51AM -0700, Ayush Ranjan wrote:
> This commit aims to fix the following issues in ext4 documentation:
> - Flexible block group docs said that the aim was to group block
>   metadata together instead of block group metadata.
> - The documentation consistly uses "location" instead of "block number".
>   It is easy to confuse location to be an absolute offset on disk. Added
>   a line to clarify all location values are in terms of block numbers.
> - Dirent2 docs said that the rec_len field is shortened instead of the
>   name_len field.
> - Typo in bg_checksum description.
> - Inode size is 160 bytes now, and hence i_extra_isize is now 32.
> - Cluster size formula was incorrect, it did not include the +10 to
>   s_log_cluster_size value.
> - Typo: there were two s_wtime_hi in the superblock struct.
> - Superblock struct was outdated, added the new fields which were part
>   of s_reserved earlier.
> - Multiple mount protection seems to be implemented in fs/ext4/mmp.c.
> 
> Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>

Fixed with one minor typo fix:

> diff --git a/Documentation/filesystems/ext4/group_descr.rst
> b/Documentation/filesystems/ext4/group_descr.rst
> index 0f783ed88..feb5c613d 100644
> --- a/Documentation/filesystems/ext4/group_descr.rst
> +++ b/Documentation/filesystems/ext4/group_descr.rst
> @@ -100,7 +100,7 @@ The block group descriptor is laid out in ``struct
> ext4_group_desc``.
>       - \_\_le16
>       - bg\_checksum
>       - Group descriptor checksum; crc16(sb\_uuid+group+desc) if the
> -       RO\_COMPAT\_GDT\_CSUM feature is set, or crc32c(sb\_uuid+group\_desc) &
> +       RO\_COMPAT\_GDT\_CSUM feature is set, or crc32c(sb\_uuid+group+desc) &
>         0xFFFF if the RO\_COMPAT\_METADATA\_CSUM feature is set.

The correct checksum should be "crc16(sb\_uuid+group\_desc)" or
"crc32c(sb\_uuid+group\_desc)".  That is, it's previous line which
needed modification.

					- Ted
