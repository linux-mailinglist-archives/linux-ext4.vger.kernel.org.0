Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784B3234DD5
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Aug 2020 00:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGaW4X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 18:56:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgGaW4W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 31 Jul 2020 18:56:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 384ACAB9F;
        Fri, 31 Jul 2020 22:56:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A41E41E12CB; Sat,  1 Aug 2020 00:56:21 +0200 (CEST)
Date:   Sat, 1 Aug 2020 00:56:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     rebello.anthony@gmail.com
Subject: Data exposure on IO error
Message-ID: <20200731225621.GA7126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

In bug 207729, Anthony reported a bug that can actually lead to a stale
data exposure on IO error. The problem is relatively simple: Suppose we
do:

  fd = open("file", O_WRONLY | O_CREAT | O_TRUNC, 0644);
  write(fd, buf, 4096);
  fsync(fd);

And IO error happens when fsync writes the block of "file". The IO error
gets properly reported to userspace but otherwise the filesystem keeps
running. So the transaction creating "file" and allocating block to it can
commit. Then when page cache of "file" gets evicted, the user can read
stale block contents (provided the IO error was just temporary or involving
only writes).

Now I understand in face of IO errors the behavior is really undefined but
potential exposure of stale data seems worse than strictly necessary. Also
if we run in data=ordered mode, especially if also data_err=abort is set,
user would rightfully expect that the filesystem gets aborted when such IO
error happens but that's not the case. Generally data_err=abort seems a bit
misnamed (and the manpage is wrong about this mount option) since what it
really does is that if jbd2 thread encounters error when writing back
ordered data, the filesystem is aborted. However the ordered data can be
written back by other processes as well and in that case the error is just
lost / reported to userspace but the filesystem doesn't get aborted.

As I was thinking about it, it seems to me that in data=ordered mode, we
should just always abort the filesystem when writeback of newly allocated
block fails to avoid the stale data exposure mentioned above. And then, we
could just deprecate data_err= mount option because it wouldn't be any
useful anymore... What do people think?

								Honza

[1] https://bugzilla.kernel.org/show_bug.cgi?id=207729
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
