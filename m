Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4A665E36
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjAKOoF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 09:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAKOna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 09:43:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9287338B
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 06:43:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 045DA17C56;
        Wed, 11 Jan 2023 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673448208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LPK4jRHj4+WaXWVLS6Y35EZBQweqs9Q8uUFxbZ2aSk=;
        b=eOuUZ1CcGqlUc5i1+ZGjPD71P31TzqaLQTY7wU9WJ3VWWmn1006vNg6jSgVir7FNJt7sqw
        0tZO3aKEAcN7Zj/lprO1K45U0b6YOusJD2+NgQ0nCFGfdZAYq8NQnnZn0wi9RgfflP+HSN
        +UUJ4Z5hH9FapdL59bWwdA5AYH7/wSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673448208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LPK4jRHj4+WaXWVLS6Y35EZBQweqs9Q8uUFxbZ2aSk=;
        b=yQm5JS3Mb8AzTHtaZngow/pytmWr5QUGRQB/B4tUBXe4mkX/i7uB+ABmcS6yTatw6QgeK1
        sG7TI0FyLCG7z5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E931113591;
        Wed, 11 Jan 2023 14:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DPzjOA/LvmNTGgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 14:43:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 803F0A0744; Wed, 11 Jan 2023 15:43:27 +0100 (CET)
Date:   Wed, 11 Jan 2023 15:43:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: use ext4_fc_tl_mem in fast-commit replay path
Message-ID: <20230111144327.gb6p3foqj23mby7w@quack3>
References: <20221217050212.150665-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217050212.150665-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-12-22 21:02:12, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> To avoid 'sparse' warnings about missing endianness conversions, don't
> store native endianness values into struct ext4_fc_tl.  Instead, use a
> separate struct type, ext4_fc_tl_mem.
> 
> Fixes: dcc5827484d6 ("ext4: factor out ext4_fc_get_tl()")
> Cc: Ye Bin <yebin10@huawei.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Just one nit below:

> -static inline void ext4_fc_get_tl(struct ext4_fc_tl *tl, u8 *val)
> +static inline void ext4_fc_get_tl(struct ext4_fc_tl_mem *tl, u8 *val)
>  {
> -	memcpy(tl, val, EXT4_FC_TAG_BASE_LEN);
> -	tl->fc_len = le16_to_cpu(tl->fc_len);
> -	tl->fc_tag = le16_to_cpu(tl->fc_tag);
> +	struct ext4_fc_tl tl_disk;
> +
> +	memcpy(&tl_disk, val, EXT4_FC_TAG_BASE_LEN);
> +	tl->fc_len = le16_to_cpu(tl_disk.fc_len);
> +	tl->fc_tag = le16_to_cpu(tl_disk.fc_tag);
>  }

So why not just:

	struct ext4_fc_tl *tl_disk = (struct ext4_fc_tl *)val;

instead of memcpy?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
