Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D5046EF51
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Dec 2021 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbhLIREH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 12:04:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60568 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241920AbhLIRD5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 12:03:57 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B9H0HqI001602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Dec 2021 12:00:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6204D4205DB; Thu,  9 Dec 2021 12:00:16 -0500 (EST)
Date:   Thu, 9 Dec 2021 12:00:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: ext4: possible ABBA deadlock in
 ext4_inline_data_truncate() and ext4_punch_hole()
Message-ID: <YbI2IEzCVo+A6GTi@mit.edu>
References: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 09, 2021 at 07:10:44PM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible ABBA deadlock in the ext4 module
> in Linux 5.10:
> 
> ext4_inline_data_truncate()
>   down_write(&EXT4_I(inode)->i_data_sem); --> Line 1895 (Lock A)
>   ext4_xattr_ibody_get()
>     ext4_xattr_inode_get()
>       ext4_xattr_inode_iget()
>         inode_lock(inode); --> Line 427 (Lock B)
> 
> ext4_punch_hole()
>   inode_lock(inode); --> Line 4018 (Lock B)
>   ext4_update_disksize_before_punch()
>     ext4_update_i_disksize()
>       down_write(&EXT4_I(inode)->i_data_sem); --> Line 3248 (Lock A)
> 
> When ext4_inline_data_truncate() and ext4_punch_hole() are concurrently
> executed, the deadlock can occur.
> 
> I am not quite sure whether this possible deadlock is real and how to fix it
> if it is real.

Hi,

Thanks for the report.  I don't believe this is deadlock is possible,
because the first thing ext4_punch_hole() does is to check to see if
the inode has inline data --- and if so, it calls
ext4_convert_inline_data() to convert it to a normal file.  In
ext4_convert_inline_data(), we take the xattr lock, and then do the
conversion, and then drop the xattr lock.  So by the time
ext4_punch_hole() starts doing its work, the inode is not an inline
data file.

In ext4_inline_data_truncate(), we take the xattr lock, and once we
have the xattr lock, we check to see if inode is still an inline data
file.  If it has been converted, we then bail out.

Hence, the ABBA deadlock that your static analysis tool has pointed
shouldn't happen in practice.

Cheers,

					- Ted
