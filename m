Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8D10D0C8
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 05:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK2En3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Nov 2019 23:43:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39888 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK2En2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Nov 2019 23:43:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id n26so24643237edw.6
        for <linux-ext4@vger.kernel.org>; Thu, 28 Nov 2019 20:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqdB82PDk1aPHvXPJTP+tArND0SNQYY7vjCHcANExmk=;
        b=GA2KjSGLO9Da0WDcfWerQwQqaQsE3iXpK4OIevCpk8576eviSF7MK9RcQNiuXxMTnH
         2bJHLTGJdwTnRQcJYJsc0TaVk60SJbTd+MnFaeJ8ng/Mz+N+IryiB0HOGD8MFnk2UeIU
         GVIvdcdJOcLHC+Zu5CaWi5HD4b6XLN4HgcMxLOgmfVyQQzh2ZcuJieZlIbJhsQ1JNkwd
         3mrEiY8XdNsYqmdrlpOAUOcko8BCLtl2xBl1+l3/fmaj0gCjS56g9d6Oe7Vn8qSHyieD
         1+nKpuSiBJ0WwDZEYKmC1njl4fW5CuYXB2y5HGWtxlsfbaw7c5J3/jO7o6Bfa96Mt1oe
         g82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqdB82PDk1aPHvXPJTP+tArND0SNQYY7vjCHcANExmk=;
        b=PYq0LefWiizBt1p0KGquuNVMDCEtWc/mvRZiwX39ZQYWP22bsDGCgx/Uo/26+e8JIG
         t1kTdZzQ2UHJ7iuIJ9Pff5DWZsGyavRuKelV5w2ssID6/ihk7tJ8c+5TpeOrNs05AQ5L
         Zd9kabEItVFpnDjFVToy5Mi1ZmFn4iJQWivJJUtQE3j9OQiN4iZnGVqBaxGwY/hzRjOn
         Imgvms23GXq3mNFTkrfjGEWarG7jVdwndSmguVWfo2EFf/m9GasV8J1aSQgcJVTyZNG7
         +CScOunlkeaeqQd4dN47+MFYSpmsel9NlPCMCn/65LSHD6gBXT5bmyNO+iPVD8lKVnP6
         ThOA==
X-Gm-Message-State: APjAAAWY3UUzgGeFyOsiOTikhpvlcV6BBwLhuc68bfCiDqZeqBYpz4Fa
        FqAZ6oexw1h196FKPz9FfcbCdLUo4KbRU75nceUwytzi
X-Google-Smtp-Source: APXvYqzhjJ4RDy623+FTBIG3iRmZWXA5CnWxvxMsBYsoBMiT0jI4uZyl2QVbjAPQGb7pXoAwSb95W6pl+WN30QyKEGs=
X-Received: by 2002:aa7:dc0c:: with SMTP id b12mr42145403edu.186.1575002605600;
 Thu, 28 Nov 2019 20:43:25 -0800 (PST)
MIME-Version: 1.0
References: <CAAwBoOLoHTZGWFw5y_3MoMgZDQ3gCUQrsAO8Z=U4RwV9KyA_fA@mail.gmail.com>
 <20191128231947.GH22921@mit.edu>
In-Reply-To: <20191128231947.GH22921@mit.edu>
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Thu, 28 Nov 2019 23:43:14 -0500
Message-ID: <CAAwBoOKsQe7vdhs0hqHfZgV5LthKD2_ZnMLRQw6LTjTvO5vTQw@mail.gmail.com>
Subject: Re: potential data race on ext_inode_hdr(inode)->eh_depth,
 ext_inode_hdr(inode)->eh_max between a creat and unlink syscall
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

First, thank you for checking this out.

I hook every memory access in the kernel so I know that the [READ] and
[WRITE] are accessing to the exact same memory address. Plus, this
access cannot be from two malloc-ed inode because we replaced kfree
with a quarantine scheme like KASan so they two inodes will have to
have two different addresses. This is what confused me too.

In addition, just in case it may make a difference, there is an fsync
happening on another thread too. The three threads are like:

[Setup]
mkdir("foo", 511) = 0;
open("foo", 65536, 511) = 3;
creat("bar", 511) = 4;
symlink("foo", "sym_foo") = 0;
open("sym_foo", 65536, 511) = 5;
dup2(5, 195) = 195;

[Thread 0: fsync(195)]
[Thread 1: creat("bar", 438)]
[Thread 2: unlink("sym_foo")]

Or in orders observed at runtime:
Enter fsync(195);
Enter unlink("sym_foo");
Enter creat("bar", 438);

Exit unlink("sym_foo");
Exit creat("bar", 438);
Exit fsync(195);

I can provide more information (eg, other function calls on the trace
or memory access logs), if that would help in checking this case. And
I am sorry for wasting your time if this case does not make sense.

Best regards,
Meng

On Thu, Nov 28, 2019 at 6:19 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Nov 28, 2019 at 12:03:04PM -0500, Meng Xu wrote:
> > I notice a potential data race on ext_inode_hdr(inode)->eh_depth,
> > ext_inode_hdr(inode)->eh_max between a create and unlink syscall.
> > Following is the trace:
> >
> > [Setup]
> > mkdir("foo", 511) = 0;
> > open("foo", 65536, 511) = 3;
> > create("bar", 511) = 4;
> > symlink("foo", "sym_foo") = 0;
> > open("sym_foo", 65536, 511) = 5;
> >
> > [Thread 1]
> > create("bar", 438);
> >
> > __do_sys_creat
> >   ksys_open
> >     do_filp_open
> >       path_openat
> >         do_last
> >           handle_truncate
> >             do_truncate
> >               notify_change
> >                 ext4_setattr
> >                   ext4_truncate
> >                     ext4_ext_truncate
> >                       ext4_ext _remove_space
> >                         [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_depth = 0;
> >                         [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_max
> > = cpu_to_le16(ext4_ext_space_root(inode, 0));
> >
> > [Thread 2]
> > unlink("sym_foo");
> >
> > __do_sys_unlink
> >   do_unlinkat
> >     iput
> >       iput_final
> >         evict
> >           ext4_evict_inode
> >             ext4_orphan_del
> >               ext4_mark_iloc_dirty
> >                 ext4_do_update_inode
> >                   [READ, 4 bytes] raw_inode->i_block[block] = ei->i_data[block];
> >
> >
> > I could observe that the order between the READ and WRITE is not
> > deterministic and I was curious what will happen if the READ takes
> > place in the middle of the two WRITES? Does it cause any damages or
> > violations?
>
> This makes no sense.  The inodes corresponding to "sym_foo" and "bar"
> are completely differenth.  So why would there be a data race?
>
> How are you concluding that that there is, in fact, a data race?
>
>                                        - Ted
