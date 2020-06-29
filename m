Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1D20D608
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbgF2TQz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 15:16:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:63722 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731875AbgF2TQy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jun 2020 15:16:54 -0400
IronPort-SDR: 1g8gEhSaaWiUI1v1Uj2zOLNMhhc3kPsTv3XBqhH2vfek7peBzKv0XyXfL6s2+Sg4Gg8HcfV24m
 Ve8VWme8/MnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164006926"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="164006926"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 08:58:33 -0700
IronPort-SDR: sRLBBEXcVtjT9ztSBkn97HUnJU4v7w2EpoAjB7RkdorPP1Dv7J6ov4LWKt+waJNKQWCdtFzuhr
 UWEhP3mubGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="480838700"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 08:58:33 -0700
Date:   Mon, 29 Jun 2020 08:58:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     =?utf-8?B?5aec6L+O?= <jiangying8582@126.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix direct I/O read error
Message-ID: <20200629155832.GE2454695@iweiny-DESK2.sc.intel.com>
References: <7925c422.4205.172f9ae864d.Coremail.jiangying8582@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7925c422.4205.172f9ae864d.Coremail.jiangying8582@126.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 28, 2020 at 02:47:43PM +0800, 姜迎 wrote:
> From: jiangying8582 <jiangying8582@126.com>
> Date: Wed, 24 Jun 2020 19:02:34 +0800
> Subject: [PATCH] ext4: fix direct I/O read error
> 
> This patch is used to fix ext4 direct I/O read error when
> the read size is not alignment with block size. Compare the
> size between read offset with file size, if read offset is
> greater than file size, then return 0.
> 
> Then, I will use a test to explain the error.
> (1) Make the file that is not alignment wiht block size:
>         $dd if=/dev/zero of=./test.jar bs=1000 count=3
> 
> (2) I wrote a test script named "direct_io_read_file.c" s following:
> 
>         #include <stdio.h>
>         #include <stdlib.h>
>         #include <unistd.h>
>         #include <sys/file.h>
>         #include <sys/types.h>
>         #include <sys/stat.h>
>         #include <string.h>
>         #define BUF_SIZE 1024
> 
>         int main()
>         {
>                 int fd;
>                 int ret;
> 
>                 unsigned char *buf;
>                 ret = posix_memalign((void **)&buf, 512, BUF_SIZE);
>                 if (ret) {
>                         perror("posix_memalign failed");
>                         exit(1);
>                 }
>                 fd = open("./test.jar", O_RDONLY | O_DIRECT, 0755);
>                 if (fd < 0){
>                         perror("open ./test.jar failed");
>                         exit(1);
>                 }
> 
>                 do {
>                         ret = read(fd, buf, BUF_SIZE);
>                         printf("ret=%d\n",ret);
>                         if (ret < 0) {
>                                 perror("write test.jar failed");
>                         }
> 
>                 } while (ret > 0);
> 
>                 free(buf);
>                 close(fd);
>         }
> 
> (3) Compiling the script:
>         $gcc direct_io_read_file.c -D_GNU_SOURCE
> 
> (4) Exec the script:
>         $./a.out
> 
>     The result is as following:
>         ret=1024
>         ret=1024
>         ret=952
>         ret=-1
>         write rts-segmenter-0.3.7.2.jar failed: Invalid argument
> 
> I have tested this script on XFS filesystem, XFS does not have
> this problem, because XFS use iomap_dio_rw() to do direct I/O
> read. And the comparing between read offset and file size is done
> is iomap_dio_rw(), the code is as following:
>         if (pos < size) {
>                 retval = filemap_write_and_wait_range(mapping, pos,
>                                         pos + iov_length(iov, nr_segs) - 1);
>                 if (!retval) {
>                         retval = mapping->a_ops->direct_IO(READ, iocb,
>                                                 iov, pos, nr_segs);
>                 }
>                 ...
>         }
> Only when "pos < size", direct I/O can be done, or 0 will be return.
> 
> I have tested my fix patch, it is up to the mustard of EINVAL in
> man2(read) as following:
>         #include <unistd.h>
>         ssize_t read(int fd, void *buf, size_t count);
> 
>         EINVAL
>                 fd is attached to an object which is unsuitable for reading;
>                 or the file was opened with the O_DIRECT flag, and either the
>                 address specified in buf, the value specified in count, or the
>                 current file offset is not suitably aligned.
> So I think this patch can be applied to fix ext4 direct I/O problem.
> 
> Why this problem can happen? I think
> commit <9fe55eea7e4b> ("Fix race when checking i_size on direct i/o read")
> caused.

Looks like you need a 'Fixes' tag added.

> 
> However Ext4 introduces direct I/O read using iomap infrastructure
> on kernel 5.5, the patch is commit <b1b4705d54ab>
> ("ext4: introduce direct I/O read using iomap infrastructure"),
> then Ext4 will be the same as XFS, they all use iomap_dio_rw() to do direct
> I/O read. So this problem does not exist on kernel 5.5 for Ext4.
> 
> From above description, we can see this problem exists on all the kernel
> versions between kernel 3.14 and kernel 5.4. Please apply this patch
> on these kernel versions, or please use the method on kernel 5.5 to fix
> this problem. Thanks.

And looks like you need this marked stable as well.

Ira

> 
> Signed-off-by: jiangying8582 <jiangying8582@126.com>
> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa2..d514ff5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3821,6 +3821,12 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
>         struct inode *inode = mapping->host;
>         size_t count = iov_iter_count(iter);
>         ssize_t ret;
> +       loff_t offset = iocb->ki_pos;
> +       loff_t size;
> +
> +       size = i_size_read(inode);
> +       if (offset >= size)
> +               return 0;
> 
>         /*
>          * Shared inode_lock is enough for us - it protects against concurrent
> -- 
> 1.8.3.1
> 
