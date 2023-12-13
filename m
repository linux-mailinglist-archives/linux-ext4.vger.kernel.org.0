Return-Path: <linux-ext4+bounces-429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD19810D5D
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 10:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DCF281746
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A1200DA;
	Wed, 13 Dec 2023 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFvemXLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1B1tCJxI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpR1VS5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8u+CRDT7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A7D5;
	Wed, 13 Dec 2023 01:27:42 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D79071FD42;
	Wed, 13 Dec 2023 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702459661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrOl+eoYRZqzUPXxqHI+9Z2AX8/dXg0cgxXIwK8DDv4=;
	b=VFvemXLo629tPCuIYNRBZ/XSV+Jp/pyfnJvCJ/RhE+N/p3jJJ7tbycmouDbzhell8yLF+Q
	1WgB2GPPhgNbiaVyrkFo6umETjGTow2moLa2iobwR7rxXdpWDpL93EutEjN5HfCm6eEqlf
	JsRbXd+q2BabgDJ735eNXiFgasfB498=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702459661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrOl+eoYRZqzUPXxqHI+9Z2AX8/dXg0cgxXIwK8DDv4=;
	b=1B1tCJxInt+13rs5oBAZV6YLFHpVhVDVCYUcHhLTFLd/luC6TW8nYlOPuHL+xkjSTCxlUe
	zEZ77S35s2p3Y4Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702459660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrOl+eoYRZqzUPXxqHI+9Z2AX8/dXg0cgxXIwK8DDv4=;
	b=TpR1VS5H5nXhddpoXWhesVJwoEAESVO+VUEHpe8h8r/vncos4CkEqoZBJz4mHG8X3uGmu0
	x/2uPqopvKKVAM43h5PpibGyv+xZ05qFiENlyJItYAn1dOhndQzRKUXtm6N6Kw5XPs7zl6
	JCXm/sB1OfaFpZE7UjBjJxXJqDNydUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702459660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrOl+eoYRZqzUPXxqHI+9Z2AX8/dXg0cgxXIwK8DDv4=;
	b=8u+CRDT7zaL+bxV3MIAYznIEotLGpRgj4958+NQ87j+RQ7ah8fyZMndTnKbw6ryn/9goWW
	rKbyBVaDq3k2q1BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C3B5B13240;
	Wed, 13 Dec 2023 09:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TFjELwx5eWXYYAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 09:27:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3559BA07E0; Wed, 13 Dec 2023 10:27:40 +0100 (CET)
Date: Wed, 13 Dec 2023 10:27:40 +0100
From: Jan Kara <jack@suse.cz>
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	sjitindarsingh@smail.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: Allow for the last group to be marked as trimmed
Message-ID: <20231213092740.2q3lwn45hpmtqoxu@quack3>
References: <20231213051635.37731-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213051635.37731-1-surajjs@amazon.com>
X-Spam-Level: 
X-Spam-Score: -0.60
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.60
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 13-12-23 16:16:35, Suraj Jitindar Singh wrote:
> The ext4 filesystem tracks the trim status of blocks at the group level.
> When an entire group has been trimmed then it is marked as such and subsequent
> trim invocations with the same minimum trim size will not be attempted on that
> group unless it is marked as able to be trimmed again such as when a block is
> freed.
> 
> Currently the last group can't be marked as trimmed due to incorrect logic
> in ext4_last_grp_cluster(). ext4_last_grp_cluster() is supposed to return the
> zero based index of the last cluster in a group. This is then used by
> ext4_try_to_trim_range() to determine if the trim operation spans the entire
> group and as such if the trim status of the group should be recorded.
> 
> ext4_last_grp_cluster() takes a 0 based group index, thus the valid values
> for grp are 0..(ext4_get_groups_count - 1). Any group index less than
> (ext4_get_groups_count - 1) is not the last group and must have
> EXT4_CLUSTERS_PER_GROUP(sb) clusters. For the last group we need to calculate
> the number of clusters based on the number of blocks in the group. Finally
> subtract 1 from the number of clusters as zero based indexing is expected.
> Rearrange the function slightly to make it clear what we are calculating
> and returning.
> 
> Reproducer:
> // Create file system where the last group has fewer blocks than blocks per group
> $ mkfs.ext4 -b 4096 -g 8192 /dev/nvme0n1 8191
> $ mount /dev/nvme0n1 /mnt
> 
> Before Patch:
> $ fstrim -v /mnt
> /mnt: 25.9 MiB (27156480 bytes) trimmed
> // Group not marked as trimmed so second invocation still discards blocks
> $ fstrim -v /mnt
> /mnt: 25.9 MiB (27156480 bytes) trimmed
> 
> After Patch:
> fstrim -v /mnt
> /mnt: 25.9 MiB (27156480 bytes) trimmed
> // Group marked as trimmed so second invocation DOESN'T discard any blocks
> fstrim -v /mnt
> /mnt: 0 B (0 bytes) trimmed
> 
> Fixes: 45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
> Cc: stable@vger.kernel.org # 4.19+
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>

Indeed. The fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 454d5612641ee..c15d8b6f887dd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6731,11 +6731,16 @@ __acquires(bitlock)
>  static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
>  					   ext4_group_t grp)
>  {
> -	if (grp < ext4_get_groups_count(sb))
> -		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
> -	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
> -		ext4_group_first_block_no(sb, grp) - 1) >>
> -					EXT4_CLUSTER_BITS(sb);
> +	unsigned long nr_clusters_in_group;
> +
> +	if (grp < (ext4_get_groups_count(sb) - 1))
> +		nr_clusters_in_group = EXT4_CLUSTERS_PER_GROUP(sb);
> +	else
> +		nr_clusters_in_group = (ext4_blocks_count(EXT4_SB(sb)->s_es) -
> +					ext4_group_first_block_no(sb, grp))
> +				       >> EXT4_CLUSTER_BITS(sb);
> +
> +	return nr_clusters_in_group - 1;
>  }
>  
>  static bool ext4_trim_interrupted(void)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

