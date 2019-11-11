Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96C3F79B8
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKKRUt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Nov 2019 12:20:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43453 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727078AbfKKRUt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Nov 2019 12:20:49 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xABHKSAk005485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 12:20:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C81E4202FD; Mon, 11 Nov 2019 12:20:28 -0500 (EST)
Date:   Mon, 11 Nov 2019 12:20:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Guiyao <guiyao@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "aceballos@gmail.com" <aceballos@gmail.com>,
        "vertaling@coevern.nl" <vertaling@coevern.nl>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGUy?= =?utf-8?Q?fsprogs=3A?=
 Check device id in advance to skip fake device name
Message-ID: <20191111172028.GE7017@mit.edu>
References: <005F77DB9A260B4E91664DDF22573C66E9D380C7@dggemm512-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005F77DB9A260B4E91664DDF22573C66E9D380C7@dggemm512-mbs.china.huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 11, 2019 at 02:43:46PM +0000, Guiyao wrote:
> 
> Actually, we found some insane system administrators, they not only do something like "mount -t tmpfs /dev/sdb /tmp ", but also they do " ln -s /dev/sdb abc ", then "resize2fs abc xxx". :(

So I don't consider ourselves necessarily obligated to twist ourselves
into knots for insane system administrators.  :-)

Did you test the patch that I sent out?  It handles that case already:

% grep /dev/loop /proc/mounts
/dev/loop0 /mnt2 tmpfs rw,relatime 0 0
/dev/loop0 /mnt ext4 rw,relatime 0 0
% ln -s /dev/loop0 abc
% ./tst_ismounted abc
Device abc reports flags 11
abc is apparently in use.
abc is mounted.
abc is mounted on /mnt2.

> So we have to add the fixing code in both sides of "name matched" and "name not matched".
> 
> For the compiling issue, it's my fault in previous patch, and added the macro in a wrong line.
> 
> So, I rewrote it again, and please give more advise. Thank you in advance.

Given that I have a patch which I've already tested, and which is a
substantial clean up in terms of removing #ifdef cases and number of
lines of code:

 lib/ext2fs/ismounted.c | 39 ++++++++++++---------------------------
  1 file changed, 12 insertions(+), 27 deletions(-)
  
I'm inclined to stick with mine.

But here's the quick review.

>  {
>     struct mntent   *mnt;
> +#ifndef __GNU__
> +   struct stat dir_st_buf;
> +#endif  /* __GNU__ */

Lots of extra #ifdef/#ifndef is undesirable.  As it turns out, it
isn't necessary to have a separate dir_st_buf at all.

> @@ -128,13 +131,32 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,
>     while ((mnt = getmntent (f)) != NULL) {
>         if (mnt->mnt_fsname[0] != '/')
>             continue;
> -       if (strcmp(file, mnt->mnt_fsname) == 0)
> +#ifndef __GNU__
> +       if (stat(mnt->mnt_dir, &dir_st_buf) != 0)
> +           continue;
> +#endif
> +       if (strcmp(file, mnt->mnt_fsname) == 0) {
> +#ifndef __GNU__
> +           if (file_rdev && (file_rdev != dir_st_buf.st_dev)) {

This doesn't need to be under #ifndef __GNU__.  In the GNU hurd case,
file_rdev will be zero, so the compiler will remove the if statement
for us, without needing an additional #ifndef __GNU__ test.

>         if (stat(mnt->mnt_fsname, &st_buf) == 0) {
>             if (ext2fsP_is_disk_device(st_buf.st_mode)) {
>  #ifndef __GNU__
> -               if (file_rdev && (file_rdev == st_buf.st_rdev))
> -                   break;
> +               if (file_rdev && (file_rdev == st_buf.st_rdev)) {
> +                   if (file_rdev == dir_st_buf.st_dev)
> +                       break;
> +               }
> +

The reason why this isn't necessary is because we're using stat, and
stat follows symlinks.  So when you do "ln -s /dev/sdb abc", and then
we stat abc, st_buf.st_rdev contains the device node of /dev/sbc, not
the symbolic link of abc.  So adding a check for dir_st_buf.st_dev is
not needed.

Cheers,

					- Ted
