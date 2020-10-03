Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467C2282111
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCENo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:13:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41514 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCENo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:13:44 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934DLGg018715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:13:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 27F4542003C; Sat,  3 Oct 2020 00:13:21 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:13:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-ext4@vger.kernel.org, darrick.wong@oracle.com,
        ira.weiny@intel.com, jack@suse.cz
Subject: Re: [PATCH v2] ext4: Disallow modifying DAX inode flag if
 inline_data has been set
Message-ID: <20201003041321.GB23474@mit.edu>
References: <20200828084330.15776-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828084330.15776-1-yangx.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 28, 2020 at 04:43:30PM +0800, Xiao Yang wrote:
> inline_data is mutually exclusive to DAX so enabling both of them triggers
> the following issue:
> ------------------------------------------
> # mkfs.ext4 -F -O inline_data /dev/pmem1
> ...
> # mount /dev/pmem1 /mnt
> # echo 'test' >/mnt/file
> # lsattr -l /mnt/file
> /mnt/file                    Inline_Data
> # xfs_io -c "chattr +x" /mnt/file
> # xfs_io -c "lsattr -v" /mnt/file
> [dax] /mnt/file
> # umount /mnt
> # mount /dev/pmem1 /mnt
> # cat /mnt/file
> cat: /mnt/file: Numerical result out of range
> ------------------------------------------
> 
> Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
