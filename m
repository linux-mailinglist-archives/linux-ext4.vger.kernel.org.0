Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147626B5806
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Mar 2023 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCKDTG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 22:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKDTF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 22:19:05 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA8F34D6
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 19:19:03 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32B3IhlV019914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 22:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678504726; bh=X4SZPPPjSfymhSVu5DOfCp8XWFcI0/91jN3YaYnh/AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=inJyC4xtFBH9CwaQZxr2uT733jlfDXRzFuOBxpU4u+x/PEmIohblrJ+8FMMZjMKka
         VNuwM8LZRZD/xsIvyR7z6rtiC6XAhOAon/6X9GYsmJROp3I4FZQLrgLz3W7249nKCh
         S33LO4qyQ3m3cGdWVHlueO/kKNGNFpOxgvt5rVT4HGvlyp8MrRb0nstxNNj9V3zy8C
         eX+ZXY93IqG+UmRah8WBnYeeIjCPp2wZy+0dLCJtVXeFxRsJETOJdOA8uAmm+pOFS7
         xbDM7LSqSMXNVaFO+pRVelDnQlNWdbZmn8A6QJEcW7pSaHEkUCDnpPO8VgAVWFmeQz
         eywN6d83PkPew==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A805F15C42F6; Fri, 10 Mar 2023 22:18:43 -0500 (EST)
Date:   Fri, 10 Mar 2023 22:18:43 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chao Yu <chao@kernel.org>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH] ext4: fix to report fstrim.minlen back to userspace
Message-ID: <20230311031843.GF860405@mit.edu>
References: <20230308011807.411478-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308011807.411478-1-chao@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 08, 2023 at 09:18:07AM +0800, Chao Yu wrote:
> Quoted from manual of fstrim:
> 
> "-m, --minimum minimum-size
> 	..., if it's smaller than the device's minimum, and report that
> (fstrim_range.minlen) back to userspace."

First of all, I'll note that the fstrim(8) man page, which is
describing how the userspace fstrim application work, is a really
weird place to put information about how the fstrim _ioctl_ works.

I've added Lukas, who is listed as one of the authors of fstrim, and
who probably had a hand in writing the man page.  The text in that
paragraph describing -m is extremely confusing, and probably needs to
be rewritten, and factored out into a fstrim(8) for system
adminsitrators, and ioctl_fitrim(2) which documents the the ioctl.

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..bd3ef29cf8a6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6491,6 +6491,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  				discard_granularity >> sb->s_blocksize_bits);
>  		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
>  			goto out;
> +
> +		/* Report adjusted minlen back to userspace */
> +		range->minlen = minlen;
>  	}

Unfortunately, this patch is not correct.  The units of struct
fstrim_range's minlen (here, range->minlen) is bytes.

However the minlen variable in ext4_trim_fs is in units of *clusters*.
And so it gets rounded up two places.  The first time is when it is
converted into units of a cluster:

	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
			      range->minlen >> sb->s_blocksize_bits);

And the second time is when it is rounded up to the block device's
discard granularity.

So after that if statement, we need to convert minlen from clusters to
bytes, like so:

	range->minlen = EXT4_C2B(EXT4_SB(sb), minlen) << sb->s_blocksize_bits);

Oh, and by the way, that first conversion is not correct as currently
written in ext4_fs_trim().   It should be

	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
		(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));

The explanation of why

	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
			      range->minlen >> sb->s_blocksize_bits);

is wrong is left as an exercise to the reader.  (Hint: what is
supposed to happen if a value of 1 byte is passed in
fstrim_range.minlen?)

Cheers,

					- Ted
