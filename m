Return-Path: <linux-ext4+bounces-8810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC6AF860C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 05:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8FC1881B01
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1D35942;
	Fri,  4 Jul 2025 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut2qIcXi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906733E1
	for <linux-ext4@vger.kernel.org>; Fri,  4 Jul 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751600036; cv=none; b=RqLPMUxEOc2XZA1v0FX8qKaV4+tDgHCQAzRY2zVAjNiz50z92Edyz32xLIRemH5HRuanKMVJIqHSU4UwiIzCT9muvSXagd4ITPBNoJrOVcEEdoFNdI4D3GbhVUSNuu/TxEmUks5i221pgaJSlO1DxtqFmM26I1mRcDP7nndUeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751600036; c=relaxed/simple;
	bh=PovOhAki9/8FtTYb/L6mOtv7q295+My55XvuW+SvZm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUcVGwAySerJnIRhasPOjhfkHVNENXxV0H6DzgMwdw0t5JT5YazDV6UirW5q82huZk1BSAzyqBeCgH9+IOYf80rXS9+jOf0u2EneVhQPFCeAorDHJv/GLK5ceBnGTqIYzZmIN3ABf4r2F4RF5Y8zIJC6+zvUwufw1drImnyRtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut2qIcXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE6C4CEE3;
	Fri,  4 Jul 2025 03:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751600036;
	bh=PovOhAki9/8FtTYb/L6mOtv7q295+My55XvuW+SvZm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ut2qIcXiRYY7lFNaVHxKlHfEjhu+CE2FbpXyWZe11hOT68OIvEnC9cdF8h2qzsbhw
	 7Om2LILRQ+JV5sf6HXgX97wePvFSL26mw/Jvi7i5P1Zr/tY16NROUkT7ptM3zqmzci
	 ynRlQhGw39yLNX1PlibMvmMxcp3mdFkCgQrrlbYRA3tndBCEE3tgXOiTCJzPNqFZXz
	 h6NRcTQNzuKb8MEE4SFeI/gq8pQfr/AGKBzUAuSBGWl+B48zaFn/AnUxQv1LFujZeV
	 PcPdA8rm3aNym6UPW/U8j8cW6/mayE+5FZUhYZ3ndZc2UcpdC97MnUYkkhyIYvA7r+
	 X5fU1K2zUOgyQ==
Date: Thu, 3 Jul 2025 20:33:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: zhanchengbin <zhanchengbin1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	qiangxiaojun@huawei.com, hejie3@huawei.com
Subject: Re: [PATCH v4] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
Message-ID: <20250704033354.GA2672070@frogsfrogsfrogs>
References: <f5445a3b-f278-6440-91f3-08e5ca5b93cf@huawei.com>
 <20250703153907.GA2672022@frogsfrogsfrogs>
 <55e2c4b2-5ceb-7aa9-772b-a2dc1f2fdbaf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e2c4b2-5ceb-7aa9-772b-a2dc1f2fdbaf@huawei.com>

On Fri, Jul 04, 2025 at 10:11:09AM +0800, zhanchengbin wrote:
> On 2025/7/3 23:39, Darrick J. Wong wrote:
> > On Thu, Jul 03, 2025 at 08:07:53PM +0800, zhanchengbin wrote:
> > > When filesystem errors occur, inspect journal sequences with parameter t to
> > > dump commit timestamps.
> > > 
> > > Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> > > ---
> > > v4: (1) Fix incorrect variable type; (2) Add logging for error branches.
> > > - Link to v3:
> > > https://patchwork.ozlabs.org/project/linux-ext4/patch/32252e29-aba9-df6f-3b97-d3774df375ad@huawei.com/
> > > v3: Change from displaying UTC time to local time.
> > > - Link to v2:
> > > https://patchwork.ozlabs.org/project/linux-ext4/patch/5a4b703c-6940-d9da-5686-337e3220d3a4@huawei.com/
> > > v2: Correct abnormal formats in the patch.
> > > - Link to v1:
> > > https://patchwork.ozlabs.org/project/linux-ext4/patch/50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com/
> > > ---
> > >   debugfs/logdump.c | 61 ++++++++++++++++++++++++++++++++++++++++-------
> > >   1 file changed, 52 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> > > index 324ed42..a1256c4 100644
> > > --- a/debugfs/logdump.c
> > > +++ b/debugfs/logdump.c
> > > @@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL,
> > > JOURNAL_IS_EXTERNAL};
> > > 
> > >   #define ANY_BLOCK ((blk64_t) -1)
> > > 
> > > -static int		dump_all, dump_super, dump_old, dump_contents,
> > > dump_descriptors;
> > > +static int		dump_all, dump_super, dump_old, dump_contents,
> > > dump_descriptors, dump_time;
> > >   static int64_t		dump_counts;
> > >   static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
> > >   static unsigned int	group_to_dump, inode_offset_to_dump;
> > > @@ -67,6 +67,8 @@ static void dump_descriptor_block(FILE *, struct
> > > journal_source *,
> > >   				  char *, journal_superblock_t *,
> > >   				  unsigned int *, unsigned int, __u32, tid_t);
> > > 
> > > +static void dump_commit_time(FILE *out_file, char *buf);
> > > +
> > >   static void dump_revoke_block(FILE *, char *, journal_superblock_t *,
> > >   				  unsigned int, unsigned int, tid_t);
> > > 
> > > @@ -118,10 +120,11 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> > > EXT2FS_ATTR((unused)),
> > >   	inode_block_to_dump = ANY_BLOCK;
> > >   	inode_to_dump = -1;
> > >   	dump_counts = -1;
> > > +	dump_time = 0;
> > >   	wrapped_flag = false;
> > > 
> > >   	reset_getopt();
> > > -	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
> > > +	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:t")) != EOF) {
> > >   		switch (c) {
> > >   		case 'a':
> > >   			dump_all++;
> > > @@ -162,6 +165,9 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> > > EXT2FS_ATTR((unused)),
> > >   				return;
> > >   			}
> > >   			break;
> > > +		case 't':
> > > +			dump_time++;
> > > +			break;
> > >   		default:
> > >   			goto print_usage;
> > >   		}
> > > @@ -521,21 +527,33 @@ static void dump_journal(char *cmdname, FILE
> > > *out_file,
> > >   				break;
> > >   		}
> > > 
> > > -		if (dump_descriptors) {
> > > -			fprintf (out_file, "Found expected sequence %u, "
> > > -				 "type %u (%s) at block %u\n",
> > > -				 sequence, blocktype,
> > > -				 type_to_name(blocktype), blocknr);
> > > -		}
> > > -
> > >   		switch (blocktype) {
> > >   		case JBD2_DESCRIPTOR_BLOCK:
> > > +			if (dump_descriptors) {
> > > +				fprintf (out_file, "Found expected sequence %u, "
> > > +					 "type %u (%s) at block %u\n",
> > > +					 sequence, blocktype,
> > > +					 type_to_name(blocktype), blocknr);
> > > +			}
> > > +
> > >   			dump_descriptor_block(out_file, source, buf, jsb,
> > >   					      &blocknr, blocksize, maxlen,
> > >   					      transaction);
> > >   			continue;
> > > 
> > >   		case JBD2_COMMIT_BLOCK:
> > > +			if (dump_descriptors) {
> > > +				fprintf (out_file, "Found expected sequence %u, "
> > > +					 "type %u (%s) at block %u",
> > > +					 sequence, blocktype,
> > > +					 type_to_name(blocktype), blocknr);
> > > +			}
> > > +
> > > +			if (dump_time)
> > > +				dump_commit_time(out_file, buf);
> > > +			else
> > > +				fprintf(out_file, "\n");
> > > +
> > >   			cur_counts++;
> > >   			transaction++;
> > >   			blocknr++;
> > > @@ -543,6 +561,13 @@ static void dump_journal(char *cmdname, FILE *out_file,
> > >   			continue;
> > > 
> > >   		case JBD2_REVOKE_BLOCK:
> > > +			if (dump_descriptors) {
> > > +				fprintf (out_file, "Found expected sequence %u, "
> > > +					 "type %u (%s) at block %u\n",
> > > +					 sequence, blocktype,
> > > +					 type_to_name(blocktype), blocknr);
> > > +			}
> > > +
> > >   			dump_revoke_block(out_file, buf, jsb,
> > >   					  blocknr, blocksize,
> > >   					  transaction);
> > > @@ -742,6 +767,24 @@ static void dump_descriptor_block(FILE *out_file,
> > >   	*blockp = blocknr;
> > >   }
> > > 
> > > +static void dump_commit_time(FILE *out_file, char *buf)
> > > +{
> > > +	struct commit_header	*header;
> > > +	uint64_t	commit_sec;
> > > +	time_t		timestamp;
> > > +	char		time_buffer[26];
> > > +	char		*result;
> > > +
> > > +	header = (struct commit_header *)buf;
> > > +	commit_sec = be64_to_cpu(header->h_commit_sec);
> > > +
> > > +	timestamp = commit_sec;
> > > +	result = ctime_r(&timestamp, time_buffer);
> > > +	if (result)
> > > +		fprintf(out_file, ", commit at: %s", time_buffer);
> > 
> > Nit: missing newline in this fprintf... or you could delete the newline
> > below and change the callsite to:
> > 
> > 	if (dump_time)
> > 		dump_commit_time(out_file, buf);
> > 	fprintf(out_file, "\n");
> > 
> 
> In my test environment, the string generated by ctime_r comes with a
> newline character at the end.

Oh, I guess that /is/ in the manpage:

	Broken-down time is stored in the structure tm, described in
	tm(3type).

	The call ctime(t) is equivalent to asctime(localtime(t)).  It
	converts the calendar time t into a null-terminated string of
	the form

           "Wed Jun 30 21:49:08 1993\n"

and then POSIX has this to say about asctime():

	The asctime() function shall convert the broken-down time in the
	structure pointed to by timeptr into a string in the form:

	Sun Sep 16 01:03:52 1973\n\0

which is also in ISO C23:

	The asctime function converts the broken-down time in the
	structure pointed to by timeptr into a string in the form:

	Sun Sep 16 01:03:52 1973\n\0

	using the equivalent of the following algorithm.

Sigh.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> Thanks,
>  - bin.
> 
> > > +	else
> > > +		fprintf(out_file, ", commit_sec is %llu\n", commit_sec);
> > 
> > Hm?
> > 
> > (Everything else in the patch looks ok to me)
> > 
> > --D
> > 
> > > +}
> > > 
> > >   static void dump_revoke_block(FILE *out_file, char *buf,
> > >   			      journal_superblock_t *jsb EXT2FS_ATTR((unused)),
> > > -- 
> > > 2.33.0
> > > 
> > > 
> > 
> > .
> > 

