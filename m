Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAE7CFD7C
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbjJSPBN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjJSPBM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 11:01:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF4612D;
        Thu, 19 Oct 2023 08:01:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACAA81F38C;
        Thu, 19 Oct 2023 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697727668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SADzQbXtqkn9LOo3Wunl1TnxEcgZDEc3CMwdG9777M=;
        b=jMZr9lKq+QJOvrSVspMNHHG/bGyg90ankhdpBioWXjc14b31w1WCMAypaFHGGG8qp4+c2f
        5iGpfQbZegdEdrBhtAvB/qPzjd9vDKuYIPE9DrO7kPt7tjWIbtETMCmI+YUB7pm0raBqkg
        hOzKHbl+6lQ42HLDPm4wZfvI/rswDqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697727668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SADzQbXtqkn9LOo3Wunl1TnxEcgZDEc3CMwdG9777M=;
        b=14zUj++VCY0+amgmyGpQ0O8k26TB12OZih5Ckngf4GgXRpZS5ekUkeBAeolDV8EookLgaC
        FM9cCRBYfAw17dBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C0A51357F;
        Thu, 19 Oct 2023 15:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BqkIJrREMWX3FAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 15:01:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 10357A0550; Thu, 19 Oct 2023 17:01:08 +0200 (CEST)
Date:   Thu, 19 Oct 2023 17:01:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/3] ext4: treat end of range as exclusive in
 ext4_zero_range()
Message-ID: <20231019150108.mwzinguhn6zxrzbu@quack3>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
 <9ae3bf53e81554cec3e609de8e8939b90966f7ab.1695987265.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae3bf53e81554cec3e609de8e8939b90966f7ab.1695987265.git.ojaswin@linux.ibm.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,suse.cz]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 29-09-23 19:40:43, Ojaswin Mujoo wrote:
> The call to filemap_write_and_wait_range() assumes the range passed to be
> inclusive, so fix the call to make sure we follow that.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Yes, makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e4115d338f10..c79b4c25afc4 100644
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
> @@ -4608,7 +4609,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		 * disk in case of crash before zeroing trans is committed.
>  		 */
>  		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start, end);
> +			ret = filemap_write_and_wait_range(mapping, start, end - 1);
>  			if (ret) {
>  				filemap_invalidate_unlock(mapping);
>  				goto out_mutex;
> -- 
> 2.39.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
