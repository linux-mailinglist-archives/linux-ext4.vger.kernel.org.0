Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A864E446FF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfFMQz6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:55:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36474 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729982AbfFMBvG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 21:51:06 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5D1ovNF006035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 21:50:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F1D04420484; Wed, 12 Jun 2019 21:50:56 -0400 (EDT)
Date:   Wed, 12 Jun 2019 21:50:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Li Dongyang <dongyangli@ddn.com>
Subject: Re: fsck doesn't seem to understand inline directories
Message-ID: <20190613015056.GA2956@mit.edu>
References: <ee4ad9f4-6706-136d-4cd8-dcf1b58e4229@rasmusvillemoes.dk>
 <044ADDD7-D7C0-4E27-B9E7-E576CDEDD1C4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044ADDD7-D7C0-4E27-B9E7-E576CDEDD1C4@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 02:40:18PM -0600, Andreas Dilger wrote:
> On Jun 12, 2019, at 8:07 AM, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > 
> > Doing a forced check on an ext4 file system with inline_data results in
> > lots of warnings - and I think answering yes to "fixing" those would
> > actually corrupt the fs.
> 
> Rasmus,
> This definitely seems like a bug in e2fsck.  It isn't totally surprising, since
> the inline_data feature is not widely used.  We are currently investigating using
> it for regular files, but it doesn't seem worthwhile for directories to me.

It looks like the problem is the combination of large_dir and
inline_data, and it does look like the problem is in e2fsck (as
opposed to the kernel).

Large_dir is a new feature (even newer than inline_data, and it looks
like the support for large_dir didn't handle the combination with
inline_data correctly).

							- Ted

# mke2fs -t ext4 -O inline_data -Fq /tmp/ext4.img 1G
/tmp/ext4.img contains a ext4 file system
	last mounted on Wed Jun 12 21:47:25 2019
# mount /tmp/ext4.img /mnt ; mkdir /mnt/aa ; umount /mnt
# e2fsck -fn /tmp/ext4.img
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/tmp/ext4.img: 12/65536 files (0.0% non-contiguous), 12954/262144 blocks

### So everything is fine with just inline_data, but when you
### enable the large_dir features, and rerun e2fsck....

# debugfs -w -R "features large_dir" /tmp/ext4.img 
debugfs 1.45.2 (27-May-2019)
Filesystem features: has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg large_dir inline_data sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
# e2fsck -fn /tmp/ext4.img
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
'..' in /aa (12) is <The NULL inode> (0), should be / (2).
Fix? no

Pass 4: Checking reference counts
Inode 2 ref count is 4, should be 3.  Fix? no

Inode 12 ref count is 2, should be 1.  Fix? no

Pass 5: Checking group summary information

/tmp/ext4.img: ********** WARNING: Filesystem still has errors **********

/tmp/ext4.img: 12/65536 files (0.0% non-contiguous), 12954/262144 blocks


