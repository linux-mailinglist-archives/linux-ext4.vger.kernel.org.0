Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88723D1DF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 22:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHEUHF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 16:07:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgHEQeG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1E01AC6E;
        Wed,  5 Aug 2020 14:15:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 011301E12CB; Wed,  5 Aug 2020 16:15:15 +0200 (CEST)
Date:   Wed, 5 Aug 2020 16:15:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mke2fs: Warn if fs block size is incompatible with DAX
Message-ID: <20200805141515.GB16475@quack2.suse.cz>
References: <20200709144057.21333-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709144057.21333-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 09-07-20 16:40:57, Jan Kara wrote:
> If we are creating filesystem on DAX capable device, warn if set block
> size is incompatible with DAX to give admin some hint why DAX might not
> be available.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Ping?

								Honza

> ---
>  configure.ac  |  3 +++
>  misc/mke2fs.c | 81 ++++++++++++++++++++++++++++++++++++++---------------------
>  2 files changed, 55 insertions(+), 29 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 18e434bc6ebc..7d9210740387 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1142,6 +1142,9 @@ if test -n "$BLKID_CMT"; then
>    AC_CHECK_LIB(blkid, blkid_probe_get_topology,
>  		      AC_DEFINE(HAVE_BLKID_PROBE_GET_TOPOLOGY, 1,
>  				[Define to 1 if blkid has blkid_probe_get_topology]))
> +  AC_CHECK_LIB(blkid, blkid_topology_get_dax,
> +		      AC_DEFINE(HAVE_BLKID_TOPOLOGY_GET_DAX, 1,
> +				[Define to 1 if blkid has blkid_topology_get_dax]))
>    AC_CHECK_LIB(blkid, blkid_probe_enable_partitions,
>  		      AC_DEFINE(HAVE_BLKID_PROBE_ENABLE_PARTITIONS, 1,
>  				[Define to 1 if blkid has blkid_probe_enable_partitions]))
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index c90dcf0e87c1..8c8f5ea467d3 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -1468,23 +1468,30 @@ int get_bool_from_profile(char **types, const char *opt, int def_val)
>  extern const char *mke2fs_default_profile;
>  static const char *default_files[] = { "<default>", 0 };
>  
> +struct device_param {
> +	unsigned long min_io;		/* prefered minimum IO size */
> +	unsigned long opt_io;		/* optimal IO size */
> +	unsigned long alignment_offset;	/* alignment offset wrt physical block size */
> +	unsigned int dax:1;		/* supports dax? */
> +};
> +
>  #ifdef HAVE_BLKID_PROBE_GET_TOPOLOGY
>  /*
>   * Sets the geometry of a device (stripe/stride), and returns the
>   * device's alignment offset, if any, or a negative error.
>   */
>  static int get_device_geometry(const char *file,
> -			       struct ext2_super_block *param,
> -			       unsigned int psector_size)
> +			       unsigned int blocksize,
> +			       unsigned int psector_size,
> +			       struct device_param *dev_param)
>  {
>  	int rc = -1;
> -	unsigned int blocksize;
>  	blkid_probe pr;
>  	blkid_topology tp;
> -	unsigned long min_io;
> -	unsigned long opt_io;
>  	struct stat statbuf;
>  
> +	memset(dev_param, 0, sizeof(*dev_param));
> +
>  	/* Nothing to do for a regular file */
>  	if (!stat(file, &statbuf) && S_ISREG(statbuf.st_mode))
>  		return 0;
> @@ -1497,23 +1504,20 @@ static int get_device_geometry(const char *file,
>  	if (!tp)
>  		goto out;
>  
> -	min_io = blkid_topology_get_minimum_io_size(tp);
> -	opt_io = blkid_topology_get_optimal_io_size(tp);
> -	blocksize = EXT2_BLOCK_SIZE(param);
> -	if ((min_io == 0) && (psector_size > blocksize))
> -		min_io = psector_size;
> -	if ((opt_io == 0) && min_io)
> -		opt_io = min_io;
> -	if ((opt_io == 0) && (psector_size > blocksize))
> -		opt_io = psector_size;
> -
> -	/* setting stripe/stride to blocksize is pointless */
> -	if (min_io > blocksize)
> -		param->s_raid_stride = min_io / blocksize;
> -	if (opt_io > blocksize)
> -		param->s_raid_stripe_width = opt_io / blocksize;
> -
> -	rc = blkid_topology_get_alignment_offset(tp);
> +	dev_param->min_io = blkid_topology_get_minimum_io_size(tp);
> +	dev_param->opt_io = blkid_topology_get_optimal_io_size(tp);
> +	if ((dev_param->min_io == 0) && (psector_size > blocksize))
> +		dev_param->min_io = psector_size;
> +	if ((dev_param->opt_io == 0) && dev_param->min_io > 0)
> +		dev_param->opt_io = dev_param->min_io;
> +	if ((dev_param->opt_io == 0) && (psector_size > blocksize))
> +		dev_param->opt_io = psector_size;
> +
> +	dev_param->alignment_offset = blkid_topology_get_alignment_offset(tp);
> +#ifdef HAVE_BLKID_TOPOLOGY_GET_DAX
> +	dev_param->dax = blkid_topology_get_dax(tp);
> +#endif
> +	rc = 0;
>  out:
>  	blkid_free_probe(pr);
>  	return rc;
> @@ -1562,6 +1566,7 @@ static void PRS(int argc, char *argv[])
>  	int		use_bsize;
>  	char		*newpath;
>  	int		pathlen = sizeof(PATH_SET) + 1;
> +	struct device_param dev_param;
>  
>  	if (oldpath)
>  		pathlen += strlen(oldpath);
> @@ -2307,17 +2312,35 @@ profile_error:
>  	}
>  
>  #ifdef HAVE_BLKID_PROBE_GET_TOPOLOGY
> -	retval = get_device_geometry(device_name, &fs_param,
> -				     (unsigned int) psector_size);
> +	retval = get_device_geometry(device_name, blocksize,
> +				     psector_size, &dev_param);
>  	if (retval < 0) {
>  		fprintf(stderr,
>  			_("warning: Unable to get device geometry for %s\n"),
>  			device_name);
> -	} else if (retval) {
> -		printf(_("%s alignment is offset by %lu bytes.\n"),
> -		       device_name, retval);
> -		printf(_("This may result in very poor performance, "
> -			  "(re)-partitioning suggested.\n"));
> +	} else {
> +		/* setting stripe/stride to blocksize is pointless */
> +		if (dev_param.min_io > blocksize)
> +			fs_param.s_raid_stride = dev_param.min_io / blocksize;
> +		if (dev_param.opt_io > blocksize) {
> +			fs_param.s_raid_stripe_width =
> +						dev_param.opt_io / blocksize;
> +		}
> +
> +		if (dev_param.alignment_offset) {
> +			printf(_("%s alignment is offset by %lu bytes.\n"),
> +			       device_name, dev_param.alignment_offset);
> +			printf(_("This may result in very poor performance, "
> +				  "(re)-partitioning suggested.\n"));
> +		}
> +
> +		if (dev_param.dax && blocksize != sys_page_size) {
> +			fprintf(stderr,
> +				_("%s is capable of DAX but current block size "
> +				  "%u is different from system page size %u so "
> +				  "filesystem will not support DAX.\n"),
> +				device_name, blocksize, sys_page_size);
> +		}
>  	}
>  #endif
>  
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
