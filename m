Return-Path: <linux-ext4+bounces-8800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A675EAF7C89
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303A57A4DEA
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33DB1E4928;
	Thu,  3 Jul 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMjEbZNI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5F54654
	for <linux-ext4@vger.kernel.org>; Thu,  3 Jul 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557148; cv=none; b=QftEAdaKGWaRcRUQp+TS6VX1R7MbHXqARlKl2nAkB/4a4//DAb7qUTU3t+WpQ18OIyzQ2BUaPux8cxXWbvFrEkYpHMWAsLJygax5Gf8301Bbt8VVVtDn1URNtFdssYEbTQfWmCjsZYeE64ODSXEX13NM9B0XDRI9RwdROTXVYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557148; c=relaxed/simple;
	bh=zo1IBbkI0IzfZUdQbmjuwvdbxz5/SuHCr5KrkAR/g78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE0Te9xVF9QrlRVvsrC+W45y05Yd5HS/R56o/6ChPx3/7+r8hDjwqExSFxsnirSybx5LEV2DNsJuwkgBkQtPB2Fznybqry0pkvZGXaJR+ppTZ82fjJC2h6pfuIXBOTnp4AL+N+k+XkcIqW259zlNj3J2LhoYvsE5JFm8nqzG+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMjEbZNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BBC4CEE3;
	Thu,  3 Jul 2025 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751557148;
	bh=zo1IBbkI0IzfZUdQbmjuwvdbxz5/SuHCr5KrkAR/g78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMjEbZNIEGyNDIhkRAlMfzw/p2Jf8dWD9ub8pAXAGyBmoC5PstroyPxird39Suc+z
	 M7M+wkmD6J5iAbS9aEDMCgMKPzgxhtZDpNK22mkNHM2WU2h0kOOBKGrcRGDoem0r9t
	 vKjqQ0hTDTYd10ca5DYNTgadnqmbGt2OVGjG/kVQ9V6JApuYCcjuCvYUBNHA8mDsIC
	 0dqVA9CiUGAVUI3FNAhAHjBmJjKV5e7gtZyM+zsvHHN+bW7vh0Ivm5l+1SBjCrYh8l
	 W7HgGczKdZglLvXLOIiTiqVVcXC9dJJenfYxSkH62uLc5iFDWsJVaVtIEfH5edwzFJ
	 49gaz8wfvSl8g==
Date: Thu, 3 Jul 2025 08:39:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: zhanchengbin <zhanchengbin1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	qiangxiaojun@huawei.com, hejie3@huawei.com
Subject: Re: [PATCH v4] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
Message-ID: <20250703153907.GA2672022@frogsfrogsfrogs>
References: <f5445a3b-f278-6440-91f3-08e5ca5b93cf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5445a3b-f278-6440-91f3-08e5ca5b93cf@huawei.com>

On Thu, Jul 03, 2025 at 08:07:53PM +0800, zhanchengbin wrote:
> When filesystem errors occur, inspect journal sequences with parameter t to
> dump commit timestamps.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
> v4: (1) Fix incorrect variable type; (2) Add logging for error branches.
> - Link to v3:
> https://patchwork.ozlabs.org/project/linux-ext4/patch/32252e29-aba9-df6f-3b97-d3774df375ad@huawei.com/
> v3: Change from displaying UTC time to local time.
> - Link to v2:
> https://patchwork.ozlabs.org/project/linux-ext4/patch/5a4b703c-6940-d9da-5686-337e3220d3a4@huawei.com/
> v2: Correct abnormal formats in the patch.
> - Link to v1:
> https://patchwork.ozlabs.org/project/linux-ext4/patch/50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com/
> ---
>  debugfs/logdump.c | 61 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 324ed42..a1256c4 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL,
> JOURNAL_IS_EXTERNAL};
> 
>  #define ANY_BLOCK ((blk64_t) -1)
> 
> -static int		dump_all, dump_super, dump_old, dump_contents,
> dump_descriptors;
> +static int		dump_all, dump_super, dump_old, dump_contents,
> dump_descriptors, dump_time;
>  static int64_t		dump_counts;
>  static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
>  static unsigned int	group_to_dump, inode_offset_to_dump;
> @@ -67,6 +67,8 @@ static void dump_descriptor_block(FILE *, struct
> journal_source *,
>  				  char *, journal_superblock_t *,
>  				  unsigned int *, unsigned int, __u32, tid_t);
> 
> +static void dump_commit_time(FILE *out_file, char *buf);
> +
>  static void dump_revoke_block(FILE *, char *, journal_superblock_t *,
>  				  unsigned int, unsigned int, tid_t);
> 
> @@ -118,10 +120,11 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> EXT2FS_ATTR((unused)),
>  	inode_block_to_dump = ANY_BLOCK;
>  	inode_to_dump = -1;
>  	dump_counts = -1;
> +	dump_time = 0;
>  	wrapped_flag = false;
> 
>  	reset_getopt();
> -	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
> +	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:t")) != EOF) {
>  		switch (c) {
>  		case 'a':
>  			dump_all++;
> @@ -162,6 +165,9 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> EXT2FS_ATTR((unused)),
>  				return;
>  			}
>  			break;
> +		case 't':
> +			dump_time++;
> +			break;
>  		default:
>  			goto print_usage;
>  		}
> @@ -521,21 +527,33 @@ static void dump_journal(char *cmdname, FILE
> *out_file,
>  				break;
>  		}
> 
> -		if (dump_descriptors) {
> -			fprintf (out_file, "Found expected sequence %u, "
> -				 "type %u (%s) at block %u\n",
> -				 sequence, blocktype,
> -				 type_to_name(blocktype), blocknr);
> -		}
> -
>  		switch (blocktype) {
>  		case JBD2_DESCRIPTOR_BLOCK:
> +			if (dump_descriptors) {
> +				fprintf (out_file, "Found expected sequence %u, "
> +					 "type %u (%s) at block %u\n",
> +					 sequence, blocktype,
> +					 type_to_name(blocktype), blocknr);
> +			}
> +
>  			dump_descriptor_block(out_file, source, buf, jsb,
>  					      &blocknr, blocksize, maxlen,
>  					      transaction);
>  			continue;
> 
>  		case JBD2_COMMIT_BLOCK:
> +			if (dump_descriptors) {
> +				fprintf (out_file, "Found expected sequence %u, "
> +					 "type %u (%s) at block %u",
> +					 sequence, blocktype,
> +					 type_to_name(blocktype), blocknr);
> +			}
> +
> +			if (dump_time)
> +				dump_commit_time(out_file, buf);
> +			else
> +				fprintf(out_file, "\n");
> +
>  			cur_counts++;
>  			transaction++;
>  			blocknr++;
> @@ -543,6 +561,13 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  			continue;
> 
>  		case JBD2_REVOKE_BLOCK:
> +			if (dump_descriptors) {
> +				fprintf (out_file, "Found expected sequence %u, "
> +					 "type %u (%s) at block %u\n",
> +					 sequence, blocktype,
> +					 type_to_name(blocktype), blocknr);
> +			}
> +
>  			dump_revoke_block(out_file, buf, jsb,
>  					  blocknr, blocksize,
>  					  transaction);
> @@ -742,6 +767,24 @@ static void dump_descriptor_block(FILE *out_file,
>  	*blockp = blocknr;
>  }
> 
> +static void dump_commit_time(FILE *out_file, char *buf)
> +{
> +	struct commit_header	*header;
> +	uint64_t	commit_sec;
> +	time_t		timestamp;
> +	char		time_buffer[26];
> +	char		*result;
> +
> +	header = (struct commit_header *)buf;
> +	commit_sec = be64_to_cpu(header->h_commit_sec);
> +
> +	timestamp = commit_sec;
> +	result = ctime_r(&timestamp, time_buffer);
> +	if (result)
> +		fprintf(out_file, ", commit at: %s", time_buffer);

Nit: missing newline in this fprintf... or you could delete the newline
below and change the callsite to:

	if (dump_time)
		dump_commit_time(out_file, buf);
	fprintf(out_file, "\n");

> +	else
> +		fprintf(out_file, ", commit_sec is %llu\n", commit_sec);

Hm?

(Everything else in the patch looks ok to me)

--D

> +}
> 
>  static void dump_revoke_block(FILE *out_file, char *buf,
>  			      journal_superblock_t *jsb EXT2FS_ATTR((unused)),
> -- 
> 2.33.0
> 
> 

