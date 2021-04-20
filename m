Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5239365BE7
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhDTPJY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Apr 2021 11:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233036AbhDTPJK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Apr 2021 11:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7174361154;
        Tue, 20 Apr 2021 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618931318;
        bh=UnKHx0jMm2KKGmaF9fS86JmTi1vR+uKqn6jS5u70lV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhtzrey8BtnSE0aoA0EZt7pHfUxW6ujseqCMMiK5Rj7IBi5nZsqQI9h3sn76iLXAv
         OE+h3Lu4KytXNdozXrmn6sAW2rrPCTjmauPphqHq6Zx3oPH9YDu5qZa5bhRdMD2/Vq
         2jmtvdZaxYMH14SnOKnfK5s6r9Jgvl8bKIcOEozzfVvbbRAvTcAXbj3xxESwM9qlUh
         R52Z2T2HMy0G6clg3QlEXwmCMJSKkVSfduEHBzqSNJSXqkjyGYuXNg7saRDh4O1AJJ
         71xBL0bffy3+T9eO5FjwaK3gdUkkNqK4ccXVYr42xuEiWaC0MQUWByYawLZeoiJfBI
         nc5DHWA0WYBJQ==
Date:   Tue, 20 Apr 2021 08:08:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "harshad shirwadkar," <harshadshirwadkar@gmail.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] e2fsprogs: Try again to solve unreliable io case
Message-ID: <20210420150835.GA3122213@magnolia>
References: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 20, 2021 at 03:18:05PM +0800, Haotian Li wrote:
> If some I/O error occured during e2fsck, for example the
> fibre channel connections are flasky, the e2fsck may exit.
> Try again in these I/O error cases may help e2fsck
> successfully execute and fix the disk correctly.
> 
> We may try five times when io_channel_write/read failed.
> Enable this option by setting true on unreliable_io in
> configure file "e2fsck.conf".

Why not set 'io_max_retries = 5' in e2fsck.conf and feed that to the io
manager directly?  That would be more flexible than a boolean that
triggers a hardwired retry counter.

--D

> 
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  e2fsck/unix.c           |   7 +++
>  lib/ext2fs/ext2_io.h    |   3 ++
>  lib/ext2fs/ext2fs.h     |   2 +-
>  lib/ext2fs/io_manager.c | 102 ++++++++++++++++++++++++++++++----------
>  lib/ext2fs/openfs.c     |   2 +
>  lib/ext2fs/unix_io.c    |   4 ++
>  6 files changed, 93 insertions(+), 27 deletions(-)
> 
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index c5f9e441..faa2f77d 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -1398,6 +1398,7 @@ int main (int argc, char *argv[])
>  	int journal_size;
>  	int sysval, sys_page_size = 4096;
>  	int old_bitmaps;
> +	int unreliable_io;
>  	__u32 features[3];
>  	char *cp;
>  	enum quota_type qtype;
> @@ -1496,6 +1497,12 @@ restart:
>  			    &old_bitmaps);
>  	if (!old_bitmaps)
>  		flags |= EXT2_FLAG_64BITS;
> +
> +	profile_get_boolean(ctx->profile, "options", "unreliable_io", 0, 0,
> +			    &unreliable_io);
> +	if (unreliable_io)
> +		flags |= EXT2_FLAG_UNRELIABLE_IO;
> +
>  	if ((ctx->options & E2F_OPT_READONLY) == 0) {
>  		flags |= EXT2_FLAG_RW;
>  		if (!(ctx->mount_flags & EXT2_MF_ISROOT &&
> diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
> index 8fe5b323..38d23a1b 100644
> --- a/lib/ext2fs/ext2_io.h
> +++ b/lib/ext2fs/ext2_io.h
> @@ -34,8 +34,10 @@ typedef struct struct_io_stats *io_stats;
>  #define CHANNEL_FLAGS_DISCARD_ZEROES	0x02
>  #define CHANNEL_FLAGS_BLOCK_DEVICE	0x04
>  #define CHANNEL_FLAGS_THREADS		0x08
> +#define CHANNEL_FLAGS_UNRELIABLE_IO     0x10
> 
>  #define io_channel_discard_zeroes_data(i) (i->flags & CHANNEL_FLAGS_DISCARD_ZEROES)
> +#define UNRELIABLE_IO_RETRY_TIMES 5
> 
>  struct struct_io_channel {
>  	errcode_t	magic;
> @@ -107,6 +109,7 @@ struct struct_io_manager {
>  #define IO_FLAG_FORCE_BOUNCE	0x0008
>  #define IO_FLAG_THREADS		0x0010
>  #define IO_FLAG_NOCACHE		0x0020
> +#define IO_FLAG_UNRELIABLE_IO   0x0040
> 
>  /*
>   * Convenience functions....
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index df150f00..4ce5e311 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -207,7 +207,7 @@ typedef struct ext2_file *ext2_file_t;
>  #define EXT2_FLAG_BBITMAP_TAIL_PROBLEM	0x1000000
>  #define EXT2_FLAG_IBITMAP_TAIL_PROBLEM	0x2000000
>  #define EXT2_FLAG_THREADS		0x4000000
> -
> +#define EXT2_FLAG_UNRELIABLE_IO         0x8000000
>  /*
>   * Special flag in the ext2 inode i_flag field that means that this is
>   * a new inode.  (So that ext2_write_inode() can clear extra fields.)
> diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
> index 996c31a1..f062ef0a 100644
> --- a/lib/ext2fs/io_manager.c
> +++ b/lib/ext2fs/io_manager.c
> @@ -61,66 +61,116 @@ errcode_t io_channel_write_byte(io_channel channel, unsigned long offset,
>  				int count, const void *data)
>  {
>  	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> -
> -	if (channel->manager->write_byte)
> -		return channel->manager->write_byte(channel, offset,
> +	errcode_t ret = EXT2_ET_UNIMPLEMENTED;
> +       int retry_times = (channel->flags & CHANNEL_FLAGS_UNRELIABLE_IO) ?
> +               UNRELIABLE_IO_RETRY_TIMES : 0;
> +retry:
> +	if (channel->manager->write_byte) {
> +		ret = channel->manager->write_byte(channel, offset,
>  						    count, data);
> -
> -	return EXT2_ET_UNIMPLEMENTED;
> +		if (ret && retry_times) {
> +                        retry_times--;
> +                        goto retry;
> +               }
> +	}
> +	return ret;
>  }
> 
>  errcode_t io_channel_read_blk64(io_channel channel, unsigned long long block,
>  				 int count, void *data)
>  {
> -	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> -
> -	if (channel->manager->read_blk64)
> -		return (channel->manager->read_blk64)(channel, block,
> +       EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> +	errcode_t ret = 0;
> +	int retry_times = (channel->flags & CHANNEL_FLAGS_UNRELIABLE_IO) ?
> +		UNRELIABLE_IO_RETRY_TIMES : 0;
> +retry_read_blk64:
> +	if (channel->manager->read_blk64) {
> +		ret = (channel->manager->read_blk64)(channel, block,
>  						      count, data);
> +		if (ret && retry_times) {
> +			retry_times--;
> +			goto retry_read_blk64;
> +		}
> +		return ret;
> +	}
> 
>  	if ((block >> 32) != 0)
>  		return EXT2_ET_IO_CHANNEL_NO_SUPPORT_64;
> -
> -	return (channel->manager->read_blk)(channel, (unsigned long) block,
> +retry_read_blk:
> +	ret = (channel->manager->read_blk)(channel, (unsigned long) block,
>  					     count, data);
> +	if (ret && retry_times) {
> +		retry_times--;
> +               goto retry_read_blk;
> +       }
> +	return ret;
>  }
> 
> +
>  errcode_t io_channel_write_blk64(io_channel channel, unsigned long long block,
>  				 int count, const void *data)
>  {
>  	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> -
> -	if (channel->manager->write_blk64)
> -		return (channel->manager->write_blk64)(channel, block,
> +	errcode_t ret = 0;
> +       int retry_times = (channel->flags & CHANNEL_FLAGS_UNRELIABLE_IO) ?
> +                UNRELIABLE_IO_RETRY_TIMES : 0;
> +retry_write_blk64:
> +	if (channel->manager->write_blk64) {
> +		ret = (channel->manager->write_blk64)(channel, block,
>  						       count, data);
> +		if (ret && retry_times) {
> +                        retry_times--;
> +                        goto retry_write_blk64;
> +               }
> +               return ret;
> +        }
> 
>  	if ((block >> 32) != 0)
>  		return EXT2_ET_IO_CHANNEL_NO_SUPPORT_64;
> -
> -	return (channel->manager->write_blk)(channel, (unsigned long) block,
> +retry_write_blk:
> +	ret = (channel->manager->write_blk)(channel, (unsigned long) block,
>  					     count, data);
> +	if (ret && retry_times) {
> +               retry_times--;
> +               goto retry_write_blk;
> +       }
> +	return ret;
>  }
> 
>  errcode_t io_channel_discard(io_channel channel, unsigned long long block,
>  			     unsigned long long count)
>  {
>  	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> -
> -	if (channel->manager->discard)
> -		return (channel->manager->discard)(channel, block, count);
> -
> -	return EXT2_ET_UNIMPLEMENTED;
> +	errcode_t ret = EXT2_ET_UNIMPLEMENTED;
> +	int retry_times = (channel->flags & CHANNEL_FLAGS_UNRELIABLE_IO) ?
> +	                UNRELIABLE_IO_RETRY_TIMES : 0;
> +retry:
> +	if (channel->manager->discard) {
> +		ret = (channel->manager->discard)(channel, block, count);
> +		if (ret && retry_times) {
> +                       retry_times--;
> +                       goto retry;
> +               }
> +	}
> +	return ret;
>  }
> 
>  errcode_t io_channel_zeroout(io_channel channel, unsigned long long block,
>  			     unsigned long long count)
>  {
>  	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
> -
> -	if (channel->manager->zeroout)
> -		return (channel->manager->zeroout)(channel, block, count);
> -
> -	return EXT2_ET_UNIMPLEMENTED;
> +	errcode_t ret = EXT2_ET_UNIMPLEMENTED;
> +       int retry_times = (channel->flags & CHANNEL_FLAGS_UNRELIABLE_IO) ?
> +                        UNRELIABLE_IO_RETRY_TIMES : 0;
> +retry:
> +	if (channel->manager->zeroout) {
> +		ret = (channel->manager->zeroout)(channel, block, count);
> +		if (ret && retry_times) {
> +                        retry_times--;
> +                        goto retry;
> +               }
> +       }
> +	return ret;
>  }
> 
>  errcode_t io_channel_alloc_buf(io_channel io, int count, void *ptr)
> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
> index 5ec8ed5c..a98a5815 100644
> --- a/lib/ext2fs/openfs.c
> +++ b/lib/ext2fs/openfs.c
> @@ -172,6 +172,8 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
>  		io_flags |= IO_FLAG_DIRECT_IO;
>  	if (flags & EXT2_FLAG_THREADS)
>  		io_flags |= IO_FLAG_THREADS;
> +	if (flags & EXT2_FLAG_UNRELIABLE_IO)
> +		io_flags |= IO_FLAG_UNRELIABLE_IO;
>  	retval = manager->open(fs->device_name, io_flags, &fs->io);
>  	if (retval)
>  		goto cleanup;
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 64eee342..845a1e16 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -837,6 +837,10 @@ static errcode_t unix_open_channel(const char *name, int fd,
>  		}
>  	}
>  #endif
> +	if (flags & IO_FLAG_UNRELIABLE_IO) {
> +		io->flags |= CHANNEL_FLAGS_UNRELIABLE_IO;
> +	}
> +
>  	*channel = io;
>  	return 0;
> 
> -- 
> 2.23.0
> 
