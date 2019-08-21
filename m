Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4992D97E62
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfHUPRP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Aug 2019 11:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUPRP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Aug 2019 11:17:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 876333001A9A
        for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2019 15:17:14 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF1E76D0BD;
        Wed, 21 Aug 2019 15:17:10 +0000 (UTC)
Reply-To: sandeen@redhat.com
Subject: Re: [PATCH 2/2] tune2fs: Warn if page size != blocksize when enabling
 encrypt
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
References: <20190821131813.9456-1-lczerner@redhat.com>
 <20190821131813.9456-2-lczerner@redhat.com>
From:   Eric Sandeen <esandeen@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=esandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <c790aa59-7686-09e2-1066-92bec97704cd@redhat.com>
Date:   Wed, 21 Aug 2019 10:17:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821131813.9456-2-lczerner@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 21 Aug 2019 15:17:14 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/21/19 8:18 AM, Lukas Czerner wrote:
> With encrypt feature enabled the file system block size must match
> system page size. Currently tune2fs will not complain at all when we try
> to enable encrypt on a file system that does not satisfy this
> requirement for the system. Add a warning for this case.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  misc/tune2fs.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 7d2d38d7..26b1b1d0 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -130,6 +130,8 @@ void do_findfs(int argc, char **argv);
>  int journal_enable_debug = -1;
>  #endif
>  
> +static int sys_page_size = 4096;
> +
>  static void usage(void)
>  {
>  	fprintf(stderr,
> @@ -1407,6 +1409,29 @@ mmp_error:
>  			      stderr);
>  			return 1;
>  		}
> +
> +		/*
> +		 * When encrypt feature is enabled, the file system blocksize
> +		 * needs to match system page size otherwise the file system
> +		 * won't mount.
> +		 */
> +		if (fs->blocksize != sys_page_size) {
> +			if (!f_flag) {
> +				com_err(program_name, 0,
> +					_("Block size (%dB) does not match "
> +					  "system page size (%dB). File "
> +					  "system won't be usable on this "
> +					  "system"),

I wonder if this message should explicitly mention the encryption option, right
now it doesn't give a lot of context as to why this is being printed.

Perhaps "Encryption feature requested, but block size (%dB) does not match ...?"

-Eric

> +					fs->blocksize, sys_page_size);
> +				proceed_question(-1);
> +			}
> +			fprintf(stderr,_("Warning: Encrypt feature enabled, "
> +					 "but block size (%dB) does not match "
> +					 "system page size (%dB), forced to "
> +					 "cointinue\n"),
> +				fs->blocksize, sys_page_size);
> +		}
> +
>  		fs->super->s_encrypt_algos[0] =
>  			EXT4_ENCRYPTION_MODE_AES_256_XTS;
>  		fs->super->s_encrypt_algos[1] =
> @@ -2844,6 +2869,7 @@ int main(int argc, char **argv)
>  int tune2fs_main(int argc, char **argv)
>  #endif  /* BUILD_AS_LIB */
>  {
> +	long sysval;
>  	errcode_t retval;
>  	ext2_filsys fs;
>  	struct ext2_super_block *sb;
> @@ -2879,6 +2905,18 @@ int tune2fs_main(int argc, char **argv)
>  #endif
>  		io_ptr = unix_io_manager;
>  
> +	/* Determine the system page size if possible */
> +#ifdef HAVE_SYSCONF
> +#if (!defined(_SC_PAGESIZE) && defined(_SC_PAGE_SIZE))
> +#define _SC_PAGESIZE _SC_PAGE_SIZE
> +#endif
> +#ifdef _SC_PAGESIZE
> +	sysval = sysconf(_SC_PAGESIZE);
> +	if (sysval > 0)
> +		sys_page_size = sysval;
> +#endif /* _SC_PAGESIZE */
> +#endif /* HAVE_SYSCONF */
> +
>  retry_open:
>  	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
>  		open_flag |= EXT2_FLAG_SKIP_MMP;
> 
