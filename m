Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0E10CFEE
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Nov 2019 00:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1XTx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Nov 2019 18:19:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50164 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbfK1XTx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Nov 2019 18:19:53 -0500
Received: from callcc.thunk.org (97-71-153.205.biz.bhn.net [97.71.153.205] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xASNJltA029092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 18:19:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5487F421A46; Thu, 28 Nov 2019 18:19:47 -0500 (EST)
Date:   Thu, 28 Nov 2019 18:19:47 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Meng Xu <mengxu.gatech@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: potential data race on ext_inode_hdr(inode)->eh_depth,
 ext_inode_hdr(inode)->eh_max between a creat and unlink syscall
Message-ID: <20191128231947.GH22921@mit.edu>
References: <CAAwBoOLoHTZGWFw5y_3MoMgZDQ3gCUQrsAO8Z=U4RwV9KyA_fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAwBoOLoHTZGWFw5y_3MoMgZDQ3gCUQrsAO8Z=U4RwV9KyA_fA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 28, 2019 at 12:03:04PM -0500, Meng Xu wrote:
> I notice a potential data race on ext_inode_hdr(inode)->eh_depth,
> ext_inode_hdr(inode)->eh_max between a create and unlink syscall.
> Following is the trace:
> 
> [Setup]
> mkdir("foo", 511) = 0;
> open("foo", 65536, 511) = 3;
> create("bar", 511) = 4;
> symlink("foo", "sym_foo") = 0;
> open("sym_foo", 65536, 511) = 5;
> 
> [Thread 1]
> create("bar", 438);
> 
> __do_sys_creat
>   ksys_open
>     do_filp_open
>       path_openat
>         do_last
>           handle_truncate
>             do_truncate
>               notify_change
>                 ext4_setattr
>                   ext4_truncate
>                     ext4_ext_truncate
>                       ext4_ext _remove_space
>                         [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_depth = 0;
>                         [WRITE, 2 bytes] ext_inode_hdr(inode)->eh_max
> = cpu_to_le16(ext4_ext_space_root(inode, 0));
> 
> [Thread 2]
> unlink("sym_foo");
> 
> __do_sys_unlink
>   do_unlinkat
>     iput
>       iput_final
>         evict
>           ext4_evict_inode
>             ext4_orphan_del
>               ext4_mark_iloc_dirty
>                 ext4_do_update_inode
>                   [READ, 4 bytes] raw_inode->i_block[block] = ei->i_data[block];
> 
> 
> I could observe that the order between the READ and WRITE is not
> deterministic and I was curious what will happen if the READ takes
> place in the middle of the two WRITES? Does it cause any damages or
> violations?

This makes no sense.  The inodes corresponding to "sym_foo" and "bar"
are completely differenth.  So why would there be a data race?

How are you concluding that that there is, in fact, a data race?

    	    	       	    	       - Ted
