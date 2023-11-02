Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282547DEF86
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbjKBKIz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 06:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbjKBKIx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 06:08:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62A136;
        Thu,  2 Nov 2023 03:08:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91A8F219D7;
        Thu,  2 Nov 2023 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698919724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsbHNsMbfhoTRCwzDvCjMOcypitr1Q8y92FNQVrgWfg=;
        b=grBBTWxg5BME0R6Tu2BulpWH5XSjwHn1vp2OoFPNtf9flpmDWdFLB+m1moLEh1iKruTdDf
        KVPqlZCUljod7aMc2lYQ+/7Tb/8NfOEsYm+OqRxs443i1czd683kTsihrqE2WHIWr82pmK
        Me8FyDPtBn4Sv49b8bktKgAr6IVyTK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698919724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsbHNsMbfhoTRCwzDvCjMOcypitr1Q8y92FNQVrgWfg=;
        b=4gYfgycFG/zpkor052AeYje+IpLZhkWcpJK7MZkQOfdBJhGaaM8XrXxn2X2LrLk7AuzEsh
        48zgfYOyjZz4yBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8064213584;
        Thu,  2 Nov 2023 10:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NJpPHyx1Q2W7fgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 02 Nov 2023 10:08:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 05A5AA06E3; Thu,  2 Nov 2023 11:08:43 +0100 (CET)
Date:   Thu, 2 Nov 2023 11:08:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/2] ext4: treat end of range as exclusive in
 ext4_zero_range()
Message-ID: <20231102100843.c3byjojrzd62g2di@quack3>
References: <cover.1698856309.git.ojaswin@linux.ibm.com>
 <e503107a7c73a2b68dec645c5ad798c437717c45.1698856309.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e503107a7c73a2b68dec645c5ad798c437717c45.1698856309.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-11-23 22:08:10, Ojaswin Mujoo wrote:
> The call to filemap_write_and_wait_range() assumes the range passed to be
> inclusive, so fix the call to make sure we follow that.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 880f383df684..265ae30a51b9 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4522,7 +4522,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	 * Round up offset. This is not fallocate, we need to zero out
>  	 * blocks, so convert interior block aligned part of the range to
>  	 * unwritten and possibly manually zero out unaligned parts of the
> -	 * range.
> +	 * range. Here, start and partial_begin are inclusive, end and
> +	 * partial_end are exclusive.
>  	 */
>  	start = round_up(offset, 1 << blkbits);
>  	end = round_down((offset + len), 1 << blkbits);
> @@ -4608,7 +4609,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		 * disk in case of crash before zeroing trans is committed.
>  		 */
>  		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start, end);
> +			ret = filemap_write_and_wait_range(mapping, start,
> +							   end - 1);
>  			if (ret) {
>  				filemap_invalidate_unlock(mapping);
>  				goto out_mutex;
> -- 
> 2.39.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
