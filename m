Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B453BD95
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jun 2022 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiFBRwd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jun 2022 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFBRwa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jun 2022 13:52:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272F120B5
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jun 2022 10:52:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E01411F453CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654192348;
        bh=LBdCDYUVvo34HLgrsp83/hhRD4K+5Vu7cbydBhhrcIA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gu/JIY83Rhbg/D4jkfd/J9X5XxkcCI0qdwAmfHQisEQzsFvGy5vzaysEaPhIxfA/N
         9nV0HoVSopAfz74Wd6OH1yDwb94accHIdSafYbcx4QAJQ6QIWwNByKnWcOLAK3snC2
         rmKO/0we6THk3BP+PrLayDAisHie530fiFOT5NcPk1ao5QubhV9af9K/XPDuOFtjW8
         pYF0iP8CGZAfWNU4KUQg8CfVm5FLazR5ryyv9w+mgP7gIO9n+9sK8m2RRE47bml5lc
         e8HROMA1TWpJKFxOq4WqN1EaH5BfdoENfdQ9WfBo3vbC+8VdGxpQ4C99Vzz31kd2GR
         Y2ojXSbX2mIXQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: Always probe filesystem blocksize with simple
 io_manager
Organization: Collabora
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
        <YlniK5dd1wV2bCXi@mit.edu> <87pml4lt5v.fsf_-_@collabora.com>
Date:   Thu, 02 Jun 2022 13:52:24 -0400
In-Reply-To: <87pml4lt5v.fsf_-_@collabora.com> (Gabriel Krisman Bertazi's
        message of "Mon, 25 Apr 2022 18:01:00 -0400")
Message-ID: <87zgivrm07.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> "Theodore Ts'o" <tytso@mit.edu> writes:
>
>> So the failure of "e2fsck -f -C 0 -b 32768 -z /root/e2fsck.e2undo
>> /dev/md0" appears to be a bug where e2fsck doesn't work correctly with
>> an undo file when using a backup superblock.  I can replicate this
>> using these commands:
>>
>> 	mke2fs -q -t ext4 /tmp/foo.img 2G
>> 	e2fsck -b 32768 -z /tmp/undo /tmp/foo.img
>>
>> Running e2fsck without the -z option succeeds.  The combination of the
>> -b and -z option seems to be broken.  As a workaround, I would suggest
>> doing is to try running e2fsck with -n, which will open the block
>> device read-only, e.g. "e2fsck -b 32768 -n /dev/mdXX".  If the changes
>> e2fsck look safe, then you can run e2fsck without the -n option.
>
> Ted,
>
> I think this is a fix for the combination of -b and -z.
>

Hi Ted, any interest in picking this up?  quite a corner case of
e2fsprogs, but I think it simplifies that path a bit. :)

> Thanks,
>
>>8
>
> Combining superblock (-b) with undo file (-z) fails iff the block size
> is not specified (-B) and is different from the first blocksize probed
> in try_open_fs (1k).  The reason is as follows:
>
> try_open_fs will probe different blocksizes if none is provided on the
> command line. It is done by opening and closing the filesystem until it
> finds a blocksize that makes sense. This is fine for all io_managers,
> but undo_io creates the undo file with that blocksize during
> ext2fs_open.  Once try_open_fs realizes it had the wrong blocksize and
> retries with a different blocksize, undo_io will read the previously
> created file and think it's corrupt for this filesystem.
>
> Ideally, undo_io would know this is a probe and would fix the undo file.
> It is not simple, though, because it would require undo_io to know the
> file was just created by the probe code, since an undo file survives
> through different fsck sessions.  We'd have to pass this information
> around somehow.  This seems like a complex change to solve a corner
> case.
>
> Instead, this patch changes the blocksize probe to always use the
> unix_io_manager. This way, we safely probe for the blocksize without
> side effects.  Once the blocksize is known, we can safely reopen the
> filesystem under the proper io_manager.
>
> An easily reproducer for this issue (from Ted, adapted by me) is:
>
>  mke2fs -b 4k -q -t ext4 /tmp/foo.img 2G
>  e2fsck -b 32768 -z /tmp/undo /tmp/foo.img
>
> Reported-by: Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  e2fsck/unix.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index ae231f93deb7..341b484e6ede 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -1171,25 +1171,32 @@ static errcode_t try_open_fs(e2fsck_t ctx, int flags, io_manager io_ptr,
>  	errcode_t retval;
>  
>  	*ret_fs = NULL;
> -	if (ctx->superblock && ctx->blocksize) {
> -		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
> -				      flags, ctx->superblock, ctx->blocksize,
> -				      io_ptr, ret_fs);
> -	} else if (ctx->superblock) {
> -		int blocksize;
> -		for (blocksize = EXT2_MIN_BLOCK_SIZE;
> -		     blocksize <= EXT2_MAX_BLOCK_SIZE; blocksize *= 2) {
> -			if (*ret_fs) {
> -				ext2fs_free(*ret_fs);
> -				*ret_fs = NULL;
> +
> +	if (ctx->superblock) {
> +		unsigned long blocksize = ctx->blocksize;
> +
> +		if (!blocksize) {
> +			for (blocksize = EXT2_MIN_BLOCK_SIZE;
> +			     blocksize <= EXT2_MAX_BLOCK_SIZE; blocksize *= 2) {
> +
> +				retval = ext2fs_open2(ctx->filesystem_name,
> +						      ctx->io_options, flags,
> +						      ctx->superblock, blocksize,
> +						      unix_io_manager, ret_fs);
> +				if (*ret_fs) {
> +					ext2fs_free(*ret_fs);
> +					*ret_fs = NULL;
> +				}
> +				if (!retval)
> +					break;
>  			}
> -			retval = ext2fs_open2(ctx->filesystem_name,
> -					      ctx->io_options, flags,
> -					      ctx->superblock, blocksize,
> -					      io_ptr, ret_fs);
> -			if (!retval)
> -				break;
> +			if (retval)
> +				return retval;
>  		}
> +
> +		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
> +				      flags, ctx->superblock, blocksize,
> +				      io_ptr, ret_fs);
>  	} else
>  		retval = ext2fs_open2(ctx->filesystem_name, ctx->io_options,
>  				      flags, 0, 0, io_ptr, ret_fs);

-- 
Gabriel Krisman Bertazi
