Return-Path: <linux-ext4+bounces-8711-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3501AEE203
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0F216DF14
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193628D8D8;
	Mon, 30 Jun 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6sz9F+j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED528BA85
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296258; cv=none; b=R+qqTy2B5STcwrDDbSIAqn+uPI0YkhokdN5vFAjqC1WrgdAbHhynD1dLyzeRVnlJNcZ298fYC6Sse7E3NEQ/rDcaoYURoJdIZdYlaUBoan/jvAeLDkNgWFZUZ3DJ3BxwXQEs9bTT0FDCaUNzjztQZ6QNb3Zblw3UzAVbNqbDTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296258; c=relaxed/simple;
	bh=8PVX2tBDfo4ak/Suy/d1+pJVfjMnTZBSNKRjwFOG88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWVWALVenUPJquTPYtZUT7QswMmJ3/tHEl/MyXLwFAZHM2wcgj4pwS5Bgc/Txhgah7+TcFmc0gWDPfWCNkYJrA9c5w8fpDEUo5FkfOjqJYwvkPieVRPR0ZRmL9nujZBgoG8/rqwxj1LEQTbL3wcu2zhH9puj7VT1P4WfWA775PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6sz9F+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D2C4CEE3;
	Mon, 30 Jun 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296257;
	bh=8PVX2tBDfo4ak/Suy/d1+pJVfjMnTZBSNKRjwFOG88Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6sz9F+j8VurY6s20YVCQMLarYVo1GwpmkMffyHQuAjiXm2j9RvZ+Yt9I7dlbi1rc
	 R93y1R0oKinNOBHCc1ULNBYsufcI2WURIrttn71Qm7ZEPHUZAdzL3wKYASxmTHoeJp
	 kO+N9doPnSsuRP7Y5y0lvKs2GyaoD/0y1Q47NYcb3pGnCGqI6eF8G8ZhILO4p0FZTg
	 +kqAulwupY8NmjqCVbdXM935OvTorQA13FRS9RP5LjM0KRZ2F2QQjMq/z4a/LXYzN9
	 vF2s0Ub/daW9yTelF8JQN8R7Yr6+xHtJXCidCVxTkNzd/iVg/dP/Kd7alDEtYJVrQB
	 ADzxZLeVqXhBg==
Date: Mon, 30 Jun 2025 08:10:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: zhanchengbin <zhanchengbin1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	qiangxiaojun@huawei.com, hejie3@huawei.com
Subject: Re: [PATCH] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
Message-ID: <20250630151057.GA9987@frogsfrogsfrogs>
References: <50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com>

On Tue, Jun 17, 2025 at 07:31:35PM +0800, zhanchengbin wrote:
> When filesystem errors occur, inspect journal sequences with parameter t to
>  dump commit timestamps.
> 
> Signed-off-by: zhanchengbin <zhanchengbin@huawei.com>
> ---
>  debugfs/logdump.c | 63 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 324ed42..bbe1384 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL,
> JOURNAL_IS_EXTERNAL};
> 
>  #define ANY_BLOCK ((blk64_t) -1)
> 
> -static int        dump_all, dump_super, dump_old, dump_contents,
> dump_descriptors;
> +static int        dump_all, dump_super, dump_old, dump_contents,
> dump_descriptors, dump_time;
>  static int64_t        dump_counts;
>  static blk64_t        block_to_dump, bitmap_to_dump, inode_block_to_dump;
>  static unsigned int    group_to_dump, inode_offset_to_dump;
> @@ -67,6 +67,8 @@ static void dump_descriptor_block(FILE *, struct
> journal_source *,
>                    char *, journal_superblock_t *,
>                    unsigned int *, unsigned int, __u32, tid_t);
> 
> +static void dump_commit_time(FILE *out_file, char *buf);
> +
>  static void dump_revoke_block(FILE *, char *, journal_superblock_t *,
>                    unsigned int, unsigned int, tid_t);
> 
> @@ -118,10 +120,11 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> EXT2FS_ATTR((unused)),
>      inode_block_to_dump = ANY_BLOCK;
>      inode_to_dump = -1;
>      dump_counts = -1;
> +    dump_time = 0;

Globals are initialized to zero if not given an explicit value so this
isn't necessary.

>      wrapped_flag = false;
> 
>      reset_getopt();
> -    while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
> +    while ((c = getopt (argc, argv, "ab:ci:f:OsSn:t")) != EOF) {
>          switch (c) {
>          case 'a':
>              dump_all++;
> @@ -162,6 +165,9 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
> EXT2FS_ATTR((unused)),
>                  return;
>              }
>              break;
> +        case 't':
> +            dump_time++;
> +            break;
>          default:
>              goto print_usage;
>          }
> @@ -521,21 +527,33 @@ static void dump_journal(char *cmdname, FILE
> *out_file,
>                  break;
>          }
> 
> -        if (dump_descriptors) {
> -            fprintf (out_file, "Found expected sequence %u, "
> -                 "type %u (%s) at block %u\n",
> -                 sequence, blocktype,
> -                 type_to_name(blocktype), blocknr);
> -        }
> -
>          switch (blocktype) {
>          case JBD2_DESCRIPTOR_BLOCK:
> +            if (dump_descriptors) {
> +                fprintf (out_file, "Found expected sequence %u, "
> +                     "type %u (%s) at block %u\n",
> +                     sequence, blocktype,
> +                     type_to_name(blocktype), blocknr);
> +            }
> +
>              dump_descriptor_block(out_file, source, buf, jsb,
>                            &blocknr, blocksize, maxlen,
>                            transaction);
>              continue;
> 
>          case JBD2_COMMIT_BLOCK:
> +            if (dump_descriptors) {
> +                fprintf (out_file, "Found expected sequence %u, "
> +                     "type %u (%s) at block %u",
> +                     sequence, blocktype,
> +                     type_to_name(blocktype), blocknr);
> +            }

Why did the "Found expected sequence..." message get moved?

> +
> +            if (dump_time)
> +                dump_commit_time(out_file, buf);
> +
> +            fprintf(out_file, "\n");
> +
>              cur_counts++;
>              transaction++;
>              blocknr++;
> @@ -543,6 +561,13 @@ static void dump_journal(char *cmdname, FILE *out_file,
>              continue;
> 
>          case JBD2_REVOKE_BLOCK:
> +            if (dump_descriptors) {
> +                fprintf (out_file, "Found expected sequence %u, "
> +                     "type %u (%s) at block %u\n",
> +                     sequence, blocktype,
> +                     type_to_name(blocktype), blocknr);
> +            }
> +
>              dump_revoke_block(out_file, buf, jsb,
>                        blocknr, blocksize,
>                        transaction);
> @@ -742,6 +767,26 @@ static void dump_descriptor_block(FILE *out_file,
>      *blockp = blocknr;
>  }
> 
> +static void dump_commit_time(FILE *out_file, char *buf)
> +{
> +    struct commit_header    *header;
> +    __be64        commit_sec;
> +    time_t        timestamp;
> +    struct tm    timeinfo;
> +
> +    header = (struct commit_header*)buf;
> +    commit_sec = be64_to_cpu(header->h_commit_sec);
> +
> +    timestamp = commit_sec;
> +    gmtime_r(&timestamp, &timeinfo);
> +    fprintf(out_file, ", commit at UTC: %04d-%02d-%02d %02d:%02d:%02d",
> +        timeinfo.tm_year + 1900,
> +        timeinfo.tm_mon + 1,
> +        timeinfo.tm_mday,
> +        timeinfo.tm_hour,
> +        timeinfo.tm_min,
> +        timeinfo.tm_sec);

Use ctime_r() to get a locale-appropriate local timestamp string to
print out.  Or asctime_r() if you really need UTC.

--D

> +}
> 
>  static void dump_revoke_block(FILE *out_file, char *buf,
>                    journal_superblock_t *jsb EXT2FS_ATTR((unused)),
> -- 
> 2.33.0
> 

