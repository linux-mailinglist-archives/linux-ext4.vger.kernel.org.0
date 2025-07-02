Return-Path: <linux-ext4+bounces-8777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB8AF5CA5
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733AB483629
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF22DCF69;
	Wed,  2 Jul 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeONaxeP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A42DCF59
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469572; cv=none; b=JHzL6Pk8pHjxFfhVDAHZuTodp+jaqKG1m/kZFCNdHFq9AbnILIbchv8jCQVKB/Rtss+VKH88JGtDPo1KdXmzaOGHWD/m06t0t4nMznBoR7FAogCHIMtn7JWbmBEqgppWEuGyepFwQ0mB0XZq4XDynLDGKh7h6mMRu1vxT5m3UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469572; c=relaxed/simple;
	bh=1U18f2bEb2vq9llOGEpHm7fyT81yH9jNiVqN9kumo2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srlods9Ni4Ca5r+ndQGzbWyi84gD/PK393JRdlxETIq+EvQLX8Fq4cdzMYX1z/4c3Fj4TR1ugXm670tsot1duqk2b1VfQ25gZYqbfAf1VMXU2LV/5IODUNZxzkBuzLh/ikih1NCkb8qvCSoWDUBuuzbfxPWlatg5uy5bRUXxc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeONaxeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD031C4CEE7;
	Wed,  2 Jul 2025 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469570;
	bh=1U18f2bEb2vq9llOGEpHm7fyT81yH9jNiVqN9kumo2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeONaxePeZl6/f/8nVNQGlxJJH92/9vH4+ZXoXpbOYcDEFpJpsmqfCbgvObYywXIe
	 TAB1bKyuObc3IEYNqINVnsDrEo5fWFpN9oWW9fKYRPTdeuGL9QwxZx/Qh60f7r95MS
	 uVUTMQO8+/rI62V1pF2HfQqcuOsOqSgFdKesUmlM8W3VmJ0IBAWAXMijMO5TyPe96g
	 6zJJ5XBCkNPiGmwWI0IEBVIcyiijeeKTyNDAeOi2t3Tu4qcRX63k2VMC2bq9ALU1zw
	 SWzqSB0/fGq9d8C1lba03zqkZMpYx8zDDAdLR30zrLMTxMvGEtrApS5rOnk87sBqeY
	 hVgsIiYOyGRBA==
Date: Wed, 2 Jul 2025 08:19:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: zhanchengbin <zhanchengbin1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	qiangxiaojun@huawei.com, hejie3@huawei.com
Subject: Re: [PATCH v3] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
Message-ID: <20250702151930.GK9987@frogsfrogsfrogs>
References: <32252e29-aba9-df6f-3b97-d3774df375ad@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32252e29-aba9-df6f-3b97-d3774df375ad@huawei.com>

On Wed, Jul 02, 2025 at 11:46:15AM +0800, zhanchengbin wrote:
> When filesystem errors occur, inspect journal sequences with parameter t to
> dump commit timestamps.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
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
> index 324ed42..ce87419 100644
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

Heh, ok, I forgot that this is a debugfs subcommand so initializing this
to zero here is totally correct.  Sorry for that noise in v2 :)

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
> +	__be64		commit_sec;
> +	time_t		timestamp;
> +	char		time_buffer[26];
> +	char		*result;
> +
> +	header = (struct commit_header *)buf;
> +	commit_sec = be64_to_cpu(header->h_commit_sec);

Nit: be64_to_cpu returns host-endian values, so commit_sec should have
type uint64_t, not __be64.

> +
> +	timestamp = commit_sec;
> +	result = ctime_r(&timestamp, time_buffer);
> +	if (result == NULL) {
> +		exit (1);

A failed attempt to render the timestamp shouldn't abort all of debugfs.
I suggest:

	if (result)
		fprintf(out_file, ", commit at: %s", time_buffer);
	else
		fprintf(out_file, ", commit at: %llu", commit_sec);

So at least you get the raw output.

--D

> +	}
> +	fprintf(out_file, ", commit at: %s", time_buffer);
> +}
> 
>  static void dump_revoke_block(FILE *out_file, char *buf,
>  			      journal_superblock_t *jsb EXT2FS_ATTR((unused)),
> -- 
> 2.33.0
> 
> 
> 

