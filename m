Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D826B5E9BBF
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiIZIPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIZIPY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 04:15:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319017661;
        Mon, 26 Sep 2022 01:15:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4EDF220B1;
        Mon, 26 Sep 2022 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664180121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO/eM9HIBNdBBFIAw0sR5E0YTAhTjpRaz4n41fHaLcY=;
        b=eonFCWLbJp+ueDZnuTUZ06+fX7Q4F5/qeP+5IoW0YGI9WtjPz9XVfAgm1pQyhLkzoTjd4r
        XfdNJVoOiNVOJ/W3kTXHLRIimKSv+yOX+koB6RGLJBYGqlT97Bl/HaVgVyG66BXlF6d367
        aMPJxRhSATAqfR1nUdDButskWHX5HaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664180121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO/eM9HIBNdBBFIAw0sR5E0YTAhTjpRaz4n41fHaLcY=;
        b=yRAMY/4xuwynNUb3b7PSA7OmBZ+wpCmbdcOEfs6YejPcdR/xNZ658pcDEyUeocW5HLov28
        8o4+Hk73AeWAsgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D784113486;
        Mon, 26 Sep 2022 08:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vt+UNJlfMWNFUQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 08:15:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 691D7A0685; Mon, 26 Sep 2022 10:15:21 +0200 (CEST)
Date:   Mon, 26 Sep 2022 10:15:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 1/2] ext4: remove unnecessary drop path
 references in mext_check_coverage()
Message-ID: <20220926081521.szxq4qizpz54opcm@quack3>
References: <20220924021211.3831551-1-yebin10@huawei.com>
 <20220924021211.3831551-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924021211.3831551-2-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-09-22 10:12:10, Ye Bin wrote:
> According to Jan Kara's suggestion:
> "The use in mext_check_coverage() can be actually removed
> - get_ext_path() -> ext4_find_extent() takes care of dropping the references."
> So remove unnecessary call ext4_ext_drop_refs() in mext_check_coverage().
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 701f1d6a217f..782bbda2a717 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -103,7 +103,6 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
>  		if (unwritten != ext4_ext_is_unwritten(ext))
>  			goto out;
>  		from += ext4_ext_get_actual_len(ext);
> -		ext4_ext_drop_refs(path);
>  	}
>  	ret = 1;
>  out:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
